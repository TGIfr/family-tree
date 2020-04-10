<?php

if($_FILES['newImage']['name']) {
  $name = $_POST['name'];
  $ext = strtolower(pathinfo($_FILES['newImage']['name'], PATHINFO_EXTENSION));
  $newImage = '../img/members/'.$name.'.'.$ext;
  move_uploaded_file($_FILES['newImage']['tmp_name'], $newImage);
  
  echo $newImage;
}
else echo 'no file';

?>