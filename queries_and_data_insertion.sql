# Scripts de inserção

USE oficina;

# clientes
INSERT INTO `oficina`.`clientes`
(`Nome`,
`Endereço`,
`Identificacao`,
`Pessoa Fisica`)
VALUES
('MACROSANN Tecnologia','Rua Aratinga, 56','13044731000180',false);
SELECT * FROM oficina.clientes;

# veiculos
SHOW COLUMNS FROM oficina.veiculos;
ALTER TABLE oficina.veiculos MODIFY placa VARCHAR(7);
INSERT INTO `oficina`.`veiculos`
(`Placa`,
`Modelo`,
`Ano`,
`Clientes_idClientes`)
VALUES
("KLG6033", "PALIO WEEKEND ADVENTURE 1.8", "2003", 1),
("BRA2E19", "PALIO WEEKEND 1.6", "2003", 1);
SELECT * FROM oficina.veiculos;

# equipes
INSERT INTO `oficina`.`equipes`
(`Descricao`)
VALUES
("MOTORES A COMBUSTÃO"),
("INJEÇÃO ELETRÔNICA"),
("ELETRICA EM GERAL");
SELECT * FROM oficina.equipes;

# mecanico
INSERT INTO `oficina`.`mecanico`
(`Nome`,
`Endereco`,
`Especialidade`,
`Equipes_idEquipes`)
VALUES
("ZÉ BEDEU", "RUA ONDE O VENTO FAZ A CURVA", "ELETRICA", 3),
("FURUSTRECO", "RUA O VENTO FAZ A CURVA ANTES", "MOTORES", 1),
("FURUSTRECO", "RUA O VENTO FAZ A CURVA ANTES", "MOTORES", 2),
("PRAQUEISSO", "RUA O VENTO NEN TENTA", "INJEÇÕES", 2);
SELECT * FROM oficina.mecanico;

# veiculos designado a equipes
ALTER TABLE `oficina`.`veiculos designado a equipes` 
DROP FOREIGN KEY `fk_Veículos_has_Equipes_Veículos1`;

ALTER TABLE `oficina`.`veiculos designado a equipes` 
CHANGE COLUMN `Veiculos_idVeículos` `Veiculos_idVeiculos` INT NOT NULL ;

ALTER TABLE `oficina`.`veiculos designado a equipes` 
ADD CONSTRAINT `fk_Veículos_has_Equipes_Veículos1`
  FOREIGN KEY (`Veiculos_idVeiculos`)
  REFERENCES `oficina`.`veiculos` (`idVeiculos`);
 
INSERT INTO `oficina`.`veiculos designado a equipes`
(`Veiculos_idVeiculos`,
`Equipes_idEquipes`)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 3);

# Serviços
INSERT INTO `oficina`.`servicos`
(`Descricao`,
`Valor`)
VALUES
('RETIFICA DOS PISTONS DE MOTOR',2199.00),
('TROCA DA INJEÇÃO ELETRÔNICA',999.00),
('DIAGNÓSTICO ELETRICO COMPLETO',599.00);

# pecas
INSERT INTO `oficina`.`pecas`
(`Descricao`,
`Valor`)
VALUES
("AMORTECEDORE FIRESTON", 1500.00),
("BICO DE MOTOR", 900.00),
("FUSIVEL", 100.00),
('JOGO DE CABO DE VELAS DO MOTOR', 300.00),
('JOGO DE VELAS DO MOTOR', 500);


# ordem de servico
ALTER TABLE oficina.`ordem de servico` MODIFY `Data de Emissao` DATETIME;
ALTER TABLE oficina.`ordem de servico` CHANGE Conclusao `Data Conclusao` DATETIME;

INSERT INTO `oficina`.`ordem de servico`
(`Data de Emissao`,
`Tipo de OS`,
`Valor Total`,
`Equipe_idEquipes`,
`Prazo de entrega`,
`Data Conclusao`,
`Status`,
`Autorizado`)
VALUES
("2022-11-26 00:00:00", '1', 0.00, 2, 20, null, "Em andamento", true),
("2022-11-26 00:00:00", '1', 0.00, 1, 15, null, "Em andamento", true),
("2022-11-26 00:00:00", '2', 0.00, 3, 20, null, "Pendente", null),
("2022-11-20 00:00:00", '2', 0.00, 1, 20, "2022-11-26 00:00:00", "Concluído", true),
("2022-11-26 00:00:00", '3', 0.00, 2, 30, null, "Em andamento", false);

# pecas da ordem de servico
INSERT INTO `oficina`.`pecas da ordem de servico`
(`Pecas_idPecas`,
`Ordem de Servico_idOrdem de Servico`)
VALUES
#(2, 1),
(4, 2), (5, 2),
(3, 3), (1, 3);

# Servicos da ordem de serviço
INSERT INTO `oficina`.`servicos da ordem de serviço`
(`Servicos_idServicos`,
`Ordem de Servico_idOrdem de Servico`)
VALUES
(2, 1),
(1, 2),
(3, 3),
(1, 4),
(2, 5);
