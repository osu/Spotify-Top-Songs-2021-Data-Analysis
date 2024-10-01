# Spotify Top 50 Songs in 2021 Analysis

This repository contains an analysis of the top 50 songs on Spotify in 2021. The analysis includes SQL queries for danceability, energy, popularity, and song keys, among other attributes. Additionally, the results are visualized using Python and Matplotlib.

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

## Instructions

### 1. Setting Up the SQLite Database (First Step)

1. Create the SQLite database using the provided SQL script:
   ```bash
   sqlite3 SpotifyDB.db
   ```

2. Run the SQL setup script to create the `Spotifydata` table and import the data from `spotify.csv`:
   ```bash
   .read spotify_queries.sql
   ```

3. Ensure that the `spotify.csv` file is correctly imported into the database. You can confirm the import by running:

   ```bash
   .tables
   ```

   You should see the `Spotifydata` table in the output.

### 2. Running SQL Queries (Second Step)

You can execute various SQL queries in the `SpotifyDB.db` database to get insights from the dataset. For example:

- **To get the average danceability by artist**:

  ```sql
  SELECT artist_name, ROUND(AVG(danceability), 3) AS average_danceability
  FROM Spotifydata
  GROUP BY artist_name
  ORDER BY average_danceability DESC;
  ```

- **To get the top 10 artists by popularity, including average danceability and energy**:

  ```sql
  SELECT
      artist_name,
      ROUND(AVG(popularity), 3) AS average_popularity,
      ROUND(AVG(danceability), 3) AS average_danceability,
      ROUND(AVG(energy), 3) AS average_energy
  FROM Spotifydata
  GROUP BY artist_name
  ORDER BY average_popularity DESC
  LIMIT 10;
  ```

- **To find the artist who released the longest song**:

  ```sql
  SELECT
      artist_name,
      track_name,
      duration_ms
  FROM Spotifydata
  ORDER BY duration_ms DESC
  LIMIT 1;
  ```

- **To find the average danceability of the top 12 most popular songs**:

  ```sql
  SELECT
      AVG(danceability) AS average_danceability
  FROM Spotifydata
  WHERE popularity >= 92;
  ```

### 3. Visualizing Data with Python and Matplotlib (Third Step)

Several Python scripts are provided to generate visualizations based on the data in the SQLite database. To run these scripts, make sure your Python environment is set up with the required libraries.

For example, to visualize the average danceability by artist, use the following Python script:

```python
import matplotlib.pyplot as plt
import sqlite3
import pandas as pd

# Connect to the SQLite database
conn = sqlite3.connect('SpotifyDB.db')

# Query to get average danceability by artist
query = '''
    SELECT artist_name, ROUND(AVG(danceability), 3) AS average_danceability
    FROM Spotifydata
    GROUP BY artist_name
    ORDER BY average_danceability DESC;
'''
df = pd.read_sql(query, conn)

# Create a bar chart
plt.figure(figsize=(10, 6))
plt.barh(df['artist_name'], df['average_danceability'], color='skyblue')
plt.xlabel('Average Danceability')
plt.title('Average Danceability by Artist')
plt.gca().invert_yaxis()  # Invert y-axis to show the highest on top
plt.tight_layout()
plt.show()
```

#### Running the Python Script

To run the Python script for visualizations, use the following command:

```bash
python3 "path_to_your_script/Average_Danceability_by_Artist.py"
```

### 4. Example Queries

Here are some additional example queries you can run on your SQLite database:

- **Top 10 Artists by Popularity**:
  
  ```sql
  SELECT
      artist_name,
      ROUND(AVG(popularity), 3) AS average_popularity
  FROM Spotifydata
  GROUP BY artist_name
  ORDER BY average_popularity DESC
  LIMIT 10;
  ```

- **Longest Song**:
  
  ```sql
  SELECT
      artist_name,
      track_name,
      duration_ms
  FROM Spotifydata
  ORDER BY duration_ms DESC
  LIMIT 1;
  ```

- **Most Common Song Keys for the Entire Dataset**:
  
  ```sql
  SELECT
      COUNT(*) AS total,
      CASE
          WHEN song_key = 0 AND song_mode = 1 THEN 'C Major'
          WHEN song_key = 0 AND song_mode = 0 THEN 'C Minor'
          WHEN song_key = 1 AND song_mode = 1 THEN 'C#/Db Major'
          WHEN song_key = 1 AND song_mode = 0 THEN 'C#/Db Minor'
          -- Add more keys and modes as per the full list
      END AS key
  FROM Spotifydata
  GROUP BY key
  ORDER BY total DESC;
  ```

### 5. Example Python Visualizations

You can visualize additional attributes using Python. For example, to plot the **average energy by artist**, use the following script:

```python
import matplotlib.pyplot as plt
import sqlite3
import pandas as pd

conn = sqlite3.connect('SpotifyDB.db')
query = '''
    SELECT artist_name, ROUND(AVG(energy), 3) AS average_energy
    FROM Spotifydata
    GROUP BY artist_name
    ORDER BY average_energy DESC;
'''
df = pd.read_sql(query, conn)
plt.figure(figsize=(10, 6))
plt.barh(df['artist_name'], df['average_energy'], color='lightcoral')
plt.xlabel('Average Energy')
plt.title('Average Energy by Artist')
plt.gca().invert_yaxis()
plt.tight_layout()
plt.show()
```

### 6. Files

- **spotify_queries.sql**: Contains SQL queries to create the database and tables and insert data.
- **spotify.csv**: The dataset of the top 50 Spotify songs in 2021.
- **README.md**: This file containing setup and usage instructions.
