- **Gustavo pereira:Dev.mobie**

## Tecnologias utilizadas

- **React Native:** desenvolvimento do aplicativo mobile.
- **Expo SDK 56:** ambiente e ferramentas de desenvolvimento.
- **Expo Go:** execução e visualização do projeto em dispositivo móvel.
- **Expo SQLite:** integração com o banco de dados local SQLite.
- **JavaScript:** linguagem de programação.
- **Node.js:** ambiente necessário para executar as ferramentas de desenvolvimento.

## Como executar o projeto

### Pré-requisitos

- Node.js instalado (versão LTS).
- Expo Go instalado no celular.
- Git instalado no computador.

### 1. Clonar o repositório

```bash
git clone https://github.com/Gusta-pera69/Nutrischool.git
```

### 2. Entrar na pasta do projeto

```bash
cd Nutrischool
```

### 3. Instalar as dependências

```bash
npm install
```

### 4. Iniciar o aplicativo

```bash
npx expo start
```

### 5. Abrir no celular

- Abra o Expo Go.
- Leia o QR Code exibido no terminal ou navegador.
- Aguarde o aplicativo carregar.

**Observações:**

- O computador e o celular devem estar conectados à mesma rede Wi-Fi.
- Caso a rede apresente problemas de conexão, execute `npx expo start --tunnel`.
- O projeto utiliza Expo SDK 56. Confira a compatibilidade do Expo Go antes de executar.

## Banco de dados

O banco de dados do NutriSchool utiliza SQLite e um modelo relacional composto por 8 tabelas, responsáveis por organizar as informações dos usuários, alunos, funcionários, merenda, produtos e pedidos.

### Diagrama Entidade-Relacionamento (DER)

![Diagrama Entidade-Relacionamento](docs/DER.png)

### Script SQL

O arquivo [`script-banco.sql`](docs/script-banco.sql) contém o script de criação das tabelas, definição dos relacionamentos, restrições de integridade e inserção de dados fictícios para testes.

O script utiliza `PRAGMA foreign_keys = ON` para habilitar a verificação das chaves estrangeiras no SQLite.

Para visualizar e executar o script em um ambiente de testes, acesse o [SQLite Online](https://sqliteonline.com).

- **Gustavo pereira:Dev.Dados**

### Estrutura do banco

| Tabela | Finalidade |
|---|---|
| `Usuario` | Armazenar os dados de acesso das contas. |
| `Aluno` | Registrar os dados dos alunos. |
| `Funcionario` | Registrar os dados dos funcionários e seus acessos. |
| `CardapioMerenda` | Armazenar as informações dos cardápios. |
| `ConfirmacaoMerenda` | Registrar as confirmações de participação na merenda. |
| `Pedido` | Armazenar os pedidos realizados pelos alunos. |
| `ProdutoCantina` | Registrar os produtos, preços e informações de estoque. |
| `ItemPedido` | Relacionar os produtos aos respectivos pedidos. |

### Integridade e regras de exclusão

O banco utiliza chaves primárias (`PRIMARY KEY`) e chaves estrangeiras (`FOREIGN KEY`) para identificar os registros e manter os relacionamentos entre as tabelas.

As regras de exclusão foram definidas para preservar o histórico e evitar a perda indevida de informações:

- **RESTRICT:** impede a exclusão de registros que possuem vínculos com outros dados, preservando a integridade dos relacionamentos.
- **CASCADE:** permite excluir automaticamente os itens relacionados quando um registro de pedido é efetivamente excluído. O cancelamento de um pedido não exclui seus itens, pois eles são mantidos para preservar o histórico.

### Inativação de contas

A tabela `Usuario` possui os campos `status_da_conta` e `data_inativacao`, permitindo registrar a situação da conta e a data em que ela foi inativada.

A inativação preserva os registros no banco de dados. A anonimização ou exclusão de dados pessoais elegíveis após o prazo definido dependerá de uma rotina administrativa implementada no aplicativo.

### Operações e consultas (CRUD)

O planejamento das operações do banco contempla:

- **CREATE (INSERT):** cadastro de informações.
- **READ (SELECT):** consulta e visualização de dados.
- **UPDATE:** atualização de registros.
- **DELETE:** exclusão de registros.
- Consultas com `JOIN` para relacionar informações de diferentes tabelas.
- Agrupamentos e contagens utilizando `GROUP BY`.

## Contribuição individual

### Dev Mobile — Gustavo Pereira Silva

**Minha contribuição:**

- Preparação do ambiente de desenvolvimento mobile.
- Configuração do projeto utilizando React Native e Expo SDK 56.
- Instalação e preparação da biblioteca `expo-sqlite` para integração com o banco de dados local.
- Execução e visualização do aplicativo pelo Expo Go.
- Criação do repositório no GitHub e envio inicial dos arquivos do projeto.

**Evidências:**

| Item | Evidência |
|---|---|
| Repositório no GitHub | [Nutrischool](https://github.com/Gusta-pera69/Nutrischool) |
| Projeto Expo SDK 56 | Projeto executando no Expo Go (`docs/expo.jpeg`). |
| Biblioteca `expo-sqlite` | Registro no `package.json`. |
| Primeiro commit | Histórico de commits do GitHub. |

### Dev de Dados — Gustavo Pereira Silva

**Banco de dados:**

**Minha contribuição:**

- Elaboração do Diagrama Entidade-Relacionamento (DER).
- Desenvolvimento do dicionário de dados.
- Criação e validação do script SQL.
- Definição das tabelas, atributos e relacionamentos.
- Definição das regras de integridade referencial (`RESTRICT` e `CASCADE`).
- Inserção de dados fictícios para testes.
- Planejamento das operações CRUD e consultas do banco.
- Execução de testes no SQLite para verificar o funcionamento do script e a integridade dos dados.

**Evidências:**

- Diagrama Entidade-Relacionamento: [`docs/DER.png`](docs/DER.png).
- Script SQL: [`docs/script-banco.sql`](docs/script-banco.sql).

---