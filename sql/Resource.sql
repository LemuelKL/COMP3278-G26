CREATE TABLE `facerecognition`.`resource` (
  `resource_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `url` VARCHAR(200) NOT NULL,
  `name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`resource_id`),
  CONSTRAINT `resource_ibfk_1`
    FOREIGN KEY (`course_id`)
    REFERENCES `facerecognition`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
