'use script';

//налаштування скролбарів
const scrollbarOptions = {
  damping: .13,
  thumbMinSize: 10,
  renderByPixels: false,
  continuousScrolling: false,
  alwaysShowTracks: true
};

//AJAX запит на сервер
//url - лінк на який слати запит
//params - POST параметри
//sucCallback - колбек-функція що виконається у випадку успішного запиту
function ajaxQuery(url, params, sucCallback, file) {
  const xhr = new XMLHttpRequest();

  xhr.onreadystatechange = function(){
    if(xhr.readyState == 4) {
      if(xhr.status == 200) {
        if(sucCallback) sucCallback(xhr.response);
      }
      else if(xhr.status == 404) throw Error('Error: cannot find required script!');
      else throw Error('Error: server response: '+ xhr.status);
    }      
  }

  xhr.open('POST', url, true);
  if(!file) xhr.setRequestHeader('Content-type','application/x-www-form-urlencoded');
  xhr.send(params);
};