CREATE VIEW relatorio_EstoqueGeral
	AS
		SELECT TOP 1000
			id_produto AS 'COD_PRODUTO',
			nome AS 'NOME',
			tamanho AS 'TAMANHO',
			estoque AS 'ESTOQUE',
			valor_produto AS 'VALOR_PRODUTO'
		FROM produto
		ORDER BY estoque DESC;