CREATE TABLE genre (
    genre_id BIGINT(20) PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL
);

CREATE TABLE seasons (
    season_id BIGINT(20) PRIMARY KEY,
    season_title VARCHAR(255) NOT NULL,
    seasons INT NOT NULL,
    season_details TEXT
);

CREATE TABLE episodes (
    episode_id BIGINT(20) PRIMARY KEY,
    episode_title VARCHAR(255) NOT NULL,
    season_id BIGINT(20),
    episodes INT NOT NULL,
    episode_details TEXT,
);

CREATE TABLE channel (
    channel_id BIGINT(20) PRIMARY KEY,
    channel_name VARCHAR(100) NOT NULL
);

CREATE TABLE viewing_history (
    viewing_history_id BIGINT(20) PRIMARY KEY,
    views INT NOT NULL,
    episode_id BIGINT(20),
);

CREATE TABLE user (
    user_id BIGINT(20) PRIMARY KEY,
    mailaddress VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    viewing_history_id BIGINT(20),
);

CREATE TABLE program (
    program_id BIGINT(20) PRIMARY KEY,
    genre_id BIGINT(20),
    title VARCHAR(255) NOT NULL,
    duration TIME NOT NULL,
    release_date DATE NOT NULL,
    viewing_history_id BIGINT(20),
    season_id BIGINT(20),
    starttime DATETIME NOT NULL,
    endtime DATETIME NOT NULL,
    channel_id BIGINT(20),
);
