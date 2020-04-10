<?php

$connection = (include 'DBconnection.php');

if(!isset($_POST['parent_id'])) echo 'error';
else $parent_id = quotemeta($_POST['parent_id']);

$family = quotemeta($_POST['family']);
$year = date("Y");
$dayOfTheYear = date('z') + 1;
$season = $dayOfTheYear < 183 ? 0 : 1;

$connection->query("INSERT INTO member(name, rec_season, rec_year, mentor_id, family_id) VALUES ('Новий мембер', $season ,$year , $parent_id, $family)");

echo $connection->insert_id;

$connection->close();
?>