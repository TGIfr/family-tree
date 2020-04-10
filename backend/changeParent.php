<?php

$connection = (include 'DBconnection.php');

if(!isset($_POST['id'])) echo 'error';
else $id = quotemeta($_POST['id']);

if(!isset($_POST['parent_id'])) echo 'error';
else $parent_id = quotemeta($_POST['parent_id']);

$connection->query("UPDATE member SET mentor_id = $parent_id WHERE id = $id");

$connection->close();
?>