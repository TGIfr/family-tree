'use strict';

const statuses = ['Observer', 'Baby', 'Full', 'Alumni']; //назви статусів бестіків
const recSeasons = ['Spring', 'Autumn']; //назви сезонів рекрутменту

const modal = document.getElementById('modal'); //спливаюче вікно 
const blackBG = modal.querySelector('.blackBG'); //темний фон за спливаючим вікном

//закрити спливаюче вікно при кліку на темний фон
blackBG.onclick = function() {
  modal.className = '';
};

//відкрити спливаюче вікно з даними що є в об'єкті memberData
function openModal(memberData) {
  //встановлення зображення
  if(memberData.image)
    modal.querySelector('.picture img').src = 'img/members/' + memberData.image;
  else
    modal.classList.add('noImage');

  //встановлення імені
  const modalName = modal.querySelector('.name');
  modalName.textContent = memberData.name;

  //встановлення активності мембера
  memberData.active ? modalName.classList.add('active') : modalName.classList.remove('active');

  //встановлення статусу бестіка
  const statusDots = modal.querySelectorAll('.status .dot');
  [].forEach.call(statusDots, function(dot, i) {
    dot.className = 'dot';
    if(i < memberData.status) dot.classList.add('filled');
    if(i == memberData.status) dot.classList.add('active');
  });

  //встановлення сезону і року рекрутменту
  const recruitment = modal.querySelector('.recruitment');
  recruitment.className = 'recruitment';
  recruitment.classList.add(recSeasons[memberData.rec_season].toLocaleLowerCase());
  recruitment.querySelector('.value').textContent = recSeasons[memberData.rec_season] + ' ' + memberData.rec_year;

  //встановлення назви та логотипу сім'ї
  const family = modal.querySelector('.family');
  if(memberData.familyName) {
    family.className = 'family';
    family.querySelector('.logo img').src = 'img/families/' + memberData.familyLogo;
    family.querySelector('.value').textContent = memberData.familyName;
  }
  else
    family.style.display = 'none';

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
    description.onclick = openModal.bind(null, memberData);
    
    member.append(description);
    
    return member;
  }
  
  toggleChildrenBlock(parent) {
    parent.querySelector('.children').classList.toggle('visible');
    const opener = parent.querySelector('.opener');
    opener.textContent = opener.textContent == '+' ? '-' : '+';
    
    //затримка для анімації
    setTimeout(function() {
      //оновлення скролбарів при зміні розміру дерева
      pageScrollBar.update();
    }, 300);
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