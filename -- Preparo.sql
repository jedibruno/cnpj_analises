-- Preparo 

CREATE INDEX ON cnpj_socio (nome);

-- Análise 1: quantidade de socio por qualificacao

SELECT 

COUNT(cnpj_s.socio_uuid) AS quantidade, 
cnpj_q.descricao AS tipo_socio


FROM cnpj_socio AS cnpj_s
    LEFT JOIN cnpj_qualificacao_socio AS cnpj_q 
        ON cnpj_q.codigo = cnpj_s.codigo_qualificacao 

GROUP BY cnpj_q.descricao

LIMIT 10;


-- Busca 1: listando empresas em nome de pessoa

SELECT  
    cnpj_e.razao_social,
    cnpj_e.cnpj_raiz

FROM cnpj_socio AS cnpj_s
    LEFT JOIN cnpj_empresa AS cnpj_e
        ON cnpj_e.cnpj_raiz = cnpj_s.cnpj_raiz

WHERE cnpj_s.nome = 'PAULO EMILIO SKUSA MORASSUTTI';




