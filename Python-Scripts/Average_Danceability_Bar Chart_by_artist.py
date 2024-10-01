import matplotlib.pyplot as plt
import sqlite3
import pandas as pd

# Connect to the SQLite database
conn = sqlite3.connect('../SpotifyDB.db')

# Query to get average danceability by artist
query = '''
    SELECT artist_name, ROUND(AVG(danceability), 3) AS average_danceability
    FROM Tracks
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
