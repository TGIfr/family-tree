<?php

if($_FILES['newImage']['name']) {
  $name = $_POST['name'];
  $ext = strtolower(pathinfo($_FILES['newImage']['name'], PATHINFO_EXTENSION));
  $newImage = '../img/members/'.$name.'.'.$ext;
  move_uploaded_file($_FILES['newImage']['tmp_name'], $newImage);
  
  $connection = (include 'DBconnection.php');

  if(!isset($_POST['id'])) echo 'error';
  else $id = quotemeta($_POST['id']);

  $connection->query("UPDATE member SET image = '$name.$ext' WHERE id = $id");
  $connection->close();
  
  echo $newImage;
}
else echo 'no file';

?>