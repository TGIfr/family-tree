<?php

$connection = (include 'DBconnection.php');

if(!isset($_POST['id'])) echo 'error';
else $id = quotemeta($_POST['id']);

$props = [];
if(isset($_POST['image'])) $props[] = "image = '".quotemeta($_POST['image'])."'";
if(isset($_POST['name'])) $props[] = "name = '".quotemeta($_POST['name'])."'";
if(isset($_POST['telegram'])) $props[] = "telegram = '".quotemeta($_POST['telegram'])."'";
if(isset($_POST['instagram'])) $props[] = "instagram = '".quotemeta($_POST['instagram'])."'";
if(isset($_POST['birthday'])) {
  $value = $_POST['birthday'] == 'null' ? "NULL" : "'".quotemeta($_POST['birthday'])."'";
  $props[] = "birthday = ".$value;
};
if(isset($_POST['active'])) $props[] = "active = ".quotemeta($_POST['active']);
if(isset($_POST['status'])) $props[] = "status = ".quotemeta($_POST['status']);
if(isset($_POST['rec_season'])) $props[] = "rec_season = ".quotemeta($_POST['rec_season']);
if(isset($_POST['rec_year'])) $props[] = "rec_year = ".quotemeta($_POST['rec_year']);
if(isset($_POST['faculty'])) {
  $value = $_POST['faculty'] == 'null' ? "NULL" : "'".quotemeta($_POST['faculty'])."'";
  $props[] = "faculty = ".$value;
};
if(isset($_POST['year_of_studying'])) $props[] = "year_of_studying = ".quotemeta($_POST['year_of_studying']);
if(isset($_POST['family_id'])) $props[] = "family_id = ".quotemeta($_POST['family_id']);

$query = "UPDATE member SET ";
$query .= implode(", ", $props);
$query .= " WHERE id = $id";

echo $query;

$connection->query($query);
$connection->close();

if(isset($_POST['image'])) {
  $ext = explode('.', $_POST['image'])[1];
  $tempPath = "../img/members/temp$id.".$ext;
  $newPath = "../img/members/".$_POST['image'];
  
  if(file_exists($newPath))
    unlink($newPath);
     
  rename($tempPath, $newPath);
};
?>