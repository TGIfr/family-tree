<?php

$connection = (include 'DBconnection.php');

if(!isset($_POST['parent_id'])) echo 'error';
else $parent_id = quotemeta($_POST['parent_id']);

$year = date("Y");
$dayOfTheYear = date('z') + 1;
$season = $dayOfTheYear < 183 ? 0 : 1;

$res = $connection->query("SELECT family_id FROM member WHERE id = $parent_id");
$family = $res->fetch_assoc()['family_id'];

if(!$family) $family = 'NULL';

$connection->query("INSERT INTO member(name, rec_season, rec_year, mentor_id, family_id) VALUES ('Новий мембер', $season , $year, $parent_id, $family)");

echo $connection->insert_id;

$connection->close();
?>