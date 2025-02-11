CREATE OR REPLACE FUNCTION verificar_e_inserir_reserva(
    p_reserva_id INT,
    p_quarto_id INT,
    p_data_checkin DATE,
    p_data_checkout DATE,
    p_quantidade_diarias INT
) RETURNS VOID AS $$
DECLARE
    v_contagem INT;
BEGIN
    -- Verifica se há conflito de reserva no período
    SELECT COUNT(*) INTO v_contagem
    FROM Reserva_Quarto
    WHERE quarto_id = p_quarto_id
    AND (
        (p_data_checkin BETWEEN data_checkin AND data_checkout) OR
        (p_data_checkout BETWEEN data_checkin AND data_checkout) OR
        (data_checkin BETWEEN p_data_checkin AND p_data_checkout)
    );

    -- Se já existir reserva nesse período, impede a inserção
    IF v_contagem > 0 THEN
        RAISE EXCEPTION 'Erro: Quarto já reservado nesse período!';
    ELSE
        -- Insere a nova reserva
        INSERT INTO Reserva_Quarto (reserva_id, quarto_id, data_checkin, data_checkout, quantidade_diarias)
        VALUES (p_reserva_id, p_quarto_id, p_data_checkin, p_data_checkout, p_quantidade_diarias);
    END IF;
END;
$$ LANGUAGE plpgsql;


SELECT verificar_e_inserir_reserva(1, 101, '2025-02-15', '2025-02-20', 5);
