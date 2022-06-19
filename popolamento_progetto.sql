/* POPOLAMENTO DB*/

insert into vaccinando values ('CF234CFGGIOG22D','Luca', 'Rizzo', '09/22/2000', 'Torino', 'Via Roma', '12', '10231','SFRA', false);
insert into vaccinando values ('EF234CFEGIOG96D','Nino', 'Franceschini', '04/17/1911', 'Roma', 'Viale Cesana', '134', '13110', 'PSCO', false);
insert into vaccinando values ('CD234CFGGIOG92D','Lello', 'Albertini', '11/13/1991', 'Milano', 'Via Garibaldi', '41', '17221', 'ALTR', true);
insert into vaccinando values ('PE234CFGGIOG01D','Pippo', 'Mussolini', '12/12/1942', 'Napoli', 'Via Castelletti', '8', '10419', 'PSAN', true);
insert into vaccinando values ('QE234FCGGIOG53D','Gianni', 'Potti', '01/06/1910', 'Torino', 'Via Po', '77', '10231', 'SFRA', false);

select idvacc from vaccinando where upper(nome) = 'PIPPO';

---------------------------------------------------------

insert into centro_vaccinale values ('Luci', 'Roma', 'Via Carlo Alberto', '11', '10152');
insert into centro_vaccinale values ('Spallanzani', 'Roma', 'Via Carlo Alberto', '21', '10887');
insert into centro_vaccinale values ('San Raffaele', 'Milano', 'Via Mazzini', '3', '10910');
insert into centro_vaccinale values ('Nuvola Lavazza', 'Torino', 'Via Palermo', '89', '10999');

select * from centro_vaccinale;

---------------------------------------------------------

insert into vaccino values ('COVIDIN', 79.09, 30, 70, 25, 'D');
insert into vaccino values ('CORONAX', 92.12, 21, 50, 18, 'D');
insert into vaccino values ('FLUSTOP', 57, 40, 80, 30, 'S');

select nome,idvaccino from vaccino;

---------------------------------------------------------

insert into allergia values ('noci');
insert into allergia values ('ananas');
insert into allergia values ('latte');

---------------------------------------------------------
insert into effetto_allergico values ('diarrea');
insert into effetto_allergico values ('vomito');
insert into effetto_allergico values ('prurito');
insert into effetto_allergico values ('dolore braccio');
insert into effetto_allergico values ('nausea');

---------------------------------------------------------

select nome,citta,idcentro from centro_vaccinale;

insert into medico values ('GTRKSS90H23F106T', 1, 'Gino', 'Strada', '01/10/1973', 'Milano', 'Via del Campo','11', '10152', 'BASE');
insert into medico values ('CDPVWD67L21B248K ', 1, 'Paolo', 'Villa', '03/11/1954', 'Napoli', 'Via Garibaldi','91', '10813', 'SPEC');
insert into medico values ('SVNLNS97L53F593Y', 2, 'Nicola', 'Strada', '06/30/1931', 'Cunedo', 'Via dei Santi','23', '10001', 'BASE');
insert into medico values ('VNWJFN33R13I563K', 3, 'Lino', 'Antonelli', '03/11/1966', 'Trapani', 'Via Girolamo','1', '10891', 'SPEC');
insert into medico values ('YKSSMG84T67B662T', 4, 'Franco', 'Paoli', '12/12/1938', 'Milano', 'Via De Andrè','95', '10724', 'BASE');

select cf,idmedico from medico;

---------------------------------------------------------

select * from vaccinando where cf = 'QE234FCGGIOG53D';

insert into preadesione values ('QE234FCGGIOG53D', 'app', '07/03/2021', '18:30', '3999320110');
insert into preadesione values ('EF234CFEGIOG96D', 'WEB', '08/03/2021', '17:30', null, 'csai@ssasj.com');

select cf,idpread from preadesione;

---------------------------------------------------------

select idvacc from vaccinando;

insert into allergico values (1, 'noci');
insert into allergico values (1, 'latte');
insert into allergico values (4, 'ananas');
insert into allergico values (5, 'noci');
insert into allergico values (3, 'ananas');

---------------------------------------------------------

select idcentro from centro_vaccinale;

insert into convocazione values (3, 2, 1, '04/16/2021', '18:30');
insert into convocazione values (4, 2, 1, '04/12/2021', '07:30');
insert into convocazione values (1, 1, 2, '07/01/2021', '19:30');
insert into convocazione values (2, 4, 3, '08/29/2021', '12:30');
insert into convocazione values (4, 2, 1, '05/01/2021', '08:30');

select * from convocazione;

---------------------------------------------------------

insert into Lotto values('87312413', 2, '01/01/2021', '01/01/2024', 120000);
insert into Lotto values('42357651', 1, '05/01/2021', '01/01/2024', 150000);
insert into Lotto values('98726347', 1, '06/01/2021', '01/01/2024', 100000);
insert into Lotto values('09131893', 3, '01/10/2021', '01/01/2024', 140000);
insert into Lotto values('11251095', 2, '03/20/2021', '01/01/2024', 120000);


select * from lotto;

---------------------------------------------------------

insert into reazione_allergica values('98726347', 'diarrea');
insert into reazione_allergica values('98726347', 'nausea');
insert into reazione_allergica values('98726347', 'vomito');
insert into reazione_allergica values('09131893', 'dolore braccio');

select * from reazione_allergica;

---------------------------------------------------------

select idconv from convocazione;
select idmedico from medico;
select numero from lotto;

insert into vaccinazione values(3, 4, '98726347', 'febbre');
insert into vaccinazione values(2, 5, '98726347');
insert into vaccinazione values(1, 4, '98726347', 'nausea');
insert into vaccinazione values(4, 2, '09131893');

select * from vaccinazione;

---------------------------------------------------------

select numero from lotto;

insert into disponibilita_dosi values(3, '87312413');
insert into disponibilita_dosi values(2, '42357651');
insert into disponibilita_dosi values(1, '09131893');
insert into disponibilita_dosi values(2, '09131893');

select * from disponibilita_dosi;

---------------------------------------------------------

select * from convocazione;

insert into report values (4, '98726347', 'febbre', '2021-07-01');
insert into report values (4, '98726347', 'nausea', '2021-04-16');

---------------------------------------------------------
