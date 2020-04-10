<?php

$connection = (include 'DBconnection.php');

if(!isset($_POST['id'])) echo 'error';
else $id = quotemeta($_POST['id']);

$props = [];
if(isset($_POST[image])) $props[] = "image = '".quotemeta($_POST[image])."'";
if(isset($_POST[name])) $props[] = "name = '".quotemeta($_POST[name])."'";
if(isset($_POST[active])) $props[] = "active = ".quotemeta($_POST[active]);
if(isset($_POST[status])) $props[] = "status = ".quotemeta($_POST[status]);
if(isset($_POST[rec_season])) $props[] = "rec_season = ".quotemeta($_POST[rec_season]);
if(isset($_POST[rec_year])) $props[] = "rec_year = ".quotemeta($_POST[rec_year]);
if(isset($_POST[family_id])) $props[] = "family_id = ".quotemeta($_POST[family_id]);

$query = "UPDATE member SET ";
$query .= implode(", ", $props);
$query .= " WHERE id = $id";

$connection->query($query);

$connection->close();
?>