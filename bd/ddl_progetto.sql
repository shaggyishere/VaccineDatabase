/*
	prima vanno fatte le create table di:
	-vaccinando 
	-centro vaccinale
	-vaccino
	-allergia
	-effetto allergico
	e poi il resto in ordine casuale.
*/

/*
	Questo schema funziona popolando prima la tabella allergia o comunque avendo
	una tabella allergia già popolata, altrimenti si rischia di non poter aggiungere reazioni allergiche
	ai lotti o allergie ai vaccinandi.
	Si procede poi col popolare le 4 tabelle principali di cui sopra, e per il resto si può popolare senza problemi.
*/

drop sequence if exists SequenzaMedico cascade;
drop sequence if exists SequenzaCentro cascade;
drop sequence if exists SequenzaVaccinando cascade;
drop table if exists Preadesione;
drop table if exists Allergico;
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

/* DEFINIZIONE TABLE DDL*/

create sequence SequenzaVaccinando
increment by 1 start 1;
create domain Vacc_id as integer default nextval('SequenzaVaccinando');
create table Vaccinando (
	CF char(16) not null ,
	Nome varchar(20) not null ,
	Cognome varchar(20) not null ,
	Eta smallint not null check (eta > 0),
	Città varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	Categoria varchar(21) 
		check (	categoria = 'PERSONALE SANITARIO' or
			  	categoria = 'PERSONALE SCOLASTICO' or
			  	categoria = 'SOGGETTO FRAGILE' or
			  	categoria = 'ALTRO') not null ,
	Positività_pregressa boolean not null ,
	IdVacc Vacc_id,
	constraint pk_vaccinando primary key (IdVacc),
	unique (CF)
);

create sequence SequenzaCentro
increment by 1 start 1;
create domain Centro_id as integer default nextval('SequenzaCentro');
create table Centro_Vaccinale (
	Nome varchar(20) not null ,
	Citta varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	CentroId Centro_id,
	constraint pk_centro primary key (CentroId),
	unique (Nome, Citta)
);

create table Vaccino (
	Nome varchar(20) not null ,
	Perc_efficacia decimal(4,2) not null check (perc_efficacia >= 0 and perc_efficacia <= 100),
	Eta_min smallint not null check (eta_min > 0),
	Eta_max smallint not null check (eta_max > 0 and eta_max > eta_min),
	Int_dosi smallint check (int_dosi > 0),
	Tipologia varchar(13) 
			check (	tipologia = 'SINGOLA DOSE' or
				  	tipologia = 'DOPPIA DOSE') not null ,
	constraint pk_vaccino primary key (Nome)
);

create table Allergia (
	Nome varchar(15) not null ,
	constraint pk_allergia primary key (nome)
);

create table Effetto_allergico (
	Nome varchar(15) not null ,
	constraint pk_effetto primary key (nome)
);

create sequence SequenzaMedico
increment by 1 start 1;
create domain Medico_id as integer default nextval('SequenzaMedico');
create table Medico (
	CF char(16) not null ,
	Nome_Centro varchar(20) not null , 
	Citta_centro varchar(20) not null , 
	Nome varchar(20) not null ,
	Cognome varchar(20) not null ,
	Eta smallint not null check (eta > 0),
	Citta varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	Qualifica varchar(14) 
		check (	qualifica = 'BASE' or
			  	qualifica = 'SPECIALIZZATO') not null ,
	MedicoId Medico_id,
	constraint pk_medico primary key (MedicoId),
	constraint fk_medicocentro 
			   foreign key (Nome_Centro,Citta_centro) references Centro_Vaccinale(Nome,Citta)
				on update cascade on delete set null,
	unique(CF)
);

create table Preadesione (
	CF char(16) not null ,
	Modalita char(3) check (modalita = 'app' or modalita = 'web') not null ,
	Data_pre date not null ,
	Ora time not null ,
	Telefono varchar(15) ,
	E_mail varchar(30) check (e_mail like '%@%.%') ,
	constraint pk_preadesione primary key (CF),
	constraint fk_preadesionevaccinando 
				foreign key (CF) references vaccinando(CF)
					on update cascade on delete cascade
);

create table Allergico (
	Vaccinando char(16) not null ,
	Allergia varchar(15) not null ,
	constraint pk_allergico primary key (Vaccinando, Allergia),
	constraint fk_allergicovaccinando
				foreign key (vaccinando) references vaccinando(CF)
					on update cascade on delete cascade ,
	constraint fk_allergicoallergia
				foreign key (Allergia) references Allergia(nome)
					on update cascade on delete cascade
);

create table Vaccinazione (
	Vaccinando char(16) not null ,
	Nome_Centro varchar(20) not null , 
	Citta_centro varchar(20) not null ,
	Data_vacc date not null ,
	Ora time not null ,
	constraint pk_vaccinazione primary key (Vaccinando,Data_vacc) ,
	--unique (nome_centro, citta_centro, ora) ,
	constraint fk_vaccinazionevaccinando
				foreign key (vaccinando) references vaccinando(CF)
					on update cascade on delete cascade ,
	constraint fk_vaccinazionecentro 
			   foreign key (nome_Centro,citta_centro) references Centro_Vaccinale(nome,citta)
				on update cascade on delete cascade
);

create table Convocazione (
	Vaccinando char(16) not null ,
	Nome_Centro varchar(20) not null , 
	Citta_centro varchar(20) not null ,
	Data_conv date not null ,
	Ora time not null ,
	Vaccino varchar(20) not null ,
	constraint pk_convocazione primary key (Vaccinando,Data_conv) ,
	--unique (nome_centro, citta_centro, ora) ,
	constraint fk_convocazionevaccinando
				foreign key (vaccinando) references vaccinando(CF)
					on update cascade on delete cascade ,
	constraint fk_convocazionecentro 
			   foreign key (nome_Centro,citta_centro) references Centro_Vaccinale(nome,citta)
				on update cascade on delete cascade ,
	constraint fk_convocazionevaccino 
			   foreign key (Vaccino) references Vaccino(nome)
				on update cascade on delete cascade
);

create table Disponibilita_dosi (
	Nome_Centro varchar(20) not null , 
	Citta_centro varchar(20) not null ,
	Vaccino varchar(20) not null ,
	Numero_dosi int not null check (numero_dosi >= 0) ,
	constraint pk_dosi primary key (Nome_Centro,Citta_centro,Vaccino) ,
	constraint fk_dosicentro 
			   foreign key (nome_Centro,citta_centro) references Centro_Vaccinale(nome,citta)
				on update cascade on delete cascade ,
	constraint fk_dosivaccino 
			   foreign key (Vaccino) references Vaccino(nome)
				on update cascade on delete cascade
);

create table Lotto (
	Numero char(8) not null ,
	Vaccino varchar(20) not null ,
	Data_prod date not null ,
	Data_scad date not null check (data_scad > data_prod),
	constraint pk_lotto primary key (Numero) ,
	constraint fk_lottovaccino 
			   foreign key (Vaccino) references Vaccino(nome)
				on update cascade on delete cascade
);

create table Reazione_allergica (
	Numero_lotto char(8) not null ,
	Effetto varchar(15) not null ,
	constraint pk_reazione primary key (Numero_lotto,Effetto),
	constraint fk_reazionelotto
				foreign key (numero_lotto) references Lotto(Numero)
					on update cascade on delete cascade ,
	constraint fk_reazioneallergia
				foreign key (Effetto) references Effetto_allergico(nome)
					on update cascade on delete cascade
);

create table Report (
	Medico char(16) not null ,
	Numero_lotto char(8) not null ,
	Effetto_allergico varchar(15) not null ,
	Data_rep date not null ,
	constraint pk_report primary key (Medico,Numero_lotto,Effetto_allergico),
	constraint fk_reportmedico
				foreign key (medico) references Medico(CF)
					on update cascade on delete cascade ,
	constraint fk_reportlotto
				foreign key (numero_lotto) references Lotto(Numero)
					on update cascade on delete cascade 
);
