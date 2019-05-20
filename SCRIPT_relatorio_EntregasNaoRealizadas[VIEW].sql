CREATE VIEW relatorio_EntregasNaoRealizadas
AS
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
		F.descricao_fp AS 'DESC_FORMA_PAGAMENTO'
	FROM pedido AS P 
	INNER JOIN usuario AS U ON P.id_usuario = U.id_usuario
	INNER JOIN formaPagamento AS F ON F.id_formaPagamento = P.id_formaPagamento
	WHERE P.data_entrega IS NULL 
	OR P.data_entrega > GETDATE();


