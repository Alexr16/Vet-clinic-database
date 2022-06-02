CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species varchar(100),
    PRIMARY KEY (id)
);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name varchar(240),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    PRIMARY KEY (id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE;

ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id) ON DELETE CASCADE;

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    CONSTRAINT vet_spe_pk PRIMARY KEY (vet_id, species_id),
    CONSTRAINT fk_vet FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE CASCADE,
    CONSTRAINT fk_speciess FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE
);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit DATE,
    CONSTRAINT ani_vet_pk PRIMARY KEY (animal_id,vet_id,date_of_visit),
    CONSTRAINT fk_animal FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE,
    CONSTRAINT fk_vet FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE CASCADE
);
