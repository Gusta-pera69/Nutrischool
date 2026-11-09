--NutriSchool--script do banco (SQLite)
-- Pode ser testado em https://sqliteonline.com ou no DB Browser for SQLite.

PRAGMA foreign_keys = ON;

-- =========================================
-- TABELA: Usuario
-- =========================================

CREATE TABLE IF NOT EXISTS Usuario (
    id_usuario INTEGER PRIMARY KEY,
    email TEXT UNIQUE,
    senha_hash TEXT NOT NULL,
    CPF TEXT UNIQUE,
    tipo_usuario TEXT NOT NULL,
    status TEXT NOT NULL,
    data_inativacao TEXT
);

-- =========================================
-- TABELA: Aluno
-- =========================================

CREATE TABLE IF NOT EXISTS Aluno (
    id_aluno INTEGER PRIMARY KEY,
    Nome TEXT NOT NULL,
    Turma TEXT NOT NULL,
    id_usuario INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (id_usuario)
        REFERENCES Usuario(id_usuario)
        ON DELETE RESTRICT
);

-- =========================================
-- TABELA: Funcionario
-- =========================================

CREATE TABLE IF NOT EXISTS Funcionario (
    id_funcionario INTEGER PRIMARY KEY,
    Nome TEXT NOT NULL,
    id_usuario INTEGER NOT NULL UNIQUE,
    acesso TEXT NOT NULL,
    FOREIGN KEY (id_usuario)
        REFERENCES Usuario(id_usuario)
        ON DELETE RESTRICT
);

-- =========================================
-- TABELA: CardapioMerenda
-- =========================================

CREATE TABLE IF NOT EXISTS CardapioMerenda (
    id_cardapio INTEGER PRIMARY KEY,
    data_cardapio TEXT NOT NULL,
    descricao TEXT NOT NULL,
    horario_limite_confirmacao TEXT NOT NULL,
    imagem_uri TEXT
);

-- =========================================
-- TABELA: ConfirmacaoMerenda
-- =========================================

CREATE TABLE IF NOT EXISTS ConfirmacaoMerenda (
    id_confirmacao INTEGER PRIMARY KEY,
    id_aluno INTEGER NOT NULL,
    id_cardapio INTEGER NOT NULL,
    data_confirmacao TEXT NOT NULL,

    FOREIGN KEY (id_aluno)
        REFERENCES Aluno(id_aluno)
        ON DELETE RESTRICT,

    FOREIGN KEY (id_cardapio)
        REFERENCES CardapioMerenda(id_cardapio)
        ON DELETE RESTRICT
);

-- =========================================
-- TABELA: Pedido
-- =========================================

CREATE TABLE IF NOT EXISTS Pedido (
    id_pedido INTEGER PRIMARY KEY,
    id_aluno INTEGER NOT NULL,
    data_hora_pedido TEXT NOT NULL,
    status TEXT NOT NULL,

    FOREIGN KEY (id_aluno)
        REFERENCES Aluno(id_aluno)
        ON DELETE RESTRICT
);

-- =========================================
-- TABELA: ProdutoCantina
-- =========================================

CREATE TABLE IF NOT EXISTS ProdutoCantina (
    id_produto INTEGER PRIMARY KEY,
    Nome TEXT NOT NULL,
    Preco REAL NOT NULL,
    Quantidade_estoque INTEGER NOT NULL,
    imagem_uri TEXT
);

-- =========================================
-- TABELA: ItemPedido
-- =========================================

CREATE TABLE IF NOT EXISTS ItemPedido (
    id_item INTEGER PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,

    FOREIGN KEY (id_pedido)
        REFERENCES Pedido(id_pedido)
        ON DELETE CASCADE,

    FOREIGN KEY (id_produto)
        REFERENCES ProdutoCantina(id_produto)
        ON DELETE RESTRICT
);

-- =========================================
-- DADOS DE DEMONSTRAÇÃO: Usuario
-- =========================================

INSERT INTO Usuario
(id_usuario, email, senha_hash, CPF, tipo_usuario, status, data_inativacao)
VALUES
(1, 'ana@teste.local', 'HASH_DEMO_ANA', NULL, 'ALUNO', 'ativo', NULL),
(2, 'bruno@teste.local', 'HASH_DEMO_BRUNO', NULL, 'ALUNO', 'ativo', NULL),
(3, 'carla@teste.local', 'HASH_DEMO_CARLA', NULL, 'ALUNO', 'ativo', NULL),
(4, 'daniel@teste.local', 'HASH_DEMO_DANIEL', NULL, 'ALUNO', 'ativo', NULL),
(5, 'eduarda@teste.local', 'HASH_DEMO_EDUARDA', NULL, 'ALUNO', 'ativo', NULL),
(6, NULL, 'HASH_DEMO_MARCIA', '12345678901', 'FUNCIONARIO', 'ativo', NULL),
(7, NULL, 'HASH_DEMO_PAULO', '98765432100', 'FUNCIONARIO', 'ativo', NULL),
(8, NULL, 'HASH_DEMO_LUCIA', '11122233344', 'FUNCIONARIO', 'ativo', NULL),
(9, NULL, 'HASH_DEMO_ROBERTO', '55566677788', 'FUNCIONARIO', 'ativo', NULL),
(10, NULL, 'HASH_DEMO_FERNANDA', '99988877766', 'FUNCIONARIO', 'ativo', NULL);

-- =========================================
-- DADOS DE DEMONSTRAÇÃO: Aluno
-- =========================================

INSERT INTO Aluno (id_aluno, Nome, Turma, id_usuario) VALUES
(1, 'Ana Silva', '1A', 1),
(2, 'Bruno Costa', '2B', 2),
(3, 'Carla Souza', '3A', 3),
(4, 'Daniel Lima', '1B', 4),
(5, 'Eduarda Alves', '2A', 5);

-- =========================================
-- DADOS DE DEMONSTRAÇÃO: Funcionario
-- =========================================

INSERT INTO Funcionario (id_funcionario, Nome, id_usuario, acesso) VALUES
(1, 'Marcia Santos', 6, 'COZINHA_ESCOLA'),
(2, 'Paulo Oliveira', 7, 'CANTINA'),
(3, 'Lucia Ferreira', 8, 'COZINHA_ESCOLA'),
(4, 'Roberto Lima', 9, 'CANTINA'),
(5, 'Fernanda Souza', 10, 'COZINHA_ESCOLA');

-- =========================================
-- DADOS DE DEMONSTRAÇÃO: CardapioMerenda
-- =========================================

INSERT INTO CardapioMerenda
(id_cardapio, data_cardapio, descricao, horario_limite_confirmacao, imagem_uri)
VALUES
(1, '2026-11-09', 'Arroz, feijao e frango', '09:30', NULL),
(2, '2026-11-10', 'Macarrao com carne', '09:30', NULL),
(3, '2026-11-11', 'Arroz, feijao e carne moida', '09:30', NULL),
(4, '2026-11-12', 'Sopa de legumes', '09:30', NULL),
(5, '2026-11-13', 'Arroz, feijao e ovo', '09:30', NULL);

-- =========================================
-- DADOS DE DEMONSTRAÇÃO: ConfirmacaoMerenda
-- =========================================

INSERT INTO ConfirmacaoMerenda
(id_confirmacao, id_aluno, id_cardapio, data_confirmacao)
VALUES
(1, 1, 1, '2026-11-08 08:00'),
(2, 2, 1, '2026-11-08 08:10'),
(3, 3, 2, '2026-11-08 08:15'),
(4, 4, 3, '2026-11-08 08:20'),
(5, 5, 4, '2026-11-08 08:30');

-- =========================================
-- DADOS DE DEMONSTRAÇÃO: Pedido
-- =========================================

INSERT INTO Pedido
(id_pedido, id_aluno, data_hora_pedido, status)
VALUES
(1, 1, '2026-11-08 09:00', 'PENDENTE'),
(2, 2, '2026-11-08 09:10', 'PREPARANDO'),
(3, 3, '2026-11-08 09:20', 'PRONTO'),
(4, 4, '2026-11-08 09:30', 'PENDENTE'),
(5, 5, '2026-11-08 09:40', 'CANCELADO');

-- =========================================
-- DADOS DE DEMONSTRAÇÃO: ProdutoCantina
-- =========================================

INSERT INTO ProdutoCantina
(id_produto, Nome, Preco, Quantidade_estoque, imagem_uri)
VALUES
(1, 'Coxinha', 6.00, 20, NULL),
(2, 'Pastel', 7.00, 15, NULL),
(3, 'Suco', 4.00, 30, NULL),
(4, 'Pao de queijo', 3.50, 25, NULL),
(5, 'Sanduiche', 8.00, 10, NULL);

-- =========================================
-- DADOS DE DEMONSTRAÇÃO: ItemPedido
-- =========================================

INSERT INTO ItemPedido
(id_item, id_pedido, id_produto, quantidade)
VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 1),
(4, 3, 4, 2),
(5, 4, 5, 1);

-- =========================================
-- CONSULTAS PARA CONFERIR OS DADOS
-- =========================================

SELECT * FROM Usuario;
SELECT * FROM Aluno;
SELECT * FROM Funcionario;
SELECT * FROM CardapioMerenda;
SELECT * FROM ConfirmacaoMerenda;
SELECT * FROM Pedido;
SELECT * FROM ProdutoCantina;
SELECT * FROM ItemPedido;
