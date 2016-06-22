<?php

class IntTools {
  public static function constrain($value, $min, $max) {
    if($value<$min){
		$value = $min;
	}
	if($value>$max){
		$value = $max;	
	}
    return $value;
  }
}