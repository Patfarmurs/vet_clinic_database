/* Populate database with sample data. */
INSERT INTO animals (
    id, name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg
)

VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23),
        (2, 'Gabumon', '2018-11-15', 2, true, 8), 
        (3, 'Pikachu', '2021-01-07', 1, false, 15.04), 
        (4, 'Devimon', '2017-05-12', 5, true, 11);

/* Update data table */
INSERT INTO animals (
    id, name, 
    date_of_birth, 
    escape_attempts, 
    eutered, weight_kg
) 

VALUES (5, 'Charmander', '2020-02-08', 0, false, 11), 
(6, 'Plantmon', '2021-11-15', 2, true, 5.7), 
(7, 'Squirtle', '1993-04-02', 3, false, 12.13), 
(8, 'Angemon', '2005-06-12', 1, true, 45), 
(9, 'Boarmon', '2005-06-07', 7, true, 20.04), 
(10, 'Blossom', '1998-10-13', 3, true, 17), 
(11, 'Ditto', '2022-05-14', 4, true, 22);

/* day3 project */ 

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

BEGIN;
UPDATE animals
SET species_id = species.id
FROM species
WHERE species.name = 'Digimon' AND animals.name LIKE '%mon';
UPDATE animals
SET species_id = species.id
FROM species
WHERE species.name = 'Pokemon' AND animals.species_id IS NULL;
COMMIT;

BEGIN;
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell';
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Charmander', 'Squirtle', 'Blossom') AND owners.full_name = 'Melody Pond';
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Angemon', 'Boarmon') AND owners.full_name = 'Dean Winchester';
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Devimon', 'Plantmon') AND owners.full_name = 'Bob';
COMMIT;

/* project4 */
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('William Tatcher', 45, '2000-04-23'), 
('Maisy Smith', 26, '2019-01-17'), 
('Stephanie Mendez', 64, '1981-05-04'), 
('Jack Harness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
 VALUES (1, 1),
 (3, 1),
 (3, 2),
 (4, 2);

INSERT INTO visits (
    animal_id, 
    vet_id, 
    visited_date) 
VALUES  (1, 1, '2020-05-24'), 
(1, 3, '2020-07-22'), 
(2, 4, '2021-02-02'), 
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'), 
(3, 2, '2020-05-14'), 
(4, 3, '2021-05-04'), 
(5, 4, '2021-02-24'), 
(6, 2, '2019-12-21'), 
(6, 1, '2020-08-10'), 
(6, 2, '2021-04-07'), 
(7, 3, '2019-09-29'), 
(8, 4, '2020-10-03'), 
(8, 4, '2020-11-04'), 
(9, 2, '2019-01-24'), 
(9, 2, '2019-05-15'), 
(9, 2, '2020-02-27'), 
(9, 2, '2020-08-03'), 
(10, 3, '2020-05-24'), 
(10, 1, '2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

INSERT INTO relationships (species_id, owner_id)
SELECT species_id, owner_id
FROM animals;

DELETE FROM visits
WHERE CTID in(
SELECT MAX(CTID)
FROM visits
GROUP BY animal_id, vet_id, date_visited
HAVING COUNT(*) > 1
);

DELETE FROM visits
WHERE CTID in (
SELECT MAX(CTID)
FROM owners
GROUP BY full_name, email
HAVING COUNT(*) > 1
);

