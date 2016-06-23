<?php
$methods = array();
$methods['error'] = function($instance){
	echo '{"error": "Something went wrong"}';
};

$methods['run'] = function($instance) {
	// Set headers
	//header('Content-Type: image/png');

	// Get tools
	$pdo = $instance->tools['con_manager']->get_connection();
	
	// Get URL variables
	$r = $instance->route;
	$mode = $r[0];
	switch ($r[0]){
		case "fix":
			$sql = "SELECT * from visits where feature_ID IS NULL;";
			// Prepare statement
			$stmt = $pdo->prepare($sql);
			// Do the thing
			$stmt->execute();
			// Fetch results into associative array
			$result = array();
			while ( $row = $stmt->fetch(PDO::FETCH_ASSOC) ) {
				$result[] = $row;
			}
			$sql = "delete from visits where feature_ID IS NULL";
			// Prepare statement
			$stmt = $pdo->prepare($sql);
			// Do the thing
			$stmt->execute();
			echo "fixed the database, removed " . count($result) . " records";
			if(count($result) > 0){
				print_r($result);
			}
		break;
		
		case "random":
			$randomChar = CharTools::random($pdo,1);
			echo $randomChar[0];
		break;
		
		case "grid":
			$randomChars = CharTools::random($pdo,100);
			$chars = 0;
			while($chars < 1500){
				foreach ($randomChars as $char) {
					echo "<img class=\"gridimg fadeIn\" id=\"".$chars."\" src = \" http://osc.rtanewmedia.ca/character-image/" . $char["HEXid"]."/50\" />";
					$chars++;
				}
			}
		
		break;
		
		case "generate":
			$randomStrings = explode("\n",file_get_contents("https://www.random.org/strings/?num=100&len=6&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new"));
			$urls = array("hum", "liv", "inn", "spa", "sci");
			foreach($randomStrings as $charid){
				for ($i=0; $i<5; $i++){
					file_get_contents("http://osc.rtanewmedia.ca/character-update/" . $charid . "/" . $urls[rand(0,4)]);
				}
			}
			
		break;
		
	}
	 
};

$page_controller = new Controller($methods);
unset($methods);
