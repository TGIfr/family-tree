'use script';

function ajaxQuery(url, params, sucCallback) {
  const xhr = new XMLHttpRequest();

  xhr.onreadystatechange = function(){
    if(xhr.readyState == 4) {
      if(xhr.status == 200){
        sucCallback(xhr.response);
      }
      else if(xhr.status == 404) {
        throw Error('Error: cannot find required script!');
      }
      else {
        throw Error('Error: server response: '+ xhr.status);
      }
    }      
  }

  xhr.open('POST', url, true);
  xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');
  xhr.send(params);
}

//scrollbar setting
const pageScrollBar = Scrollbar.init(document.querySelector('#wrapper'), {
  damping: .13,
  thumbMinSize: 10,
  renderByPixels: false,
  continuousScrolling: false
});

//popup opener
const modal = document.getElementById('modal');
const blackBG = modal.querySelector('.blackBG');

blackBG.onclick = function() {
  modal.classList.remove('active');
};

//family tree generating
var familyTree;

ajaxQuery('membersData.php', null, function(response) {
    const membersData = JSON.parse(response);
    familyTree = new FamilyTree(membersData, document.getElementById('familyTree'));
});


//search setting
function resetHighlighted() {
  const hightlighted = document.querySelector('.highlighted');
  if(hightlighted) hightlighted.classList.remove('highlighted');
};

document.addEventListener('click', resetHighlighted);

function findMember(id) {
  const memberBlock = document.getElementById('member'+id);
  
  resetHighlighted();
  memberBlock.classList.add('highlighted');
  
  let childrenBlock = memberBlock.parentNode;
  let parentBlock = childrenBlock.closest('.member');
  while(parentBlock) {
    if(!childrenBlock.classList.contains('visible'))
      parentBlock.querySelector('.opener').click();
    
    childrenBlock = parentBlock.parentNode;
    parentBlock = childrenBlock.closest('.member');
  };
  
  const memberBlockDescription = memberBlock.querySelector('.description');
  setTimeout(function() {
    pageScrollBar.scrollIntoView(memberBlockDescription, {
      offsetLeft: (window.innerWidth - memberBlockDescription.offsetWidth)/2,
      offsetTop: (window.innerHeight - memberBlockDescription.offsetHeight)/2
    });
  }, 300);
};

const search = document.getElementById('search');
const searchInput = search.querySelector('input');
const searchResults = search.querySelector('.results');
const searchResultsList = searchResults.querySelector('.list');

const searchResultsScrollBar = Scrollbar.init(searchResults, {
  damping: .13,
  thumbMinSize: 10,
  renderByPixels: false,
  continuousScrolling: false
});

searchInput.oninput = function() {
  searchResultsList.innerHTML = '';
  if(searchInput.value) {
    ajaxQuery('getMembersId.php', 'name='+searchInput.value, function(response) {
      [].forEach.call(JSON.parse(response), function(answer) {
        const block = document.createElement('div');
        block.classList.add('answer');
        block.textContent = answer.name;
        block.onclick = function(e) {
          e.stopPropagation();
          findMember(answer.id);
          searchResultsList.innerHTML = searchInput.value = '';
        };
        searchResultsList.append(block);
      });
    });
    searchResultsScrollBar.update();
  };
};