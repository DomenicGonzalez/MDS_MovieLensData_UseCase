# MDS_MovieLensData_UseCase
This repository contains the data and the code that was used to build the use case in Oracle and MongoDB. 

#### Paper
- The 'MDS_Paper.pdf' file contains the paper with the description, explanations and results of the use case.

#### Data
- The 'MovieLensData' folder contains all the CSV-files with the data used in our use case

#### Oracle RDBS
- The 'Oracle_Scripts' folder contains all the script for creating the tables and the queries (standard and in-memory)

#### MongoDB NoSQL Database
- The 'Merge_CSV_TO_JSON.py' script merges and transforms the CSV-files into one JSON-file with the structure we needed for MongoDB
- The 'MongoDB_Aggregate_Queries.txt' file contains all aggregation pipelines we used to perform the aggregation queries in MongoDB
- The 'MongoDB_CUD_Operations.py' script is connecting to the MongoDB-server and running the different Insert-, Update- and Delete-Operations for our use case
