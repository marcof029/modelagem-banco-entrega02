# Projeto Aplicado I - Schulz S.A.
## Entrega 02: Modelagem e Implementação de Banco de Dados

**Empresa Parceira:** Schulz S.A. - Laboratório de Metrologia
**Tema 02:** Modelagem de Banco de Dados Relacional (SQLite)
**Professor:** Prof. MSc. Hugo Menezes Barra

### Contexto da Entrega 02

Na Entrega 01, mapeamos os problemas das planilhas manuais na Schulz S.A. para emissão de 600 a 700 certificados de calibração por mês. A leitura estática de arquivos Excel e TXT da MMC Carl Zeiss (Modelo 500.011) gera perda de histórico, inconsistência e falta de segurança. Nesta Entrega 02, como analistas de sistemas, estruturamos um banco de dados relacional em **SQLite** que substitui essas planilhas, armazenando de forma organizada as informações de técnicos, equipamentos e medições.

### 1. Organização dos Dados

O banco foi dividido em 3 entidades principais, conforme o modelo conceitual simplificado proposto para esta etapa:

**Entidade 1: Técnico / Solicitante**
Armazena os técnicos executores das medições (Ex: Jose Alcides Rosa Junior) e o setor solicitante da calibração (Ex: Usinagem I). Evita digitar o mesmo nome em todo certificado emitido, centralizando essa informação em um único cadastro.

**Entidade 2: Equipamento**
Registra os instrumentos calibrados pelo laboratório. Ex: Código 703.1208, Dispositivo de controle. Guarda TAG única, fabricante e modelo, permitindo localizar o histórico completo de um instrumento a partir de um único identificador.

**Entidade 3: Medição**
Registra o evento de calibração. Recebe os dados extraídos do relatório da MMC (Actual, Nominal, Upper Tol, Lower Tol) e mapeia esses valores para os campos do certificado (Valor obtido, Valor nominal, Tol +, Tol -, Erro), associando cada medição ao equipamento e ao técnico responsáveis.

### 2. Justificativa - Evitar Dados Duplicados

A separação em 3 entidades relacionadas por chave estrangeira (FK), em vez de uma única planilha repetindo os mesmos dados em cada linha, resolve diretamente problemas já identificados na Entrega 01:

1. **Integridade Referencial:** o SQLite impede o cadastro de uma medição para um equipamento ou técnico inexistente (`PRAGMA foreign_keys = ON`), o que bloqueia erros de digitação que hoje geram divergências como as observadas entre grafias diferentes de uma mesma MMC (ex: "500.011", "500011" e "500008" referindo-se ao mesmo tipo de equipamento).

2. **Histórico:** cada certificado (ex: 00091/2026) fica vinculado ao `id_equipamento` e ao `id_tecnico` correspondentes, permitindo consultar todas as calibrações de um instrumento sem depender de arquivos soltos em diretório de rede.

3. **Produtividade:** elimina a digitação manual repetida de dados cadastrais (nome do técnico, código do equipamento) a cada novo certificado, reduzindo o retrabalho mapeado no Bloco 1 da Entrega 01.

4. **Padronização de nomes:** como o nome do técnico e o código do equipamento passam a existir uma única vez no banco (em `tecnico` e `equipamento`), variações de grafia do mesmo dado em registros diferentes (ex: "José A. Rosa Jr" e "Jose Alcides Rosa Junior") deixam de ocorrer, pois toda medição referencia o mesmo cadastro por `id`, em vez de repetir o texto a cada linha.
