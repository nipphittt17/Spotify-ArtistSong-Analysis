CREATE DATABASE IF NOT EXISTS spotify;
USE spotify;

CREATE TABLE albums(
	album_id VARCHAR(50) NOT NULL,
	album_name VARCHAR(100) NOT NULL,
	album_type ENUM("album", "single","compilation") NOT NULL,
    total_tracks INT NOT NULL,
    popularity INT,
    href VARCHAR(200) NOT NULL,
    release_date DATE NOT NULL,
    uri VARCHAR(200) NOT NULL,
    PRIMARY KEY (album_id)
);

CREATE TABLE tracks(
	track_id VARCHAR(50) NOT NULL,
    track_name VARCHAR(100) NOT NULL,
    duration_ms INT NOT NULL,
    href VARCHAR(200) NOT NULL,
    popularity INT,
    uri VARCHAR(200) NOT NULL,
    album_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (track_id),
	FOREIGN KEY (album_id) REFERENCES albums(album_id)
)
