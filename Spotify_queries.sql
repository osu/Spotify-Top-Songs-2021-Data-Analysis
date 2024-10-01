--Dataset: Spotify top 50 songs in 2021
--Source: Kaggle https://www.kaggle.com/datasets/equinxx/spotify-top-50-songs-in-2021
--Queried using: SQLite3

-- Create the main Tracks table to store all Spotify track data
CREATE TABLE Tracks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    artist_name TEXT,
    track_name TEXT,
    track_id TEXT,
    popularity INTEGER,
    danceability REAL,
    energy REAL,
    song_key INTEGER,
    loudness REAL,
    song_mode INTEGER,
    speechiness REAL,
    acousticness REAL,
    instrumentalness REAL,
    liveness REAL,
    valence REAL,
    tempo REAL,
    duration_ms INTEGER,
    time_signature INTEGER
);

-- Import data from the CSV file into the Tracks table
.mode csv
.import /Users/nothimofc/Documents/sql_projects/spotify/spotify.csv Tracks -- Change the file path to the location of your CSV file

-- Create the Keys lookup table to map song_key and song_mode to human-readable keys
CREATE TABLE Keys (
    song_key INTEGER,
    song_mode INTEGER,
    key_name TEXT
);

-- Insert mappings for musical keys using pitch-class integer notation
INSERT INTO Keys (song_key, song_mode, key_name)
VALUES (0, 1, 'C Major'),
       (0, 0, 'C Minor'),
       (1, 1, 'C#/Db Major'),
       (1, 0, 'C#/Db Minor'),
       (2, 1, 'D Major'),
       (2, 0, 'D Minor'),
       (3, 1, 'D#/Eb Major'),
       (3, 0, 'D#/Eb Minor'),
       (4, 1, 'E Major'),
       (4, 0, 'E Minor'),
       (5, 1, 'F Major'),
       (5, 0, 'F Minor'),
       (6, 1, 'F#/Gb Major'),
       (6, 0, 'F#/Gb Minor'),
       (7, 1, 'G Major'),
       (7, 0, 'G Minor'),
       (8, 1, 'G#/Ab Major'),
       (8, 0, 'G#/Ab Minor'),
       (9, 1, 'A Major'),
       (9, 0, 'A Minor'),
       (10, 1, 'A#/Bb Major'),
       (10, 0, 'A#/Bb Minor'),
       (11, 1, 'B Major'),
       (11, 0, 'B Minor');

-- Create a table for popularity rankings of different keys
CREATE TABLE PopularityRanking (
    key_name TEXT,
    ranking INTEGER
);

-- Insert predefined rankings for musical keys based on popularity
INSERT INTO PopularityRanking (key_name, ranking)
VALUES ('C Major', 1),
       ('D Major', 2),
       ('G Major', 3),
       ('A Major', 4),
       ('E Major', 5),
       ('A Minor', 6),
       ('F Major', 7),
       ('C Minor', 8),
       ('E Minor', 9),
       ('D Minor', 10),
       ('D#/Eb Major', 11),
       ('G Minor', 12),
       ('A#/Bb Major', 13),
       ('B Minor', 14),
       ('F#/Gb Minor', 15),
       ('F Minor', 16),
       ('C#/Db Major', 17),
       ('F#/Gb Major', 18),
       ('B Major', 19),
       ('C#/Db Minor', 20),
       ('D#/Eb Minor', 21),
       ('G#/Ab Major', 22),
       ('A#/Bb Minor', 23),
       ('G#/Ab Minor', 24);

-- Query: Select all tracks to verify data import
SELECT * FROM Tracks LIMIT 10;

-- Query: What is the average danceability by artist?
SELECT
    artist_name,
    ROUND(AVG(danceability), 3) AS average_danceability
FROM Tracks
GROUP BY artist_name
ORDER BY average_danceability DESC;

-- Query: Who are the top 10 artists based on popularity, and their tracks' average danceability and energy?
SELECT
    artist_name,
    ROUND(AVG(popularity), 3) AS average_popularity,
    ROUND(AVG(danceability), 3) AS average_danceability,
    ROUND(AVG(energy), 3) AS average_energy
FROM Tracks
GROUP BY artist_name
ORDER BY average_popularity DESC
LIMIT 10;

-- Query: What artist released the longest song?
SELECT
    artist_name,
    track_name,
    duration_ms
FROM Tracks
ORDER BY duration_ms DESC
LIMIT 1;

-- Query: What is the average danceability of the top 12 most popular songs?
SELECT
    AVG(danceability) AS average_danceability
FROM Tracks
WHERE popularity >= 92;

-- Query: What are the most common musical keys for all songs?
SELECT
    key_name,
    COUNT(*) AS count_of_songs
FROM Tracks
JOIN Keys ON Tracks.song_key = Keys.song_key AND Tracks.song_mode = Keys.song_mode
GROUP BY key_name
ORDER BY count_of_songs DESC;

-- Query: Compare the most popular song keys with song keys most represented in the top 50 tracks
SELECT
    COUNT(Tracks.track_name) AS total,
    Keys.key_name,
    PopularityRanking.ranking AS popular_song_keys
FROM Tracks
JOIN Keys ON Tracks.song_key = Keys.song_key AND Tracks.song_mode = Keys.song_mode
LEFT JOIN PopularityRanking ON Keys.key_name = PopularityRanking.key_name
GROUP BY Keys.key_name
ORDER BY total DESC;

-- Query: Calculate the average popularity for the artists in the Spotify data table
-- For every artist with an average popularity of 90 or above, label them as a "Top Star."
WITH average_popularity_CTE AS (
    SELECT 
        artist_name,
        AVG(popularity) AS avg_popularity
    FROM Tracks
    GROUP BY artist_name
)
SELECT
    artist_name,
    avg_popularity,
    'Top Star' AS tag
FROM average_popularity_CTE
WHERE avg_popularity >= 90
ORDER BY avg_popularity DESC;

-- Additional Query: Create a more readable 'tonality' field for human-friendly key names
ALTER TABLE Tracks ADD COLUMN tonality TEXT;

-- Populate the 'tonality' field based on song_key and song_mode
UPDATE Tracks
SET tonality = Keys.key_name
FROM Keys
WHERE Tracks.song_key = Keys.song_key AND Tracks.song_mode = Keys.song_mode;

-- Query: Select all tracks along with their tonality
SELECT track_name, artist_name, tonality
FROM Tracks;