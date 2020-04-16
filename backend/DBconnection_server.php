<?php

$host = "localhost";
$login = "bestkyiv";
$pass = "CIpdaqpdTZ";
$dbname = "familytree";

$connection = new mysqli($host, $login, $pass, $dbname);
$connection->set_charset("utf8");
if($connection->connect_error) die("Connection failed: " . $conn->connect_error);

return $connection;

?>