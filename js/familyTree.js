'use strict';

const checkHRstatus = () => true;

const statuses = ['Observer', 'Baby', 'Full', 'Alumni']; //назви статусів бестіків
const recSeasons = ['Spring', 'Autumn']; //назви сезонів рекрутменту
const animationDelay = 500;

class Member {
  constructor(memberData, parent = null) {
    this.parent = parent;
    this.id = memberData.id;
    this.active = memberData.active;
    this.image = memberData.image;
    this.name = memberData.name;
    this.status = memberData.status;
    this.node = this.createHTMLnode();
  }
  
  createHTMLnode() {
    if(this.node) return;
    
    //блок нового мембера
    const member = document.createElement('div');
    member.classList.add('member');
    //надання унікального ідентифікатору для можливості пошуку
    member.setAttribute('id', 'member' + this.id);
    
    //позначення мембера активним
    if(this.active) member.classList.add('active');
    this.activate = () => {
      member.classList.add('active');
      this.active = true;
    };
    this.deactivate = () => {
      member.classList.remove('active');
      this.active = false;
    };
    
    //блок що містить всі дані
    const description = document.createElement('div');
    description.classList.add('description');
    
    //блок з зображенням мембера
    const picture = document.createElement('div');
    picture.classList.add('picture');
    description.append(picture);
    
    this.loadPicture = () => {
      if(this.image && !picture.firstChild) {
        const image = document.createElement('img');
        image.src = 'img/members/' + this.image;
        picture.append(image);
      };
    };
    
    this.setPicture = fileName => {
      if(fileName == this.image) return;
      this.image = fileName;
      if(!this.image) {
        const image = document.createElement('img');
        image.src = 'img/members/' + fileName;
        picture.append(image);
      }
      else picture.firstChild.src = 'img/members/' + fileName;
    };

    //блок з іменем мембера
    const name = document.createElement('div');
    name.classList.add('name');
    name.textContent = this.name;
    description.append(name);
    this.setName = newName => {
      if(newName == this.name) return;
      this.name = newName;
      name.textContent = newName;
    };

    //блок зі статусом мембера
    const status = document.createElement('div');
    status.classList.add('status');
    status.textContent = statuses[this.status];
    description.append(status);
    this.setStatus = newStatus => {
      if(newStatus == this.status) return;
      status.textContent = statuses[newStatus];
      this.name = newStatus;
    };
    
    //відкрити спливаюче вікно з інформацією при кліку на опис мембера
    description.onclick = (function(e) {
      e.stopPropagation();
      modal.open(checkHRstatus() ? 'editMember' : 'memberInfo', { memberId: this.id });
    }).bind(this);
    
    //режим редагування дерева
    if(checkHRstatus()) {
      //блок що містить всі кнопки редагування
      const settings = document.createElement('div');
      settings.classList.add('settings');
      
      //кнопка що відкриває модальне вікно для зміни ментора
      const changeParent = document.createElement('div');
      changeParent.classList.add('changeParent');
      changeParent.setAttribute('title', 'Змінити ментора');
      changeParent.onclick = (function(e) {
        e.stopPropagation();
        modal.open('changeParent', { memberId: this.id });
      }).bind(this);
      settings.append(changeParent);
      
      //кнопка що відкриває модальне вікно для видалення мембера
      const removeMember = document.createElement('div');
      removeMember.classList.add('removeMember');
      removeMember.setAttribute('title', 'Видалити мембера');
      removeMember.onclick = (function(e) {
        e.stopPropagation();
        modal.open('removeConfirmation', { memberId: this.id });
      }).bind(this);
      settings.append(removeMember);
      
      //якщо мембер є фулом чи алюмні, то додати кнопку що створює дитину
      const addChild = document.createElement('div');
      addChild.classList.add('addChild');
      addChild.setAttribute('title', 'Додати дитину');
      addChild.onclick = (function(e) {
        e.stopPropagation();
        familyTree.createNewMember(this);
      }).bind(this);
      if(this.status < 2) addChild.classList.add('hidden');
      settings.append(addChild);
      this.showAddChildButton = () => addChild.classList.remove('hidden');
      this.hideAddChildButton = () => addChild.classList.add('hidden');
      
      description.append(settings);
    };
    
    //скасовує перетягування полотна якщо клік відбувається на описі мембера
    description.onmousedown = function(e) {e.stopPropagation()};
    
    member.append(description);
    
    return member;
  }
  
  addChild(child) {
    child.parent = this;
    if(!this.children) {
      this.children = [];
      this.addChildrenBlock();
    };
    this.children.push(child);
    this.pushMemberToChildrenBlock(child);
  }
  
  removeChild(childToRemove) {
    this.children = this.children.filter(child => child.id != childToRemove.id);
    if(!this.children[0])
      this.removeChildrenBlock();
  }
  
  //створення блоку з дітьми мембера
  addChildrenBlock() {
    const childrenBlock = document.createElement('div');
    childrenBlock.classList.add('children');
    this.pushMemberToChildrenBlock = member => childrenBlock.append(member.node);
    this.removeChildrenBlock = () => childrenBlock.remove();
    
    const openerButton = document.createElement('div');
    openerButton.classList.add('opener');
    openerButton.textContent = '+';
    
    this.showChildrenBlock = () => {
      this.children.forEach(child => child.loadPicture());
      childrenBlock.classList.add('visible');
      openerButton.textContent = '-';
    };
    
    this.hideChildrenBlock = () => {
      childrenBlock.classList.remove('visible');
      openerButton.textContent = '+';
      this.children.forEach(child => !child.children || child.hideChildrenBlock());
    };
    
    openerButton.onclick = () => {
      childrenBlock.classList.contains('visible') ? this.hideChildrenBlock() : this.showChildrenBlock();

      //затримка для анімації
      setTimeout((function() {
        familyTree.mountBlock.scrollBar.update();
        familyTree.mountBlock.scrollBar.scrollIntoView(openerButton, {
          offsetLeft: window.innerWidth/2,
          offsetTop: window.innerHeight/2
        });
      }).bind(this), animationDelay);
    };

    //скасовує перетягування полотна якщо клік відбувається на кнопці розгортання
    openerButton.onmousedown = function(e) {e.stopPropagation()};
    
    this.node.append(openerButton);
    this.node.append(childrenBlock);
  }
  
  change(newMemberData) {
    if(newMemberData.active === true) this.activate();
    if(newMemberData.active === false) this.deactivate();
    if(newMemberData.name) this.setName(newMemberData.name);
    if(newMemberData.image) this.setPicture(newMemberData.image);
    if(newMemberData.status) {
      this.setStatus(newMemberData.status);
      newMemberData.status < 2 ? this.hideAddChildButton() : this.showAddChildButton();
    };
  }
  
  remove() {
    this.node.remove();
    if(this.children) this.children.forEach(child => child.remove());
    this.parent.removeChild(this);
  }
};

const familyTree = {
  members: [],
  mountBlock: {
    node: document.getElementById('mountBlock'), //html блок в якому буде побудуване дерево
    scrollBar: null
  },
  
  init() {
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
  },
  
  resetHighlightedMember() {
    const hightlighted = document.querySelector('.highlighted');
    if(hightlighted) hightlighted.classList.remove('highlighted');
  },
  
  getMemberById(id) {
    return familyTree.members.filter(member => member.id == id)[0];
  },
  
  showMember(id) {
    familyTree.resetHighlightedMember();
    
    const member = this.getMemberById(id);
    
    if(member.parent) {
      let parentBlock = member.parent;
      
      while(parentBlock) {
        parentBlock.showChildrenBlock();
        parentBlock = parentBlock.parent;
      };
    };

    const memberBlockDescription = member.node.querySelector('.description');
    setTimeout(function() {
      familyTree.mountBlock.scrollBar.update();
      
      //виділення шуканого мембера
      member.node.classList.add('highlighted');

      //скролити до місця де знаходиться блок з шуканим id
      familyTree.mountBlock.scrollBar.scrollIntoView(memberBlockDescription, {
        offsetLeft: (window.innerWidth - memberBlockDescription.offsetWidth)/2, //центрування екрану по горизонталі
        offsetTop: (window.innerHeight - memberBlockDescription.offsetHeight)/2 //центрування екрану по вертикалі
      });
    }, animationDelay);
  },
  
  createNewMember(parentMember) {
    ajaxQuery('backend/createMember.php', 'parent_id='+parentMember.id, function(id) {
      const child = new Member({
        id: id,
        active: true,
        name: 'Новий мембер',
        status: 0
      }, parentMember);
      
      familyTree.members.push(child);
      parentMember.addChild(child);
      
      familyTree.showMember(id);
      
      modal.open('editMember', { memberId: id });
    });
  },
  
  changeMember(newMemberData) {
    if(!checkHRstatus()) return;
    
    const memberBlock = this.getMemberById(newMemberData.id).change(newMemberData);
  },
  
  //видалити мембера з id
  //якщо cascade = true то видалити також всіх нащадків
  //якщо cascade = false то всім дітям дати нового ментора, що є батьком мембера з id
  removeMember(id, cascade) {
    if(!checkHRstatus()) return;
    
    var props = 'id='+id;
    if(cascade) props += '&cascade=true';

    ajaxQuery('backend/removeMemberById.php', props, function() {
      const memberBlock = familyTree.getMemberById(id);

      if(!cascade)
        memberBlock.children.forEach(child => child.changeParent(memberBlock.parent));

      memberBlock.remove();
      familyTree.members = familyTree.members.filter(member => member.id != id);
      
      modal.close();
    });
  },
  
  changeParent(id, newParentId) {
    if(!checkHRstatus()) return;
    
    familyTree.getMemberById(newParentId).addChild(familyTree.getMemberById(id));
  },
  
  buildBranches(membersData, parentMember = null) {
    membersData.forEach(memberData => {
      const newMember = new Member(memberData, parentMember);
      
      if(memberData.children)
        familyTree.buildBranches(memberData.children, newMember);
      
      if(parentMember) parentMember.addChild(newMember);
      else {
        newMember.loadPicture();
        familyTree.node.append(newMember.node);
      };
      
      familyTree.members.push(newMember);
    });
  },
  
  generate(membersData) {
    familyTree.node = document.createElement('div');
    familyTree.node.id = 'familyTree';
    familyTree.buildBranches(membersData);
    familyTree.mountBlock.node.append(familyTree.node);
  },
  
  configureMountBlock() {
    familyTree.mountBlock.scrollBar = Scrollbar.init(familyTree.mountBlock.node, scrollbarOptions);
    
    //перетягування полотна мишкою
    if(window.innerWidth > 800) { //лише для десктопу
      var clicked = false;
      var clickCoords = {x: 0, y:0};

      familyTree.mountBlock.node.onmousedown = function(e) {
        familyTree.mountBlock.node.classList.add('grabbing');
        clicked = true;
        clickCoords.x = e.pageX;
        clickCoords.y = e.pageY;
      };

      familyTree.mountBlock.node.onmouseup = familyTree.mountBlock.node.onmouseleave = function() {
        familyTree.mountBlock.node.classList.remove('grabbing');
        clicked = false;
      };

      familyTree.mountBlock.node.onmousemove = function(e) {
        if(clicked) {
          const offsetX = familyTree.mountBlock.scrollBar.offset.x + clickCoords.x - e.pageX;
          const offsetY = familyTree.mountBlock.scrollBar.offset.y + clickCoords.y - e.pageY;
          clickCoords.x = e.pageX;
          clickCoords.y = e.pageY;
          familyTree.mountBlock.scrollBar.scrollTo(offsetX, offsetY, 0);
        };
      };
    };
    
    document.addEventListener('click', familyTree.resetHighlightedMember);
  }
};

familyTree.init();