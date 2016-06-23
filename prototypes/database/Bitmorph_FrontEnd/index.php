<?php 

	function getCurrentUri()
	{
		$basepath = implode('/', array_slice(explode('/', $_SERVER['SCRIPT_NAME']), 0, -1)) . '/';
		$uri = substr($_SERVER['REQUEST_URI'], strlen($basepath));
		if (strstr($uri, '?')) $uri = substr($uri, 0, strpos($uri, '?'));
		$uri = '/' . trim($uri, '/');
		return $uri;
	}
	$base_url = getCurrentUri();
	$routes = array();
	$routes = explode('/', $base_url);
	foreach($routes as $route)
	{
		if(trim($route) != '')
			array_push($routes, $route);
	}
	if($routes[1] == "index.php"){
		$routes[1] = null;	
	}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>Bitmorph</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Horizantal Scrolling CSS -->
<link href="css/bootstrap-horizon.css">

<!-- Custom CSS -->
<link href="css/grayscale.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<script type="text/javascript">
    function replaceContentInContainer(target, source) {
        document.getElementById(target).innerHTML = document.getElementById(source).innerHTML;
    }
	function loadContent(target, url){
		var classes = document.getElementById(target).className;
		document.getElementById(target).className  += " loading";
		var xhttp;
		xhttp = new XMLHttpRequest();
		xhttp.open("GET", url, false);
		xhttp.send();
		setTimeout(function(){
			document.getElementById(target).innerHTML = xhttp.responseText; 
			document.getElementById(target).className = classes;
		},1500);
	}
	
</script>
<script type="text/javascript">
(function fadeInDiv() {
    var divs = $('.fadeIn');
    var elem = divs.eq(Math.floor(Math.random() * divs.length));
    if (!elem.is(':visible')) {
        elem.prev().remove();
        elem.fadeIn(Math.floor(Math.random() * 1000), fadeInDiv);
    } else {

        elem.fadeOut(Math.floor(Math.random() * 1000), function() {
            elem.before('<div>&nbsp;</div>');
            fadeInDiv();
        });
    }
})();
</script>
<script src="http://maps.googleapis.com/maps/api/js"></script>
<script>
var myCenter=new google.maps.LatLng(43.716045,-79.3391);

function initialize()
{
var mapProp = {
  center:myCenter,
  zoom:15, 
  mapTypeId:google.maps.MapTypeId.ROADMAP};

var map=new google.maps.Map(document.getElementById("Googlemap"),mapProp);

var marker=new google.maps.Marker({
  position:myCenter,
  });

marker.setMap(map);
}

google.maps.event.addDomListener(window, 'load', initialize);
</script>

<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

<!-- Navigation -->
<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse"> <i class="fa fa-bars"></i> </button>
      <a class="navbar-brand page-scroll" href="#page-top"> <i class="fa fa-play-circle"></i> <span class="light">Bitmorph</span> </a> </div>
    
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse navbar-right navbar-main-collapse">
      <ul class="nav navbar-nav">
        <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
        <li class="hidden"> <a href="#page-top"></a> </li>
        <li> <a class="page-scroll" href="#explore">Explore</a> </li>
        <li> <a class="page-scroll" href="#about">About</a> </li>
        <li> <a class="page-scroll" href="#contact">Visit</a> </li>
      </ul>
    </div>
    <!-- /.navbar-collapse --> 
  </div>
  <!-- /.container --> 
</nav>

<!-- Intro Header -->
<header class="intro">

<div class="intro-body">
<div class="container">
  <div class="row">
    <?php if($routes[1] == null || $routes[1] == "index.php")  : ?>
      <div class="col-md-12" style="display:block; text-align:center;"><span style="display:block;"><h2 class="header01">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum libero enim, aliquet placerat convallis ac, gravida id ipsum. Morbi massa augue, blandit at malesuada at, tempus nec enim. Integer interdum efficitur suscipit. Donec malesuada ligula mattis purus pharetra venenatis. Nam porttitor orci sed auctor ullamcorper. Curabitur lacinia ut diam a finibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.</h2></span>
      <h1> enter your bitmorph ID</h1>
      <span style="display:block;"><h2 class="header01">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum libero enim, aliquet placerat convallis ac, gravida id ipsum. Morbi massa augue, blandit at malesuada at, tempus nec enim. Integer interdum efficitur suscipit. Donec malesuada ligula mattis purus pharetra venenatis. Nam porttitor orci sed auctor ullamcorper. Curabitur lacinia ut diam a finibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.</h2></span>
      <h1> enter your bitmorph ID</h1>
      <?php elseif (file_get_contents("http://osc.rtanewmedia.ca/character-image/" . $routes[1] . "/600") == "invalid") : ?>
        <div class="col-md-12" style="display:block; text-align:center;"><span style="display:block;"><h2 class="header01">Your character ID is invalid, please try again</h2></span>

      <?php else : ?>
      <div class="col-md-6 col-md-offset-1"> <img class="bigImg" src="http://osc.rtanewmedia.ca/character-image/<?php echo htmlspecialchars($routes[1])?>/600" /></div>
      <?php echo file_get_contents("http://osc.rtanewmedia.ca/character-path/" . htmlspecialchars($routes[1]) . "/tracking"); ?>
      <div class = "col-md-8 col-md-offset-2">
        <!--<h3>Name your Bitmorph
          <input class="textbox" id="charName" type="text">
        </h3>-->
        <h4 style="margin-left: 30px;"><a href = "http://osc.rtanewmedia.ca/print/<?php echo htmlspecialchars($routes[1])?>">Print</a> | <a href = "#explore">Explore</a></h4>
        <!--<div id="email_button" >
          <ul class="list-inline banner-social-buttons">
            <a href="#" onClick="replaceContentInContainer('email_button', 'email_results');" class="btn btn-default btn-lg"><span class="network-name">Email Your Friends</span></a>
            </li>
          </ul>
        </div>
        <div id="email_results">
          <form class="form-inline" role="form">
            <div class="form-group">     
              <label for="email">Email address:</label>
                  
              <input type="email" class="form-control" id="email">
                </div>
              
            <button type="submit" class="btn btn-default">Send</button>
          </form>
        </div>-->
        <?php endif ?>
        <a href="#about" class="btn btn-circle page-scroll"> <i class="fa fa-angle-double-down animated"></i> </a> </div>
    </div>
  </div>
</div>
<div class="rowImgs" id="imgs">
<?php echo file_get_contents("http://osc.rtanewmedia.ca/character/grid"); ?>

</div>
<div class = "gradient">&nbsp;</div>
</header>

<!-- Explore Section -->
<section id="explore" class="content-section text-center">
  <div class="row">
    <div class="col-lg8">
      <h2>Explore other Bitmorphs</h2>
    </div>
  </div>
  <div class="row" id="ExploreDisplay">
    <div class="row" id="ExploreList">
      <div class="col-lg-12" style="overflow:scroll;">
        <div class="horizon-container"> 
         <?php echo file_get_contents("http://osc.rtanewmedia.ca/character-list/"); ?>
         </div>
      </div>
    </div>
  </div>
</section>

<!-- About Section -->
<section id="about" class="container content-section text-center">
<div class="row">
<div class="col-lg-8 col-lg-offset-2">
  <h2>About Bitmorph</h2>
  <p>We are developing an interactive experience for the Ontario Science Centre which will insert itself into the existing fabric of the centre. Our experience will encourage visitors to explore the centre and discover areas they have might have overlooked. We are not aiming to communicate scientific or educational content; that’s the job of the existing exhibits. Rather, we take visitors through what is already there and provide them with an additional layer of interactivity in order to make their visit to the centre more compelling. </p>
  <div class="row">
    <div class="col-sm-1-5 col-sm-6"><img style="width:150px;" src="img/science.png"></div>
    <div class="col-sm-1-5 col-sm-6"><img style="width:100px;" src="img/RyersonLogo.png"></div>
    <div class="col-sm-1-5 col-sm-6"><img style="width:100px;" src="img/rta.jpg"></div>
    <div class="col-sm-1-5 col-sm-6"><img style="width:100px;" src="img/newmedia.jpg"></div>
  </div>
</div>
</section>

<!-- Contact Section -->
<section id="contact" class="container content-section text-center">
  <div class="row">
    <div class="col-lg-8 col-lg-offset-2">
      <h2>Visit the Ontario Science Centre</h2>
      <p>The Ontario Science Centre is open year round, 7 days a week.<br>
        Closed December 25.</br>
      </p>
      <p>We're at 770 Don Mills Road at the corner of Eglinton Avenue East in Toronto, Ontario, Canada.</p>
      <p><a href="https://www.ontariosciencecentre.ca">Visit our Website</a> </p>
      <ul class="list-inline banner-social-buttons">
        <li> <a href="https://twitter.com/OntScienceCtr" class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i> <span class="network-name">Twitter</span></a> </li>
        <li> <a href="https://www.facebook.com/ontariosciencecentre" class="btn btn-default btn-lg"> <span class="network-name">Facebook</span></a> </li>
        <li> <a href="https://plus.google.com/+ontariosciencecentre/posts" class="btn btn-default btn-lg"><i class="fa fa-google-plus fa-fw"></i> <span class="network-name">Google+</span></a> </li>
      </ul>
    </div>
  </div>
</section>

<!-- Map Section -->
<div id="Googlemap"></div>


<!-- Footer -->
<footer>
  <div class="container text-center">
    <p>Copyright &copy; Bitmorph 2016</p>
  </div>
</footer>

<!-- jQuery --> 
<!-- <script src="js/jquery.js"></script> --> 
<script src="js/jquery-1.11.3.min.js"></script> 

<!-- Bootstrap Core JavaScript --> 
<script src="js/bootstrap.min.js"></script> 

<!-- Plugin JavaScript --> 
<script src="js/jquery.easing.min.js"></script> 

<!-- Custom Theme JavaScript --> 
<script src="js/grayscale.js"></script>
</body>
</html>
