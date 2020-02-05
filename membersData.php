<?php

$connection = new mysqli("localhost", "dima", "12345", "bestkyivfamilytree");
//$connection = new mysqli("mysql.zzz.com.ua", "dimamyhal", "M942d245s", "dimamyhal");
if($connection->connect_error) die("Connection failed: " . $conn->connect_error);

function createMember($memberData, $dbconn) {
  $member = array(
    "id" => $memberData["id"],
    "name" => $memberData["name"],
    "image" => $memberData["image"],
    "status" => $memberData["status"],
    "active" => $memberData["active"] ? true : false,
    "rec_season" => $memberData["rec_season"],
    "rec_year" => $memberData["rec_year"],
    "familyName" => $memberData["family_name"],
    "familyLogo" => $memberData["family_logo"]
  );
  
  $children = $dbconn->query("SELECT member.*, family.name as family_name, family.logo as family_logo
    FROM member
    INNER JOIN family ON member.family_id = family.id
    WHERE mentor_id = ".$memberData["id"]);
  
  if($children->num_rows > 0) {
    $member["children"] = [];
    while($childData = $children->fetch_assoc()) {
      $member["children"][] = createMember($childData, $dbconn);
    };
  };
  
  return $member;
};

$familyTree = array();
$firstGeneration = $connection->query("SELECT member.*, family.name as family_name, family.logo as family_logo
    FROM member
    INNER JOIN family ON member.family_id = family.id
    WHERE mentor_id IS NULL");

if($firstGeneration->num_rows > 0) {
  while($memberData = $firstGeneration->fetch_assoc()) {
    $member = createMember($memberData, $connection);
    $familyTree[] = $member;
  }
}

echo json_encode($familyTree);

$connection->close();

?>