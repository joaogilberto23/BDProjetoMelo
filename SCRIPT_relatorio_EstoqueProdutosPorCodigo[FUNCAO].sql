CREATE FUNCTION relatorio_EstoqueProdutosPorCodigo(@idproduto INTEGER)
	RETURNS TABLE
AS
	RETURN
		SELECT
			nome AS 'NOME_PRODUTO',
			tamanho AS 'TAMANHO',
			estoque AS 'ESTOQUE',
			P.valor_produto AS 'VALOR_PRODUTO'
		FROM produto AS P
		WHERE P.id_produto = @idproduto;

--Exemplo de chamada: SELECT * FROM relatatorio_EstoqueProdutosPorCodigo(30);
