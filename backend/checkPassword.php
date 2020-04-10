<?php

//echo password_hash("karino4ka", PASSWORD_DEFAULT);

if(!isset($_POST['pass'])) echo 'error';
else $pass = $_POST['pass'];

echo password_verify($pass, '$2y$10$jMsTSoJ5qy7e/nMoJEFc8e0WMJtucsBVN7qJwnOvtbHSWxT8HwM9i');

?>