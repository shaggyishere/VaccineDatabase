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

create table Vaccinando (
	IdVacc char(8) not null ,
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
	Positività_pregressa boolean default 'false' ,
	constraint pk_vaccinando primary key (IdVacc),
	unique (CF)
);


create table Centro_Vaccinale (
	IdCentro char(8) not null ,
	Nome varchar(20) not null ,
	Citta varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	constraint pk_centro primary key (IdCentro),
	unique (Nome, Citta)
);

create table Vaccino (
	Nome varchar(20) not null ,
	Perc_efficacia decimal(4,2) not null check (perc_efficacia >= 0 and perc_efficacia <= 100),
	Eta_min smallint not null check (eta_min > 0),
	Eta_max smallint not null check (eta_max > 0 and eta_max > eta_min),
	Int_dosi smallint check (int_dosi > 0),
	Tipologia char 
			check (	tipologia = 'S' or
				  	tipologia = 'D') not null ,
	constraint pk_vaccino primary key (Nome)
);

create table Allergia (
	Nome varchar(20) not null ,
	constraint pk_allergia primary key (nome)
);

create table Effetto_allergico (
	Nome varchar(20) not null ,
	constraint pk_effetto primary key (nome)
);

create table Medico (
	IdMedico char(8) not null ,
	CF char(16) not null ,
	Centro char(8) not null ,
	Nome varchar(20) not null ,
	Cognome varchar(20) not null ,
	Data_nascita date not null ,
	Citta varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	Qualifica char 
		check (	qualifica = 'B' or
			  	qualifica = 'S') not null ,
	constraint pk_medico primary key (IdMedico),
	constraint fk_medicocentro 
			   foreign key (Centro) references Centro_Vaccinale(IdCentro)
				on update cascade on delete set null,
	unique(CF)
);

create table Preadesione (
	IDPread char(8) not null ,
	Modalita char(3) check (modalita = 'app' or modalita = 'web') not null ,
	Data_pre date not null ,
	Ora time not null ,
	Telefono varchar(15) ,
	E_mail varchar(30) check (e_mail like '%@%.%') ,
	constraint pk_preadesione primary key (IDPread),
	constraint fk_preadesionevaccinando 
				foreign key (ID) references vaccinando(IDVacc)
					on update cascade on delete cascade
);

create table Allergico (
	Vaccinando char(8) not null ,
	Allergia varchar(20) not null ,
	constraint pk_allergico primary key (Vaccinando, Allergia),
	constraint fk_allergicovaccinando
				foreign key (vaccinando) references vaccinando(IDVacc)
					on update cascade on delete cascade ,
	constraint fk_allergicoallergia
				foreign key (Allergia) references Allergia(nome)
					on update cascade on delete cascade
);

create table Convocazione (
	IDConv char(8) not null ,
	Vaccinando char(8) not null , 
	Centro char(8) not null ,
	Data_conv date not null ,
	Ora time not null ,
	Vaccino varchar(20) not null ,
	constraint pk_convocazione primary key (IDConv) ,
	unique (vaccinando,data_conv) ,
	constraint fk_convocazionevaccinando
				foreign key (vaccinando) references vaccinando(IDVacc)
					on update cascade on delete cascade ,
	constraint fk_convocazionecentro 
			   foreign key (centro) references Centro_Vaccinale(IdCentro)
				on update cascade on delete cascade ,
	constraint fk_convocazionevaccino 
			   foreign key (Vaccino) references Vaccino(nome)
				on update cascade on delete cascade
);

create table Lotto (
	Numero char(8) not null ,
	Vaccino varchar(20) not null ,
	Data_prod date not null ,
	Data_scad date not null check (data_scad > data_prod),
	Numero_dosi int not null check (numero_dosi > 0) ,
	constraint pk_lotto primary key (Numero) ,
	constraint fk_lottovaccino 
			   foreign key (Vaccino) references Vaccino(nome)
				on update cascade on delete cascade
);

create table Vaccinazione (
	IDVacc char(8) not null ,
	Vaccinando char(8) not null ,
	Centro varchar(20) not null , 
	Medico char(8) not null ,
	Lotto char(8) not null ,
	constraint pk_vaccinazione primary key (IdVacc) ,
	--unique (nome_centro, citta_centro, ora) ,
	constraint fk_vaccinazioneconvocazione 
				foreign key (Idvacc) references Convocazione(IdConv)
					on update cascade on delete cascade ,
	constraint fk_vaccinazionevaccinando
				foreign key (vaccinando) references vaccinando(IDVacc)
					on update cascade on delete cascade ,
	constraint fk_vaccinazionecentro 
			   foreign key (centro) references Centro_Vaccinale(IdCentro)
					on update cascade on delete cascade ,
	constraint fk_vaccinazionemedico
				foreign key (medico) references Medico(IDMedico)
					on update cascade on delete cascade ,
	constraint fk_vaccinazionelotto
				foreign key (lotto) references Lotto(Numero)
					on update cascade on delete cascade
);


create table Disponibilita_dosi (
	Centro char(8) not null ,
	Lotto char(8) not null ,
	constraint pk_dosi primary key (Centro,Lotto) ,
	constraint fk_dosicentro 
			   foreign key (centro) references Centro_Vaccinale(IdCentro)
				on update cascade on delete cascade ,
	constraint fk_dosivaccino 
			   foreign key (Lotto) references Lotto(numero)
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
	Medico char(8) not null ,
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
