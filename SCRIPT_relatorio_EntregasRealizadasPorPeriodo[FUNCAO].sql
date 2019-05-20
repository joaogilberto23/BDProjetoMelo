CREATE FUNCTION relatorio_EntregasRealizadasPorPeriodo (@DATA1 DATE, @DATA2 DATE)
	RETURNS TABLE
AS
	RETURN 
		(
			SELECT
			P.id_pedido AS 'NUM_PEDIDO',
			U.nome AS 'NOME_CLIENTE',
			P.id_usuario AS 'COD_CLIENTE',
			U.cpf AS 'CPF',
			U.email AS 'E-MAIL',
			U.tel_celular AS 'CONTATO',
			P.data_pedido AS 'DATA_PEDIDO',
			P.data_entrega AS 'DATA_ENTREGA', 
			P.valor_pedido AS 'VALOR_PEDIDO',
			F.tipo_fp AS 'FORMA_PAGAMENTO',
			F.descricao_fp AS 'TIPO_FORMA_PAGAMENTO'
			FROM pedido AS P
				INNER JOIN usuario AS U ON p.id_usuario = u.id_usuario
				INNER JOIN formaPagamento AS F ON F.id_formaPagamento = P.id_formaPagamento
			WHERE P.data_entrega IS NOT NULL 
				AND P.data_pedido BETWEEN @DATA1 AND @DATA2
				AND P.data_entrega < GETDATE()
		);

-- Exemplo de chamada: SELECT * FROM relatorio_EntregasRealizadas ('01-05-2019', '30-05-2019');





