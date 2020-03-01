'use strict';

const statuses = ['Observer', 'Baby', 'Full', 'Alumni']; //назви статусів бестіків
const recSeasons = ['Spring', 'Autumn']; //назви сезонів рекрутменту

const modal = document.getElementById('modal'); //спливаюче вікно 
var content;
const blackBG = modal.querySelector('.blackBG'); //темний фон за спливаючим вікном

//закрити спливаюче вікно при кліку на темний фон
blackBG.onclick = function() {
  modal.className = '';
  content.classList.remove('active');
  content.classList.remove('hasImage');
};

function displayMemberData(memberData) {
  //встановлення зображення
  if(memberData.image) {
    content.querySelector('.picture img').src = 'img/members/' + memberData.image;
    content.classList.add('hasImage');
  };

  //встановлення імені
  const modalName = content.querySelector('.name');
  modalName.textContent = memberData.name;

  //встановлення активності мембера
  memberData.active ? modalName.classList.add('active') : modalName.classList.remove('active');

  //встановлення статусу бестіка
  const statusDots = content.querySelectorAll('.status .dot');
  [].forEach.call(statusDots, function(dot, i) {
    dot.className = 'dot';
    if(i < memberData.status) dot.classList.add('filled');
    if(i == memberData.status) dot.classList.add('active');
  });

  //встановлення сезону і року рекрутменту
  const recruitment = content.querySelector('.recruitment');
  recruitment.className = 'recruitment';
  if(memberData.rec_season || memberData.rec_year) {

    if(memberData.rec_season)
      recruitment.classList.add(recSeasons[memberData.rec_season].toLocaleLowerCase());

    var value = recruitment.querySelector('.value');
    if(memberData.rec_season) {
      value.textContent = recSeasons[memberData.rec_season];
      if(memberData.rec_year) value.textContent += ' ';
    }
    if(memberData.rec_year) value.textContent += memberData.rec_year;
  }
  else
    recruitment.classList.add('hidden');

  //встановлення назви та логотипу сім'ї
  const family = content.querySelector('.family');
  family.className = 'family';
  if(memberData.familyName) {
    family.querySelector('.logo').style.backgroundImage = memberData.familyLogo ? 'url(../img/families/' + memberData.familyLogo + ')' : 'none';
    family.querySelector('.value').textContent = memberData.familyName;
  }
  else
    family.classList.add('hidden');
}

//відкрити спливаюче вікно з даними що є в об'єкті memberData
function openModal(memberData, type) {
  content = modal.querySelector('.'+type);
  content.classList.add('active');
  
  switch(type) {
    case 'memberInfo': displayMemberData(memberData); break;
    case 'removeConfirmation': console.log(1); break;
    case 'editInfo': console.log(1); break;
    case 'newMember': console.log(1); break;
    default: console.log('error')
  };
  
  modal.classList.add('active');
}


class FamilyTree {
  constructor(membersData, mountBlock) {
    this.membersData = membersData; //дані про сімейне дерево в JSON форматі
    this.mountBlock = mountBlock; //блок в якому буде побудуване дерево
    
    this.generate();
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
    description.onclick = function(e) {
      e.stopPropagation();
      openModal(memberData, 'memberInfo');
    };
    
    if(HR_MODE) {
      const settings = document.createElement('div');
      settings.classList.add('settings');
      
      const changeParent = document.createElement('div');
      changeParent.classList.add('changeParent');
      settings.append(changeParent);
      
      const removeMember = document.createElement('div');
      removeMember.classList.add('removeMember');
      settings.append(removeMember);
      
      if(memberData.status == 2 && memberData.active) {
        const addChild = document.createElement('div');
        addChild.classList.add('addChild');
        settings.append(addChild);
      }
      
      description.append(settings);
    };
    
    description.onmousedown = function(e) {e.stopPropagation()};
    
    member.append(description);
    
    return member;
  }
  
  toggleChildrenBlock(parent) {
    var childrenBlock = parent.querySelector('.children');
    if(childrenBlock) {
      childrenBlock.classList.toggle('visible');
      var opener = parent.querySelector('.opener');
      opener.textContent = opener.textContent == '+' ? '-' : '+';

      if(!childrenBlock.classList.contains('visible')) {
        const posterity = childrenBlock.querySelectorAll('.member');
        [].forEach.call(posterity, function(childrenMember) {
          childrenBlock = childrenMember.querySelector('.children');
          if(childrenBlock) {
            childrenBlock.classList.remove('visible');
            childrenMember.querySelector('.opener').textContent = '+';
          }
        });
      }

      //затримка для анімації
      setTimeout(function() {
        //оновлення скролбарів при зміні розміру дерева
        pageScrollBar.update();
      }, 300);
    };
  };
  
  //створення блоку з дітьми мембера
  createChildrenBlock(parent) {
    const block = document.createElement('div');
    block.classList.add('children');

    //кнопка для розгортання блоку з дітьми
    const opener = document.createElement('div');
    opener.classList.add('opener');
    opener.textContent = '+';
    opener.onclick = (function(e) {
      e.stopPropagation();
      this.toggleChildrenBlock(parent);
    }).bind(this);
    
    opener.onmousedown = function(e) {e.stopPropagation()};
    
    parent.append(opener);
    
    return block;
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
  
  generate() {
    //побудува дерева нащадків для кожного з мемберів з першого покоління
    this.membersData.forEach(this.buildMemberPosterityTree.bind(this, this.mountBlock));
  }
}