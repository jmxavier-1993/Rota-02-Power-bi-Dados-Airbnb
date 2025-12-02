-- SQL para a View de ROOMS Limpa (V_CLEAN_ROOMS)
CREATE OR REPLACE VIEW
  `my-project-laboratoria.project_rota02.rooms_clean` AS
SELECT
  SAFE_CAST(id AS INT64) AS room_id,
  TRIM(COALESCE(name, 'No Name')) AS room_name,
  neighbourhood,
  neighbourhood_group,
  
  -- Garante o tipo numérico para as coordenadas
  CAST(latitude AS BIGNUMERIC) AS latitude,
  CAST(longitude AS BIGNUMERIC) AS longitude,
  
  room_type,
  
  -- Garante que o mínimo de noites é pelo menos 1 (Assunção de Negócio)
  CAST(GREATEST(minimum_nights, 1) AS INT64) AS minimum_nights
FROM
  `my-project-laboratoria.project_rota02.rooms`
-- Filtra quartos sem ID válido ou sem localização
WHERE SAFE_CAST(id AS INT64) IS NOT NULL AND latitude IS NOT NULL AND longitude IS NOT NULL;