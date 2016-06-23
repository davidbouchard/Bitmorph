<?php

/**
 * Controller for 404 error response
 * @todo add HTTP 404 header
 */

$methods = array();

$methods['error'] = function($instance){
	echo '{"error": "Something went wrong"}';
};

$methods['run'] = function($instance) {
	$new = true;
	// Set headers
	header('Content-Type: image/png');

	// Get tools
	$pdo = $instance->tools['con_manager']->get_connection();
	
	// Get URL variables
	$r = $instance->route;
	$characterID = $r[0]; // TODO: check valid string
	$stationID   = $r[1]; // TODO: check valid string
	
	$current_state = null;
	$colorVar = null;
	$primary_station = null;
	$firstVisit = false;
	// === Generate current character === //
	$sql = "SELECT * FROM characters c
	WHERE c.HEXid=:charid";
	// Prepare statement
	$stmt = $pdo->prepare($sql);
	// Bind values
	$stmt->bindValue("charid",  $characterID,  PDO::PARAM_STR );
	$stmt->execute();
	// Fetch results into associative array
	$result = array();
	while ( $row = $stmt->fetch(PDO::FETCH_ASSOC) ) {
		$result[] = $row;
	}
	//if there is no character with this ID, create it, and make an egg
	if(count($result) != 1){
		$firstVisit = true;
		//Get an egg to assign to this character
		$getEgg = "SELECT f.HEXid, f.colorVar, f.hueShift FROM features f
		WHERE f.station_ID=:STNid and f.stage=0 order by rand() limit 1";
		$getEgg_stmt = $pdo->prepare($getEgg);
		$getEgg_stmt->bindValue("STNid",  $stationID,  PDO::PARAM_STR );
		$getEgg_stmt->execute();
		$result = array();
		if ( $row = $getEgg_stmt->fetch(PDO::FETCH_ASSOC) ) {
			$colorVar = $row["colorVar"];
			$eggID = $row["HEXid"];
			$hueShift = $row["hueShift"]
		}
		if ($stationID != "hum"){
			$colorVar = rand(0,1);
		}		
		$insert_character = "INSERT INTO characters (HEXid, date_created, color_variant,hueShift, primary_station, current_state) VALUES (:HXid, now(), :colorVar, :hSFT, :pristn, 0)";
		$stmt = $pdo->prepare($insert_character);
		// Bind variables
		$stmt->bindValue("HXid", $characterID, PDO::PARAM_STR );
		$stmt->bindValue("colorVar", $colorVar, PDO::PARAM_INT );
		$stmt->bindValue("hSFT", $hueShift, PDO::PARAM_INT );
		$stmt->bindValue("pristn", $stationID, PDO::PARAM_STR );
		// Insert the row
		$stmt->execute();
		
		$insert_egg="INSERT INTO visits(character_ID, feature_ID, current_state, date_posted) VALUES (:HXid, :FTid, :state, now())";
		$stmt = $pdo->prepare($insert_egg);
		// Bind variables
		$stmt->bindValue("HXid", $characterID, PDO::PARAM_STR );
		$stmt->bindValue("FTid", $eggID, PDO::PARAM_STR );
		$stmt->bindValue("state", 0, PDO::PARAM_INT );
		// Insert the row
		$stmt->execute();
		
		
		//info variables
		$current_state = 0;
		$primary_station = $stationID;
		$body_type = null;
		
	} else {
		//get info
		$current_state = $result[0]["current_state"];
		$colorVar = $result[0]["color_variant"];
		$hueShift = $result[0]["hueShift"];
		$primary_station = $result[0]["primary_station"];
		$body_type = $result[0]["body_type"];
		//detect already scanned

		$detect_already_scanned = "SELECT s.id FROM scans s
		WHERE s.station_ID=:stnID and s.character_ID=:charID order by rand() limit 1";
		$detect_already_scanned_stmt = $pdo->prepare($detect_already_scanned);
		$detect_already_scanned_stmt->bindValue("stnID",  $stationID,  PDO::PARAM_STR );
		$detect_already_scanned_stmt->bindValue("charID",  $characterID,  PDO::PARAM_STR );
		$detect_already_scanned_stmt->execute();
		$result = array();
		while ( $row = $detect_already_scanned_stmt->fetch(PDO::FETCH_ASSOC) ) {
			$result[] = $row;
		}
		if(count($result) > 0){
			$new = false;
		}
	}
	
	//record scan
	$insert_scan="INSERT INTO scans(character_ID, station_id, date_posted) VALUES (:HXid, :STNid, now())";
		$stmt = $pdo->prepare($insert_scan);
		// Bind variables
		$stmt->bindValue("HXid", $characterID, PDO::PARAM_STR );
		$stmt->bindValue("STNid", $stationID, PDO::PARAM_STR );
		// Insert the row
		$stmt->execute();


	// ====== get prev state img ====== \\
	$sql = "SELECT v.current_state, f.front_sprite_filename, f.front_depth_map, f.back_sprite_filename, f.back_depth_map, f.front_anim_sprite_filename, f.front_anim_depth_map, f.back_anim_sprite_filename, f.back_anim_depth_map, f.station_ID FROM characters c
	LEFT JOIN visits v ON v.character_ID=c.HEXid
	LEFT JOIN features f ON v.feature_ID=f.HEXid
	WHERE c.HEXid=:charid
	";
	// Prepare statement
	$stmt = $pdo->prepare($sql);
	// Bind values
	$stmt->bindValue("charid",  $characterID,  PDO::PARAM_STR );
	$stmt->execute();
	// Fetch results into associative array
	$result = array();
		$sci = false;
		$hum = false;
		$liv = false;
		$inn = false;
		$spa = false;
	while ( $row = $stmt->fetch(PDO::FETCH_ASSOC) ) {
		$result[] = $row;
		if(!$firstVisit){
		switch ($row["station_ID"]){
				case 'sci':
					$sci = true;
					//echo "science";
					break;
				case 'hum':
					$hum = true;
					//echo "human";
					break;
				case 'liv':
					$liv = true;
					//echo "liv";
					break;
				case 'inn':
					$inn = true;
					//echo "inn";
					break;
				case 'spa':
					$spa = true;
					//echo "space";
					break;				
		}
		}
	}
	$stations = array($sci, $hum, $liv, $inn, $spa);
	$prevImg=ImgTools::create_char($result);

	


	if($new){
		// ====== CREATE CURRENT STATE ======\\
		$current_state = IntTools::constrain($current_state+1,0,4);
		
		// === Modify character for visit === ///
		$feature_ID = null;
		if($current_state <= 2){
			//baby and worm
			$sql = "SELECT f.HEXid FROM features f
			WHERE f.station_id=:stnID AND f.stage=:state AND f.colorVar=:cVar ORDER BY rand()
			limit 1
			";
			// Prepare statement
			$stmt = $pdo->prepare($sql);
			// Bind values
			$stmt->bindValue("stnID",  $primary_station,  PDO::PARAM_STR );
			$stmt->bindValue("state", $current_state, PDO::PARAM_INT);
			$stmt->bindValue("cVar",$colorVar, PDO::PARAM_INT);
			$stmt->execute();
			// Fetch results into associative array
			$feature_ID = null;
			if($row = $stmt->fetch(PDO::FETCH_ASSOC)){
				$feature_ID = $row["HEXid"];
			} else {
				
			}
		} else if($current_state == 3){
			//adult
			$sql = "SELECT f.HEXid, f.body_type FROM features f
			WHERE f.stage=:state AND f.colorVar=:cVar AND f.hueShift=:hSFT AND f.basestn=:pri ORDER BY rand()
			limit 1
			";
			// Prepare statement
			$stmt = $pdo->prepare($sql);
			// Bind values
			$stmt->bindValue("stnID",  $stationID,  PDO::PARAM_STR );
			$stmt->bindValue("state", $current_state, PDO::PARAM_INT);
			$stmt->bindValue("cVar",$colorVar, PDO::PARAM_INT);
			$stmt->bindValue("hSFT",$hueShift, PDO::PARAM_INT);
			$stmt->bindValue("pri",$primary_station, PDO::PARAM_STR);
			$stmt->execute();
			// Fetch results into associative array
			$feature_ID = null;
			if($row = $stmt->fetch(PDO::FETCH_ASSOC)){
				$feature_ID = $row["HEXid"];
				$btype = $row["body_type"];
				$update = "UPDATE characters c SET c.body_type = :type
				where c.HEXid = :hxID;";
				$stmt = $pdo->prepare($update);
				// Bind variables
				$stmt->bindValue("hxID", $characterID, PDO::PARAM_STR);
				$stmt->bindValue("type", $btype,  PDO::PARAM_INT);
				// Insert the row
				$stmt->execute();
			} 
			
			else {
				
			}
		} else if($current_state == 4){
			//adult
			$sql = "SELECT f.HEXid FROM features f
			WHERE f.station_id=:stnID AND f.stage=:state AND f.body_type=:btype ORDER BY rand()
			limit 1
			";
			// Prepare statement
			$stmt = $pdo->prepare($sql);
			// Bind values
			$stmt->bindValue("stnID",  $stationID,  PDO::PARAM_STR );
			$stmt->bindValue("state", $current_state, PDO::PARAM_INT);
			$stmt->bindValue("btype",$body_type, PDO::PARAM_INT);
			$stmt->execute();
			// Fetch results into associative array
			$feature_ID = null;
			if($row = $stmt->fetch(PDO::FETCH_ASSOC)){
				$feature_ID = $row["HEXid"];
			} 
			
			else {
				
			}
		}

			$sql = "INSERT INTO visits (character_ID, feature_ID, current_state, date_posted)
			VALUES (:charid, :featid, :state, now())";
			$stmt = $pdo->prepare($sql);
			// Bind variables
			$stmt->bindValue("charid", $characterID, PDO::PARAM_STR);
			$stmt->bindValue("featid", $feature_ID,  PDO::PARAM_STR);
			$stmt->bindValue("state", $current_state,  PDO::PARAM_INT);
			// Insert the row
			$stmt->execute();
			// Get the id of what we just inserted
			$idInserted = $pdo->lastInsertId();
			
			$update = "UPDATE characters c SET c.current_state = :state
			where c.HEXid = :hxID;";
			$stmt = $pdo->prepare($update);
			// Bind variables
			$stmt->bindValue("hxID", $characterID, PDO::PARAM_STR);
			$stmt->bindValue("state", $current_state,  PDO::PARAM_INT);
			// Insert the row
			$stmt->execute();

		// ========= GET THE FINAL CHARACTER ========= \\
		$sql = "SELECT v.current_state, f.*  FROM characters c
		LEFT JOIN visits v ON v.character_ID=c.HEXid
		LEFT JOIN features f ON v.feature_ID=f.HEXid
		WHERE c.HEXid=:charid LIMIT 6
		";
		$stmt = $pdo->prepare($sql);
		$stmt->bindValue("charid",  $characterID,  PDO::PARAM_STR );
		$stmt->execute();
		$result = array();
		while ( $row = $stmt->fetch(PDO::FETCH_ASSOC) ) {
			$result[] = $row;
			
		}
		$updated_char = ImgTools::create_char($result);

		//print_r($stations);

		$images = array($prevImg["def"][0],$prevImg["def"][1],$prevImg["def"][2],$prevImg["def"][3],$updated_char["def"][0],$updated_char["def"][1],$updated_char["def"][2],$updated_char["def"][3],$prevImg["anim"][0],$prevImg["anim"][1],$prevImg["anim"][2],$prevImg["anim"][3],$updated_char["anim"][0],$updated_char["anim"][1],$updated_char["anim"][2],$updated_char["anim"][3]);
		$no = 0;
		foreach ($images as $image) {
			imagepng($image, "image# ".$no);
			$no++;
		}
		$final_image = ImgTools::makeImgGrid($images,4,4,50,50,"png");
	} else {
		$images = array($prevImg["def"][0],$prevImg["def"][1],$prevImg["def"][2],$prevImg["def"][3],$prevImg["anim"][0],$prevImg["anim"][1],$prevImg["anim"][2],$prevImg["anim"][3]);
		$no = 0;
		foreach ($images as $image) {
			imagepng($image, "image# ".$no);
			$no++;
		}
		$final_image = ImgTools::makeImgGrid($images,2,4,50,50,"png");
	}
	
	$final_image = ImgTools::encodeData($final_image, $stations);
	imagepng($final_image);
};

$page_controller = new Controller($methods);
unset($methods);