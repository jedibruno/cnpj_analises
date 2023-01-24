-- Preparo 

CREATE INDEX ON cnpj_socio (nome);



--

-- Análise 1: quantidade de socio por qualificacao

SELECT 

COUNT(cnpj_s.socio_uuid) AS quantidade, 
cnpj_q.descricao AS tipo_socio


FROM cnpj_socio AS cnpj_s
    LEFT JOIN cnpj_qualificacao_socio AS cnpj_q 
        ON cnpj_q.codigo = cnpj_s.codigo_qualificacao 

GROUP BY cnpj_q.descricao;






-- Busca 1: encontrando o uuid de uma pessoa
-- Observação: a busca por nome pode resultar em falsos positivos por homônimos. O uuid é um identificador único

SELECT
    socio_uuid,
    nome,
    cpf_cnpj

FROM cnpj_socio

WHERE nome = '';



-- Busca 2: listando empresas em nome de pessoa
-- Observação 1: a busca por nome pode resultar em falsos positivos por homônimos.


SELECT  
    cnpj_em.razao_social,
    cnpj_est.cnpj

FROM cnpj_socio AS cnpj_s
    LEFT JOIN cnpj_empresa AS cnpj_em 
        ON cnpj_em.uuid = cnpj_s.empresa_uuid
    LEFT JOIN cnpj_estabelecimento AS cnpj_est
        ON cnpj_est.empresa_uuid = cnpj_em.uuid 

WHERE cnpj_s.nome = '';

-- Busca 2.1: listando empresas ativas em nome de uma pessoa

SELECT  
    cnpj_em.razao_social,
    cnpj_est.cnpj

FROM cnpj_socio AS cnpj_s
    LEFT JOIN cnpj_empresa AS cnpj_em 
        ON cnpj_em.uuid = cnpj_s.empresa_uuid
    LEFT JOIN cnpj_estabelecimento AS cnpj_est
        ON cnpj_est.empresa_uuid = cnpj_em.uuid 

WHERE cnpj_s.nome = '' AND cnpj_est.codigo_situacao_cadastral = '2';

-- Busca 3: listando empresas em nome de um uuid

SELECT  
    cnpj_em.razao_social,
    cnpj_est.cnpj

FROM cnpj_socio AS cnpj_s
    LEFT JOIN cnpj_empresa AS cnpj_em 
        ON cnpj_em.uuid = cnpj_s.empresa_uuid
    LEFT JOIN cnpj_estabelecimento AS cnpj_est
        ON cnpj_est.empresa_uuid = cnpj_em.uuid 

WHERE cnpj_s.socio_uuid = '';

-- Busca 3.1: listando empresas em nome de um uuid

SELECT  
    cnpj_em.razao_social,
    cnpj_est.cnpj,
    cnpj_est.codigo_situacao_cadastral,
    cnpj_est.data_situacao_cadastral

FROM cnpj_socio AS cnpj_s
    LEFT JOIN cnpj_empresa AS cnpj_em 
        ON cnpj_em.uuid = cnpj_s.empresa_uuid
    LEFT JOIN cnpj_estabelecimento AS cnpj_est
        ON cnpj_est.empresa_uuid = cnpj_em.uuid 

WHERE cnpj_s.socio_uuid = '';
