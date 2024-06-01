CREATE DATABASE IF NOT EXISTS Track; 

USE Track;

-- import table from track_data_cleaned.csv or track_data_cleaned.json

SELECT * FROM track_data_cleaned;

-- modify some columns' name
ALTER TABLE track_data_cleaned
RENAME COLUMN `key` to track_key,
RENAME COLUMN `mode` to track_mode;

-- modify the columns' datatype
ALTER TABLE track_data_cleaned
MODIFY COLUMN track_id VARCHAR(50),
MODIFY COLUMN track_name VARCHAR(50),
MODIFY COLUMN href VARCHAR(100),
MODIFY COLUMN popularity INT,
MODIFY COLUMN uri VARCHAR(100),
MODIFY COLUMN album_id VARCHAR(50),
MODIFY COLUMN duration FLOAT,
MODIFY COLUMN loudness FLOAT,
MODIFY COLUMN tempo FLOAT,
MODIFY COLUMN time_signature CHAR(3),
MODIFY COLUMN track_key ENUM( "No Key","C","C#/Db","D","D#/Eb","E","F","F#/Gb","G","G#/Ab","A","A#/Bb","B"),
MODIFY COLUMN track_mode ENUM('Major','Minor'),
MODIFY COLUMN acousticness FLOAT,
MODIFY COLUMN energy FLOAT,
MODIFY COLUMN danceability FLOAT,
MODIFY COLUMN album_name VARCHAR(50),
MODIFY COLUMN album_type ENUM('album','single'),
MODIFY COLUMN album_popularity INT,
MODIFY COLUMN release_date DATE,
MODIFY COLUMN total_tracks INT,
MODIFY COLUMN album_uri VARCHAR(100),
MODIFY COLUMN album_href VARCHAR(100);

-- begin analysis

-- 1. top 10 track
SELECT track_name, album_name, popularity
FROM track_data_cleaned
ORDER BY popularity DESC
LIMIT 10;

-- 2. album and the released year
WITH ranked_track_album AS (
    SELECT track_name, album_name, popularity, YEAR(release_date) as released_year, total_tracks, album_type,
        ROW_NUMBER() OVER (PARTITION BY album_name ORDER BY popularity DESC) AS rank_track
    FROM track_data_cleaned
)
SELECT album_name,released_year, total_tracks, track_name as 'top track', popularity as track_popularity
FROM ranked_track_album
WHERE album_type = 'album' and rank_track = 1;

-- 3. average track popularity by released year
SELECT YEAR(release_date) AS released_year, COUNT(track_id) AS total_tracks, ROUND(AVG(popularity),2) AS avg_track_popularity
FROM track_data_cleaned
GROUP BY released_year
ORDER BY released_year;

-- 4. top track by year
WITH ranked_track_year AS (
    SELECT track_id,track_name, YEAR(release_date) AS released_year, popularity,
        ROW_NUMBER() OVER (PARTITION BY YEAR(release_date) ORDER BY popularity DESC) AS rank_track
    FROM track_data_cleaned
)
SELECT released_year,track_name
FROM ranked_track_year
WHERE rank_track = 1
ORDER BY released_year;

-- 5. key distributions in tracks
SELECT track_key, COUNT(*) as count
FROM track_data_cleaned
GROUP BY track_key
ORDER BY count DESC;

-- 6. key distributions in tracks of each album
SELECT album_name, track_key, COUNT(*) as count
FROM track_data_cleaned
GROUP BY  album_name, track_key
ORDER BY album_name,count DESC;

-- 7. mode distributions in tracks
SELECT track_mode, COUNT(*) AS count
FROM track_data_cleaned
GROUP BY track_mode
ORDER BY count DESC;

-- 8. mode distributions in tracks of each album released each year
SELECT album_name, track_mode, COUNT(*) AS count
FROM track_data_cleaned
GROUP BY album_name, track_mode
ORDER BY album_name, count DESC;

-- 9. time distributions in tracks
SELECT time_signature, COUNT(*) as count
FROM track_data_cleaned
GROUP BY time_signature
ORDER BY count DESC;

-- 10. find out the only 1 song that use time signature as 3/4
SELECT track_name, album_name
FROM track_data_cleaned
WHERE time_signature = '3/4';

-- 11. average value of features with their own units: duration (m) loudness (dB), tempo (BPM)
SELECT ROUND(AVG(duration),2) AS avg_duration_sec, ROUND(AVG(loudness),2) as avg_loudness_db, ROUND(AVG(tempo),2) as avg_tempo_bpm
FROM track_data_cleaned;

-- 12. features with their own units of each album: duration (m) loudness (dB), tempo (BPM)
SELECT album_name, COUNT(track_id) as total_tracks,
ROUND(AVG(duration),2) AS avg_duration_sec, ROUND(AVG(loudness),2) as avg_loudness_db, ROUND(AVG(tempo),2) as avg_tempo_bpm
FROM track_data_cleaned
GROUP BY album_name
ORDER BY album_name;

-- 13. average value of features with range (0-1): acousticness, energy, danceability 
SELECT ROUND(AVG(acousticness),2) AS avg_acousticness, ROUND(AVG(energy),2) as avg_energy, ROUND(AVG(danceability),2) as danceability
FROM track_data_cleaned;

-- 14. features with value range (0-1) of each album: acousticness, energy, danceability 
SELECT album_name, COUNT(track_id) as total_tracks,
ROUND(AVG(acousticness),2) AS avg_acousticness, ROUND(AVG(energy),2) as avg_energy, ROUND(AVG(danceability),2) as danceability
FROM track_data_cleaned
GROUP BY album_name
ORDER BY album_name;





