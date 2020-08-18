<?php if($_SERVER['REQUEST_URI'] == '/hr') $HR_mode = true; ?>

<!DOCTYPE html>
<html lang="ua">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>Сімейне Дерево</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
  <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">
  <link rel="stylesheet" href="css/reset.css">
  <link rel="stylesheet" href="css/index.css">
  <link rel="stylesheet" href="css/modals.css">
</head>
<body>
  <section id="modal">
    <?php include 'parts/modals/memberInfo.html'; ?>
    <?php if($HR_mode) include 'parts/modals/editMember.html'; ?>
    <?php if($HR_mode) include 'parts/modals/removeConfirmation.html'; ?>
    <?php if($HR_mode) include 'parts/modals/changeParent.html'; ?>
    <div class="blackBG"></div>
  </section>
  
  <section id="findMember" class="searchField">
    <input type="text" placeholder="Type name...">
    <div class="results">
      <div class="list"></div>
    </div>
  </section>
 
  <section id="mountBlock"></section>
  
  <script src="js/smooth-scrollbar.js"></script>
  <script src="js/index.js"></script>
  <script src="js/dropDownSearch.js"></script>
  <script src="js/familyTree.js"></script>
  
  <script src="js/modals.js"></script>
  <?php if($HR_mode) echo '<script src="js/modals_hr.js"></script>'; ?>
</body>
</html>