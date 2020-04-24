'use strict';

modal.addType('editMember', {
  node: document.getElementById('editMember'),
  elements: {
    img: {
      node: document.querySelector('#editMember .picture img'),
      set: function(fileName) {
        modal.types.editMember.elements.img.node.src = fileName;
        modal.types.editMember.node.classList.add('hasImage');
      },
      clear: function() {
        modal.types.editMember.elements.img.node.src = '';
        modal.types.editMember.node.classList.remove('hasImage');
      }
    },
    imgInput: {
      node: document.querySelector('#editMember .picture .imageLoad'),
      clear: function() {
        modal.types.editMember.elements.imgInput.node.value = '';
      },
      init: function() {
        modal.types.editMember.elements.imgInput.node.onchange = function(e) {
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
          
          var imgName = 'member'+modal.types.editMember.memberData.current.id;
          const currentSrc = modal.types.editMember.elements.img.node.getAttribute('src');
          if(currentSrc) {
            const srcParts = currentSrc.split('/');
            imgName = srcParts[srcParts.length - 1].split('.')[0];
          };
          
          switch(newImage.type) {
            case 'image/jpg':
            case 'image/jpeg': imgName += '.jpg'; break;
            case 'image/png': imgName += '.png';
          };

          var formData = new FormData();
          formData.append('newImage', newImage, this.value);
          formData.append('id', modal.types.editMember.memberData.current.id);

          ajaxQuery('backend/uploadPicture.php', formData, function(tempSrc) {
            modal.types.editMember.elements.img.set(tempSrc);
            modal.types.editMember.memberData.new.image = imgName;
          }, true);
        };
      }
    },
    name: {
      node: document.querySelector('#editMember .name'),
      set: function(value) {
        modal.types.editMember.elements.name.node.value = value;
      },
      clear: function() {
        modal.types.editMember.elements.name.node.value = '';
      },
      init: function() {
        modal.types.editMember.elements.name.node.oninput = function() {
          modal.types.editMember.memberData.setNew('name', modal.types.editMember.elements.name.node.value);
        };
      }
    },
    activityIndicator: {
      node: document.getElementById('activityIndicatorInput'),
      set: function(value) {
        modal.types.editMember.elements.activityIndicator.node.checked = value;
      },
      clear: function() {
        modal.types.editMember.elements.activityIndicator.node.checked = false;
      },
      init: function() {
        modal.types.editMember.elements.activityIndicator.node.onclick = function() {
          modal.types.editMember.memberData.setNew('active', modal.types.editMember.elements.activityIndicator.node.checked);
        };
      }
    },
    statusDots: {
      nodes: document.querySelectorAll('#editMember .status .dot'),
      set: function(status) {
        [].forEach.call(modal.types.editMember.elements.statusDots.nodes, function(dot, i) {
          if(i < status) dot.classList.add('filled');
          if(i == status) dot.classList.add('active');
        });
      },
      clear: function() {
        [].forEach.call(modal.types.editMember.elements.statusDots.nodes, function(dot) {
          dot.className = 'dot';
        });
      },
      init: function() {
        [].forEach.call(modal.types.editMember.elements.statusDots.nodes, function(dot, i) {
          dot.onclick = function() {
            for(var j = 0; j < 4; j++) {
              modal.types.editMember.elements.statusDots.nodes[j].className = 'dot';
              if(j < i) modal.types.editMember.elements.statusDots.nodes[j].classList.add('filled');
            };
            dot.classList.add('active');
            
            modal.types.editMember.memberData.setNew('status', i);
          };
        });
      }
    },
    recruitment: {
      node: document.querySelector('#editMember .recruitment'),
      seasonNode: document.querySelector('#editMember .recruitment .season'),
      yearNode: document.querySelector('#editMember .recruitment .year'),
      set: function(season, year) {
        if(season) {
          modal.types.editMember.elements.recruitment.seasonNode.value = String(season);
        };

        if(year) {
          modal.types.editMember.elements.recruitment.yearNode.value = String(year);
        };
      },
      clear: function() {
        modal.types.editMember.elements.recruitment.seasonNode.value = modal.types.editMember.elements.recruitment.yearNode.value = 'null';
      },
      init: function() {        
        for(var i = 2007; i <= new Date().getFullYear(); i++) {
          const option = document.createElement('option');
          option.value = i;
          option.textContent = i;
          if(i == new Date().getFullYear()) option.selected = true;
          modal.types.editMember.elements.recruitment.yearNode.append(option);
        };
           
        modal.types.editMember.elements.recruitment.seasonNode.onchange = function() {
          modal.types.editMember.memberData.setNew('rec_season', modal.types.editMember.elements.recruitment.seasonNode.value);
        };
        
        modal.types.editMember.elements.recruitment.yearNode.onchange = function() {
          modal.types.editMember.memberData.setNew('rec_year', modal.types.editMember.elements.recruitment.yearNode.value);
        };
      }
    },
    family: {
      node: document.querySelector('#editMember .family select'),
      set: function(familyName) {
        modal.types.editMember.elements.family.node.value = String(familyName);
      },
      clear: function() {
        modal.types.editMember.elements.family.node.value = 'null';
      },
      init: function() {
        ajaxQuery('backend/getAllFamilies.php', null, function(response) {
          JSON.parse(response).forEach(function(family) {
            const option = document.createElement('option');
            option.value = family.id;
            option.textContent = family.name;
            modal.types.editMember.elements.family.node.append(option);
          });
        });
        
        modal.types.editMember.elements.family.node.onchange = function() {
          modal.types.editMember.memberData.setNew('family_id', modal.types.editMember.elements.family.node.value);
        };
      }
    },
    birthday: {
      dayInputNode: document.querySelector('#editMember .birthday .day'),
      monthInputNode: document.querySelector('#editMember .birthday .month'),
      yearInputNode: document.querySelector('#editMember .birthday .year'),
      set: function(date) {
        const birthday = new Date(date);
        modal.types.editMember.elements.birthday.dayInputNode.value = birthday.getDate();
        modal.types.editMember.elements.birthday.monthInputNode.value = birthday.getMonth() + 1;
        modal.types.editMember.elements.birthday.yearInputNode.value = birthday.getFullYear();
      },
      clear: function() {
        modal.types.editMember.elements.birthday.dayInputNode.value = modal.types.editMember.elements.birthday.monthInputNode.value = modal.types.editMember.elements.birthday.yearInputNode.value = '';
      },
      init: function() {
        modal.types.editMember.elements.birthday.dayInputNode.oninput = modal.types.editMember.elements.birthday.monthInputNode.oninput = modal.types.editMember.elements.birthday.yearInputNode.oninput = function() {
          if(!modal.types.editMember.elements.birthday.yearInputNode.value || !modal.types.editMember.elements.birthday.monthInputNode.value  || !modal.types.editMember.elements.birthday.dayInputNode.value) {
            modal.types.editMember.memberData.setNew('birthday', null);
            return;
          };
            
          const value = modal.types.editMember.elements.birthday.yearInputNode.value + '-' + modal.types.editMember.elements.birthday.monthInputNode.value + '-' + modal.types.editMember.elements.birthday.dayInputNode.value;
          modal.types.editMember.memberData.setNew('birthday', value);
        };
      }
    },
    saveButton: {
      node: document.querySelector('#editMember .save'),
      init: function() {
        modal.types.editMember.elements.saveButton.node.onclick = function() {
          var props = 'id=' + modal.types.editMember.memberData.current.id;
          var propsCount = 0;
          for(let prop in modal.types.editMember.memberData.new) {
            props += (props ? '&' : '') + prop + '=' + modal.types.editMember.memberData.new[prop];
            propsCount++;
          };

          if(propsCount > 0) {
            ajaxQuery('backend/editMember.php', props, function(response) {
              const newMemberData = modal.types.editMember.memberData.new;
              newMemberData.id = modal.types.editMember.memberData.current.id;
              familyTree.changeMember(newMemberData);
              modal.close();
            });
          }
          else
            modal.close();
        };
      }
    }
  },
  init: function() {
    for(let element in modal.types.editMember.elements)
      if(modal.types.editMember.elements[element].init)
        modal.types.editMember.elements[element].init();
  },
  opener: function(settings) {
    ajaxQuery('backend/getMemberById.php', 'id='+settings.memberId, function(response) {
      const memberData = JSON.parse(response);
      modal.types.editMember.memberData.current = memberData;

      if(memberData.image) modal.types.editMember.elements.img.set('img/members/' + memberData.image);
      modal.types.editMember.elements.name.set(memberData.name);
      if(memberData.birthday) modal.types.editMember.elements.birthday.set(memberData.birthday);
      modal.types.editMember.elements.activityIndicator.set(memberData.active);
      modal.types.editMember.elements.statusDots.set(memberData.status);
      if(memberData.rec_season || memberData.rec_year) modal.types.editMember.elements.recruitment.set(memberData.rec_season, memberData.rec_year);
      if(memberData.family_id) modal.types.editMember.elements.family.set(memberData.family_id);
    });
  },
  closer: function() {
    for(let element in modal.types.editMember.elements)
      if(modal.types.editMember.elements[element].clear)
        modal.types.editMember.elements[element].clear();
    
    ajaxQuery('backend/deleteTempPicture.php', 'id='+modal.types.editMember.memberData.current.id);
    
    modal.types.editMember.memberData.current = modal.types.editMember.memberData.new = {};
  },
  memberData: {
    current: {},
    new: {},
    setNew: function(key, value) {
      if(value === modal.types.editMember.memberData.current[key])
        delete modal.types.editMember.memberData.new[key];
      else
        modal.types.editMember.memberData.new[key] = value;
    }
  }
});


modal.addType('changeParent', {
  node: document.getElementById('changeParent'),
  elements: {
    child: {
      node: document.querySelector('#changeParent .currentParent .child'),
      set: function(value) {
        modal.types.changeParent.elements.child.node.textContent = value;
      },
      clear: function() {
        modal.types.changeParent.elements.child.node.textContent = '';
      }
    },
    currentParent: {
      node: document.querySelector('#changeParent .currentParent .value'),
      set: function(value) {
        modal.types.changeParent.elements.currentParent.node.textContent = value || '-';
      },
      clear: function() {
        modal.types.changeParent.elements.currentParent.node.textContent = '';
      }
    },
    searchField: {
      node: document.querySelector('#changeParent .searchField'),
      init: function() {
        familyTree.configureSearchField(modal.types.changeParent.elements.searchField.node, 'backend/findMentorsByName.php', function(mentor) {
          if(modal.types.changeParent.memberData.newParent != mentor.id) {
            if(modal.types.changeParent.memberData.currentParent == mentor.id)
              modal.types.changeParent.memberData.newParent = null;
            else
              modal.types.changeParent.memberData.newParent = mentor.id;
            
            modal.types.changeParent.elements.currentParent.set(mentor.name);
          };
        });
      }
    },
    saveButton: {
      node: document.querySelector('#changeParent .save'),
      init: function() {
        modal.types.changeParent.elements.saveButton.node.onclick = function() {
          if(modal.types.changeParent.memberData.newParent) {
            const props = 'id='+modal.types.changeParent.memberData.id+'&parent_id='+modal.types.changeParent.memberData.newParent;
            ajaxQuery('backend/changeParent.php', props, function() {
              familyTree.changeParent(modal.types.changeParent.memberData.id, modal.types.changeParent.memberData.newParent);
              familyTree.showMember(modal.types.changeParent.memberData.id);
              modal.close();
            });
          }
          else
            modal.close();
        };
      }
    },
    removeMentor: {
      node: document.querySelector('#changeParent .removeMentor'),
      init: function() {
        modal.types.changeParent.elements.removeMentor.node.onclick = function() {
          if(modal.types.changeParent.memberData.currentParent) {
            const props = 'id='+modal.types.changeParent.memberData.id+'&parent_id=null';
            ajaxQuery('backend/changeParent.php', props, function() {
              familyTree.changeParent(modal.types.changeParent.memberData.id, null);
              familyTree.showMember(modal.types.changeParent.memberData.id);
              modal.close();
            });
          }
          else
            modal.close();
        }
      }
    }
  },
  memberData: {
    id: null,
    currentParent: null,
    newParent: null
  },
  init: function() {
    modal.types.changeParent.elements.searchField.init();
    modal.types.changeParent.elements.saveButton.init();
    modal.types.changeParent.elements.removeMentor.init();
  },
  opener: function(settings) {
    ajaxQuery('backend/getMemberById.php', 'id='+settings.memberId, function(response) {
      const memberData = JSON.parse(response);
      modal.types.changeParent.memberData.id = memberData.id;
      modal.types.changeParent.memberData.currentParent = memberData.mentor_id;
      modal.types.changeParent.elements.child.set(memberData.name);
      modal.types.changeParent.elements.currentParent.set(memberData.mentor_name);
    });
  },
  closer: function() {
    modal.types.changeParent.elements.child.clear();
    modal.types.changeParent.elements.currentParent.clear();
    modal.types.changeParent.memberData.id = modal.types.changeParent.memberData.currentParent = modal.types.changeParent.memberData.newParent = null;
  },
});


modal.addType('removeConfirmation', {
  node: document.getElementById('removeConfirmation'),
  elements: { 
    name: {
      node: document.querySelector('#removeConfirmation .name'),
      set: function(value) {
        modal.types.removeConfirmation.elements.name.node.textContent = value;
      },
      clear: function() {
        modal.types.removeConfirmation.elements.name.node.textContent = '';
      }
    },
    hasChildrenButtons: document.querySelectorAll('#removeConfirmation .ifHasChildren'),
    hasNoChildrenButton: document.querySelector('#removeConfirmation .ifHasNoChildren'),
  },
  opener: function(settings) {
    ajaxQuery('backend/getMemberById.php', 'id='+settings.memberId, function(response) {
      const memberData = JSON.parse(response);
      
      modal.types.removeConfirmation.elements.name.set(memberData.name);
      if(memberData.children) modal.types.removeConfirmation.node.classList.add('hasChildren');
      
      modal.types.removeConfirmation.elements.hasChildrenButtons[0].onclick = familyTree.removeMember.bind(familyTree, memberData.id, false);
      modal.types.removeConfirmation.elements.hasChildrenButtons[1].onclick = familyTree.removeMember.bind(familyTree, memberData.id, true);
      modal.types.removeConfirmation.elements.hasNoChildrenButton.onclick = familyTree.removeMember.bind(familyTree, memberData.id);
    });
  },
  closer: function() {
    modal.types.removeConfirmation.elements.name.clear();
    modal.types.removeConfirmation.node.classList.remove('hasChildren');
  }
});