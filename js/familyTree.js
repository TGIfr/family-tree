'use strict';

const statuses = ['Observer', 'Baby', 'Full', 'Alumni']; //назви статусів бестіків
const recSeasons = ['Spring', 'Autumn']; //назви сезонів рекрутменту

class FamilyTree {
  constructor(mountBlock, HR_mode) {
    this.animationDelay = 500;
    
    this.mountBlock = {
      node: mountBlock, //html блок в якому буде побудуване дерево
      scrollBar: null //об'єкт Scrollbar блоку в якому буде побудоване дерево
    };
    
    if(HR_mode) this.checkHRstatus();
    else this.init();
  }
  
  checkHRstatus() {
    let password = prompt("А який пароль?");
    ajaxQuery('/backend/checkPassword.php', 'pass='+password, (function(response) {
      if(response) {
        this.HR_mode = !!response;
        this.init();
      }
      else window.location.href = '/';
    }).bind(this));
  }
  
  init() {
    const familyTree = this;
    
    ajaxQuery('/backend/getAllMembersData.php', null, function(response) {
      familyTree.generate(JSON.parse(response));
      familyTree.configureMountBlock();
      
      new DropDownSearch(document.getElementById('findMember'), '/backend/findMembersByName.php', function(answer) {
        const block = document.createElement('div');
        block.classList.add('answer');
        block.textContent = answer.name;
        block.addEventListener('click', familyTree.showMember.bind(familyTree, answer.id));
        
        return block;
      });
    });
  };
  
  resetHighlightedMember() {
    const hightlighted = document.querySelector('.highlighted');
    if(hightlighted) hightlighted.classList.remove('highlighted');
  };
  
  showMember(id) {
    this.resetHighlightedMember();
    
    //пошук блоку з таким ідентифікатором
    const memberBlock = this.getMemberBlockById(id);

    let parentBlock = this.getParentBlockById(id); //батьківський блок мембера
    
    if(parentBlock) {
      let childrenBlock = parentBlock.querySelector('.children'); //блок дітей в якому знаходить шуканий мембер

      //поки існує батьківський блок
      while(parentBlock) {
        //якщо блок дітей скритий то відкрити його
        if(!childrenBlock.classList.contains('visible'))
          this.toggleChildrenBlock(parentBlock);

        //перехід на попереднє покоління
        childrenBlock = parentBlock.parentNode;
        parentBlock = childrenBlock.closest('.member');
      };
    };

    const memberBlockDescription = memberBlock.querySelector('.description');
    setTimeout((function() {
      //виділення шуканого мембера
      memberBlock.classList.add('highlighted');

      //скролити до місця де знаходиться блок з шуканим id
      this.mountBlock.scrollBar.scrollIntoView(memberBlockDescription, {
        offsetLeft: (window.innerWidth - memberBlockDescription.offsetWidth)/2, //центрування екрану по горизонталі
        offsetTop: (window.innerHeight - memberBlockDescription.offsetHeight)/2 //центрування екрану по вертикалі
      });
    }).bind(this), this.animationDelay);
  };
  
  //отримати DOM елемент мембера з id
  getMemberBlockById(id) {
    return document.getElementById('member'+id);
  }
  
  //отримати DOM елемент ментора мембера з id
  getParentBlockById(id) {
    return this.getMemberBlockById(id).parentNode.closest('.member');
  }
  
  changeMember(newMemberData) {
    if(!this.HR_mode) return;
    
    const memberBlock = this.getMemberBlockById(newMemberData.id);
    
    if(newMemberData.image) {
      var pictureBlock = memberBlock.querySelector('.picture');
      var imgBlock = pictureBlock.querySelector('img');
      if(!imgBlock) {
        var imgBlock = document.createElement('img');
        pictureBlock.append(imgBlock)
      };
      imgBlock.src = 'img/members/' + newMemberData.image;
    };
    
    if(newMemberData.name)
      memberBlock.querySelector('.name').textContent = newMemberData.name;
    
    if(newMemberData.active === true)
      memberBlock.classList.add('active');
    else if(newMemberData.active === false)
      memberBlock.classList.remove('active');
    
    if(newMemberData.status !== undefined) {
      memberBlock.querySelector('.status').textContent = statuses[newMemberData.status];
      
      const addChild = memberBlock.querySelector('.settings .addChild');
      if(newMemberData.status < 2) addChild.classList.add('hidden');
      else addChild.classList.remove('hidden');
    };
  }
  
  //видалити мембера з id
  //якщо cascade = true то видалити також всіх нащадків
  //якщо cascade = false то всім дітям дати нового ментора, що є батьком мембера з id
  removeMember(id, cascade) {
    if(!this.HR_mode) return;
    
    var props = 'id='+id;
    if(cascade) props += '&cascade=true';

    ajaxQuery('backend/removeMemberById.php', props, (function() {
      const memberBlock = this.getMemberBlockById(id);
      const parentBlock = this.getParentBlockById(id);
      const memberHabitation = parentBlock ? parentBlock.querySelector('.children') : memberBlock.parentNode;

      if(!cascade) {
        const children = memberBlock.querySelector('.children').childNodes;
        children.forEach(function(child) {
          memberHabitation.appendChild(child);
        });
      };

      memberBlock.remove();

      if(parentBlock && !memberHabitation.childNodes.length) {
        parentBlock.querySelector('.opener').remove();
        memberHabitation.remove();
      };
      
      modal.close();
    }).bind(this));
  }
  
  changeParent(id, newParentId) {
    if(!this.HR_mode) return;
    
    const memberBlock = this.getMemberBlockById(id);
    const parentBlock = this.getParentBlockById(id);
    const memberHabitation = parentBlock ? parentBlock.querySelector('.children') : memberBlock.parentNode;

    const newParentBlock = this.getMemberBlockById(newParentId);
    var newMemberHabitation = newParentBlock ? newParentBlock.querySelector('.children') : document.getElementById('familyTree');

    if(!newMemberHabitation) {
      newMemberHabitation = this.createChildrenBlock(newParentBlock);
      newParentBlock.append(newMemberHabitation);
    };

    newMemberHabitation.appendChild(memberBlock);

    if(parentBlock && !memberHabitation.childNodes.length) {
      parentBlock.querySelector('.opener').remove();
      memberHabitation.remove();
    };
  }
  
  addNewChild(parentId) {
    ajaxQuery('backend/createMember.php', 'parent_id='+parentId, (function(id) {
      const child = this.createMemberBlock({
        id: id,
        active: true,
        name: 'Новий мембер',
        status: 0
      });
      const parentBlock = this.getMemberBlockById(parentId);
      
      var childrenBlock = parentBlock.querySelector('.children');
      if(!childrenBlock) {
        childrenBlock = familyTree.createChildrenBlock(parentBlock);
        parentBlock.append(childrenBlock);
      };
      
      childrenBlock.append(child);
      this.showMember(id);
      
      modal.open('editMember', {memberId: id});
    }).bind(this));
  }
  
  //приховати/показати дітей мембера
  toggleChildrenBlock(parent) {
    var childrenBlock = parent.querySelector('.children');
    //якщо існує блок з дітьми
    if(childrenBlock) {
      //зробити його видимим
      childrenBlock.classList.toggle('visible');
      
      //кнопці відкривання надати значення "-"
      var opener = parent.querySelector('.opener');
      opener.textContent = opener.textContent == '+' ? '-' : '+';
      
      //якщо блок приховується
      if(!childrenBlock.classList.contains('visible')) {
        //знайти всіх нащадків
        const posterity = childrenBlock.querySelectorAll('.member');
        
        //кожному нащадку приховати блок з дітьми
        [].forEach.call(posterity, function(childrenMember) {
          childrenBlock = childrenMember.querySelector('.children');
          if(childrenBlock) {
            childrenBlock.classList.remove('visible');
            childrenMember.querySelector('.opener').textContent = '+';
          }
        });
      }
      
      //затримка для анімації
      setTimeout((function() {
        //оновлення скролбарів при зміні розміру дерева
        this.mountBlock.scrollBar.update();
      }).bind(this), this.animationDelay);
    };
  };
  
  //додати кнопку "показати дітей" для блоку мембера
  addChildrenOpenerButton(parent) {
    const button = document.createElement('div');
    button.classList.add('opener');
    button.textContent = '+';
    button.onclick = (function(e) {
      e.stopPropagation();
      this.toggleChildrenBlock(parent);
      
      setTimeout((function(){
        this.mountBlock.scrollBar.scrollIntoView(button, {
          offsetLeft: window.innerWidth/2,
          offsetTop: window.innerHeight/2
        });
      }).bind(this), this.animationDelay);
    }).bind(this);

    //скасовує перетягування полотна якщо клік відбувається на кнопці розгортання
    button.onmousedown = function(e) {e.stopPropagation()};
    
    parent.append(button);
  }
  
  //створення блоку з дітьми мембера
  createChildrenBlock(parent) {
    const block = document.createElement('div');
    block.classList.add('children');

    //кнопка для розгортання блоку з дітьми
    this.addChildrenOpenerButton(parent);
    
    return block;
  }
  
    //створення блоку мембера з даними які є в об'єкті memberData
  createMemberBlock(memberData) {
    //блок нового мембера
    const member = document.createElement('div');
    member.classList.add('member');
    //надання унікального ідентифікатору для можливості пошуку
    member.setAttribute('id', 'member' + memberData.id);
    
    //позначення мембера активним
    if(memberData.active) member.classList.add('active');
    
    //блок що містить всі дані
    const description = document.createElement('div');
    description.classList.add('description');
    
    //блок з зображенням мембера
    const picture = document.createElement('div');
    picture.classList.add('picture');
    if(memberData.image) {
      const image = document.createElement('img');
      image.src = 'img/members/' + memberData.image;
      picture.append(image);
    };
    description.append(picture);

    //блок з іменем мембера
    const name = document.createElement('div');
    name.classList.add('name');
    name.textContent = memberData.name;
    description.append(name);

    //блок зі статусом мембера
    const status = document.createElement('div');
    status.classList.add('status');
    status.textContent = statuses[memberData.status];
    description.append(status);
    
    //відкрити спливаюче вікно з інформацією при кліку на опис мембера
    description.onclick = (function(e) {
      e.stopPropagation();
      modal.open(this.HR_mode ? 'editMember' : 'memberInfo', {memberId: memberData.id});
    }).bind(this);
    
    //режим редагування дерева
    if(this.HR_mode) {
      //блок що містить всі кнопки редагування
      const settings = document.createElement('div');
      settings.classList.add('settings');
      
      //кнопка що відкриває модальне вікно для зміни ментора
      const changeParent = document.createElement('div');
      changeParent.classList.add('changeParent');
      changeParent.setAttribute('title', 'Змінити ментора');
      changeParent.onclick = function(e) {
        e.stopPropagation();
        modal.open('changeParent', {memberId: memberData.id});
      };
      settings.append(changeParent);
      
      //кнопка що відкриває модальне вікно для видалення мембера
      const removeMember = document.createElement('div');
      removeMember.classList.add('removeMember');
      removeMember.setAttribute('title', 'Видалити мембера');
      removeMember.onclick = function(e) {
        e.stopPropagation();
        modal.open('removeConfirmation', {memberId: memberData.id});
      };
      settings.append(removeMember);
      
      //якщо мембер є фулом чи алюмні, то додати кнопку що створює дитину
      const addChild = document.createElement('div');
      addChild.classList.add('addChild');
      addChild.setAttribute('title', 'Додати дитину');
      addChild.onclick = (function(e) {
        e.stopPropagation();
        this.addNewChild(memberData.id);
      }).bind(this);
      if(memberData.status < 2) addChild.classList.add('hidden');
      settings.append(addChild);
      
      description.append(settings);
    };
    
    //скасовує перетягування полотна якщо клік відбувається на описі мембера
    description.onmousedown = function(e) {e.stopPropagation()};
    
    member.append(description);
    
    return member;
  }
  
  //побудова дерева нащадків
  buildMemberPosterityTree(mountBlock, memberData) {
    const newMember = this.createMemberBlock(memberData);
    
    //якщо в мембера є діти - заходимо в рекурсію
    if(memberData.children) {
      const parent = newMember;
      const childrenBlock = this.createChildrenBlock(parent);
      //будуємо дерево всіх нащадків для кожного з дітей
      memberData.children.forEach(this.buildMemberPosterityTree.bind(this, childrenBlock));
      parent.append(childrenBlock);
    };
    
    mountBlock.append(newMember);
  }
  
  generate(membersData) {
    const familyTree = document.createElement('div');
    familyTree.id = 'familyTree';

    //побудува дерева нащадків для кожного з мемберів з першого покоління
    membersData.forEach(this.buildMemberPosterityTree.bind(this, familyTree));

    this.mountBlock.node.classList.add('mountBlock');
    this.mountBlock.node.append(familyTree);
  }
  
  configureMountBlock() {
    this.mountBlock.scrollBar = Scrollbar.init(this.mountBlock.node, scrollbarOptions);
    const mountBlock = this.mountBlock;
    
    //перетягування полотна мишкою
    if(window.innerWidth > 800) { //лише для десктопу
      var clicked = false;
      var clickCoords = {x: 0, y:0};

      mountBlock.node.onmousedown = (function(e) {
        mountBlock.node.classList.add('grabbing');
        clicked = true;
        clickCoords.x = e.pageX;
        clickCoords.y = e.pageY;
      }).bind(this);

      mountBlock.node.onmouseup = this.mountBlock.onmouseleave = function() {
        mountBlock.node.classList.remove('grabbing');
        clicked = false;
      };

      mountBlock.node.onmousemove = function(e) {
        if(clicked) {
          const offsetX = mountBlock.scrollBar.offset.x + clickCoords.x - e.pageX;
          const offsetY = mountBlock.scrollBar.offset.y + clickCoords.y - e.pageY;
          clickCoords.x = e.pageX;
          clickCoords.y = e.pageY;
          mountBlock.scrollBar.scrollTo(offsetX, offsetY, 0);
        };
      };
    };
    
    document.addEventListener('click', this.resetHighlightedMember);
  }
}