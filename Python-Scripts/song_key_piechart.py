import matplotlib.pyplot as plt
import sqlite3
import pandas as pd

# Connect to the SQLite database
conn = sqlite3.connect('../SpotifyDB.db')

# Query to get the count of each song key
query = '''
    SELECT song_key, COUNT(*) AS total
    FROM Tracks
    GROUP BY song_key
    ORDER BY total DESC;
'''
df = pd.read_sql(query, conn)

# Create a pie chart
plt.figure(figsize=(8, 8))
plt.pie(df['total'], labels=df['song_key'], autopct='%1.1f%%', startangle=140, colors=plt.cm.Paired.colors)
plt.title('Distribution of Song Keys')
plt.tight_layout()
plt.show()
