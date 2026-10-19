-- Projeto Aplicado I - Schulz S.A.
-- Entrega 02 - Banco de Dados SQLite
-- Professor: Hugo Menezes Barra

PRAGMA foreign_keys = ON;

-- Tabela 1: Tecnico / Solicitante
CREATE TABLE tecnico (
    id_tecnico INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_tecnico TEXT NOT NULL,
    setor TEXT NOT NULL
);

-- Tabela 2: Equipamento - Ex: TAG 703.1208
CREATE TABLE equipamento (
    id_equipamento INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo_tag TEXT NOT NULL UNIQUE,
    nome_equipamento TEXT NOT NULL,
    fabricante TEXT NOT NULL,
    modelo TEXT NOT NULL
);

-- Tabela 3: Medicao - Dados do TXT da MMC Zeiss
CREATE TABLE medicao (
    id_medicao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipamento INTEGER NOT NULL,
    id_tecnico INTEGER NOT NULL,
    codigo TEXT NOT NULL,
    parametro_medido TEXT NOT NULL,
    valor_nominal REAL NOT NULL,
    tolerancia_min REAL NOT NULL,
    tolerancia_max REAL NOT NULL,
    valor_obtido REAL NOT NULL,
    erro REAL NOT NULL, -- Calculado pelo sistema: |valor_obtido - valor_nominal|
    status_resultado TEXT CHECK(status_resultado IN ('APROVADO','REPROVADO')),
    data_medicao TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(id_equipamento) REFERENCES equipamento(id_equipamento),
    FOREIGN KEY(id_tecnico) REFERENCES tecnico(id_tecnico)
);

-- Dados de exemplo reais
INSERT INTO tecnico (nome_tecnico, setor) VALUES ('Jose Alcides Rosa Junior', 'Metrologia');
INSERT INTO equipamento (codigo_tag, nome_equipamento, fabricante, modelo) VALUES ('703.1208', 'Dispositivo de controle', 'Carl Zeiss', '500.011');