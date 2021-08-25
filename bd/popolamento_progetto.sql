/* POPOLAMENTO DB*/

insert into allergia values ('noci');
insert into allergia values ('ananas');
insert into allergia values ('latte');

select * from allergia;

insert into effetto_allergico values ('diarrea');
insert into effetto_allergico values ('vomito');
insert into effetto_allergico values ('prurito');
insert into effetto_allergico values ('dolore braccio');
insert into effetto_allergico values ('nausea');

select * from effetto_allergico;

insert into vaccinando values ('CF234CFGGIOG22D','Luca', 'Rizzo', 21, 'Torino', 'Via Roma 12', 'SOGGETTO FRAGILE', false);
insert into vaccinando values ('EF234CFEGIOG96D','Nino', 'Franceschini', 11, 'Roma', 'Viale Cesana 134', 'PERSONALE SCOLASTICO', false);
insert into vaccinando values ('CD234CFGGIOG92D','Lello', 'Albertini', 91, 'Milano', 'Via Garibaldi 41', 'ALTRO', true);
insert into vaccinando values ('PE234CFGGIOG01D','Pippo', 'Mussolini', 42, 'Napoli', 'Via Castelletti 11', 'PERSONALE SANITARIO', true);
insert into vaccinando values ('QE234FCGGIOG53D','Gianni', 'Potti', 10, 'Torino', 'Via Po 3', 'SOGGETTO FRAGILE', false);

select * from vaccinando;

insert into vaccino values ('COVIDIN', 79.09, 30, 70, 25, 'DOPPIA DOSE');
insert into vaccino values ('CORONAX', 92.12, 21, 50, 18, 'DOPPIA DOSE');
insert into vaccino values ('FLUSTOP', 57, 40, 80, 30, 'SINGOLA DOSE');

select * from vaccino;

insert into centro_vaccinale values ('Luci', 'Roma', 'Via Carlo Alberto 11');
insert into centro_vaccinale values ('Spallanzani', 'Roma', 'Via Carlo Alberto 11');
insert into centro_vaccinale values ('San Raffaele', 'Milano', 'Via Mazzini 3');
insert into centro_vaccinale values ('Nuvola Lavazza', 'Torino', 'Via Palermo 89');

select * from centro_vaccinale;

insert into preadesione values ('QE234FCGGIOG53D', 'app', '07/03/2021', '18:30', '3999320110');
insert into preadesione values ('EF234CFEGIOG96D', 'web', '08/03/2021', '17:30', null, 'csai@ssasj.com');

select * from preadesione;

insert into medico values ('GTRKSS90H23F106T', 'Spallanzani', 'Roma', 'Gino', 'Strada', 73, 'Milano', 'Via del Campo', 'BASE');
insert into medico values ('CDPVWD67L21B248K ', 'Luci', 'Roma', 'Paolo', 'Villa', 54, 'Napoli', 'Via Garibaldi', 'SPECIALIZZATO');
insert into medico values ('SVNLNS97L53F593Y', 'Spallanzani', 'Roma', 'Nicola', 'Strada', 31, 'Cunedo', 'Via dei Santi', 'BASE');
insert into medico values ('VNWJFN33R13I563K', 'San Raffaele', 'Milano', 'Lino', 'Antonelli', 66, 'Trapani', 'Via Girolamo', 'SPECIALIZZATO');
insert into medico values ('YKSSMG84T67B662T', 'Nuvola Lavazza', 'Torino', 'Franco', 'Paoli', 38, 'Milano', 'Via De Andrè', 'BASE');

select * from medico;

insert into allergico values ('CD234CFGGIOG92D', 'noci');
insert into allergico values ('CD234CFGGIOG92D', 'latte');
insert into allergico values ('PE234CFGGIOG01D', 'ananas');
insert into allergico values ('PE234CFGGIOG01D', 'noci');
insert into allergico values ('CD234CFGGIOG92D', 'ananas');

select * from allergico;

insert into vaccinazione values ('CD234CFGGIOG92D', 'San Raffaele', 'Milano', '03/30/2021', '08:30', 'GTRKSS90H23F106T');
insert into vaccinazione values ('PE234CFGGIOG01D', 'Luci', 'Roma', '12/22/2021', '18:42', 'VNWJFN33R13I563K');
insert into vaccinazione values ('QE234FCGGIOG53D', 'San Raffaele', 'Milano', '07/30/2021', '17:00', 'VNWJFN33R13I563K');
insert into vaccinazione values ('CD234CFGGIOG92D', 'Nuvola Lavazza', 'Torino', '01/11/2021', '09:45', 'SVNLNS97L53F593Y');

select * from vaccinazione;

insert into convocazione values ('CD234CFGGIOG92D', 'San Raffaele', 'Milano', '03/30/2021', '08:30', 'COVIDIN');
insert into convocazione values ('PE234CFGGIOG01D', 'Luci', 'Roma', '12/22/2021', '18:42', 'CORONAX');
insert into convocazione values ('QE234FCGGIOG53D', 'San Raffaele', 'Milano', '07/30/2021', '17:00', 'CORONAX');
insert into convocazione values ('CD234CFGGIOG92D', 'Nuvola Lavazza', 'Torino', '01/11/2021', '09:45', 'FLUSTOP');

select * from convocazione;


insert into lotto values ('67541234', 'COVIDIN', '04/28/2021', '07/30/2029', 15000);
insert into lotto values ('87631192', 'FLUSTOP', '08/27/2021', '07/30/2031', 20000);
insert into lotto values ('87422331', 'CORONAX', '09/11/2021', '07/30/2027', 7000);
insert into lotto values ('09116748', 'COVIDIN', '06/20/2021', '07/30/2035', 9000);

select * from lotto;

insert into disponibilita_dosi values ('San Raffaele', 'Milano', '67541234');
insert into disponibilita_dosi values ('Luci', 'Roma', '67541234');
insert into disponibilita_dosi values ('Luci', 'Roma', '87422331');
insert into disponibilita_dosi values ('San Raffaele', 'Milano', '09116748');

select * from disponibilita_dosi;

insert into reazione_allergica values ('87631192', 'diarrea');
insert into reazione_allergica values ('87631192', 'prurito');
insert into reazione_allergica values ('87631192', 'vomito');
insert into reazione_allergica values ('09116748', 'diarrea');

select * from reazione_allergica;

insert into report values ('GTRKSS90H23F106T', '87631192', 'diarrea', '09/30/2021');
insert into report values ('GTRKSS90H23F106T', '09116748', 'prurito', '08/15/2021');
insert into report values ('GTRKSS90H23F106T', '09116748', 'irritazione', '03/02/2021');

select * from report;

delete from vaccinando where città = 'Torino';

---------------------------------------------------------




