<?php

$connection = (include 'DBconnection.php');

if(!isset($_POST['id'])) echo 'error';
else $id = quotemeta($_POST['id']);

if(!isset($_POST[cascade])) {
  $parent_id = $connection->query("SELECT mentor_id FROM member WHERE id = $id")->fetch_assoc()[mentor_id];
  if(!$parent_id) $parent_id = 'NULL';
  
  $connection->query("UPDATE member SET mentor_id = $parent_id WHERE mentor_id = $id");
};

$connection->query("DELETE FROM member WHERE id = $id");

//remove image

$connection->close();
?>