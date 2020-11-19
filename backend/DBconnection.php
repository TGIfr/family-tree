<?php

$host = "localhost";
$login = "ch75b8d88a_bestkyiv";
$pass = "CIpdaqpdTZ";
$dbname = "ch75b8d88a_familytree";

$connection = new mysqli($host, $login, $pass, $dbname);
$connection->set_charset("utf8");
if($connection->connect_error) die("Connection failed: " . $conn->connect_error);

return $connection;

?>
