SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered IS TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name,escape_attempts FROM animals WHERE weight_kg > '10.5';
SELECT * FROM animals WHERE neutered IS TRUE;
SELECT * FROM animals WHERE name NOT LIKE 'Agumon';
SELECT * FROM animals WHERE weight_kg BETWEEN '10.4' AND '17.3';

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT deleteAnimal;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO deleteAnimal;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(name) AS Animals FROM animals;

SELECT COUNT(name) AS Animals_never_tried_to_scape FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS Average_weight FROM animals;

SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered; 

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT name, owner_id, full_name FROM animals INNER JOIN owners ON owner_id = owners.id WHERE owner_id = 4;

SELECT animals.name, species_id, species.name FROM animals INNER JOIN species ON species_id = species.id WHERE species_id = 1;

SELECT full_name, animals.name, owner_id FROM owners LEFT JOIN animals ON owner_id = owners.id;

SELECT COUNT(animals) as Animals, species_id, species.name FROM animals INNER JOIN species ON species_id = species.id GROUP BY species_id, species.name;