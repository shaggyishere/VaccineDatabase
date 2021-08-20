/*
	prima vanno fatte le create table di:
	-vaccinando 
	-centro vaccinale
	-medico
	-allergia
	(FATTE ed ESEGUITE tutte e tre!)
	e poi il resto in ordine casuale.
*/

/*
	Vanno inoltre creati i seguenti domini?
	O basta farli con dei semplici vincoli di check?
	-Modalità (PRE-ADESIONE)
	-Categoria (VACCINANDO)
	-Tipologia (VACCINO)
	-Qualifica (MEDICO)
*/

create table Vaccinando (
	Codice varchar(12) not null ,
	CF char(16) not null unique,
	Nome varchar(20) not null ,
	Cognome varchar(20) not null ,
	Età smallint not null ,
	Città varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	Categoria varchar(21) 
		check (	categoria = 'PERSONALE SANITARIO' or
			  	categoria = 'PERSONALE SCOLASTICO' or
			  	categoria = 'SOGGETTO FRAGILE' or
			  	categoria = 'ALTRO') not null ,
	Positività_pregressa boolean not null ,
	constraint pk_vaccinando primary key (Codice)
);

create table Centro_Vaccinale (
	Codice varchar(12) not null ,
	Nome varchar(20) not null ,
	Città varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	constraint pk_centro primary key (Codice),
	unique (nome, città)
);

create table Medico (
	Codice varchar(12) not null ,
	CF char(16) not null unique,
	Centro varchar(12) not null unique, 
	Nome varchar(20) not null ,
	Cognome varchar(20) not null ,
	Età smallint not null ,
	Città varchar(20) not null ,
	Indirizzo varchar(30) not null ,
	Qualifica varchar(14) 
		check (	qualifica = 'BASE' or
			  	qualifica = 'SPECIALIZZATO') not null ,
	constraint pk_medico primary key (Codice),
	constraint fk_medicocentro 
			   foreign key (Centro) references Centro_Vaccinale(Codice)
);

create table Allergia (
	Nome varchar(12) not null ,
	constraint pk_allergia primary key (nome)
);






