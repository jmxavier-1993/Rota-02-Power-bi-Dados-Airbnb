# 🏨 Airbnb Business Intelligence Project

![Status](https://img.shields.io/badge/Status-Concluído-success)
![Power BI](https://img.shields.io/badge/PowerBI-Desktop-yellow)
![BigQuery](https://img.shields.io/badge/Google-BigQuery-blue)
![SQL](https://img.shields.io/badge/Language-SQL-orange)
![DAX](https://img.shields.io/badge/Language-DAX-green)

## 📋 Sobre o Projeto

Com o crescimento de plataformas como o Airbnb, a análise de dados tornou-se crucial para maximizar a eficiência e a rentabilidade de anfitriões e da própria plataforma.

Este projeto utiliza **Business Intelligence (BI)** para explorar dados de disponibilidade, preços e avaliações. O objetivo é transformar dados brutos em insights estratégicos sobre ocupação, precificação e tendências geográficas em Nova York, permitindo tomadas de decisão informadas para otimizar a receita.

---

## ⚙️ Arquitetura e Tecnologias

O projeto segue um fluxo de trabalho de BI moderno, desde a engenharia de dados na nuvem até a visualização avançada.

* [cite_start]**Processamento & ETL:** Google BigQuery (SQL).
* [cite_start]**Visualização & Análise:** Microsoft Power BI.
* [cite_start]**Linguagens:** SQL (Limpeza e Transformação) e DAX (Métricas Analíticas).

---

## 🚀 Pipeline de Dados (ETL)

O tratamento de dados foi realizado no **BigQuery**, onde as tabelas brutas foram higienizadas e preparadas para modelagem.

### 1. Limpeza e Tratamento (SQL)
Foram criadas `VIEWS` limpas para garantir a integridade dos dados:

***Tabela `hosts`:** Conversão segura de IDs com `SAFE_CAST`, tratamento de nomes nulos (`COALESCE`) e remoção de espaços (`TRIM`).
***Tabela `rooms`:** Validação de coordenadas geográficas (`BIGNUMERIC`), tratamento de nulos em nomes e imposição de regra de negócio para estadia mínima (`GREATEST(minimum_nights, 1)`) .
***Tabela `reviews` (Fato):**
    * Conversão de preços e datas.
    * Tratamento de nulos em avaliações mensais.
    ***Engenharia de Atributos:** Criação da coluna `occupancy_segment` (Segmentação de Ocupação), classificando imóveis desde "Totalmente Ocupado" até "Ocioso" com base na disponibilidade anual .

### 2. Modelagem de Dados (Star Schema)
No Power BI, foi implementado um **Modelo Estrela**, ideal para performance de dashboards:

| Tabela | Tipo | Descrição |
| :--- | :--- | :--- |
| **reviews_clean** | Fato | Contém métricas de preço, disponibilidade e reviews. |
| **rooms_clean** | Dimensão | Detalhes do imóvel, tipo de quarto e localização. |
| **hosts_clean** | Dimensão | Dados cadastrais dos anfitriões. |

---

## 📈 Principais Métricas (DAX)

As análises foram sustentadas por medidas calculadas em DAX para garantir dinamismo nos filtros:

***Total de Imóveis:** Contagem distinta de IDs (`DISTINCTCOUNT`) para evitar duplicações.
***Preço Médio:** Média simples dos preços (`AVERAGE`).
***Taxa de Ocupação Média (%):
***Cálculo complexo utilizando:** variáveis (`VAR`) para determinar a proporção de dias ocupados em relação à capacidade total anual do portfólio.
***Receita Potencial Máxima:** Estimativa baseada na capacidade total de dias e preço.

---
## 📊 Dashboard e Insights

O painel foi estruturado para responder a perguntas de negócio sobre oportunidades e eficiência em Nova York.

### Visão Geral do Painel
![Airbnb Power BI Dashboard](dashboard.png)

### Visualizações Chave
1.  **Mapa Geográfico:** Plotagem de Receita Potencial Máxima por latitude/longitude, identificando "zonas de calor" financeiro.
2.  **Histograma de Preços:** Distribuição do volume de imóveis por faixas de preço.
3.  **Análise Temporal:** Evolução da Taxa de Ocupação Média ao longo dos anos por grupo de bairro.

### Principais Descobertas
* **Manhattan:** Possui o maior **Potencial de Receita** e a maior volatilidade (desvio padrão) de preços, indicando um mercado misto de luxo e oportunidades.
* **Brooklyn:** Apresenta a **Taxa de Ocupação** mais alta e consistente, sugerindo uma demanda estável.
* **Inventário:** A maior parte dos imóveis listados pertence à categoria "Entire home/apt".

---

## 🛠️ Como Executar

1.  **BigQuery:**
    * Importe os arquivos CSV brutos (`hosts`, `rooms`, `reviews`) para o seu projeto no Google Cloud.
    * Execute os scripts SQL disponíveis na pasta `/scripts` deste repositório para criar as views limpas (`_clean`).
2.  **Power BI:**
    * Abra o arquivo `projeto_rota02.pbix`.
    * Atualize as credenciais de conexão com o seu projeto do BigQuery.
    * Atualize os dados para carregar as views processadas.

---

## ✒️ Autoria

Projeto desenvolvido como parte do bootcamp da Laboratória (Rota 02 - BI).