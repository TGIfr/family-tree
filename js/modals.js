'use strict';

const modal = document.getElementById('modal'); //спливаюче вікно
const modalTypes = {
  memberInfo: {
    node: document.getElementById('memberInfo'),
    elements: {
      img: document.querySelector('#memberInfo .picture img'),
      name: document.querySelector('#memberInfo .name'),
      statusDots: document.querySelectorAll('#memberInfo .status .dot'),
      recruitment: document.querySelector('#memberInfo .recruitment'),
      recruimentValue: document.querySelector('#memberInfo .recruitment .value'),
      family: document.querySelector('#memberInfo .family')
    },
    opener: displayMemberInfoModal
  }
};

var activeModal = {
  type: null,
  node: null
};

//відкрити спливаюче вікно з даними що є в об'єкті memberData
function openModal(type, memberId) {
  activeModal.type = type;
  activeModal.node = document.getElementById(type);
  activeModal.node.classList.add('active');
  
  if(memberId) {
    ajaxQuery('backend/getMemberById.php', 'id='+memberId, function(response) {
      modalTypes[type].opener(JSON.parse(response));
      modal.classList.add('active');
    });
  }
  else {
    modalTypes[type](JSON.parse(response));
    modal.classList.add('active');
  };
};

function closeModal() {
  modal.className = '';
  activeModal.node.className = 'content';
  
  if(modalTypes[activeModal.type].closer) modalTypes[activeModal.type].closer();
  activeModal.node = null;
  activeModal.type = null;
};

modal.querySelector('.blackBG').addEventListener('click', closeModal); //закрити спливаюче вікно при кліку на темний фон


function displayMemberInfoModal(memberData) {
  //встановлення зображення
  if(memberData.image) {
    modalTypes.memberInfo.elements.img.src = 'img/members/' + memberData.image;
    modalTypes.memberInfo.node.classList.add('hasImage');
  };

  //встановлення імені
  modalTypes.memberInfo.elements.name.textContent = memberData.name;

  //встановлення активності мембера
  if(memberData.active)
    modalTypes.memberInfo.elements.name.classList.add('active');
  else
    modalTypes.memberInfo.elements.name.classList.remove('active');

  //встановлення статусу бестіка
  [].forEach.call( modalTypes.memberInfo.elements.statusDots, function(dot, i) {
    dot.className = 'dot';
    if(i < memberData.status) dot.classList.add('filled');
    if(i == memberData.status) dot.classList.add('active');
  });

  //встановлення сезону і року рекрутменту
   modalTypes.memberInfo.elements.recruitment.className = 'recruitment';
  if(memberData.rec_season || memberData.rec_year) {
    if(memberData.rec_season)
       modalTypes.memberInfo.elements.recruitment.classList.add(recSeasons[memberData.rec_season].toLocaleLowerCase());

    if(memberData.rec_season) {
       modalTypes.memberInfo.elements.recruimentValue.textContent = recSeasons[memberData.rec_season];
      if(memberData.rec_year)  modalTypes.memberInfo.elements.recruimentValue.textContent += ' ';
    }
    if(memberData.rec_year)  modalTypes.memberInfo.elements.recruimentValue.textContent += memberData.rec_year;
  }
  else
     modalTypes.memberInfo.elements.recruitment.classList.add('hidden');

  //встановлення назви та логотипу сім'ї
   modalTypes.memberInfo.elements.family.className = 'family';
  if(memberData.family_name) {
     modalTypes.memberInfo.elements.family.querySelector('.logo').style.backgroundImage = memberData.family_logo ? 'url(../img/families/' + memberData.family_logo + ')' : 'none';
     modalTypes.memberInfo.elements.family.querySelector('.value').textContent = memberData.family_name;
  }
  else
     modalTypes.memberInfo.elements.family.classList.add('hidden');
};