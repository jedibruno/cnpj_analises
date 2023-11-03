cnpj_cnae                          
    codigo, descricao
cnpj_empresa                       
    uuid, pessoa_uuid, codigo_natureza_juridica, codigo_qualificacao_responsavel, codigo_porte, ente_responsavel_codigo_municipio, capital_social, 
    cnpj_raiz, razao_social, ente_responsavel_uf 
cnpj_estabelecimento
    uuid, empresa_uuid, cnpj,matriz, nome_fantasia, codigo_situacao_cadastral, data_situacao_cadastral, codigo_motivo_situacao_cadastral, cidade_exterior, 
    codigo_pais, data_inicio_atividade, cnae_principal, cnae_secundaria, tipo_logradouro, logradouro, numero, complemento, bairro, cep, uf, codigo_municipio, 
    ddd_1, telefone_1, ddd_2, telefone_2, ddd_fax, fax, email, situacao_especial, data_situacao_especial 
cnpj_motivo_situacao_cadastral
    codigo, descricao
cnpj_municipio_uf
    codigo, uf, nome, nome_slug
cnpj_natureza_juridica
    codigo, descricao
cnpj_pais
    codigo, descricao
cnpj_qualificacao_socio
    codigo, descricao
cnpj_regime_tributario
    empresa_uuid, ano, cnpj, cnpj_scp, forma_tributacao, qtd_escrituracoes 
cnpj_simples
    empresa_uuid, cnpj_raiz, opcao_simples, data_opcao_simples, data_exclusao_simples, opcao_mei, data_opcao_mei, data_exclusao_mei 
cnpj_socio
    socio_uuid, empresa_uuid, cnpj_raiz, codigo_identificador, nome, cpf_cnpj, codigo_qualificacao, data_entrada_sociedade, codigo_pais, 
    representante_cpf_cnpj, representante, representante_codigo_qualificacao, representante_uuid, codigo_faixa_etaria 



-- Possíveis melhorias


-- Explorações quantitativas


-- Analises Exploratorias
--- 1 Natureza juridica 
--- 1.1 Quantidade de empresas por natureza juridcia


SELECT 
    COUNT (uuid) AS quantidade,
    cnpj_nat.descricao AS descricao
FROM cnpj_empresa AS cnpj_emp
    LEFT JOIN cnpj_natureza_juridica AS cnpj_nat
    ON cnpj_emp.codigo_natureza_juridica = cnpj_nat.codigo
GROUP BY descricao
ORDER BY quantidade DESC;


-- Dúvidas: a) 5642 municipios?


--- 1.2 Lista entidades com natureza jurídica diferentes

SELECT 
    cnpj_emp.razao_social,
    cnpj_nat.descricao
FROM cnpj_empresa AS cnpj_emp
    LEFT JOIN cnpj_natureza_juridica AS cnpj_nat
    ON cnpj_emp.codigo_natureza_juridica = cnpj_nat.codigo
WHERE cnpj_nat.codigo = "5037";


-- Busca pessoa por CPF

SELECT 
    nome,
    empresa_uuid,
    cnpj_raiz,
    cpf_cnpj

FROM cnpj_socio

WHERE cpf_cnpj = '***600290**'; 

-- Busca empresa por CNPJ

SELECT 
    uuid.cnpj_est, 
    empresa_uuid.cnpj_est, 
    cnpj.cnpj_est,
    matriz.cnpj_est, 
    nome_fantasia.cnpj_est,
    

FROM cnpj_estabelecimento AS cnpj_est
    LEFT JOIN cnpj_empresa AS cnpj_emp
    ON cnpj_est.empresa_uuid = cnpj_emp.uuid

WHERE cnpj = '19527956000174';