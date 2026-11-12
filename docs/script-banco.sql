--NutriSchool--script do banco (SQLite)
-- Pode ser testado em https://sqliteonline.com ou no DB Browser for SQLite.


PRAGMA foreign_keys = ON;

CREATE TABLE Usuario (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE,
    senha_hash TEXT NOT NULL,
    CPF TEXT UNIQUE,
    tipo_usuario TEXT NOT NULL,
    status_da_conta TEXT NOT NULL DEFAULT 'ativo',
    data_inativacao TEXT,
    CHECK (tipo_usuario IN ('ALUNO', 'FUNCIONARIO')),
    CHECK (
        (tipo_usuario = 'ALUNO' AND email IS NOT NULL AND CPF IS NULL)
        OR
        (tipo_usuario = 'FUNCIONARIO' AND CPF IS NOT NULL AND email IS NULL)
    ),
    CHECK (status_da_conta IN ('ativo', 'inativo')),
    CHECK (
        (status_da_conta = 'ativo' AND data_inativacao IS NULL)
        OR
        (status_da_conta = 'inativo' AND data_inativacao IS NOT NULL)
    )
);

CREATE TABLE Aluno (
    id_aluno INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome TEXT NOT NULL,
    Turma TEXT NOT NULL,
    id_usuario INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (id_usuario)
        REFERENCES Usuario(id_usuario) ON DELETE RESTRICT
);

CREATE TABLE Funcionario (
    id_funcionario INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome TEXT NOT NULL,
    id_usuario INTEGER NOT NULL UNIQUE,
    acesso TEXT NOT NULL,
    FOREIGN KEY (id_usuario)
        REFERENCES Usuario(id_usuario) ON DELETE RESTRICT,
    CHECK (acesso IN ('CANTINA', 'COZINHA_ESCOLA'))
);


CREATE TABLE CardapioMerenda (
    id_cardapio INTEGER PRIMARY KEY AUTOINCREMENT,
    data_cardapio TEXT NOT NULL UNIQUE,
    descricao TEXT NOT NULL,
    horario_limite_confirmacao TEXT NOT NULL,
    imagem_uri TEXT
);

CREATE TABLE ConfirmacaoMerenda (
    id_confirmacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_aluno INTEGER NOT NULL,
    id_cardapio INTEGER NOT NULL,
    data_confirmacao TEXT NOT NULL,
    FOREIGN KEY (id_aluno)
        REFERENCES Aluno(id_aluno) ON DELETE RESTRICT,
    FOREIGN KEY (id_cardapio)
        REFERENCES CardapioMerenda(id_cardapio) ON DELETE RESTRICT,
    UNIQUE (id_aluno, id_cardapio)
);


CREATE TABLE Pedido (
    id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    id_aluno INTEGER NOT NULL,
    data_hora_pedido TEXT NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (id_aluno)
        REFERENCES Aluno(id_aluno) ON DELETE RESTRICT,
    CHECK (status IN ('PENDENTE', 'PREPARANDO', 'PRONTO', 'CANCELADO'))
);

CREATE TABLE ProdutoCantina (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome TEXT NOT NULL,
    Preco REAL NOT NULL,
    Quantidade_estoque INTEGER NOT NULL,
    imagem_uri TEXT,
    CHECK (Preco >= 0),
    CHECK (Quantidade_estoque >= 0)
);


CREATE TABLE ItemPedido (
    id_item INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    FOREIGN KEY (id_pedido)
        REFERENCES Pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_produto)
        REFERENCES ProdutoCantina(id_produto) ON DELETE RESTRICT,
    CHECK (quantidade > 0),
    UNIQUE (id_pedido, id_produto)
);

INSERT INTO Usuario
    (id_usuario, email, senha_hash, CPF, tipo_usuario, status_da_conta, data_inativacao)
VALUES
    (1, 'ana@teste.local',      'HASH_DEMO_ANA',      NULL,          'ALUNO',       'ativo', NULL),
    (2, 'bruno@teste.local',    'HASH_DEMO_BRUNO',    NULL,          'ALUNO',       'ativo', NULL),
    (3, 'carla@teste.local',    'HASH_DEMO_CARLA',    NULL,          'ALUNO',       'ativo', NULL),
    (4, 'daniel@teste.local',   'HASH_DEMO_DANIEL',   NULL,          'ALUNO',       'ativo', NULL),
    (5, 'eduarda@teste.local',  'HASH_DEMO_EDUARDA',  NULL,          'ALUNO',       'ativo', NULL),
    (6, NULL,                   'HASH_DEMO_MARCIA',   '12345678901', 'FUNCIONARIO', 'ativo', NULL),
    (7, NULL,                   'HASH_DEMO_PAULO',    '98765432100', 'FUNCIONARIO', 'ativo', NULL),
    (8, NULL,                   'HASH_DEMO_LUCIA',    '11122233344', 'FUNCIONARIO', 'ativo', NULL),
    (9, NULL,                   'HASH_DEMO_ROBERTO',  '55566677788', 'FUNCIONARIO', 'ativo', NULL),
    (10, NULL,                  'HASH_DEMO_FERNANDA', '99988877766', 'FUNCIONARIO', 'ativo', NULL);

INSERT INTO Aluno (id_aluno, Nome, Turma, id_usuario) VALUES
    (1, 'Ana Silva', '1A', 1),
    (2, 'Bruno Costa', '2B', 2),
    (3, 'Carla Souza', '3A', 3),
    (4, 'Daniel Lima', '1B', 4),
    (5, 'Eduarda Alves', '2A', 5);

INSERT INTO Funcionario (id_funcionario, Nome, id_usuario, acesso) VALUES
    (1, 'Marcia Santos', 6, 'COZINHA_ESCOLA'),
    (2, 'Paulo Oliveira', 7, 'CANTINA'),
    (3, 'Lucia Ferreira', 8, 'COZINHA_ESCOLA'),
    (4, 'Roberto Lima', 9, 'CANTINA'),
    (5, 'Fernanda Souza', 10, 'COZINHA_ESCOLA');

INSERT INTO CardapioMerenda
    (id_cardapio, data_cardapio, descricao, horario_limite_confirmacao, imagem_uri)
VALUES
    (1, '2026-11-09', 'Arroz, feijao e frango', '09:30', NULL),
    (2, '2026-11-10', 'Macarrao com carne', '09:30', NULL),
    (3, '2026-11-11', 'Arroz, feijao e carne moida', '09:30', NULL),
    (4, '2026-11-12', 'Sopa de legumes', '09:30', NULL),
    (5, '2026-11-13', 'Arroz, feijao e ovo', '09:30', NULL);
    
INSERT INTO ConfirmacaoMerenda
    (id_confirmacao, id_aluno, id_cardapio, data_confirmacao)
VALUES
    (1, 1, 1, '2026-11-08 08:00'),
    (2, 2, 1, '2026-11-08 08:10'),
    (3, 3, 2, '2026-11-08 08:15'),
    (4, 4, 3, '2026-11-08 08:20'),
    (5, 5, 4, '2026-11-08 08:30');

INSERT INTO Pedido (id_pedido, id_aluno, data_hora_pedido, status) VALUES
    (1, 1, '2026-11-08 09:00', 'PENDENTE'),
    (2, 2, '2026-11-08 09:10', 'PREPARANDO'),
    (3, 3, '2026-11-08 09:20', 'PRONTO'),
    (4, 4, '2026-11-08 09:30', 'PENDENTE'),
    (5, 5, '2026-11-08 09:40', 'CANCELADO');

INSERT INTO ProdutoCantina
    (id_produto, Nome, Preco, Quantidade_estoque, imagem_uri)
VALUES
    (1, 'Coxinha', 6.00, 20, NULL),
    (2, 'Pastel', 7.00, 15, NULL),
    (3, 'Suco', 4.00, 30, NULL),
    (4, 'Pao de queijo', 3.50, 25, NULL),
    (5, 'Sanduiche', 8.00, 10, NULL);

INSERT INTO ItemPedido (id_item, id_pedido, id_produto, quantidade) VALUES
    (1, 1, 1, 2),
    (2, 1, 3, 1),
    (3, 2, 2, 1),
    (4, 3, 4, 2),
    (5, 4, 5, 1);

SELECT * FROM Usuario;
SELECT * FROM Aluno;
SELECT * FROM Funcionario;
SELECT * FROM CardapioMerenda;
SELECT * FROM ConfirmacaoMerenda;
SELECT * FROM Pedido;
SELECT * FROM ProdutoCantina;
SELECT * FROM ItemPedido;

