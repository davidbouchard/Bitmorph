<?php
$methods = array();
$methods['error'] = function($instance){
	echo '{"error": "Something went wrong"}';
};

$methods['run'] = function($instance) {
	//header('Content-Type: text/html; charset=utf-8');
	// Set headers
	// Get tools
	$pdo = $instance->tools['con_manager']->get_connection();
	// Get URL variables
	$r = $instance->route;	
	  //===========================\\
	 //|====== GET CHARACTER ======|\\
	//||===========================||\\
	$result = CharTools::random($pdo,25);
	$first = true;
	foreach ($result as $output){
		if($first){
			echo "<div onClick=\"loadContent('ExploreDisplay', '/ajaxproxy.php?url=http://osc.rtanewmedia.ca/character-path/" . $output["HEXid"] . "/explore');\" class=\"horizon\" ><img src=\"http://osc.rtanewmedia.ca/character-image/" . $output["HEXid"] . "/300\">
            <div class=\"explore-hover\">
              <h3>More Info</h3>
            </div>
          </div>";
		  $first = false;
		} else {
			echo "<div onClick=\"loadContent('ExploreDisplay', '/ajaxproxy.php?url=http://osc.rtanewmedia.ca/character-path/" . $output["HEXid"] . "/explore');\" class=\"horizon\"><img src=\"http://osc.rtanewmedia.ca/character-image/" . $output["HEXid"] . "/300\">
            <div class=\"explore-hover\">
              <h3>More Info</h3>
            </div>
          </div>";
		}
	}
	  //===========================\\
	 //|==== Create  Path List ====|\\
	//||===========================||\\	
	
};

$page_controller = new Controller($methods);
unset($methods);