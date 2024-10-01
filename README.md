# Spotify Top 50 Songs in 2021 Analysis

This repository contains an analysis of the top 50 songs on Spotify in 2021. The analysis includes queries for danceability, energy, popularity, and song keys, among other attributes. Additionally, the results are visualized using Python and Matplotlib.

## Dataset

The dataset used for this project is available on Kaggle: [Spotify Top 50 Songs in 2021](https://www.kaggle.com/datasets/equinxx/spotify-top-50-songs-in-2021).

The dataset contains the following attributes:

- **Artist Name**
- **Track Name**
- **Track ID**
- **Popularity**
- **Danceability**
- **Energy**
- **Song Key**
- **Loudness**
- **Song Mode**
- **Speechiness**
- **Acousticness**
- **Instrumentalness**
- **Liveness**
- **Valence**
- **Tempo**
- **Duration (ms)**
- **Time Signature**

## Prerequisites

To run this project, you need the following:

- **SQLite3**: for running SQL queries.
- **Python 3.x**: for generating data visualizations.
- **Pandas**: Python library for data analysis.
- **Matplotlib**: Python library for creating plots.

### Python Dependencies

Install the necessary Python libraries by running:

```bash
pip install pandas matplotlib sqlite3
```
or
```bash
pip3 install pandas matplotlib sqlite3
```

Instructions

## Setting Up the SQLite Database First Step

Create the SQLite database using the provided SQL script:
  ```bash
  sqlite3 SpotifyDB.db
  ```
Run the SQL setup script to create the Spotifydata table and import the data from spotify.csv:
    ```bash
    .read spotify_queries.sql
    ```
Ensure that the spotify.csv file is correctly imported into the database. You can confirm the import by running:
```bash
.tables
```

## Running SQL Queries Second Step

You can execute various SQL queries in the SpotifyDB.db database to get insights from the dataset. For example:


  	
    
    
    
  
