drop table if exists Preadesione;
drop table if exists Allergico;
drop table if exists Dosi_totali;
drop table if exists Vaccinazione;
drop table if exists Report;
drop table if exists Convocazione;
drop table if exists Reazione_allergica;
drop table if exists Disponibilita_dosi;
drop table if exists Lotto;
drop table if exists Medico;
drop table if exists Vaccino;
drop table if exists Vaccinando;
drop table if exists Centro_Vaccinale;
drop table if exists Effetto_allergico;
drop table if exists Allergia;


create table Vaccinando (
	CF char(16) not null ,
	Nome varchar(20) not null ,
	Cognome varchar(20) not null ,
	Data_nascita date not null ,
	Città varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	Categoria char(4) 
		check (	categoria = 'PSAN' or
			  	categoria = 'PSCO' or
			  	categoria = 'SFRA' or
			  	categoria = 'ALTR') not null ,
	Positività_pregressa boolean not null ,
	IdVacc serial ,
	constraint pk_vaccinando primary key (IdVacc),
	unique (CF)
);

insert into vaccinando values ('CF234CFGGIOG22D','Luca', 'Rizzo', '09/22/2000', 'Torino', 'Via Roma 12', 'SFRA', false);
insert into vaccinando values ('EF234CFEGIOG96D','Nino', 'Franceschini', '04/17/1911', 'Roma', 'Viale Cesana 134', 'PSCO', false);
insert into vaccinando values ('CD234CFGGIOG92D','Lello', 'Albertini', '11/13/1991', 'Milano', 'Via Garibaldi 41', 'ALTR', true);
insert into vaccinando values ('PE234CFGGIOG01D','Pippo', 'Mussolini', '12/12/1942', 'Napoli', 'Via Castelletti 11', 'PSAN', true);
insert into vaccinando values ('QE234FCGGIOG53D','Gianni', 'Potti', '01/06/1910', 'Torino', 'Via Po 3', 'SFRA', false);


select idvacc from vaccinando where upper(nome) = 'PIPPO';

create table Centro_Vaccinale (
	Nome varchar(20) not null ,
	Citta varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	IdCentro serial ,
	constraint pk_centro primary key (IdCentro),
	unique (Nome, Citta)
);

insert into centro_vaccinale values ('Luci', 'Roma', 'Via Carlo Alberto 11');
insert into centro_vaccinale values ('Spallanzani', 'Roma', 'Via Carlo Alberto 11');
insert into centro_vaccinale values ('San Raffaele', 'Milano', 'Via Mazzini 3');
insert into centro_vaccinale values ('Nuvola Lavazza', 'Torino', 'Via Palermo 89');

select * from centro_vaccinale;

create table Vaccino (
	Nome varchar(20) not null ,
	Perc_efficacia decimal(4,2) not null check (perc_efficacia >= 0 and perc_efficacia <= 100),
	Eta_min smallint not null check (eta_min > 0),
	Eta_max smallint not null check (eta_max > 0 and eta_max > eta_min),
	Int_dosi smallint check (int_dosi > 0),
	Tipologia char 
			check (	tipologia = 'S' or
				  	tipologia = 'D') not null ,
	IdVaccino serial ,
	constraint pk_vaccino primary key (IdVaccino) ,
	unique(nome)
);

insert into vaccino values ('COVIDIN', 79.09, 30, 70, 25, 'D');
insert into vaccino values ('CORONAX', 92.12, 21, 50, 18, 'D');
insert into vaccino values ('FLUSTOP', 57, 40, 80, 30, 'S');

select nome,idvaccino from vaccino;

create table Allergia (
	Nome varchar(20) not null ,
	constraint pk_allergia primary key (nome)
);

insert into allergia values ('noci');
insert into allergia values ('ananas');
insert into allergia values ('latte');

create table Effetto_allergico (
	Nome varchar(20) not null ,
	constraint pk_effetto primary key (nome)
);

insert into effetto_allergico values ('diarrea');
insert into effetto_allergico values ('vomito');
insert into effetto_allergico values ('prurito');
insert into effetto_allergico values ('dolore braccio');
insert into effetto_allergico values ('nausea');

create table Medico (
	CF char(16) not null ,
	Centro integer not null ,
	Nome varchar(20) not null ,
	Cognome varchar(20) not null ,
	Data_nascita date not null ,
	Citta varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	Qualifica char(4) 
		check (	qualifica = 'BASE' or
			  	qualifica = 'SPEC') not null ,
	IdMedico serial ,
	constraint pk_medico primary key (IdMedico),
	constraint fk_medicocentro 
			   foreign key (Centro) references Centro_Vaccinale(IdCentro)
				on update cascade on delete set null,
	unique(CF)
);

select nome,citta,idcentro from centro_vaccinale;

insert into medico values ('GTRKSS90H23F106T', 1, 'Gino', 'Strada', '01/10/1973', 'Milano', 'Via del Campo', 'BASE');
insert into medico values ('CDPVWD67L21B248K ', 1, 'Paolo', 'Villa', '03/11/1954', 'Napoli', 'Via Garibaldi', 'SPEC');
insert into medico values ('SVNLNS97L53F593Y', 2, 'Nicola', 'Strada', '06/30/1931', 'Cunedo', 'Via dei Santi', 'BASE');
insert into medico values ('VNWJFN33R13I563K', 3, 'Lino', 'Antonelli', '03/11/1966', 'Trapani', 'Via Girolamo', 'SPEC');
insert into medico values ('YKSSMG84T67B662T', 4, 'Franco', 'Paoli', '12/12/1938', 'Milano', 'Via De Andrè', 'BASE');

select cf,idmedico from medico;

--da rivedere soprattutto la pk perché non mi sembra sensata (fixed)
create table Preadesione (
	CF char(16) not null ,
	Modalita char(3) check (lower(modalita) = 'app' or lower(modalita) = 'web') not null ,
	Data_pre date not null ,
	Ora time not null ,
	Telefono varchar(15) ,
	E_mail varchar(30) check (e_mail like '%@%.%') ,
	IDPread	 serial ,
	constraint pk_preadesione primary key (IDPread),
	constraint fk_preadesionevaccinando 
				foreign key (CF) references vaccinando(CF)
					on update cascade on delete cascade,
	unique(CF)
);

select * from vaccinando where cf = 'QE234FCGGIOG53D';

insert into preadesione values ('QE234FCGGIOG53D', 'app', '07/03/2021', '18:30', '3999320110');
insert into preadesione values ('EF234CFEGIOG96D', 'WEB', '08/03/2021', '17:30', null, 'csai@ssasj.com');

select cf,idpread from preadesione;

create table Allergico (
	Vaccinando integer not null ,
	Allergia varchar(20) not null ,
	constraint pk_allergico primary key (Vaccinando, Allergia),
	constraint fk_allergicovaccinando
				foreign key (vaccinando) references vaccinando(IDVacc)
					on update cascade on delete cascade ,
	constraint fk_allergicoallergia
				foreign key (Allergia) references Allergia(nome)
					on update cascade on delete cascade
);

select idvacc from vaccinando;

insert into allergico values (1, 'noci');
insert into allergico values (1, 'latte');
insert into allergico values (4, 'ananas');
insert into allergico values (5, 'noci');
insert into allergico values (3, 'ananas');

create table Convocazione (
	Vaccinando integer not null , 
	Centro integer not null ,
	Vaccino integer not null ,
	Data_conv date not null ,
	Ora time not null ,
	IDConv serial ,
	constraint pk_convocazione primary key (IDConv) ,
	constraint fk_convocazionevaccinando
				foreign key (vaccinando) references vaccinando(IDVacc)
					on update cascade on delete cascade ,
	constraint fk_convocazionecentro 
			   foreign key (centro) references Centro_Vaccinale(IdCentro)
				on update cascade on delete cascade ,
	constraint fk_convocazionevaccino 
			   foreign key (Vaccino) references Vaccino(IdVaccino)
				on update cascade on delete cascade ,
	unique (vaccinando,data_conv) 
);

select idcentro from centro_vaccinale;

insert into convocazione values (3, 2, 1, '04/16/2021', '18:30');
insert into convocazione values (4, 2, 1, '04/12/2021', '07:30');
insert into convocazione values (1, 1, 2, '07/01/2021', '19:30');
insert into convocazione values (2, 4, 3, '08/29/2021', '12:30');
insert into convocazione values (4, 2, 1, '05/01/2021', '08:30');

select * from convocazione;

create table Lotto (
	Numero char(8) not null ,
	Vaccino integer not null ,
	Data_prod date not null ,
	Data_scad date not null check (data_scad > data_prod),
	Numero_dosi int not null check (numero_dosi > 0) ,
	constraint pk_lotto primary key (Numero) ,
	constraint fk_lottovaccino 
			   foreign key (Vaccino) references Vaccino(IdVaccino)
				on update cascade on delete cascade
);

insert into Lotto values('87312413', 2, '01/01/2021', '01/01/2024', 120000);
insert into Lotto values('42357651', 1, '05/01/2021', '01/01/2024', 150000);
insert into Lotto values('98726347', 1, '06/01/2021', '01/01/2024', 100000);
insert into Lotto values('09131893', 3, '01/10/2021', '01/01/2024', 140000);
insert into Lotto values('11251095', 2, '03/20/2021', '01/01/2024', 120000);


select * from lotto;

create table Reazione_allergica (
	Numero_lotto char(8) not null ,
	Effetto varchar(20) not null ,
	constraint pk_reazione primary key (Numero_lotto,Effetto),
	constraint fk_reazionelotto
				foreign key (numero_lotto) references Lotto(Numero)
					on update cascade on delete cascade ,
	constraint fk_reazioneallergia
				foreign key (Effetto) references Effetto_allergico(nome)
					on update cascade on delete cascade
);

insert into reazione_allergica values('98726347', 'diarrea');
insert into reazione_allergica values('98726347', 'nausea');
insert into reazione_allergica values('98726347', 'vomito');
insert into reazione_allergica values('09131893', 'dolore braccio');

select * from reazione_allergica;

create table Vaccinazione (
	Convocazione integer not null ,
	Medico integer not null ,
	Lotto char(8) not null ,
	Reazione_riscontrata varchar(20) ,
	IDVacc serial ,
	constraint pk_vaccinazione primary key (IdVacc) ,
	constraint fk_vaccinazioneconvocazione 
				foreign key (Convocazione) references Convocazione(IdConv)
					on update cascade on delete cascade ,
	constraint fk_vaccinazionemedico
				foreign key (medico) references Medico(IDMedico)
					on update cascade on delete cascade ,
	constraint fk_vaccinazionelotto
				foreign key (lotto) references Lotto(Numero)
					on update cascade on delete cascade,
	unique(convocazione)
);

select idconv from convocazione;
select idmedico from medico;
select numero from lotto;

insert into vaccinazione values(3, 4, '98726347', 'febbre');
insert into vaccinazione values(2, 5, '98726347');
insert into vaccinazione values(1, 3, '09131893');
insert into vaccinazione values(1, 4, '98726347', 'nausea');
insert into vaccinazione values(4, 2, '09131893');

select * from vaccinazione;

create table Disponibilita_dosi (
	Centro integer not null ,
	Lotto char(8) not null ,
	constraint pk_dispdosi primary key (Centro,Lotto) ,
	constraint fk_dispdosicentro 
			   foreign key (centro) references Centro_Vaccinale(IdCentro)
				on update cascade on delete cascade ,
	constraint fk_dispdosivaccino 
			   foreign key (Lotto) references Lotto(numero)
				on update cascade on delete cascade
);

select numero from lotto;

insert into disponibilita_dosi values(3, '87312413');
insert into disponibilita_dosi values(2, '42357651');
insert into disponibilita_dosi values(1, '09131893');
insert into disponibilita_dosi values(2, '09131893');

select * from disponibilita_dosi;

create table Dosi_totali (
	Centro integer not null ,
	Vaccino integer not null ,
	Quantita integer check (quantita > 0) not null ,
	constraint pk_dositot primary key (Centro,Vaccino,Quantita) ,
	constraint fk_dositotcentro 
			   foreign key (centro) references Centro_Vaccinale(IdCentro)
				on update cascade on delete cascade ,
	constraint fk_dositotvaccino 
			   foreign key (Vaccino) references Vaccino(IDVaccino)
				on update cascade on delete cascade
);

create table Report (
	Medico integer not null ,
	Numero_lotto char(8) not null ,
	Reazione_riscontrata varchar(20) not null ,
	Data_rep date not null ,
	constraint pk_report primary key (Medico,Numero_lotto,Reazione_riscontrata),
	constraint fk_reportmedico
				foreign key (medico) references Medico(IdMedico)
					on update cascade on delete cascade ,
	constraint fk_reportlotto
				foreign key (numero_lotto) references Lotto(Numero)
					on update cascade on delete cascade 
);

select * from convocazione;

insert into report values (4, '98726347', 'febbre', '2021-07-01');
insert into report values (4, '98726347', 'nausea', '2021-04-16');
