import matplotlib.pyplot as plt
import sqlite3
import pandas as pd

conn = sqlite3.connect('../SpotifyDB.db')

# Query to get song durations
query = '''
    SELECT duration_ms FROM Tracks;
'''
df = pd.read_sql(query, conn)

# Create a histogram
plt.figure(figsize=(8, 6))
plt.hist(df['duration_ms'], bins=20, color='orange', edgecolor='black')
plt.xlabel('Duration (ms)')
plt.ylabel('Number of Songs')
plt.title('Distribution of Song Durations')
plt.tight_layout()
plt.show()
