/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%mon';

SELECT name from animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

SELECT name from animals WHERE neutered = 'true' AND escape_attempts < 3;

SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = true;

SELECT * from animals WHERE name != 'Gabumon';

SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Update queries */
BEGIN;

-- update the transaction

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

-- start another transaction

BEGIN;

-- update transaction

UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals
SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;

-- commit transaction
COMMIT;
SELECT * FROM animals;

-- start another transaction

BEGIN;

-- Delete all transactions

DELETE FROM animals;
-- Return to previous state
ROLLBACK;
SELECT * FROM animals;

-- Start transaction
BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;

-- create a savepoint for weight_kg column
SAVEPOINT weight_kg;

UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

-- Return to savepoint
ROLLBACK TO weight_kg;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;
SELECT * FROM animals;

-- Start transaction
BEGIN;

-- make  counts for animals
SELECT COUNT (*) FROM animals;

SELECT COUNT (*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* Query multiple tables */
SELECT name FROM animals JOIN owners ON owner_id =owner_id
WHERE fullname = 'Melody Pond';

SELECT * FROM animals JOIN species s ON species_id = s.id
WHERE s.name = 'Pokemon';

SELECT fullname AS owner, name AS pet FROM animals a
FULL JOIN owners o ON o.id = a.owner_id;

SELECT COUNT(a.name), s.name FROM animals a JOIN species s ON species_id = s.id
GROUP BY s.name;

SELECT a.name FROM animals a 
LEFT JOIN owners o ON o.id = a.owner_id
LEFT JOIN species s ON s.id = a.species_id
WHERE o.fullname = 'Jennifer' AND s.name = 'Digimon';

SELECT * FROM animals a
FULL JOIN owners o ON o.id = owner_id
WHERE o.fullname = 'Dean Winchester' AND escape_attempts = 0;

SELECT COUNT(*) as count, fullname FROM animals a
INNER JOIN owners o ON a.owner_id = o.id
GROUP BY o.fullname
ORDER BY count DESC;