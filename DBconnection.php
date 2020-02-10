<?php

$host = "localhost";
$login = "dima";
$pass = "12345";
$dbname = "bestkyivfamilytree";

$connection = new mysqli($host, $login, $pass, $dbname);
if($connection->connect_error) die("Connection failed: " . $conn->connect_error);

return $connection;

?>