<?php

$connection = (include 'DBconnection.php');

$res = $connection->query("SELECT * FROM family");

$families = array();

if($res->num_rows > 0) {
  while($family = $res->fetch_assoc()) {
    $families[] = array(
      "id" => $family['id'],
      "name" => $family['name'],
      "logo" => $family['logo']
    );
  }
}

echo json_encode($families);

$connection->close();
?>