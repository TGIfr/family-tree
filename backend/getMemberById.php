<?php

$connection = (include 'DBconnection.php');

if(!isset($_POST['id'])) echo 'error';
else $needed_id = $_POST['id'];

$res = $connection->query("SELECT member.*, family.id as family_id, family.name as family_name, family.logo as family_logo FROM member LEFT JOIN family ON member.family_id = family.id WHERE member.id = $needed_id");

$member;

if($res->num_rows > 0) {
  while($memberData = $res->fetch_assoc()) {
    $member = array(
      "id" => $memberData['id'],
      "mentor_id" => $memberData["mentor_id"],
      "name" => $memberData['name'],
      "image" => $memberData["image"],
      "status" => $memberData["status"],
      "active" => $memberData["active"] ? true : false,
      "rec_season" => $memberData["rec_season"],
      "rec_year" => $memberData["rec_year"],
      "family_id" => $memberData["family_id"],
      "family_name" => $memberData["family_name"],
      "family_logo" => $memberData["family_logo"]
    );
  }
}

$children = $connection->query("SELECT * FROM member WHERE mentor_id = $id");
if($children->num_rows > 0) $member["children"] = true;

echo json_encode($member);

$connection->close();

?>