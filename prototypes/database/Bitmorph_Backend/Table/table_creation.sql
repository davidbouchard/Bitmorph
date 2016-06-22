DROP table if exists visits;
DROP table if exists scans;
DROP table if exists features;
DROP table if exists characters;
DROP table if exists stations;

CREATE TABLE IF NOT EXISTS stations
		  (
		  id MEDIUMINT NOT NULL AUTO_INCREMENT,
		  station_ID char(3) unique,
		  name TEXT,
		  description TEXT,
		  link TEXT,
		  map TEXT,
		  PRIMARY KEY (id)
		  ) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS characters
		  (
		  id MEDIUMINT NOT NULL AUTO_INCREMENT,
		  HEXid char(6) unique,
		  date_created datetime default '0000-00-00 00:00:00',
		  current_state TINYINT,
		  primary_station char(3),
		  body_type TINYINT,
		  color_variant TINYINT,
		  name TEXT,
		  PRIMARY KEY (id),
		  FOREIGN KEY (primary_station) REFERENCES stations(station_ID)
		  ) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
          
  
CREATE TABLE IF NOT EXISTS features
		  (
		  id MEDIUMINT NOT NULL AUTO_INCREMENT UNIQUE,
		  HEXid char(6) unique,
		  front_sprite_filename TEXT,
		  front_depth_map TEXT,
		  front_anim_sprite_filename TEXT,
		  front_anim_depth_map TEXT,
		  back_sprite_filename TEXT,
		  back_depth_map TEXT,
		  back_anim_sprite_filename TEXT,
		  back_anim_depth_map TEXT, 
		  station_ID char(3),
          stage TINYINT,
          body_type TINYINT,
		  colorVar TINYINT,
		  hueShift TINYINT,
		  basestn char(3),
		  PRIMARY KEY (id), 
		  FOREIGN KEY (station_ID) REFERENCES stations(station_ID),
		  FOREIGN KEY (basestn) REFERENCES stations(station_ID)
		  ) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
 
CREATE TABLE IF NOT EXISTS visits
		  (
		  id MEDIUMINT NOT NULL AUTO_INCREMENT,        
		  date_posted datetime NOT NULL default '0000-00-00 00:00:00',
		  current_state TINYINT,
		  character_ID   char(6),
		  feature_ID     char(6),
		  svg_path TEXT,
		  audio_path TEXT,		  
		  FOREIGN KEY (character_ID)  REFERENCES characters(HEXid),
		  FOREIGN KEY (feature_ID)      REFERENCES features(HEXid),
		  FOREIGN KEY (feature_ID)      REFERENCES features(HEXid),
		  PRIMARY KEY (id)
		  ) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS scans
		  (
		  id MEDIUMINT NOT NULL AUTO_INCREMENT,
		  date_posted datetime NOT NULL default '0000-00-00 00:00:00',
		  character_ID char(6),
		  station_ID char(3),
		  FOREIGN KEY (character_ID)    REFERENCES characters(HEXid),
		  FOREIGN KEY (station_ID)      REFERENCES stations(station_ID),
		  PRIMARY KEY (id)
		  ) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

########################  
# ----- Stations ----- #
########################

INSERT INTO stations (station_ID, name, link)
		VALUES ("sci", "Science Arcade", "http://www.ontariosciencecentre.ca/Tour/Science-Arcade/");
		
INSERT INTO stations (station_ID, name, link)
		VALUES ("hum", "The Human Edge", "http://www.ontariosciencecentre.ca/Tour/TheAstraZenecaHumanEdge/");
		
INSERT INTO stations (station_ID, name, link)
		VALUES ("liv", "The Living Earth", "http://www.ontariosciencecentre.ca/Tour/Living-Earth/");
		
INSERT INTO stations (station_ID, name, link)
		VALUES ("inn", "Innovation Centre", "http://www.ontariosciencecentre.ca/Tour/WFIC/");
		
INSERT INTO stations (station_ID, name, link)
		VALUES ("spa", "Space", "http://www.ontariosciencecentre.ca/Tour/Space/");


########################
# -------------------- #
# ------- Eggs ------- #
# -------------------- #
########################


# ------ Human ------- #	  
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "01egg/hum_1.png", "01egg/hum_1.png", "01egg/hum_1.png", "01egg/hum_1.png", "01egg/hum_2.png", "01egg/hum_2.png", "01egg/hum_2.png", "01egg/hum_2.png", "hum", 0, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "01egg/hum_3.png", "01egg/hum_3.png", "01egg/hum_3.png", "01egg/hum_3.png", "01egg/hum_4.png", "01egg/hum_4.png", "01egg/hum_4.png", "01egg/hum_4.png", "hum", 0, 1);

# ---- Innovation ---- #	  
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "01egg/inn_1.png", "01egg/inn_1.png", "01egg/inn_1.png", "01egg/inn_1.png", "01egg/inn_2.png", "01egg/inn_2.png", "01egg/inn_2.png", "01egg/inn_2.png", "inn", 0, 0);

# --- Living Earth --- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "01egg/liv_1.png", "01egg/liv_1.png", "01egg/liv_1.png", "01egg/liv_1.png", "01egg/liv_2.png", "01egg/liv_2.png", "01egg/liv_2.png", "01egg/liv_2.png", "liv", 0, 0);

# -- Science Arcade -- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "01egg/sci_1.png", "01egg/sci_1.png", "01egg/sci_1.png", "01egg/sci_1.png", "01egg/sci_2.png", "01egg/sci_2.png", "01egg/sci_2.png", "01egg/sci_2.png", "sci", 0, 0);

# ------ Space ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "01egg/spa_1.png", "01egg/spa_1.png", "01egg/spa_1.png", "01egg/spa_1.png", "01egg/spa_2.png", "01egg/spa_2.png", "01egg/spa_2.png", "01egg/spa_2.png", "spa", 0, 0);


########################
# -------------------- #
# ------- Baby ------- #
# -------------------- #
########################


# ------ Human ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/hum_1_1.png", "02baby/hum_1_2.png", "02baby/hum_1_3.png", "02baby/hum_1_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "hum", 1, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/hum_2_1.png", "02baby/hum_2_2.png", "02baby/hum_2_3.png", "02baby/hum_2_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "hum", 1, 1);

# ---- Innovation ---- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/inn_1_1.png", "02baby/inn_1_2.png", "02baby/inn_1_3.png", "02baby/inn_1_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "inn", 1, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/inn_2_1.png", "02baby/inn_2_2.png", "02baby/inn_2_3.png", "02baby/inn_2_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "inn", 1, 1);

# --- Living Earth --- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/liv_1_1.png", "02baby/liv_1_2.png", "02baby/liv_1_3.png", "02baby/liv_1_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "liv", 1, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/liv_2_1.png", "02baby/liv_2_2.png", "02baby/liv_2_3.png", "02baby/liv_2_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "liv", 1, 1);

# -- Science Arcade -- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/sci_1_1.png", "02baby/sci_1_2.png", "02baby/sci_1_3.png", "02baby/sci_1_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "sci", 1, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/sci_2_1.png", "02baby/sci_2_2.png", "02baby/sci_2_3.png", "02baby/sci_2_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "sci", 1, 1);

# ------ Space ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/spa_1_1.png", "02baby/spa_1_2.png", "02baby/spa_1_3.png", "02baby/spa_1_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "spa", 1, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "02baby/spa_2_1.png", "02baby/spa_2_2.png", "02baby/spa_2_3.png", "02baby/spa_2_4.png", "02baby/depth_1.png", "02baby/depth_2.png", "02baby/depth_3.png", "02baby/depth_4.png", "spa", 1, 1);


########################
# -------------------- #
# ------- Worm ------- #
# -------------------- #
########################


# ------ Human ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/hum_1_1.png", "03worm/hum_1_2.png", "03worm/hum_1_3.png", "03worm/hum_1_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "hum", 2, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/hum_2_1.png", "03worm/hum_2_2.png", "03worm/hum_2_3.png", "03worm/hum_2_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "hum", 2, 1);

# ---- Innovation ---- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/inn_1_1.png", "03worm/inn_1_2.png", "03worm/inn_1_3.png", "03worm/inn_1_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "inn", 2, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/inn_2_1.png", "03worm/inn_2_2.png", "03worm/inn_2_3.png", "03worm/inn_2_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "inn", 2, 1);

# --- Living Earth --- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/liv_1_1.png", "03worm/liv_1_2.png", "03worm/liv_1_3.png", "03worm/liv_1_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "liv", 2, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/liv_2_1.png", "03worm/liv_2_2.png", "03worm/liv_2_3.png", "03worm/liv_2_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "liv", 2, 1);

# -- Science Arcade -- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/sci_1_1.png", "03worm/sci_1_2.png", "03worm/sci_1_3.png", "03worm/sci_1_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "sci", 2, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/sci_2_1.png", "03worm/sci_2_2.png", "03worm/sci_2_3.png", "03worm/sci_2_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "sci", 2, 1);

# ------ Space ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/spa_1_1.png", "03worm/spa_1_2.png", "03worm/spa_1_3.png", "03worm/spa_1_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "spa", 2, 0);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, stage, colorVar, hueShift)
		VALUES ("*", "03worm/spa_2_1.png", "03worm/spa_2_2.png", "03worm/spa_2_3.png", "03worm/spa_2_4.png", "03worm/depth_1.png", "03worm/depth_2.png", "03worm/depth_3.png", "03worm/depth_4.png", "spa", 2, 1);

########################
# -------------------- #
# ------- Adult ------ #
# -------------------- #
########################


########################
# ------ Base  ------- #
# ------ Human ------- #
########################

# ---- Innovation ---- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-hum/inn_1_1.png", "04adult/type1-hum/inn_1_2.png", "04adult/type1-hum/inn_1_3.png", "04adult/type1-hum/inn_1_4.png", "04adult/type1-hum/depth_1.png", "04adult/type1-hum/depth_2.png", "04adult/type1-hum/depth_3.png", "04adult/type1-hum/depth_4.png", "inn", 1, 3, 1, "hum");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-hum/inn_2_1.png", "04adult/type1-hum/inn_2_2.png", "04adult/type1-hum/inn_2_3.png", "04adult/type1-hum/inn_2_4.png", "04adult/type1-hum/depth_1.png", "04adult/type1-hum/depth_2.png", "04adult/type1-hum/depth_3.png", "04adult/type1-hum/depth_4.png", "inn", 1, 3, 0, "hum");

# --- Living Earth --- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-hum/liv_1_1.png", "04adult/type1-hum/liv_1_2.png", "04adult/type1-hum/liv_1_3.png", "04adult/type1-hum/liv_1_4.png", "04adult/type1-hum/depth_1.png", "04adult/type1-hum/depth_2.png", "04adult/type1-hum/depth_3.png", "04adult/type1-hum/depth_4.png", "liv", 1, 3, 1, "hum");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-hum/liv_2_1.png", "04adult/type1-hum/liv_2_2.png", "04adult/type1-hum/liv_2_3.png", "04adult/type1-hum/liv_2_4.png", "04adult/type1-hum/depth_1.png", "04adult/type1-hum/depth_2.png", "04adult/type1-hum/depth_3.png", "04adult/type1-hum/depth_4.png", "liv", 1, 3, 0, "hum");

# -- Science Arcade -- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-hum/sci_1_1.png", "04adult/type1-hum/sci_1_2.png", "04adult/type1-hum/sci_1_3.png", "04adult/type1-hum/sci_1_4.png", "04adult/type1-hum/depth_1.png", "04adult/type1-hum/depth_2.png", "04adult/type1-hum/depth_3.png", "04adult/type1-hum/depth_4.png", "sci", 1, 3, 1, "hum");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-hum/sci_2_1.png", "04adult/type1-hum/sci_2_2.png", "04adult/type1-hum/sci_2_3.png", "04adult/type1-hum/sci_2_4.png", "04adult/type1-hum/depth_1.png", "04adult/type1-hum/depth_2.png", "04adult/type1-hum/depth_3.png", "04adult/type1-hum/depth_4.png", "sci", 1, 3, 0, "hum");

# ------ Space ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-hum/spa_1_1.png", "04adult/type1-hum/spa_1_2.png", "04adult/type1-hum/spa_1_3.png", "04adult/type1-hum/spa_1_4.png", "04adult/type1-hum/depth_1.png", "04adult/type1-hum/depth_2.png", "04adult/type1-hum/depth_3.png", "04adult/type1-hum/depth_4.png", "spa", 1, 3, 1, "hum");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-hum/spa_2_1.png", "04adult/type1-hum/spa_2_2.png", "04adult/type1-hum/spa_2_3.png", "04adult/type1-hum/spa_2_4.png", "04adult/type1-hum/depth_1.png", "04adult/type1-hum/depth_2.png", "04adult/type1-hum/depth_3.png", "04adult/type1-hum/depth_4.png", "spa", 1, 3, 0, "hum");



########################
# ------  Base  ------ #
# --- Living Earth --- #
########################

# ------ Human ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-liv/hum_1_1.png", "04adult/type1-liv/hum_1_2.png", "04adult/type1-liv/hum_1_3.png", "04adult/type1-liv/hum_1_4.png", "04adult/type1-liv/depth_1.png", "04adult/type1-liv/depth_2.png", "default/default.png", "default/default.png", "hum", 1, 3, 1, "liv");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-liv/hum_2_1.png", "04adult/type1-liv/hum_2_2.png", "04adult/type1-liv/hum_2_3.png", "04adult/type1-liv/hum_2_4.png", "04adult/type1-liv/depth_1.png", "04adult/type1-liv/depth_2.png", "default/default.png", "default/default.png", "hum", 1, 3, 0, "liv");

# ---- Innovation ---- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-liv/inn_1_1.png", "04adult/type1-liv/inn_1_2.png", "04adult/type1-liv/inn_1_3.png", "04adult/type1-liv/inn_1_4.png", "04adult/type1-liv/depth_1.png", "04adult/type1-liv/depth_2.png", "default/default.png", "default/default.png", "inn", 1, 3, 1, "liv");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-liv/inn_2_1.png", "04adult/type1-liv/inn_2_2.png", "04adult/type1-liv/inn_2_3.png", "04adult/type1-liv/inn_2_4.png", "04adult/type1-liv/depth_1.png", "04adult/type1-liv/depth_2.png", "default/default.png", "default/default.png", "inn", 1, 3, 0, "liv");

# -- Science Arcade -- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-liv/sci_1_1.png", "04adult/type1-liv/sci_1_2.png", "04adult/type1-liv/sci_1_3.png", "04adult/type1-liv/sci_1_4.png", "04adult/type1-liv/depth_1.png", "04adult/type1-liv/depth_2.png", "default/default.png", "default/default.png", "sci", 1, 3, 1, "liv");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-liv/sci_2_1.png", "04adult/type1-liv/sci_2_2.png", "04adult/type1-liv/sci_2_3.png", "04adult/type1-liv/sci_2_4.png", "04adult/type1-liv/depth_1.png", "04adult/type1-liv/depth_2.png", "default/default.png", "default/default.png", "sci", 1, 3, 0, "liv");

# ------ Space ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-liv/spa_1_1.png", "04adult/type1-liv/spa_1_2.png", "04adult/type1-liv/spa_1_3.png", "04adult/type1-liv/spa_1_4.png", "04adult/type1-liv/depth_1.png", "04adult/type1-liv/depth_2.png", "default/default.png", "default/default.png", "spa", 1, 3, 1, "liv");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-liv/spa_2_1.png", "04adult/type1-liv/spa_2_2.png", "04adult/type1-liv/spa_2_3.png", "04adult/type1-liv/spa_2_4.png", "04adult/type1-liv/depth_1.png", "04adult/type1-liv/depth_2.png", "default/default.png", "default/default.png", "spa", 1, 3, 0, "liv");

########################
# ------  Base  ------ #
# -- Science Arcade -- #
########################

# ------ Human ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-sci/hum_1_1.png", "04adult/type1-sci/hum_1_2.png", "04adult/type1-sci/hum_1_3.png", "04adult/type1-sci/hum_1_3.png", "04adult/type1-sci/hum_1_1d.png", "04adult/type1-sci/hum_1_2d.png", "04adult/type1-sci/hum_1_3d.png", "04adult/type1-sci/hum_1_3d.png", "hum", 1, 3, 1, "sci");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-sci/hum_2_1.png", "04adult/type1-sci/hum_2_2.png", "04adult/type1-sci/hum_2_3.png", "04adult/type1-sci/hum_2_3.png", "04adult/type1-sci/hum_2_1d.png", "04adult/type1-sci/hum_2_2d.png", "04adult/type1-sci/hum_2_3d.png", "04adult/type1-sci/hum_2_3d.png", "hum", 1, 3, 0, "sci");

# ---- Innovation ---- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-sci/inn_1_1.png", "04adult/type1-sci/inn_1_2.png", "04adult/type1-sci/inn_1_3.png", "04adult/type1-sci/inn_1_3.png", "04adult/type1-sci/inn_1_1d.png", "04adult/type1-sci/inn_1_2d.png", "04adult/type1-sci/inn_1_3d.png", "04adult/type1-sci/inn_1_3d.png", "inn", 1, 3, 1, "sci");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-sci/inn_2_1.png", "04adult/type1-sci/inn_2_2.png", "04adult/type1-sci/inn_2_3.png", "04adult/type1-sci/inn_2_3.png", "04adult/type1-sci/inn_2_1d.png", "04adult/type1-sci/inn_2_2d.png", "04adult/type1-sci/inn_2_3d.png", "04adult/type1-sci/inn_2_3d.png", "inn", 1, 3, 0, "sci");

# --- Living Earth --- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-sci/liv_1_1.png", "04adult/type1-sci/liv_1_2.png", "04adult/type1-sci/liv_1_3.png", "04adult/type1-sci/liv_1_3.png", "04adult/type1-sci/liv_1_1d.png", "04adult/type1-sci/liv_1_2d.png", "04adult/type1-sci/liv_1_3d.png", "04adult/type1-sci/liv_1_3d.png", "liv", 1, 3, 1, "sci");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-sci/liv_2_1.png", "04adult/type1-sci/liv_2_2.png", "04adult/type1-sci/liv_2_3.png", "04adult/type1-sci/liv_2_3.png", "04adult/type1-sci/liv_2_1d.png", "04adult/type1-sci/liv_2_2d.png", "04adult/type1-sci/liv_2_3d.png", "04adult/type1-sci/liv_2_3d.png", "liv", 1, 3, 0, "sci");

# ------ Space ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-sci/spa_1_1.png", "04adult/type1-sci/spa_1_2.png", "04adult/type1-sci/spa_1_3.png", "04adult/type1-sci/spa_1_3.png", "04adult/type1-sci/spa_1_1d.png", "04adult/type1-sci/spa_1_2d.png", "04adult/type1-sci/spa_1_3d.png", "04adult/type1-sci/spa_1_3d.png", "spa", 1, 3, 1, "sci");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type1-sci/spa_2_1.png", "04adult/type1-sci/spa_2_2.png", "04adult/type1-sci/spa_2_3.png", "04adult/type1-sci/spa_2_3.png", "04adult/type1-sci/spa_2_1d.png", "04adult/type1-sci/spa_2_2d.png", "04adult/type1-sci/spa_2_3d.png", "04adult/type1-sci/spa_2_3d.png", "spa", 1, 3, 0, "sci");

########################
# ------  Base  ------ #
# ---- Innovation ---- #
########################

# ------ Human ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-inn/hum_1_1.png", "04adult/type2-inn/hum_1_2.png", "04adult/type2-inn/hum_1_3.png", "04adult/type2-inn/hum_1_3.png", "04adult/type2-inn/hum_1_1d.png", "04adult/type2-inn/hum_1_2d.png", "04adult/type2-inn/hum_1_3d.png", "04adult/type2-inn/hum_1_3d.png", "hum", 2, 3, 0, "inn");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-inn/hum_2_1.png", "04adult/type2-inn/hum_2_2.png", "04adult/type2-inn/hum_2_3.png", "04adult/type2-inn/hum_2_3.png", "04adult/type2-inn/hum_2_1d.png", "04adult/type2-inn/hum_2_2d.png", "04adult/type2-inn/hum_2_3d.png", "04adult/type2-inn/hum_2_3d.png", "hum", 2, 3, 1, "inn");

# --- Living Earth --- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-inn/liv_1_1.png", "04adult/type2-inn/liv_1_2.png", "04adult/type2-inn/liv_1_3.png", "04adult/type2-inn/liv_1_3.png", "04adult/type2-inn/liv_1_1d.png", "04adult/type2-inn/liv_1_2d.png", "04adult/type2-inn/liv_1_3d.png", "04adult/type2-inn/liv_1_3d.png", "liv", 2, 3, 0, "inn");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-inn/liv_2_1.png", "04adult/type2-inn/liv_2_2.png", "04adult/type2-inn/liv_2_3.png", "04adult/type2-inn/liv_2_3.png", "04adult/type2-inn/liv_2_1d.png", "04adult/type2-inn/liv_2_2d.png", "04adult/type2-inn/liv_2_3d.png", "04adult/type2-inn/liv_2_3d.png", "liv", 2, 3, 1, "inn");

# -- Science Arcade -- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-inn/sci_1_1.png", "04adult/type2-inn/sci_1_2.png", "04adult/type2-inn/sci_1_3.png", "04adult/type2-inn/sci_1_3.png", "04adult/type2-inn/sci_1_1d.png", "04adult/type2-inn/sci_1_2d.png", "04adult/type2-inn/sci_1_3d.png", "04adult/type2-inn/sci_1_3d.png", "sci", 2, 3, 0, "inn");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-inn/sci_2_1.png", "04adult/type2-inn/sci_2_2.png", "04adult/type2-inn/sci_2_3.png", "04adult/type2-inn/sci_2_3.png", "04adult/type2-inn/sci_2_1d.png", "04adult/type2-inn/sci_2_2d.png", "04adult/type2-inn/sci_2_3d.png", "04adult/type2-inn/sci_2_3d.png", "sci", 2, 3, 1, "inn");

# ------ Space ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-inn/spa_1_1.png", "04adult/type2-inn/spa_1_2.png", "04adult/type2-inn/spa_1_3.png", "04adult/type2-inn/spa_1_3.png", "04adult/type2-inn/spa_1_1d.png", "04adult/type2-inn/spa_1_2d.png", "04adult/type2-inn/spa_1_3d.png", "04adult/type2-inn/spa_1_3d.png", "spa", 2, 3, 0, "inn");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-inn/spa_2_1.png", "04adult/type2-inn/spa_2_2.png", "04adult/type2-inn/spa_2_3.png", "04adult/type2-inn/spa_2_3.png", "04adult/type2-inn/spa_2_1d.png", "04adult/type2-inn/spa_2_2d.png", "04adult/type2-inn/spa_2_3d.png", "04adult/type2-inn/spa_2_3d.png", "spa", 2, 3, 1, "inn");


########################
# ------ Base  ------- #
# ------ Space ------- #
########################

# ------ Human ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-spa/hum_1_1.png", "04adult/type2-spa/hum_1_2.png", "04adult/type2-spa/hum_1_3.png", "04adult/type2-spa/hum_1_4.png", "04adult/type2-spa/depth_1.png", "04adult/type2-spa/depth_2.png", "default/default.png", "default/default.png", "hum", 2, 3, 0, "spa");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-spa/hum_2_1.png", "04adult/type2-spa/hum_2_2.png", "04adult/type2-spa/hum_2_3.png", "04adult/type2-spa/hum_2_4.png", "04adult/type2-spa/depth_1.png", "04adult/type2-spa/depth_2.png", "default/default.png", "default/default.png", "hum", 2, 3, 1, "spa");

# --- Living Earth --- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-spa/liv_1_1.png", "04adult/type2-spa/liv_1_2.png", "04adult/type2-spa/liv_1_3.png", "04adult/type2-spa/liv_1_4.png", "04adult/type2-spa/depth_1.png", "04adult/type2-spa/depth_2.png", "default/default.png", "default/default.png", "liv", 2, 3, 0, "spa");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-spa/liv_2_1.png", "04adult/type2-spa/liv_2_2.png", "04adult/type2-spa/liv_2_3.png", "04adult/type2-spa/liv_2_4.png", "04adult/type2-spa/depth_1.png", "04adult/type2-spa/depth_2.png", "default/default.png", "default/default.png", "liv", 2, 3, 1, "spa");

# -- Science Arcade -- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-spa/sci_1_1.png", "04adult/type2-spa/sci_1_2.png", "04adult/type2-spa/sci_1_3.png", "04adult/type2-spa/sci_1_4.png", "04adult/type2-spa/depth_1.png", "04adult/type2-spa/depth_2.png", "default/default.png", "default/default.png", "sci", 2, 3, 0, "spa");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-spa/sci_2_1.png", "04adult/type2-spa/sci_2_2.png", "04adult/type2-spa/sci_2_3.png", "04adult/type2-spa/sci_2_4.png", "04adult/type2-spa/depth_1.png", "04adult/type2-spa/depth_2.png", "default/default.png", "default/default.png", "sci", 2, 3, 1, "spa");

# ---- Innovation ---- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-spa/inn_1_1.png", "04adult/type2-spa/inn_1_2.png", "04adult/type2-spa/inn_1_3.png", "04adult/type2-spa/inn_1_4.png", "04adult/type2-spa/depth_1.png", "04adult/type2-spa/depth_2.png", "default/default.png", "default/default.png", "inn", 2, 3, 0, "spa");

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, colorVar, basestn, hueShift)
		VALUES ("*", "04adult/type2-spa/inn_2_1.png", "04adult/type2-spa/inn_2_2.png", "04adult/type2-spa/inn_2_3.png", "04adult/type2-spa/inn_2_4.png", "04adult/type2-spa/depth_1.png", "04adult/type2-spa/depth_2.png", "default/default.png", "default/default.png", "inn", 2, 3, 1, "spa");

########################
# -------------------- #
# ---- Accessories --- #
# -------------------- #
########################

# ------ Human ------- #
# ------ Type1 ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/hum_f_1_1.png", "05accessories/forType1/hum_f_1_1.png", "05accessories/forType1/hum_f_1_2.png", "05accessories/forType1/hum_f_1_2.png", "05accessories/forType1/hum_f_1_1d.png", "05accessories/forType1/hum_f_1_1d.png", "default/default.png", "default/default.png", "hum", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/hum_f_1_1.png", "05accessories/forType1/hum_f_1_1.png", "default/default.png", "default/default.png", "05accessories/forType1/hum_f_1_1d.png", "05accessories/forType1/hum_f_1_1d.png", "default/default.png", "default/default.png", "hum", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/hum_f_2_1.png", "05accessories/forType1/hum_f_2_1.png", "default/default.png", "default/default.png", "05accessories/forType1/hum_f_2_1d.png", "05accessories/forType1/hum_f_2_1d.png", "default/default.png", "default/default.png", "hum", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/hum_f_3_1.png", "05accessories/forType1/hum_f_3_1.png", "default/default.png", "default/default.png", "05accessories/forType1/hum_f_3_1d.png", "05accessories/forType1/hum_f_3_1d.png", "default/default.png", "default/default.png", "hum", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/hum_f_4_1.png", "05accessories/forType1/hum_f_4_1.png", "default/default.png", "default/default.png", "05accessories/forType1/hum_f_4_1d.png", "05accessories/forType1/hum_f_4_1d.png", "default/default.png", "default/default.png", "hum", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/hum_f_5_1.png", "05accessories/forType1/hum_f_5_1.png", "default/default.png", "default/default.png", "05accessories/forType1/hum_f_5_1d.png", "05accessories/forType1/hum_f_5_1d.png", "default/default.png", "default/default.png", "hum", 1, 4);

# ------ Type2 ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/hum_f_1_1.png", "05accessories/forType2/hum_f_1_1.png", "05accessories/forType2/hum_f_1_2.png", "05accessories/forType2/hum_f_1_2.png", "05accessories/forType2/hum_f_1_1d.png", "05accessories/forType2/hum_f_1_1d.png", "default/default.png", "default/default.png", "hum", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/hum_f_2_1.png", "05accessories/forType2/hum_f_2_1.png", "default/default.png", "default/default.png", "05accessories/forType2/hum_f_2_1d.png", "05accessories/forType2/hum_f_2_1d.png", "default/default.png", "default/default.png", "hum", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/hum_f_3_1.png", "05accessories/forType2/hum_f_3_1.png", "default/default.png", "default/default.png", "05accessories/forType2/hum_f_3_1d.png", "05accessories/forType2/hum_f_3_1d.png", "default/default.png", "default/default.png", "hum", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/hum_f_4_1.png", "05accessories/forType2/hum_f_4_1.png", "default/default.png", "default/default.png", "05accessories/forType2/hum_f_4_1d.png", "05accessories/forType2/hum_f_4_1d.png", "default/default.png", "default/default.png", "hum", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/hum_f_5_1.png", "05accessories/forType2/hum_f_5_1.png", "default/default.png", "default/default.png", "05accessories/forType2/hum_f_5_1d.png", "05accessories/forType2/hum_f_5_1d.png", "default/default.png", "default/default.png", "hum", 2, 4);

# ---- Innovation ---- #
# ------ Type1 ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/inn_b_1_1.png", "05accessories/forType1/inn_b_1_1.png", "default/default.png", "default/default.png", "05accessories/forType1/inn_b_1_1d.png", "05accessories/forType1/inn_b_1_1d.png", "default/default.png", "default/default.png", "inn", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/inn_f_4_1.png", "05accessories/forType1/inn_f_4_1.png", "default/default.png", "default/default.png", "05accessories/forType1/inn_f_4_1d.png", "05accessories/forType1/inn_f_4_1d.png", "default/default.png", "default/default.png", "inn", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/inn_f_5_1.png", "05accessories/forType1/inn_f_5_1.png", "default/default.png", "default/default.png", "05accessories/forType1/inn_f_5_1d.png", "05accessories/forType1/inn_f_5_1d.png", "default/default.png", "default/default.png", "inn", 1, 4);

# ------ Type2 ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/inn_b_1_1.png", "05accessories/forType2/inn_b_1_1.png", "default/dDQefault.png", "default/default.png", "05accessories/forType2/inn_b_1_1d.png", "05accessories/forType2/inn_b_1_1d.png", "default/default.png", "default/default.png", "inn", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/inn_f_1_1.png", "05accessories/forType2/inn_f_1_1.png", "default/default.png", "default/default.png", "05accessories/forType2/inn_f_1_1d.png", "05accessories/forType2/inn_f_1_1d.png", "default/default.png", "default/default.png", "inn", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/inn_f_2_1.png", "05accessories/forType2/inn_f_2_1.png", "default/default.png", "default/default.png", "05accessories/forType2/inn_f_2_1d.png", "05accessories/forType2/inn_f_2_1d.png", "default/default.png", "default/default.png", "inn", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/inn_f_3_1.png", "05accessories/forType2/inn_f_3_1.png", "default/default.png", "default/default.png", "05accessories/forType2/inn_f_3_1d.png", "05accessories/forType2/inn_f_3_1d.png", "default/default.png", "default/default.png", "inn", 2, 4);

# --- Living Earth --- #
# ------ Type1 ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/liv_b_1_1.png", "05accessories/forType1/liv_b_1_1.png", "default/default.png", "default/default.png", "05accessories/forType1/liv_b_1_1d.png", "05accessories/forType1/liv_b_1_1d.png", "default/default.png", "default/default.png", "liv", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/liv_f_1_1.png", "05accessories/forType1/liv_f_1_1.png", "default/default.png", "default/default.png", "05accessories/forType1/liv_f_1_1d.png", "05accessories/forType1/liv_f_1_1d.png", "default/default.png", "default/default.png", "liv", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/liv_f_2_1.png", "05accessories/forType1/liv_f_2_1.png", "default/default.png", "default/default.png", "05accessories/forType1/liv_f_2_1d.png", "05accessories/forType1/liv_f_2_1d.png", "default/default.png", "default/default.png", "liv", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/liv_f_3_1.png", "05accessories/forType1/liv_f_3_1.png", "default/default.png", "default/default.png", "05accessories/forType1/liv_f_3_1d.png", "05accessories/forType1/liv_f_3_1d.png", "default/default.png", "default/default.png", "liv", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/liv_f_4_1.png", "05accessories/forType1/liv_f_4_1.png", "default/default.png", "default/default.png", "05accessories/forType1/liv_f_4_1d.png", "05accessories/forType1/liv_f_4_1d.png", "default/default.png", "default/default.png", "liv", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/liv_f_5_1.png", "05accessories/forType1/liv_f_5_1.png", "default/default.png", "default/default.png", "05accessories/forType1/liv_f_5_1d.png", "05accessories/forType1/liv_f_5_1d.png", "default/default.png", "default/default.png", "liv", 1, 4);


# ------ Type2 ------- #

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/liv_f_1_1.png", "05accessories/forType2/liv_f_1_1.png", "default/default.png", "default/default.png", "05accessories/forType2/liv_f_1_1d.png", "05accessories/forType2/liv_f_1_1d.png", "default/default.png", "default/default.png", "liv", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/liv_f_3_1.png", "05accessories/forType2/liv_f_3_1.png", "default/default.png", "default/default.png", "05accessories/forType2/liv_f_3_1d.png", "05accessories/forType2/liv_f_3_1d.png", "default/default.png", "default/default.png", "liv", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/liv_f_4_1.png", "05accessories/forType2/liv_f_4_1.png", "default/default.png", "default/default.png", "05accessories/forType2/liv_f_4_1d.png", "05accessories/forType2/liv_f_4_1d.png", "default/default.png", "default/default.png", "liv", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/liv_f_5_1.png", "05accessories/forType2/liv_f_5_1.png", "default/default.png", "default/default.png", "05accessories/forType2/liv_f_5_1d.png", "05accessories/forType2/liv_f_5_1d.png", "default/default.png", "default/default.png", "liv", 2, 4);

# -- Science Arcade -- #
# ------ Type1 ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/sci_b_1_1.png", "05accessories/forType1/sci_b_1_1.png", "default/default.png", "default/default.png", "05accessories/forType1/sci_b_1_1d.png", "05accessories/forType1/sci_b_1_1d.png", "default/default.png", "default/default.png", "sci", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/sci_f_1_1.png", "05accessories/forType1/sci_f_1_1.png", "default/default.png", "default/default.png", "05accessories/forType1/sci_f_1_1d.png", "05accessories/forType1/sci_f_1_1d.png", "default/default.png", "default/default.png", "sci", 1, 4);

# ------ Type2 ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/sci_b_1_1.png", "05accessories/forType2/sci_b_1_1.png", "default/default.png", "default/default.png", "05accessories/forType2/sci_b_1_1d.png", "05accessories/forType2/sci_b_1_1d.png", "default/default.png", "default/default.png", "sci", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/sci_f_2_1.png", "05accessories/forType2/sci_f_2_1.png", "default/default.png", "default/default.png", "05accessories/forType2/sci_f_2_1d.png", "05accessories/forType2/sci_f_2_1d.png", "default/default.png", "default/default.png", "sci", 2, 4);

# ------ Space ------- #
# ------ Type1 ------- #
INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/spa_f_1_1.png", "05accessories/forType1/spa_f_1_1.png", "default/default.png", "default/default.png", "05accessories/forType1/spa_f_1_1d.png", "05accessories/forType1/spa_f_1_1d.png", "default/default.png", "default/default.png", "spa", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/spa_f_2_1.png", "05accessories/forType1/spa_f_2_1.png", "default/default.png", "default/default.png", "05accessories/forType1/spa_f_2_1d.png", "05accessories/forType1/spa_f_2_1d.png", "default/default.png", "default/default.png", "spa", 1, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType1/spa_f_3_1.png", "05accessories/forType1/spa_f_3_1.png", "default/default.png", "default/default.png", "05accessories/forType1/spa_f_3_1d.png", "05accessories/forType1/spa_f_3_1d.png", "default/default.png", "default/default.png", "spa", 1, 4);

# ------ Type2 ------- #

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/spa_f_2_1.png", "05accessories/forType2/spa_f_2_1.png", "default/default.png", "default/default.png", "05accessories/forType2/spa_f_2_1d.png", "05accessories/forType2/spa_f_2_1d.png", "default/default.png", "default/default.png", "spa", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/spa_f_4_1.png", "05accessories/forType2/spa_f_4_1.png", "default/default.png", "default/default.png", "05accessories/forType2/spa_f_4_1d.png", "05accessories/forType2/spa_f_4_1d.png", "default/default.png", "default/default.png", "spa", 2, 4);

INSERT INTO features (HEXid, front_sprite_filename, front_anim_sprite_filename, back_sprite_filename, back_anim_sprite_filename, front_depth_map, front_anim_depth_map, back_depth_map, back_anim_depth_map, station_id, body_type, stage, hueShift)
		VALUES ("*", "05accessories/forType2/spa_f_5_1.png", "05accessories/forType2/spa_f_5_1.png", "default/default.png", "default/default.png", "05accessories/forType2/spa_f_5_1d.png", "05accessories/forType2/spa_f_5_1d.png", "default/default.png", "default/default.png", "spa", 2, 4);

