# Spotify Top 50 Songs Data Analysis using SQLite

This repository contains an SQLite database and SQL queries to analyze Spotify’s top 50 songs in 2021. The dataset was sourced from Kaggle and processed using SQL queries. Below is a breakdown of the database structure and the queries used for various analyses.

Dataset

The dataset used contains data on the top 50 most popular Spotify songs in 2021, including fields like:

	•	artist_name: The name of the artist.
	•	track_name: The name of the song.
	•	track_id: Spotify’s unique ID for the track.
	•	popularity: Spotify’s popularity rating for the track.
	•	danceability: How suitable a track is for dancing based on tempo, rhythm, and beat.
	•	energy: The energy level of a track, ranging from low to high.
	•	song_key: The key in which the track is composed.
	•	loudness: The track’s overall loudness in decibels.
	•	song_mode: Whether the track is in a major (1) or minor (0) key.
	•	speechiness: The amount of spoken words in the track.
	•	acousticness: A measure of how acoustic the song is.
	•	instrumentalness: A prediction of whether a track contains no vocals.
	•	liveness: The measure of whether the song was performed live.
	•	valence: How positive or happy the track feels.
	•	tempo: The overall tempo (beats per minute) of the track.
	•	duration_ms: The duration of the song in milliseconds.
	•	time_signature: The overall time signature of the track.

SQL Database Structure

The database contains the following tables:

	1.	Tracks: Holds the raw data for the Spotify top 50 songs.
	2.	PopularityRanking: Ranks the song keys based on overall popularity.
	3.	Keys: Stores readable key information for each track (e.g., C Major, A Minor, etc.).
