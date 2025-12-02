-- SQL para a View de REVIEWS (Fatos) Limpa- VERSÃO FINAL

-- Esta View será a sua Tabela de FATOS no PowerBI
CREATE OR REPLACE VIEW
  `my-project-laboratoria.project_rota02.reviews_clean` AS
SELECT
  -- Chaves (Relacionamentos)
  SAFE_CAST(id AS INT64) AS room_id,
  SAFE_CAST(host_id AS INT64) AS host_id,
  
  -- Métricas
  CAST(price AS BIGNUMERIC) AS price,
  SAFE_CAST(last_review AS DATE) AS last_review,
  CAST(number_of_reviews AS INT64) AS number_of_reviews,
  COALESCE(reviews_per_month, 0.0) AS reviews_per_month,
  CAST(calculated_host_listings_count AS INT64) AS calculated_host_listings_count,
  
  -- Métrica Principal: disponibilidade (limpeza e validação)
  GREATEST(0, LEAST(CAST(availability_365 AS INT64), 365)) AS availability_365,
  
  -- Coluna Calculada (Feature Engineering)
  CASE
    -- Aplicamos a mesma lógica de limpeza para garantir a consistência
    WHEN GREATEST(0, LEAST(CAST(availability_365 AS INT64), 365)) = 0 THEN 'Totalmente Ocupado'
    WHEN GREATEST(0, LEAST(CAST(availability_365 AS INT64), 365)) <= 90 THEN 'Alta Ocupação' -- Menos de 25% disponível
    ELSE 'Baixa Ocupação/Disponível'
  END AS occupancy_segment
FROM
  `my-project-laboratoria.project_rota02.reviews`
WHERE 
  SAFE_CAST(id AS INT64) IS NOT NULL AND 
  SAFE_CAST(host_id AS INT64) IS NOT NULL AND 
  price IS NOT NULL AND price > 0;