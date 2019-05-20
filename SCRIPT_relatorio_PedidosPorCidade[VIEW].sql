CREATE VIEW relatorio_PedidosPorCidade
	AS
		SELECT TOP 1000 
			E.cidade AS 'CIDADE',
			E.estado AS 'ESTADO', COUNT(E.cidade) AS 'QTD_PEDIDOS',
			SUM(P.valor_pedido) AS 'VALOR_TOTAL'
		FROM pedido AS P
		INNER JOIN endereco AS e ON P.id_usuario = E.id_usuario
		GROUP BY E.cidade, E.estado
		ORDER BY QTD_PEDIDOS DESC