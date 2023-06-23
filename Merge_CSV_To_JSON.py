import pandas as pd
import numpy as np
from pymongo import MongoClient
import json

# CSV-Dateien einlesen
movies_df = pd.read_csv('movie.csv')
ratings_df = pd.read_csv('rating.csv')
tags_df = pd.read_csv('tag.csv')

# Merge der Datenframes basierend auf 'movieId'
merged_df = movies_df.merge(ratings_df, on='movieId', how='left').merge(tags_df, on='movieId', how='left')

# Funktion zum Erstellen des gewünschten JSON-Formats
def create_movie_document(group):
    if pd.isnull(group['ratingId']).all():
        return None
    
    movie_document = {
        'movieId': group['movieId'].iat[0],
        'title': group['title'].iat[0],
        'year':group['year'].iat[0],
        'genre': group['genre'].iat[0],
        'ratings': [],
        'tags': []
    }
    for _, row in group.iterrows():
        if not pd.isnull(row['ratingId']):
            rating = {
                'ratingId': row['ratingId'],
                'userId': row['rat_userId'],
                'rating': row['rating'],
                'timestamp': row['rat_timestamp']
            }
            if rating not in movie_document['ratings']:
                movie_document['ratings'].append(rating)
        if not pd.isnull(row['tagId']):
            tag = {
                'tagId': row['tagId'],
                'userId': row['tag_userId'],
                'tag': row['tag'],
                'timestamp': row['tag_timestamp']
            }
            if tag not in movie_document['tags']:
                movie_document['tags'].append(tag)
    return movie_document

# Gruppieren der Daten nach 'movieId' und Erstellen der Movie-Dokumente
grouped_df = merged_df.groupby('movieId').apply(create_movie_document).dropna().reset_index(drop=True)

# Konvertieren der Movie-Dokumente in JSON
json_documents = json.loads(grouped_df.to_json(orient='records'))

# MongoDB-Verbindung herstellen
client = MongoClient('mongodb://localhost:27017/')
db = client['MovieLensData']
collection = db['Movie']

# Movie-Dokumente in MongoDB hochladen
collection.insert_many(json_documents)

# Verbindung zur MongoDB trennen
client.close()



