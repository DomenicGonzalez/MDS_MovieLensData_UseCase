from pymongo import MongoClient
from bson.objectid import ObjectId
import datetime

# Connect to MongoDB-server
client = MongoClient('mongodb://localhost:27017/')

# Choose database and collection
db = client['MovieLensData']
movie_collection = db['Movie']



"""INSERT MOVIE"""

# Find the document with highest movieId
highest_movie_id_doc = list(movie_collection.find({}, {"movieId": 1}).sort("movieId", -1).limit(1))

# If a document was found, increase the movieId by 1, otherwise set it to 1
if len(highest_movie_id_doc) > 0:
    new_movie_id = highest_movie_id_doc[0]["movieId"] + 1
else:
    new_movie_id = 1

# Create a new movie document
new_movie = {
    "movieId": new_movie_id,
    "title": "Evil Dead Rise",
    "year": "2023",
    "genre": "Horror"
}

# Insert movie document into the collection
movie_collection.insert_one(new_movie)



"""INSERT RATING"""

# Find the document with highest ratingId in ratings
highest_rating_id_doc = list(movie_collection.find({}, {"ratings.ratingId": 1}).sort("ratings.ratingId", -1).limit(1))

# If there is a document with a ratingId in ratings, increment the ratingId by 1, else set it on 1
if len(highest_rating_id_doc) > 0 and "ratings" in highest_rating_id_doc[0] and len(highest_rating_id_doc[0]["ratings"]) > 0:
    new_rating_id = max(rating["ratingId"] for rating in highest_rating_id_doc[0]["ratings"]) + 1
else:
    new_rating_id = 1

# Create new rating
new_rating = {
    "ratingId": new_rating_id,
    "userId": 10,
    "rating": 4,
    "timestamp": datetime.datetime.utcnow().isoformat()
}

# Update collection with the new rating
movie_collection.update_one(
    { "_id": ObjectId("64943f8610e003a1948f5fab") }, # current ObjectId of the movie "Evil Dead Rise" (changes if movie gets deleted and inserted again)
    { "$push": { "ratings": new_rating } }
)



"""UPDATE RATING"""

# Update the rating
movie_collection.update_one(
    { "_id": ObjectId("64943f8610e003a1948f5fab") }, # current ObjectId of the movie "Evil Dead Rise" (changes if movie gets deleted and inserted again)
    { "$set": { "ratings.$[elem].rating": 5 } },
    array_filters=[ { "elem.ratingId": 55000 } ]
)



"""DELETE RATING"""

# Delete rating 
movie_collection.update_one(
    { "_id": ObjectId("64943f8610e003a1948f5fab") }, # current ObjectId of the movie "Evil Dead Rise" (changes if movie gets deleted and inserted again)
    { "$pull": { "ratings": { "ratingId": 55000 } } } # current next ratingId 
)



"""DELETE MOVIE"""

# Delete movie document
movie_collection.delete_one({ "_id": ObjectId("64943f8610e003a1948f5fab") }) # current ObjectId of the movie "Evil Dead Rise" (changes if movie gets deleted and inserted again)