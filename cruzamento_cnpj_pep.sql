-- Tabela e colunas 

-- Criando uuid

ALTER TABLE pep_09_2023 ADD column pep_uuid uuid;

UPDATE pep_09_2023 SET pep_uuid = person_uuid(REPLACE(REPLACE(cpf, '.', ''), '-', ''), nome_pep);

CREATE INDEX on pep_09_2023 (pep_uuid);

-- Nome padrão: pep_[mes]_[ano]


-- Colunas PEP
 cpf,                
 nome_pep              
 sigla_funcao          
 descricao_funcao      
 nivel_funcao          
 nome_orgao            
 data_inicio_exercicio 
 data_fim_exercicio    
 data_fim_carencia     
 pep_uuid  

cnpj_empresa                       
    uuid, pessoa_uuid, codigo_natureza_juridica, codigo_qualificacao_responsavel, codigo_porte, ente_responsavel_codigo_municipio, capital_social, 
    cnpj_raiz, razao_social, ente_responsavel_uf 
cnpj_estabelecimento
    uuid, empresa_uuid, cnpj,matriz, nome_fantasia, codigo_situacao_cadastral, data_situacao_cadastral, codigo_motivo_situacao_cadastral, cidade_exterior, 
    codigo_pais, data_inicio_atividade, cnae_principal, cnae_secundaria, tipo_logradouro, logradouro, numero, complemento, bairro, cep, uf, codigo_municipio, 
    ddd_1, telefone_1, ddd_2, telefone_2, ddd_fax, fax, email, situacao_especial, data_situacao_especial 

-- Lista empresas cujos sócios são PEP: nome, cargo/função, orgão, razão social, cnpj 

SELECT
    pep.nome_pep,
    pep.descricao_funcao,
    pep.nome_orgao,
    cnpj_emp.razao_social,
    cnpj_est.cnpj,
    cnpj_est.codigo_situacao_cadastral

FROM cnpj_empresa AS cnpj_emp 
    LEFT JOIN pep_09_2023 AS pep
        ON pep.pep_uuid = cnpj_emp.pessoa_uuid
    LEFT JOIN cnpj_estabelecimento AS cnpj_est
        ON cnpj_est.empresa_uuid = cnpj_emp.uuid 

ORDER BY 2 ASC 
LIMIT 100;

-- Cria tabela com empresas de PEPs

CREATE TABLE pep_empresas AS
SELECT
    pep.nome_pep,
    pep.descricao_funcao,
    pep.nome_orgao,
    cnpj_emp.razao_social,
    cnpj_est.cnpj,
    cnpj_est.codigo_situacao_cadastral

FROM cnpj_empresa AS cnpj_emp 
    LEFT JOIN pep_09_2023 AS pep
        ON pep.pep_uuid = cnpj_emp.pessoa_uuid
    LEFT JOIN cnpj_estabelecimento AS cnpj_est
        ON cnpj_est.empresa_uuid = cnpj_emp.uuid;

