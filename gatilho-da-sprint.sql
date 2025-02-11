CREATE TABLE Log_Reservas (
    id SERIAL PRIMARY KEY,
    reserva_id INT,
    quarto_id INT,
    data_checkin DATE,
    data_checkout DATE,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    mensagem TEXT
);


CREATE OR REPLACE FUNCTION log_nova_reserva()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Log_Reservas (reserva_id, quarto_id, data_checkin, data_checkout, mensagem)
    VALUES (
        NEW.reserva_id,
        NEW.quarto_id,
        NEW.data_checkin,
        NEW.data_checkout,
        'Reserva inserida para o quarto ' || NEW.quarto_id || ' de ' || NEW.data_checkin || ' até ' || NEW.data_checkout
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_log_reserva
AFTER INSERT ON Reserva_Quarto
FOR EACH ROW
EXECUTE FUNCTION log_nova_reserva();


INSERT INTO Reserva_Quarto (reserva_id, quarto_id, data_checkin, data_checkout, quantidade_diarias)
VALUES (1, 101, '2025-03-01', '2025-03-05', 4);
