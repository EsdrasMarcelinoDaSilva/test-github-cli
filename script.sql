CREATE DATABASE escola;

CREATE TABLE disciplinas (
    id_disciplina SERIAL PRIMARY KEY,
    nome_disciplina VARCHAR(50) NOT NULL,
    nome_professor VARCHAR(50) NOT NULL
);

INSERT INTO disciplinas (nome_disciplina, nome_professor) VALUES
('Matemática', 'Prof. Carlos'),
('História', 'Prof. Ana'),
('Física', 'Prof. João'),
('Biologia', 'Prof. Maria'),
('Química', 'Prof. Fernanda');

select * from disciplinas

create table alunos (
	id_alunos SERIAL PRIMARY key,
  	nome_alunos varchar(50) not NULL,
  	disciplina_id int,
  	CONSTRAINT fk_disciplinas
  	FOREIGN key (disciplina_id)
  	REFERENCES disciplinas (id_disciplina)
)

INSERT INTO alunos (nome_alunos, disciplina_id) VALUES
('Pedro Santos', 1),
('Mariana Lima', 2),
('Rafael Alves', 3),
('Beatriz Souza', 4),
('Lucas Ferreira', 5);

SELECT * FROM alunos

ALTER TABLE alunos
DROP CONSTRAINT fk_disciplinas;

INSERT INTO alunos (nome_alunos, disciplina_id) VALUES
('Fernando Silva', NULL),   
('Gabriela Ferreira', 6);  

UPDATE alunos SET disciplina_id = NULL WHERE disciplina_id NOT IN (SELECT id_disciplina FROM disciplinas);

ALTER TABLE alunos
ADD CONSTRAINT fk_disciplinas
FOREIGN KEY (disciplina_id)
REFERENCES disciplinas (id_disciplina);

SELECT 
    alunos.id_alunos, 
    alunos.nome_alunos, 
    disciplinas.nome_disciplina, 
    disciplinas.nome_professor
FROM 
    alunos
INNER JOIN 
    disciplinas 
ON 
    alunos.disciplina_id = disciplinas.id_disciplina;


SELECT 
    alunos.id_alunos, 
    alunos.nome_alunos, 
    disciplinas.nome_disciplina, 
    disciplinas.nome_professor
FROM 
    alunos
LEFT JOIN 
    disciplinas 
ON 
    alunos.disciplina_id = disciplinas.id_disciplina;