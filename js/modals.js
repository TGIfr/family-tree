'use strict';

const modal = {
  node: document.getElementById('modal'),
  types: {},
  activeType: null,
  open: function(type, settings) {
    if(modal.activeType) modal.close();
    
    modal.activeType = type;
    modal.types[type].opener(settings);
    
    modal.node.classList.add('active');
    modal.types[type].node.classList.add('active');
  },
  close: function() {
    if(!modal.activeType) return;

    modal.node.classList.remove('active');
    modal.types[modal.activeType].node.classList.remove('active');

    if(modal.types[modal.activeType].closer)
      modal.types[modal.activeType].closer();
    
    modal.activeType = null;
  },
  addType: function(name, settings) {
    modal.types[name] = settings;
    if(modal.types[name].init)
      modal.types[name].init();
  }
};

modal.node.querySelector('.blackBG').addEventListener('click', modal.close);


modal.addType('memberInfo', {
  node: document.getElementById('memberInfo'),
  elements: {
    img: {
      node: document.querySelector('#memberInfo .picture img'),
      set: function(fileName) {
        modal.types.memberInfo.elements.img.node.src = 'img/members/' + fileName;
        modal.types.memberInfo.node.classList.add('hasImage');
      },
      clear: function() {
        modal.types.memberInfo.elements.img.node.src = '';
        modal.types.memberInfo.node.classList.remove('hasImage'); 
      }
    },
    name: {
      node: document.querySelector('#memberInfo .name'),
      set: function(value, activity) {
        modal.types.memberInfo.elements.name.node.textContent = value;
        if(activity) modal.types.memberInfo.elements.name.node.classList.add('active');
      },
      clear: function() {
        modal.types.memberInfo.elements.name.node.textContent = '';
        modal.types.memberInfo.elements.name.node.classList.remove('active');
      }
    },
    statusDots: {
      nodes: document.querySelectorAll('#memberInfo .status .dot'),
      set: function(status) {
        [].forEach.call(modal.types.memberInfo.elements.statusDots.nodes, function(dot, i) {
          if(i < status) dot.classList.add('filled');
          if(i == status) dot.classList.add('active');
        });
      },
      clear: function() {
        [].forEach.call(modal.types.memberInfo.elements.statusDots.nodes, function(dot) {dot.className = 'dot'});
      }
    },
    recruitment: {
      node: document.querySelector('#memberInfo .recruitment'),
      valueNode: document.querySelector('#memberInfo .recruitment .value'),
      set: function(season, year) {
        if(!season && !year) {
          modal.types.memberInfo.elements.recruitment.node.classList.add('hidden');
          return;
        };
        
        var value = '';
        if(season !== null) {
          modal.types.memberInfo.elements.recruitment.node.classList.add(recSeasons[season].toLowerCase());
          value = recSeasons[season] + (year ? ' ' : '');
        };
        
        if(year) value += year;
        
        modal.types.memberInfo.elements.recruitment.valueNode.textContent = value;
      },
      clear: function() {
        modal.types.memberInfo.elements.recruitment.node.className = 'recruitment';
        modal.types.memberInfo.elements.recruitment.valueNode.textContent = '';
      }
    },
    family: {
      node: document.querySelector('#memberInfo .family'),
      logoNode: document.querySelector('#memberInfo .family .logo'),
      valueNode: document.querySelector('#memberInfo .family .value'),
      set: function(familyName, familyLogo) {
        if(!familyName) {
          modal.types.memberInfo.elements.family.node.classList.add('hidden');
          return;
        };
        
        if(familyLogo)
          modal.types.memberInfo.elements.family.logoNode.style.backgroundImage = 'url(../img/families/' + familyLogo + ')';
        
        modal.types.memberInfo.elements.family.valueNode.textContent = familyName;
      },
      clear: function() {
        modal.types.memberInfo.elements.family.node.className = 'family';
        modal.types.memberInfo.elements.family.logoNode.style.backgroundImage = 'url(../img/family.svg)';
        modal.types.memberInfo.elements.family.valueNode.textContent = '';
      }
    }
  },
  init: function() {
    setTimeout(function() {
      if(window.location.hash.includes('#member')) {
        const id = window.location.hash.match(/\d+/g)[0];
        familyTree.showMember(id);
        modal.open('memberInfo', {memberId: id});
      };
    }, 1000);
  },
  opener: function(settings) {
    if(!window.location.hash.includes('#member')) window.location.hash = 'member' + settings.memberId;
    ajaxQuery('backend/getMemberById.php', 'id='+settings.memberId, function(response) {
      const memberData = JSON.parse(response);
      if(memberData.image) modal.types.memberInfo.elements.img.set(memberData.image);
      modal.types.memberInfo.elements.name.set(memberData.name, memberData.active);
      modal.types.memberInfo.elements.statusDots.set(memberData.status);
      modal.types.memberInfo.elements.recruitment.set(memberData.rec_season, memberData.rec_year);
      modal.types.memberInfo.elements.family.set(memberData.family_name, memberData.family_logo);
    });
  },
  closer: function() {
    history.pushState("", document.title, window.location.pathname + window.location.search);
    for(let element in modal.types.memberInfo.elements)
      modal.types.memberInfo.elements[element].clear();
  }
});