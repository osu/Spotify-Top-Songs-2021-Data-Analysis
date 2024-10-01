import matplotlib.pyplot as plt
import sqlite3
import pandas as pd

# Connect to the SQLite database
conn = sqlite3.connect('../SpotifyDB.db')

# Query to get the top 10 longest songs by duration
query = '''
    SELECT track_name, artist_name, duration_ms 
    FROM Tracks
    ORDER BY duration_ms DESC
    LIMIT 10;
'''
df = pd.read_sql(query, conn)

# Create a bar chart for the top 10 longest songs
plt.figure(figsize=(10, 6))
plt.barh(df['track_name'] + ' - ' + df['artist_name'], df['duration_ms'], color='orange', edgecolor='black')
plt.xlabel('Duration (ms)')
plt.ylabel('Song')
plt.title('Top 10 Longest Songs by Duration')
plt.gca().invert_yaxis()  # Invert y-axis to have the longest song at the top
plt.tight_layout()
plt.show()
