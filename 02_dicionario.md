# 02_dicionario.md - Dicionário de Dados

### Tabela: tecnico

| Campo | Tipo | Restrição | Descrição |
|---|---|---|---|
| id_tecnico | INTEGER | PK AUTOINCREMENT | ID único do técnico/solicitante |
| nome_tecnico | TEXT | NOT NULL | Ex: Jose Alcides Rosa Junior |
| setor | TEXT | NOT NULL | Ex: Metrologia |

### Tabela: equipamento

| Campo | Tipo | Restrição | Descrição |
|---|---|---|---|
| id_equipamento | INTEGER | PK AUTOINCREMENT | ID único do equipamento |
| codigo_tag | TEXT | UNIQUE NOT NULL | Ex: 703.1208 |
| nome_equipamento | TEXT | NOT NULL | Ex: Dispositivo de controle |
| fabricante | TEXT | NOT NULL | Ex: Carl Zeiss |
| modelo | TEXT | NOT NULL | Ex: 500.011 |

### Tabela: medicao

| Campo | Tipo | Restrição | Descrição |
|---|---|---|---|
| id_medicao | INTEGER | PK AUTOINCREMENT | ID único da medição |
| id_equipamento | INTEGER | NOT NULL, FK | Vínculo com equipamento |
| id_tecnico | INTEGER | NOT NULL, FK | Vínculo com técnico |
| codigo | TEXT | NOT NULL | Código do equipamento - Ex: 703.1208 |
| parametro_medido | TEXT | NOT NULL | Ex: 62P_DIAMETRO, PLANICIDADE_REF |
| valor_nominal | REAL | NOT NULL | Valor nominal esperado - Ex: 6,075 |
| tolerancia_min | REAL | NOT NULL | Tol - |
| tolerancia_max | REAL | NOT NULL | Tol + |
| valor_obtido | REAL | NOT NULL | Valor medido na MMC (Actual) - Ex: 6,079 |
| erro | REAL | NOT NULL | Calculado pelo sistema como \|valor_obtido − valor_nominal\| - Ex: 0,004. Não é o Deviation bruto do relatório da MMC |
| status_resultado | TEXT | CHECK | APROVADO/REPROVADO |
| data_medicao | TEXT | DEFAULT CURRENT_TIMESTAMP | Data e hora da calibração |

**Total de campos mapeados:** 20 (3 em tecnico + 5 em equipamento + 12 em medicao), acima do mínimo de 12 exigido pelo roteiro.
