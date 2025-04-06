-- Schema: Usuario
CREATE SCHEMA IF NOT EXISTS Usuario;

CREATE TABLE Usuario.Usuarios (
  Id SERIAL PRIMARY KEY,
  Senha TEXT NOT NULL,
  Matricula TEXT UNIQUE,
  Token TEXT,
  CreatedAt TIMESTAMP,
  UpdatedAt TIMESTAMP
);

CREATE TABLE Usuario.Perfis (
  Id SERIAL PRIMARY KEY,
  Nivel TEXT,
  Area TEXT
);

CREATE TABLE Usuario.UsuarioPerfil (
  Id SERIAL PRIMARY KEY,
  IdUsuario INTEGER REFERENCES Usuario.Usuarios(Id),
  IdPerfil INTEGER REFERENCES Usuario.Perfis(Id)
);

-- Schema: Certificado
CREATE SCHEMA IF NOT EXISTS Certificado;

CREATE TABLE Certificado.Certificados (
  Token TEXT PRIMARY KEY,
  IdUsuario INTEGER REFERENCES Usuario.Usuarios(Id),
  CreatedAt TIMESTAMP,
  UpdatedAt TIMESTAMP
);

-- Schema: Aprendizagem
CREATE SCHEMA IF NOT EXISTS Aprendizagem;

CREATE TABLE Aprendizagem.Trilhas (
  Id SERIAL PRIMARY KEY,
  Titulo TEXT
);

CREATE TABLE Aprendizagem.UsuarioTrilha (
  Id SERIAL PRIMARY KEY,
  IdUsuario INTEGER REFERENCES Usuario.Usuarios(Id),
  IdTrilha INTEGER REFERENCES Aprendizagem.Trilhas(Id)
);

CREATE TABLE Aprendizagem.Modulos (
  Id SERIAL PRIMARY KEY,
  Titulo TEXT,
  IdTrilha INTEGER REFERENCES Aprendizagem.Trilhas(Id),
  Descricao TEXT,
  UpdatedAt TIMESTAMP,
  CreatedAt TIMESTAMP
);

CREATE TABLE Aprendizagem.Videos (
  Id SERIAL PRIMARY KEY,
  Titulo TEXT,
  Duracao INTERVAL,
  Link TEXT,
  Descricao TEXT,
  Legenda TEXT,
  HQL TEXT,
  CreatedAt TIMESTAMP,
  UpdatedAt TIMESTAMP
);

CREATE TABLE Aprendizagem.ModuloVideo (
  Id SERIAL PRIMARY KEY,
  IdModulo INTEGER REFERENCES Aprendizagem.Modulos(Id),
  IdVideo INTEGER REFERENCES Aprendizagem.Videos(Id)
);

CREATE TABLE Aprendizagem.Quizzes (
  Id SERIAL PRIMARY KEY,
  Questions JSONB,
  Responses JSONB
);

-- Schema: Progresso
CREATE SCHEMA IF NOT EXISTS Progresso;

CREATE TABLE Progresso.AvancosVideo (
  IdUsuario INTEGER REFERENCES Usuario.Usuarios(Id),
  IdVideo INTEGER REFERENCES Aprendizagem.Videos(Id),
  MomentoAtual INTERVAL,
  Finalizado BOOLEAN,
  PRIMARY KEY (IdUsuario, IdVideo)
);

CREATE TABLE Progresso.Visualizados (
  Id SERIAL PRIMARY KEY,
  IdUsuario INTEGER REFERENCES Usuario.Usuarios(Id),
  IdVideo INTEGER REFERENCES Aprendizagem.Videos(Id),
  CreatedAt TIMESTAMP
);

CREATE TABLE Progresso.TentativasQuizzes (
  Id SERIAL PRIMARY KEY,
  IdUsuario INTEGER REFERENCES Usuario.Usuarios(Id),
  IdQuiz INTEGER REFERENCES Aprendizagem.Quizzes(Id),
  TentativaAtual INTEGER,
  TempoTentativa INTERVAL,
  Pontuacao NUMERIC
);

CREATE TABLE Progresso.HistoricoTentativas (
  Id SERIAL PRIMARY KEY,
  IdTentativaQuiz INTEGER REFERENCES Progresso.TentativasQuizzes(Id),
  NumTentativa INTEGER,
  Pontuacao NUMERIC,
  TempoTentativa INTERVAL
);

-- Schema: Gamific
CREATE SCHEMA IF NOT EXISTS Gamific;

CREATE TABLE Gamific.Pontos (
  IdUsuario INTEGER PRIMARY KEY REFERENCES Usuario.Usuarios(Id),
  Qtd INTEGER
);

CREATE TABLE Gamific.Conquistas_quiz (
  Id SERIAL PRIMARY KEY,
  IdQuiz INTEGER REFERENCES Aprendizagem.Quizzes(Id),
  Tipo TEXT,
  Descricao TEXT,
  Pontuacao INTEGER
);

CREATE TABLE Gamific.Conquistas_trilhas (
  Id SERIAL PRIMARY KEY,
  IdTrilha INTEGER REFERENCES Aprendizagem.Trilhas(Id),
  Tipo TEXT,
  Descricao TEXT,
  Pontuacao INTEGER
);

CREATE TABLE Gamific.Conquistas_module (
  Id SERIAL PRIMARY KEY,
  IdModulo INTEGER REFERENCES Aprendizagem.Modulos(Id),
  Tipo TEXT,
  Descricao TEXT,
  Pontuacao INTEGER
);

-- Schema: Premios
CREATE SCHEMA IF NOT EXISTS Premios;

CREATE TABLE Premios.Recompensas (
  Id SERIAL PRIMARY KEY,
  Valor INTEGER,
  Descricao TEXT
);

CREATE TABLE Premios.Resgates (
  Id SERIAL PRIMARY KEY,
  IdUsuario INTEGER REFERENCES Usuario.Usuarios(Id),
  IdRecompensa INTEGER REFERENCES Premios.Recompensas(Id),
  DataResgate TIMESTAMP
);
