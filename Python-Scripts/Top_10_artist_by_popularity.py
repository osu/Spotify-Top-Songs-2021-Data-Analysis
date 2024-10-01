import matplotlib.pyplot as plt
import sqlite3
import pandas as pd

# Connect to the SQLite database
conn = sqlite3.connect('../SpotifyDB.db')
# Query to get top 10 artists by popularity
query = '''
    SELECT artist_name, ROUND(AVG(popularity), 3) AS average_popularity
    FROM Tracks
    GROUP BY artist_name
    ORDER BY average_popularity DESC
    LIMIT 10;
'''
df = pd.read_sql(query, conn)

# Create a bar chart
plt.figure(figsize=(10, 6))
plt.bar(df['artist_name'], df['average_popularity'], color='lightgreen')
plt.ylabel('Average Popularity')
plt.title('Top 10 Artists by Popularity')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.show()
