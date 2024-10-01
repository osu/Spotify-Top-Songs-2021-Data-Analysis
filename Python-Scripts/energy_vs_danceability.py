import matplotlib.pyplot as plt
import sqlite3
import pandas as pd

# Connect to the SQLite database
conn = sqlite3.connect('../SpotifyDB.db')

# Query to get energy and danceability for each track
query = '''
    SELECT danceability, energy
    FROM Tracks;
'''
df = pd.read_sql(query, conn)

# Create a scatter plot
plt.figure(figsize=(8, 6))
plt.scatter(df['danceability'], df['energy'], color='purple')
plt.xlabel('Danceability')
plt.ylabel('Energy')
plt.title('Danceability vs Energy')
plt.tight_layout()
plt.show()
