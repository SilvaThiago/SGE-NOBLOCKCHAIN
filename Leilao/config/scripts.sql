CREATE TABLE `leilao`.`tb_casa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NULL,
  `imagem` VARCHAR(100) NULL,
  `qtd_placas` INT NULL,
  `numero` INT NULL,
  `saldo_energetico` INT NULL,
  PRIMARY KEY (`id`));


 CREATE TABLE `leilao`.`tb_usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NULL,
  `senha` VARCHAR(200) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))


  CREATE TABLE `leilao`.`tb_acutions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `house_id` INT NULL,
  `user_id` INT NULL,
  `house_number` INT NULL,
  `picture` VARCHAR(100) NULL,
  `energy` INT NULL,
  `greatest_bid` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `house_id_fk_idx` (`house_id` ASC) VISIBLE,
  INDEX `fk_usuario_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_casa`
    FOREIGN KEY (`house_id`)
    REFERENCES `leilao`.`tb_casa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario`
    FOREIGN KEY (`user_id`)
    REFERENCES `leilao`.`tb_usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION); 

INSERT INTO `leilao`.`tb_casa` (`nome`, `imagem`, `qtd_placas`, `numero`, `saldo_energetico`) VALUES ('Jhon', 'images/01.jpeg', '3', '10', '100');
INSERT INTO `leilao`.`tb_casa` (`nome`, `imagem`, `qtd_placas`, `numero`, `saldo_energetico`) VALUES ('Paul', 'images/02.jpeg', '3', '11', '200');
INSERT INTO `leilao`.`tb_casa` (`nome`, `imagem`, `qtd_placas`, `numero`, `saldo_energetico`) VALUES ('Mark', 'images/03.jpeg', '2', '12', '200');
INSERT INTO `leilao`.`tb_casa` (`nome`, `imagem`, `qtd_placas`, `numero`, `saldo_energetico`) VALUES ('Clark', 'images/04.jpeg', '2', '13', '200');
INSERT INTO `leilao`.`tb_casa` (`nome`, `imagem`, `qtd_placas`, `numero`, `saldo_energetico`) VALUES ('Matthew', 'images/05.jpeg', '2', '14', '200');
INSERT INTO `leilao`.`tb_casa` (`nome`, `imagem`, `qtd_placas`, `numero`, `saldo_energetico`) VALUES ('George', 'images/06.jpeg', '3', '15', '100');
INSERT INTO `leilao`.`tb_casa` (`nome`, `imagem`, `qtd_placas`, `numero`, `saldo_energetico`) VALUES ('Rilan', 'images/07.jpeg', '3', '16', '200');
INSERT INTO `leilao`.`tb_casa` (`nome`, `imagem`, `qtd_placas`, `numero`, `saldo_energetico`) VALUES ('Scott', 'images/08.jpeg', '3', '17', '30');


INSERT INTO `leilao`.`tb_usuario` (`nome`, `senha`) VALUES ('teste', '$2b$10$HB.CBRLFw9YSmzJmPaCegeHz51s6rr7VNVIgowkSDLL89nCB0mum2');

