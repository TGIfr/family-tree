<?php if($_SERVER['REQUEST_URI'] == '/hr') $HR_mode = true; ?>

<!DOCTYPE html>
<html lang="ua">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>Сімейне Дерево</title>
  <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">
  <link rel="stylesheet" href="css/reset.css">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <section id="modal">
    <div class="content" id="memberInfo">
      <div class="picture"><img src=""></div>
      <div class="name"></div>
      <div class="status">
        <div class="dot"><span>Observer</span></div>
        <div class="line"></div>
        <div class="dot"><span>Baby</span></div>
        <div class="line"></div>
        <div class="dot"><span>Full</span></div>
        <div class="line"></div>
        <div class="dot"><span>Alumni</span></div>
      </div>
      <div class="row">
        <div class="recruitment">
          <div class="caption">Recruitment</div>
          <div class="value"></div>
        </div>
        <div class="family">
          <div class="logo"></div>
          <div>
            <div class="caption">Family</div>
            <div class="value"></div>
          </div>
        </div>
      </div>
    </div>
    <?php if($HR_mode): ?>
    <div class="content" id="editMember">
      <label class="picture"><img src=""><input class="imageLoad" type="file" name="pic"></label>
      <input type="checkbox" id="activityIndicatorInput">
      <label for="activityIndicatorInput" class="activityIndicator">Active</label>
      <input type="text" class="name">
      <div class="status">
        <div class="dot"><span>Observer</span></div>
        <div class="line"></div>
        <div class="dot"><span>Baby</span></div>
        <div class="line"></div>
        <div class="dot"><span>Full</span></div>
        <div class="line"></div>
        <div class="dot"><span>Alumni</span></div>
      </div>
      <div class="row">
        <div class="recruitment">
          <div class="caption">Recruitment</div>
          <div class="value">
            <select class="season">
              <option value="null">Невідомо</option>
              <option value="0">Spring</option>
              <option value="1">Autumn</option>
            </select>
            <select class="year">
              <option value="null">Невідомо</option>
            </select>
          </div>
        </div>
        <div class="family">
          <div class="logo"></div>
          <div>
            <div class="caption">Family</div>
            <div class="value">
              <select>
                <option value="null">Нема</option>
              </select>
            </div>
          </div>
        </div>
      </div>
      <div class="options">
        <button class="save">Зберегти</button>
        <button onclick="closeModal()">Відмінити</button>
      </div>
    </div>
    <div class="content" id="removeConfirmation">
      <p>Ви впевнені що хочете видалити мембера <span class="name"></span>?</p>
      <div class="options">
        <button class="red ifHasChildren">Лише цього мембера</button>
        <button class="red ifHasChildren">Цього мембера і всіх нащадків</button>
        <button class="red ifHasNoChildren">Так</button>
        <button onclick="closeModal()">Ні</button>
      </div>
    </div>
    <div class="content" id="changeParent">
      <div class="currentParent">Ментор: <span class="value">-</span></div>
      <div class="searchField">
        <input type="text" placeholder="Type name...">
        <div class="results">
          <div class="list"></div>
        </div>
      </div>
      <div class="options">
        <button class="save">Зберегти</button>
        <button onclick="closeModal()">Відмінити</button>
      </div>
    </div>
    <?php endif; ?>
    <div class="blackBG"></div>
  </section>
  
  <section id="findMember" class="searchField">
    <input type="text" placeholder="Type name...">
    <div class="results">
      <div class="list"></div>
    </div>
  </section>
 
  <section id="wrapper"></section>
  
  <script src="js/smooth-scrollbar.js"></script>
  <script src="js/script.js"></script>
  <script src="js/familyTreeGenerator.js"></script>
  <script>
    familyTree = new FamilyTree(document.getElementById('wrapper')<?php if($HR_mode) echo ', true'; ?>);
  </script>
  <script src="js/modals.js"></script>
  <?php if($HR_mode) echo '<script src="js/modals_hr.js"></script>'; ?>
</body>
</html>