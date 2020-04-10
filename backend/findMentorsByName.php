<?php

$connection = (include 'DBconnection.php');

if(!isset($_POST['name'])) echo 'error';
else $needed_name = quotemeta($_POST['name']);

$res = $connection->query("SELECT id, name FROM member WHERE name LIKE '%$needed_name%' AND status >= 2 ORDER BY name");

$members = array();

if($res->num_rows > 0) {
  while($memberData = $res->fetch_assoc()) {
    $members[] = array(
      "id" => $memberData["id"],
      "name" => $memberData['name']
    );
  }
}

echo json_encode($members);

$connection->close();
?>