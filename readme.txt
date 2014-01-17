Idee:

-palestra:



-ricette:


-ebook free pdf download (archivio)
	-autenticazione perl
	-xml-> db libri e categorie
	-xslt
	-js- dinamica





-biblioteca, verifica disponibilita’ online
	-biblioteca di partiture musicali(.pdf) e file di partiture musicali
	(.sib per Sibelius e .mus per Finale) online,tipo IMSLP 
	esempio di pagina:  http://imslp.org/wiki/Category:Bach,_Johann_Sebastian

"testata giornalistica" : come ad esempio il foglio, l'avvenire o l'unità, con gestione dei dati tramite xml.

-“gestione corsi università”:sito per informatica con divisione in anni->corsi.
			per ogni anno ho:
				*-il calendario degli orari
				*-il calendario degli esami

			per ogni pagina di corso ho:
				-il link alla pagina del prof.
				-il materiale degli anni scorsi(possiamo usare in blocco la struttura già presente su MEGA)
				*-il link a una pagina con le specifiche relative al progetto(solo se richiesto/obbligatorio)
				*-le scadenze del progetto(ben visibili)
				*-un file con le valutazioni dell’ultimo appello svolto e data e luogo della prossima registrazione(data e luogo dovrebbero essere ben visibili direttamente quando l’utente apre la pagina del relativo corso,senza che debba cercarsi o caricare un altra pagina/file,in questo modo aumento l’usabilità del sito)
				-uso Feed RSS per mantenere gli iscritti aggiornati senza che debbano aprire la pagina ogni volta per vedere se ci sono novità.

*I feed sono collegati alle pagine segnate.

//in pratica l’idea è di integrare quello che c’è su MEGA,parte delle info del sito informatica.unipd,[parte di moodle] e le info dei vari corsi sui siti dei professori singoli,ovviamente non si può appesantire troppo la cosa.cercare quindi di rendere compatte e usabili informazioni che sono frammentate e a volte poco precise.
bisogna tener conto che i prof vogliono avere la “libertà” di gestirsi il loro sito/spazio come gli pare,quindi noi diamo solo il link alla pagina del singolo docente(così abbiamo anche meno dati da mantenere nel database) poi il resto del sito si usa per dare informazioni VELOCI,IMPORTANTI e quindi subito reperibili(per gli studenti).

probabilmente l’utente dovrà iscriversi per usufruire dei servizi del sito:
	
1-possiamo controllare che l’utente sia di informatica e consentire l’iscrizione solo in quel caso(basta che chiediamo di inserire il numero di matricola e la pass e la controlliamo tramite un database che andrà aggiornato dinamicamente[ad esempio tramite trigger],oppure facciamo lo stesso ragionamento ma usando come database la login dei laboratori informatici).in questo caso non serve fare tutta la parte di iscrizione al sito e l’utente usa la login del lab.

2-possiamo lasciare libero accesso,senza iscrizione obbligatoria.ci permettere una “maggior visibilità” anche se in realtà il sito è costruito per uno specifico target di utenti(studenti di informatica) e quindi potrebbe crearci problemi se vogliamo implementare funzionalità specifiche che coinvolgano direttamente gli utenti.[forse non è una buona idea,non ha molto senso].

3-possiamo fare entrambe le cose creando 2 classi di utenti diverse,dando ovviamente funzionalità in più agli utenti che si sono iscritti.tipo posso permettere agli utenti iscritti di inserire commenti riguardo alle attività di laboratorio appena svolte e il responsabile delle attività di lab può rispondere(un po’ come facevamo con filè a P1) oppure possono rispondere altri utenti iscritti(mi pare che una cosa simile fosse stata chiesta allo scorso incontro sulla didattica).ovviamente anche questo sarà notificato dai Feed RSS.
