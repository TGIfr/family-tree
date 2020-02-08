<?php
$connection = new mysqli("localhost", "dima", "12345", "bestkyivfamilytree");
//$connection = new mysqli("mysql.zzz.com.ua", "dimamyhal", "M942d245s", "dimamyhal");
if($connection->connect_error) die("Connection failed: " . $conn->connect_error);

if(!isset($_POST[name])) echo 'error';
else $name = quotemeta($_POST[name]);

$res = $connection->query("SELECT id, name FROM member WHERE name LIKE '%$name%' ORDER BY name");

$members = [];

if($res->num_rows > 0) {
  while($memberData = $res->fetch_assoc()) {
    $members[] = array(
      "id" => $memberData["id"],
      "name" => $memberData["name"]
    );
  }
}

echo json_encode($members);

$connection->close();
?>