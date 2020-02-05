'use script';

//налаштування скролбару
const pageScrollBar = Scrollbar.init(document.querySelector('#wrapper'), {
  damping: .13,
  thumbMinSize: 10,
  renderByPixels: false,
  continuousScrolling: false,
  alwaysShowTracks: true
});


//AJAX запит на сервер
//url - лінк на який слати запит
//params - POST параметри
//sucCallback - колбек-функція що виконається у випадку успішного запиту
function ajaxQuery(url, params, sucCallback) {
  const xhr = new XMLHttpRequest();

  xhr.onreadystatechange = function(){
    if(xhr.readyState == 4) {
      if(xhr.status == 200) sucCallback(xhr.response);
      else if(xhr.status == 404) throw Error('Error: cannot find required script!');
      else throw Error('Error: server response: '+ xhr.status);
    }      
  }

  xhr.open('POST', url, true);
  xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');
  xhr.send(params);
}


//генерація сімейного дерева
var familyTree;
//надсилання запиту для отримання даних про всіх мемберів
ajaxQuery('membersData.php', null, function(response) {
  const membersData = JSON.parse(response);
  familyTree = new FamilyTree(membersData, document.getElementById('familyTree'));
});


//налаштування пошуку мембера
const search = document.getElementById('search');
const searchInput = search.querySelector('input');
const searchResults = search.querySelector('.results');
const searchResultsList = searchResults.querySelector('.list');

//скролбар для результатів пошуку
const searchResultsScrollBar = Scrollbar.init(searchResults, {
  damping: .13,
  thumbMinSize: 10,
  renderByPixels: false,
  continuousScrolling: false,
  alwaysShowTracks: true
});

//при введені символу в поле вводу
searchInput.oninput = function() {
  //очистити попередні результати
  searchResultsList.innerHTML = '';
  
  //якщо поле вводу не пусте
  if(searchInput.value) {
    //надсилання запиту для отримання даних про мемберів які мають в своєму імені текст з поля вводу
    ajaxQuery('getMembersId.php', 'name='+searchInput.value, function(response) {
      const answers = JSON.parse(response);
      //виведення списку результатів
      [].forEach.call(answers, createAnswerBlock);
      
      //оновлення скролбару для результатів
      searchResultsScrollBar.update();
    });
  };
};

//створення блоку з результатом
function createAnswerBlock(answer) {
  const block = document.createElement('div');
  block.classList.add('answer');
  block.textContent = answer.name;
  
  block.onclick = function(e) {
    e.stopPropagation();
    resetHighlighted();
    findMember(answer.id);
    
    //очищення результатів пошуку
    searchResultsList.innerHTML = searchInput.value = '';
  };
  
  searchResultsList.append(block);
}

//знайти мембера в якоого ідентифікатор має значення id 
function findMember(id) {
  //пошук блоку з таким ідентифікатором
  const memberBlock = document.getElementById('member'+id);
  
  //виділення шуканого мембера
  memberBlock.classList.add('highlighted');
  
  let childrenBlock = memberBlock.parentNode; //блок дітей в якому знаходить шуканий мембер
  let parentBlock = childrenBlock.closest('.member'); //батьківський блок мембера
  
  //поки існує батьківський блок
  while(parentBlock) {
    //якщо блок дітей скритий то відкрити його
    if(!childrenBlock.classList.contains('visible')) familyTree.openChildrenBlock(parentBlock);
    
    //перехід на попереднє покоління
    childrenBlock = parentBlock.parentNode;
    parentBlock = childrenBlock.closest('.member');
  };
  
  const memberBlockDescription = memberBlock.querySelector('.description');
  setTimeout(function() {
    //скролити до місця де знаходиться блок з шуканим id
    pageScrollBar.scrollIntoView(memberBlockDescription, {
      offsetLeft: (window.innerWidth - memberBlockDescription.offsetWidth)/2, //центрування екрану по горизонталі
      offsetTop: (window.innerHeight - memberBlockDescription.offsetHeight)/2 //центрування екрану по вертикалі
    });
  }, 300);
};

//скидання виділення певного мембера
function resetHighlighted() {
  const hightlighted = document.querySelector('.highlighted');
  if(hightlighted) hightlighted.classList.remove('highlighted');
};

//скинути виділення при кліку
document.addEventListener('click', resetHighlighted);