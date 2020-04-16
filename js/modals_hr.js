'use strict';

modalTypes.editMember = {
  node: document.getElementById('editMember'),
  elements: {
    img: document.querySelector('#editMember .picture img'),
    imgLoad: document.querySelector('#editMember .picture .imageLoad'),
    name: document.querySelector('#editMember .name'),
    activityIndicator: document.getElementById('activityIndicatorInput'),
    statusDots: document.querySelectorAll('#editMember .status .dot'),
    recruitment: document.querySelector('#editMember .recruitment'),
    recruimentSeason: document.querySelector('#editMember .recruitment .season'),
    recruimentYear: document.querySelector('#editMember .recruitment .year'),
    family: document.querySelector('#editMember .family select'),
    saveButton: document.querySelector('#editMember .save')
  },
  opener: displayMemberEditModal,
  closer: function() {
    modalTypes.editMember.newData = {};
    modalTypes.editMember.elements.img.src = '';
  },
  newData: {}
};

modalTypes.editMember.elements.imgLoad.onchange = function(e) {
  const newImage = this.files[0];
  var mime_types = ['image/jpeg', 'image/jpg', 'image/png'];
  if(mime_types.indexOf(newImage.type) == -1) {
    alert('Error: Incorrect file type');
    return;
  };

  if(newImage.size > 2*1024*1024) {
    alert('Error: Exceeded size 2MB');
    return;
  };
        
  const name = modalTypes.editMember.elements.img.getAttribute('src') ? modalTypes.editMember.elements.img.getAttribute('src').split('/')[2].split('.')[0] : 'member'+modalTypes.editMember.newData.id;
  
  var formData = new FormData();
  formData.append('newImage', newImage, this.value);
  formData.append('id', modalTypes.editMember.newData.id);
  formData.append('name', name);

  ajaxQuery('backend/uploadPicture.php', formData, function(src) {
    modalTypes.editMember.node.classList.add('hasImage');
    modalTypes.editMember.elements.img.src = src;
    
    const memberBlock = familyTree.getMemberBlockById(modalTypes.editMember.newData.id);
    var pictureBlock = memberBlock.querySelector('.picture');
    var imgBlock = pictureBlock.querySelector('img');
    if(!imgBlock) {
      var imgBlock = document.createElement('img');
      pictureBlock.append(imgBlock)
    };

    imgBlock.src = src;
  }, true);
};

[].forEach.call(modalTypes.editMember.elements.statusDots, function(dot, i) {
  dot.onclick = function() {
    for(var j = 0; j < 4; j++) {
      modalTypes.editMember.elements.statusDots[j].className = 'dot';
      if(j < i) modalTypes.editMember.elements.statusDots[j].classList.add('filled');
    };
    dot.classList.add('active');
  };
});

for(var i = 2007; i <= new Date().getFullYear(); i++) {
  const option = document.createElement('option');
  option.value = i;
  option.textContent = i;
  if(i == new Date().getFullYear()) option.selected = true;
  modalTypes.editMember.elements.recruimentYear.append(option);
};

ajaxQuery('backend/getAllFamilies.php', null, function(response) {
  JSON.parse(response).forEach(function(family) {
    const option = document.createElement('option');
    option.value = family.id;
    option.textContent = family.name;
    modalTypes.editMember.elements.family.append(option);
  });
});

modalTypes.editMember.elements.saveButton.onclick = function() {
  var props = 'id='+modalTypes.editMember.newData.id;
  for(let prop in modalTypes.editMember.newData) {
    if(prop == 'id') continue;
    props += '&' + prop + '=' + modalTypes.editMember.newData[prop];
  };
  
  ajaxQuery('backend/editMember.php', props, function(response) {
    familyTree.changeMember(modalTypes.editMember.newData);
    modalTypes.editMember.newData = {};
    closeModal();
  });
};


function displayMemberEditModal(memberData) {
  modalTypes.editMember.newData.id = memberData.id;
  
  //встановлення зображення
  if(memberData.image) {
    modalTypes.editMember.elements.img.src = 'img/members/' + memberData.image;
    modalTypes.editMember.node.classList.add('hasImage');
  };
  
  //встановлення імені
  modalTypes.editMember.elements.name.value = memberData.name;
  modalTypes.editMember.elements.name.oninput = function() {
    if(modalTypes.editMember.elements.name.value == memberData.name)
      delete modalTypes.editMember.newData.name;
    else 
      modalTypes.editMember.newData.name = modalTypes.editMember.elements.name.value;
  };
  
  //встановлення активності мембера
  modalTypes.editMember.elements.activityIndicator.checked = memberData.active;
  modalTypes.editMember.elements.activityIndicator.onclick = function() {
    if(modalTypes.editMember.elements.activityIndicator.checked == memberData.active)
      delete modalTypes.editMember.newData.active;
    else 
      modalTypes.editMember.newData.active = modalTypes.editMember.elements.activityIndicator.checked;
  };
  
    //встановлення статусу бестіка
  [].forEach.call(modalTypes.editMember.elements.statusDots, function(dot, i) {
    dot.className = 'dot';
    if(i < memberData.status) dot.classList.add('filled');
    if(i == memberData.status) dot.classList.add('active');
    dot.addEventListener('click', function() {
      if(i == memberData.status)
        delete modalTypes.editMember.newData.status;
      else
        modalTypes.editMember.newData.status = i;
    });
  });
  
  //встановлення сезону і року рекрутменту
  modalTypes.editMember.elements.recruitment.className = 'recruitment';
  if(memberData.rec_season) {
    modalTypes.editMember.elements.recruimentSeason.value = String(memberData.rec_season);
    modalTypes.editMember.elements.recruimentSeason.onchange = function() {
      if(modalTypes.editMember.elements.recruimentSeason.value == String(memberData.rec_season))
        delete modalTypes.editMember.newData.rec_season;
      else
        modalTypes.editMember.newData.rec_season = modalTypes.editMember.elements.recruimentSeason.value;
    };
  };
  
  if(memberData.rec_year) {
    modalTypes.editMember.elements.recruimentYear.value = String(memberData.rec_year);
    modalTypes.editMember.elements.recruimentYear.onchange = function() {
      if(modalTypes.editMember.elements.recruimentYear.value == String(memberData.rec_year))
        delete modalTypes.editMember.newData.rec_year;
      else
        modalTypes.editMember.newData.rec_year = modalTypes.editMember.elements.recruimentYear.value;
    };
  };

  //встановлення назви та логотипу сім'ї
  modalTypes.editMember.elements.family.className = 'family';
  modalTypes.editMember.elements.family.value = String(memberData.family_id);
  modalTypes.editMember.elements.family.onchange = function() {
    if(modalTypes.editMember.elements.family.value == String(memberData.family_id))
      delete modalTypes.editMember.newData.family_id;
    else
      modalTypes.editMember.newData.family_id = modalTypes.editMember.elements.family.value;
  };
};



modalTypes.changeParent = {
  node: document.getElementById('changeParent'),
  elements: {
    currentParent: document.querySelector('#changeParent .currentParent .value'),
    searchField: document.querySelector('#changeParent .searchField'),
    saveButton: document.querySelector('#changeParent .save')
  },
  newData: {},
  opener: function(memberData) {
    const parent = familyTree.getParentBlockById(memberData.id);
    modalTypes.changeParent.elements.currentParent.textContent = parent ? parent.querySelector('.name').textContent : '-';
    modalTypes.changeParent.newData.childId = memberData.id;
  },
  closer: function() {
    modalTypes.changeParent.newData = {};
  },
};

modalTypes.changeParent.elements.saveButton.onclick = function() {
  const props = 'id='+modalTypes.changeParent.newData.childId+'&parent_id='+modalTypes.changeParent.newData.newParentId;
  ajaxQuery('backend/changeParent.php', props, function() {
    familyTree.changeParent(modalTypes.changeParent.newData.childId, modalTypes.changeParent.newData.newParentId);
    familyTree.showMember(modalTypes.changeParent.newData.childId);
    closeModal();
  });
};

familyTree.configureSearchField(modalTypes.changeParent.elements.searchField, 'backend/findMentorsByName.php', function(answer) {
  if(modalTypes.changeParent.elements.currentParent.textContent != answer.name) {
    modalTypes.changeParent.elements.currentParent.textContent = answer.name;
    modalTypes.changeParent.newData.newParentId = answer.id;
    modalTypes.changeParent.node.classList.add('newParent');
  };
});


modalTypes.removeConfirmation = {
  node: document.getElementById('removeConfirmation'),
  elements: { 
    name: document.querySelector('#removeConfirmation .name'),
    hasChildrenButtons: document.querySelectorAll('#removeConfirmation .ifHasChildren'),
    hasNoChildrenButton: document.querySelector('#removeConfirmation .ifHasNoChildren'),
  },
  opener: function(memberData) {
    modalTypes.removeConfirmation.elements.name.textContent = memberData.name;
    if(memberData.children) modalTypes.removeConfirmation.node.classList.add('hasChildren');
    modalTypes.removeConfirmation.elements.hasChildrenButtons[0].onclick = familyTree.removeMember.bind(familyTree, memberData.id, false);
    modalTypes.removeConfirmation.elements.hasChildrenButtons[1].onclick = familyTree.removeMember.bind(familyTree, memberData.id, true);
    modalTypes.removeConfirmation.elements.hasNoChildrenButton.onclick = familyTree.removeMember.bind(familyTree, memberData.id);
  }
};