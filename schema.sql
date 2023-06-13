/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id integer, 
    name varchar(100), 
    date_of_birth date, 
    escape_attempts integer, 
    neutered boolean, 
    weight_kg decimal, 
    PRIMARY KEY(id)
);

/* Alter Animals Table */
ALTER TABLE animals ADD species VARCHAR(150);

/* Add 2 more tables */
CREATE TABLE owners(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INT 
);

CREATE TABLE species(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT,
  ADD CONSTRAINT fk_species
  FOREIGN KEY (species_id)
  REFERENCES species (id);

ALTER TABLE animals ADD COLUMN owner_id INT,
  ADD CONSTRAINT fk_owners
  FOREIGN KEY (owner_id)
  REFERENCES owners (id);


CREATE TABLE vets (
  id INT Generated ALWAYS AS IDENTITY PRIMARY KEY, 
  name VARCHAR(100), 
  age INT, 
  date_of_graduation DATE
);

CREATE TABLE specializations (
  species_id INT CONSTRAINT fk_specializations_species_id REFERENCES species(id), 
  vet_id INT CONSTRAINT fk_vet_id REFERENCES vets(id)
);

CREATE TABLE visits (
  animal_id INT CONSTRAINT fk_animal_id REFERENCES animals(id), 
  vet_id INT CONSTRAINT fk_visits_vet_id REFERENCES vets(id), 
  visited_date Date NOT NULL DEFAULT CURRENT_DATE
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE TABLE relationships (
    id serial PRIMARY KEY,
    species_id integer,
    owner_id integer
);
