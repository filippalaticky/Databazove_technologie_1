CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;

CREATE TABLE IF NOT EXISTS `dim_users` (
  `user_key` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `gender` CHAR(1) NULL,
  `age` INT NULL,
  `age_group` VARCHAR(45) NULL,
  `zip_code` VARCHAR(255) NULL,
  `occupation` VARCHAR(255) NULL,
  PRIMARY KEY (`user_key`),
  UNIQUE INDEX `uq_dim_users_user_id` (`user_id`)
);

CREATE TABLE IF NOT EXISTS `dim_movies` (
  `movie_key` INT NOT NULL AUTO_INCREMENT,
  `movie_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `release_year` CHAR(4) NULL,
  PRIMARY KEY (`movie_key`),
  UNIQUE INDEX `uq_dim_movies_movie_id` (`movie_id`)
);

CREATE TABLE IF NOT EXISTS `dim_genres` (
  `genre_key` INT NOT NULL AUTO_INCREMENT,
  `genre_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`genre_key`),
  UNIQUE INDEX `uq_dim_genres_genre_id` (`genre_id`)
);

CREATE TABLE IF NOT EXISTS `dim_date` (
  `date_key` INT NOT NULL,
  `full_date` DATE NOT NULL,
  `day` SMALLINT NOT NULL,
  `month` SMALLINT NOT NULL,
  `month_name` VARCHAR(20) NOT NULL,
  `quarter` SMALLINT NOT NULL,
  `year` SMALLINT NOT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE INDEX `uq_dim_date_full_date` (`full_date`)
);

CREATE TABLE IF NOT EXISTS `bridge_movie_genres` (
  `movie_key` INT NOT NULL,
  `genre_key` INT NOT NULL,
  PRIMARY KEY (`movie_key`, `genre_key`),
  INDEX `idx_bridge_genre` (`genre_key`),
  CONSTRAINT `fk_bridge_movie`
    FOREIGN KEY (`movie_key`) REFERENCES `dim_movies` (`movie_key`),
  CONSTRAINT `fk_bridge_genre`
    FOREIGN KEY (`genre_key`) REFERENCES `dim_genres` (`genre_key`)
);

CREATE TABLE IF NOT EXISTS `fact_ratings` (
  `rating_key` BIGINT NOT NULL AUTO_INCREMENT,
  `user_key` INT NOT NULL,
  `movie_key` INT NOT NULL,
  `date_key` INT NOT NULL,
  `rating` SMALLINT NOT NULL,
  `rated_at` DATETIME NULL,
  PRIMARY KEY (`rating_key`),
  INDEX `idx_fact_user` (`user_key`),
  INDEX `idx_fact_movie` (`movie_key`),
  INDEX `idx_fact_date` (`date_key`),
  CONSTRAINT `fk_fact_user`
    FOREIGN KEY (`user_key`) REFERENCES `dim_users` (`user_key`),
  CONSTRAINT `fk_fact_movie`
    FOREIGN KEY (`movie_key`) REFERENCES `dim_movies` (`movie_key`),
  CONSTRAINT `fk_fact_date`
    FOREIGN KEY (`date_key`) REFERENCES `dim_date` (`date_key`)
);