CREATE FUNCTION relatorio_FinanceiroPorMes (@MES INT, @ANO INT)
	RETURNS TABLE
AS
	RETURN 
		(
			SELECT			
			CASE @MES
				WHEN 01 THEN 'Janeiro'
				WHEN 02 THEN 'Fevereiro'
				WHEN 03 THEN 'Março'
				WHEN 04 THEN 'Abril'
				WHEN 05 THEN 'Maio'
				WHEN 06 THEN 'Junho'
				WHEN 07 THEN 'Julho'
				WHEN 08 THEN 'Agosto'
				WHEN 09 THEN 'Setembro'
				WHEN 10 THEN 'Outubro'
				WHEN 11 THEN 'Novembro'
				WHEN 12 THEN 'Dezembro'
			END AS 'MES_PEDIDOS',
			@ANO AS 'ANO_PEDIDOS',
			COUNT(P.id_pedido) AS 'QTD_PEDIDOS',
			SUM(P.valor_pedido) AS 'VALOR_TOTAL' 
			FROM pedido AS P
			INNER JOIN formaPagamento AS FP ON P.id_formaPagamento = FP.id_formaPagamento
			WHERE DATEPART(MONTH, P.data_entrega) = @MES
			AND DATEPART(YEAR, P.data_entrega) = @ANO
		);

-- Exemplo de Chamada: SELECT * FROM relatorio_FinanceiroPorMes (05,2019);