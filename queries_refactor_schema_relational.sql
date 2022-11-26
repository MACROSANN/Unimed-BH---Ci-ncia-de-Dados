use ECOMMERCE;
show tables;

select * from CLIENTS;
show columns from CLIENTS;

# Refinamentos 
-- Cliente PJ e PF - Uma conta pode ser PJ ou PF, mas não pode ter as duas informações; 

alter table CLIENTS add PhysicalPerson tinyint not null;
alter table CLIENTS change CPF Identification char(14) not null;
update CLIENTS set PhysicalPerson = 1;
insert into CLIENTS (Fname, Minit, Lname, Identification, Address, PhysicalPerson) values ('Macrosann', '', 'Tecnologia', '13044731000180', 'Rua Aratinga, 56 - Água Fria - Recife/PE', 0);

-- recuperação de pedido com produto associado
select PhysicalPerson, Fname, Identification, idOrder, orderStatus, orderDescription, sendValue, paymentCash, idPOproduct, Pname, poQuantity, poStatus
	from CLIENTS c 
		inner join orders o ON c.idClient = o.idOrderClient
        inner join productOrder i on i.idPOorder = o.idOrder
        inner join product p on p.idProduct = idPOproduct
	group by idClient; 
    
-- Pagamento - Pode ter cadastrado mais de uma forma de pagamento.alter;
select * from ORDERS;
select * from PAYMENTS;
show columns from PAYMENTS;
alter table PAYMENTS drop column idClient;
alter table PAYMENTS modify typePayment enum('Boleto','Cartão','PIX');

insert into PAYMENTS (idPayment, typePayment, limitAvailable)
		values (1, 'Boleto Bradesco', 1000),
				(2, 'Rede', 2000),
				(2, 'MasterCard', 2000),
                (3, 'PIX', 1500);

create table if not exists `ecommerce`.`PaymentsOrder` (
  `Payments_idPayment` int not null,
  `Order_idOrder` int not null,
  primary key (`Payments_idPayment`, `Order_idOrder`),
  index `fk_PaymentsOrder_has_Order_Order1_idx` (`Order_idOrder` asc) visible,
  index `fk_PaymentsOrder_has_Order_PaymentsOrder1_idx` (`Payments_idPayment` asc) invisible  )
engine = MyISAM;

insert into PaymentOrder (Payments_idPayment, Order_idOrder)
		values ();

create table if not exists `ecommerce`.`CreditCard` (
  `idCreditCard` int not null auto_increment,
  `Number` int not null,
  `Titular` varchar(45) not null,
  `Validity` date not null,
  `CVC` varchar(45) not null,
  `Payments_idPayment` int not null,
  primary key (`idCreditCard`, `Payments_idPayment`),
  index `fk_CreditCard_Payments1_idx` (`Payments_idPayment` asc) invisible,
  constraint `fk_CreditCard_Payments1`
    foreign key (`Payments_idPayment`)
    references `ecommerce`.`Payments` (`idPayment`)
    on delete no action
    on update no action )
engine = InnoDB;


-- Entrega - Possui status e código de rastreio;


