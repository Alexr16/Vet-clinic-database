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

SELECT animals.name, species_id, species.name, owner_id, full_name FROM animals INNER JOIN species ON species_id = species.id INNER JOIN owners ON owner_id = owners.id WHERE owner_id = 2 AND species_id = 2;

SELECT animals.name, species_id, escape_attempts, owner_id, full_name FROM animals INNER JOIN owners ON owner_id = owners.id WHERE owner_id = 5 AND escape_attempts = 0;

SELECT owner_id, full_name, COUNT(animals) AS Number_of_animals FROM animals INNER JOIN owners ON owner_id = owners.id GROUP BY owner_id, full_name ORDER BY Number_of_animals desc;

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, animal_id, vet_id, vets.name, date_of_visit FROM vets INNER JOIN visits ON vet_id = vets.id INNER JOIN animals ON animal_id = animals.id WHERE vet_id = 1 ORDER BY date_of_visit desc
    LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) as number_of_animals, vet_id, vets.name FROM vets
    INNER JOIN visits ON vet_id = vets.id
    WHERE vet_id = 3 GROUP BY vets.name, vet_id;

-- List all vets and their specialties, including vets with no specialties.
SELECt vet_id, vets.name, species_id, species.name FROM vets
    LEFT JOIN specializations ON vet_id= vets.id
    LEFT JOIN species ON species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animal_id, animals.name, vet_id, vets.name, date_of_visit FROM vets
    INNER JOIN visits ON vet_id = vets.id
    INNER JOIN animals ON animal_id = animals.id
    WHERE vet_id = 3 AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animal_id, animals.name, COUNT(*) as number_of_visits FROM visits
    INNER JOIN animals ON animal_id = animals.id
    GROUP BY animal_id, animals.name
    ORDER BY number_of_visits DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vet_id, vets.name, animal_id, animals.name, date_of_visit FROM visits
    INNER JOIN animals ON animal_id = animals.id
    INNER JOIN vets ON vet_id = vets.id
    WHERE vet_id = 2 ORDER BY date_of_visit ASC LIMIT 1;

