CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_cadastro DATE NOT NULL
);

drop table clientes

INSERT INTO clientes (nome, data_cadastro) VALUES
('João Silva', '2025-02-01'),
('Maria Souza', '2025-02-01'),
('Pedro Santos', '2025-02-01'),
('Ana Costa', '2025-02-01'),
('Lucas Oliveira', '2025-02-01'),
('Carla Ferreira', '2025-02-01'),
('Ricardo Almeida', '2025-02-01'),
('Sofia Lima', '2025-02-02'),
('Felipe Araújo', '2025-02-03'),
('Mariana Barbosa', '2025-02-04'),
('Bruno Martins', '2025-02-05'),
('Beatriz Nogueira', '2025-02-06'),
('Gustavo Ramos', '2025-02-07'),
('Fernanda Rocha', '2025-02-08'),
('Rafael Castro', '2025-02-09'),
('Isabela Mendes', '2025-02-10'),
('Diego Cardoso', '2025-02-11'),
('Tatiana Teixeira', '2025-02-12'),
('Henrique Santos', '2025-02-13'),
('Patrícia Correia', '2025-02-14');

select * from clientes

CREATE OR REPLACE FUNCTION contar_clientes_por_dia(data DATE) RETURNS INTEGER AS $$
DECLARE
    total_clientes INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_clientes
    FROM clientes
    WHERE data_cadastro = data;
    
    RETURN total_clientes;
END;
$$ LANGUAGE plpgsql;

SELECT contar_clientes_por_dia('2025-02-01') AS total_clientes;


