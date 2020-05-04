'use strict';

class DropDownSearch {
  constructor(block, dataSource, answerGenerator) {
    this.waiting = false;
    this.dataSource = dataSource;
    this.answerGenerator = answerGenerator;
    
    const self = this;
    this.input = {
      node: block.querySelector('input'),
      clear: function() {self.input.node.value = ''}
    };
    
    this.results = {
      node: block.querySelector('.results .list'),
      add: function(resultNode) {self.results.node.append(resultNode)},
      clear: function() {self.results.node.innerHTML = ''}
    };

    Scrollbar.init(block.querySelector('.results'), scrollbarOptions);
    
    this.input.node.oninput = this.updateResults.bind(this);
    
    this.input.node.onclick = function(e) {e.stopPropagation()};
    document.addEventListener('click', this.clear.bind(this));
  }
  
  updateResults() {
    this.results.clear();
    
    if(this.input.node.value && !this.waiting) {
      this.waiting = true;
      
      const self = this;
      ajaxQuery(this.dataSource, 'query='+this.input.node.value, function(response) {
        const answers = JSON.parse(response);
        [].forEach.call(answers, function(answer) {
          self.results.add(self.answerGenerator(answer));
        });
        self.waiting = false;
      });
    };
  }
  
  clear() {
    this.results.clear();
    this.input.clear();
  }
}