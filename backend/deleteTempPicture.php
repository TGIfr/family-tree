<?php

if(isset($_POST['id'])) {
  $id = $_POST['id'];

  if(file_exists("../img/members/temp$id.png"))
    unlink("../img/members/temp$id.png");
  if(file_exists("../img/members/temp$id.jpg"))
    unlink("../img/members/temp$id.jpg");
};

?>