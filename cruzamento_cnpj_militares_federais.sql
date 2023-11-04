


-- Criando uuid

ALTER TABLE militares_ativos ADD column militar_uuid uuid;

UPDATE militares_ativos SET militar_uuid = person_uuid(REPLACE(REPLACE(cpf, '.', ''), '-', ''), nome);

CREATE INDEX on militares_ativos (militar_uuid);

-- Criando tabela com apenas dados cadastrais

CREATE TABLE militares_ativos_cadastro AS
SELECT 
    ano,
    mes,
    id_servidor_portal,
    cpf,
    nome,
    militar_uuid
FROM militares_ativos; 
