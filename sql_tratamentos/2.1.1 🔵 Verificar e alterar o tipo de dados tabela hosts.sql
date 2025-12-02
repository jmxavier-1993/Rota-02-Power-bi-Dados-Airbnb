-- SQL para a View de HOSTS Limpa
CREATE OR REPLACE VIEW
  `my-project-laboratoria.project_rota02.hosts_clean` AS
SELECT
  -- 1. Garante que o ID do anfitrião seja um inteiro.
SAFE_CAST(host_id AS INT64) AS host_id,
  
  -- 2. Trata valores nulos no nome, substituindo por 'N/A', e remove espaços em branco extras.
  TRIM(COALESCE(nomedohost, 'N/A')) AS host_name
FROM
  `my-project-laboratoria.project_rota02.hosts`
-- Remove quaisquer anfitriões sem ID (garantia de integridade)
WHERE SAFE_CAST(host_id AS INT64) IS NOT NULL
GROUP BY 1, 2