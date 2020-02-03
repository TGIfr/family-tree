'use strict';

const statusesId = {
  Observer: 0,
  Baby: 1,
  Full: 2,
  Alumni: 3
};

class FamilyTree {
  constructor(membersData, mountBlock) {
    this.membersData = membersData;
    this.mountBlock = mountBlock;
    
    this.generate();
  }
  
  createMemberBlock(memberData) {
    const image = document.createElement('img');
    image.src = 'img/members/' + memberData.image;

    const picture = document.createElement('div');
    picture.classList.add('picture');
    picture.append(image);

    const name = document.createElement('div');
    name.classList.add('name');
    name.textContent = memberData.name;

    const status = document.createElement('div');
    status.classList.add('status');
    status.textContent = memberData.status;

    const description = document.createElement('div');
    description.classList.add('description');
    description.append(picture);
    description.append(name);
    description.append(status);

    description.onclick = function() {
      //load picture
      modal.querySelector('.picture img').src = 'img/members/' + memberData.image;
      
      //load name
      const modalName = modal.querySelector('.name');
      modalName.textContent = memberData.name;
      
      //load activity
      memberData.active ? modalName.classList.add('active') : modalName.classList.remove('active');
      
      //load status
      const statusDots = modal.querySelectorAll('.status .dot');
      [].forEach.call(statusDots, function(dot, i) {
        dot.classList.remove('filled');
        dot.classList.remove('active');
      });
      [].forEach.call(statusDots, function(dot, i) {
        if(i < statusesId[memberData.status]) dot.classList.add('filled');
        if(i == statusesId[memberData.status]) dot.classList.add('active');
      });
      
      //load recruitment date
      const recruitment = modal.querySelector('.recruitment');
      recruitment.className = 'recruitment';
      recruitment.classList.add(memberData.rec_season);
      recruitment.querySelector('.value').textContent = memberData.rec_season + ' ' + memberData.rec_year;
      
      //load family
      const family = modal.querySelector('.family');
      if(memberData.familyName) {
        family.className = 'family';
        family.querySelector('.logo img').src = 'img/families/' + memberData.familyLogo;
        family.querySelector('.value').textContent = memberData.familyName;
      }
      else
        family.style.display = 'none';
      
      //show modal
      modal.classList.add('active');
    };
    
    const member = document.createElement('div');
    member.classList.add('member');
    member.setAttribute('id', 'member' + memberData.id)
    if(memberData.active) member.classList.add('active');
    member.append(description);
    
    return member;
  }
  
  buildMemberChildrenTree(mountBlock, memberData) {
    const newMember = this.createMemberBlock(memberData);
    
    if(memberData.children) {
      const parent = newMember;
      const childrenBlock = document.createElement('div');
      childrenBlock.classList.add('children');
      
      const opener = document.createElement('div');
      opener.classList.add('opener');
      opener.textContent = '+';
      opener.onclick = function(e) {
        e.stopPropagation();
        childrenBlock.classList.toggle('visible');
        opener.textContent = opener.textContent == '+' ? '-' : '+';
        setTimeout(function() {pageScrollBar.update()}, 300);
      };
      
      memberData.children.forEach(this.buildMemberChildrenTree.bind(this, childrenBlock));
      
      parent.append(opener);
      parent.append(childrenBlock);
    };
    
    mountBlock.append(newMember);
  }
  
  generate() {
    const members = this.membersData.map(this.buildMemberChildrenTree.bind(this, this.mountBlock));
  }
}