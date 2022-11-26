/*Descrição do Desafio
Para este cenário você irá utilizar seu esquema conceitual, 
criado no desafio do módulo de modelagem de BD com modelo ER, 
para criar o esquema lógico para o contexto de uma oficina. Neste desafio, 
você definirá todas as etapas. Desde o esquema até a implementação do banco de dados. 
Sendo assim, neste projeto você será o protagonista. Tenha os mesmos cuidados, apontados no desafio anterior, 
ao modelar o esquema utilizando o modelo relacional.

Após a criação do esquema lógico, realize a criação do Script SQL para criação do esquema do banco de dados. 
Posteriormente, realize a persistência de dados para realização de testes. 
Especifique ainda queries mais complexas do que apresentadas durante a explicação do desafio. 
Sendo assim, crie queries SQL com as cláusulas abaixo:

Recuperações simples com SELECT Statement;
Filtros com WHERE Statement;
Crie expressões para gerar atributos derivados;
Defina ordenações dos dados com ORDER BY;
Condições de filtros aos grupos – HAVING Statement;
Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;

Diretrizes

Não há um mínimo de queries a serem realizadas;
Os tópicos supracitados devem estar presentes nas queries;
Elabore perguntas que podem ser respondidas pelas consultas
As cláusulas podem estar presentes em mais de uma query
O projeto deverá ser adicionado a um repositório do Github para futura avaliação do desafio de projeto. 
Adicione ao Readme a descrição do projeto lógico para fornecer o contexto sobre seu esquema lógico apresentado.
*/

SELECT * FROM `oficina`.`veiculos designado a equipes` INNER JOIN oficina.veiculos ON Veiculos_idVeiculos = idVeiculos
														INNER JOIN oficina.equipes ON Equipes_idEquipes = idEquipe;
SELECT * FROM `oficina`.`veiculos designado a equipes` INNER JOIN oficina.veiculos ON Veiculos_idVeiculos = idVeiculos
														INNER JOIN oficina.equipes ON Equipes_idEquipes = idEquipe
WHERE idVeiculos = 2;
SELECT * FROM `oficina`.`veiculos designado a equipes` INNER JOIN oficina.veiculos ON Veiculos_idVeiculos = idVeiculos
														INNER JOIN oficina.equipes ON Equipes_idEquipes = idEquipe
WHERE idEquipe = 3;

UPDATE oficina.veiculos
SET Ano = 2010
WHERE idVeiculos = 2;

SELECT * FROM `oficina`.`veiculos designado a equipes` INNER JOIN oficina.veiculos ON Veiculos_idVeiculos = idVeiculos
														INNER JOIN oficina.equipes ON Equipes_idEquipes = idEquipe
WHERE Ano in (2010);

SELECT * FROM oficina.`ordem de servico` INNER JOIN  (SELECT * FROM oficina.`veiculos designado a equipes` 
																INNER JOIN oficina.veiculos ON Veiculos_idVeiculos = idVeiculos
																INNER JOIN oficina.equipes ON Equipes_idEquipes = idEquipe) VeiculoOS 
																ON VeiculoOS.idEquipe = Equipe_idEquipes
                                         INNER JOIN oficina.`pecas da ordem de servico` pOS ON pOS.`Ordem de Servico_idOrdem de Servico` = `idOrdem de Servico`
                                         INNER JOIN oficina.pecas ON idPecas = pOS.Pecas_idPecas
ORDER BY `idOrdem de Servico`;

SELECT * FROM oficina.`ordem de servico` INNER JOIN  (SELECT * FROM oficina.`veiculos designado a equipes` 
																INNER JOIN oficina.veiculos ON Veiculos_idVeiculos = idVeiculos
																INNER JOIN oficina.equipes ON Equipes_idEquipes = idEquipe) VeiculoOS 
																ON VeiculoOS.idEquipe = Equipe_idEquipes
                                         INNER JOIN oficina.`servicos da ordem de serviço` sOS ON sOS.`Ordem de Servico_idOrdem de Servico` = `idOrdem de Servico`
                                         INNER JOIN oficina.servicos ON idServicos = sOS.Servicos_idServicos
ORDER BY `idOrdem de Servico`;

SELECT COUNT(`idOrdem de servico`) QtdDia, `Data de Emissao` FROM oficina.`ordem de servico` GROUP BY `Data de Emissao`;
SELECT COUNT(`idOrdem de servico`) QtdDia, `Data Conclusao` FROM oficina.`ordem de servico` GROUP BY `Data Conclusao` HAVING `Data Conclusao` IS NOT NULL;
