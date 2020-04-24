<?php

if($_FILES['newImage']) {
  $ext = strtolower(pathinfo($_FILES['newImage']['name'], PATHINFO_EXTENSION));
  $tempImage = '../img/members/temp'.$_POST['id'].'.'.$ext;
  move_uploaded_file($_FILES['newImage']['tmp_name'], $tempImage);
  
  echo $tempImage;
}
else echo 'no file';

?>