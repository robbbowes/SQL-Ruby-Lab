DROP TABLE IF EXISTS bounty_hunters;

CREATE TABLE bounty_hunters(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    species VARCHAR(255),
    bounty_value INT,
    danger_level INT,
    last_known_location VARCHAR(255),
    homeworld VARCHAR(255),
    favourite_weapon VARCHAR(255),
    cashed_in VARCHAR(255),
    collected_by VARCHAR(255)
);
