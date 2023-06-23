create table MOVIE
(
    MOVIE_ID NUMBER        not null
        primary key,
    TITLE    VARCHAR2(150) not null,
    YEAR     VARCHAR2(4)   not null,
    GENRE    VARCHAR2(100) not null
)
/

create index IDX_YEAR
    on MOVIE (YEAR)
/

create index IDX_GENRE
    on MOVIE (GENRE)
/

create table TAG
(
    TAG_ID        NUMBER not null
        primary key,
    USER_ID       NUMBER,
    MOVIE_ID      NUMBER
        constraint TAG_MOVIE_MOVIE_ID_FK
            references MOVIE,
    TAG           VARCHAR2(200),
    TAG_TIMESTAMP TIMESTAMP(6)
)
/

create table RATING
(
    RATING_ID        NUMBER not null
        primary key,
    USER_ID          NUMBER,
    MOVIE_ID         NUMBER
        constraint RATING_MOVIE_MOVIE_ID_FK
            references MOVIE,
    RATING           FLOAT,
    RATING_TIMESTAMP TIMESTAMP(6)
)
/

