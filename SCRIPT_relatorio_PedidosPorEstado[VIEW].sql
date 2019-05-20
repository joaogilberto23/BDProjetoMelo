CREATE VIEW relatorio_PedidosPorEstado
	AS
		SELECT TOP 1000
			E.estado AS 'ESTADO',
			COUNT(E.estado) AS 'QTD_PEDIDOS',
			SUM(P.valor_pedido) AS 'VALOR_TOTAL'
		FROM pedido AS P
		INNER JOIN endereco AS e ON P.id_usuario = E.id_usuario
		GROUP BY E.estado
		ORDER BY QTD_PEDIDOS DESC