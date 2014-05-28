########################
#                      #
#  CHAOTIC ROBOT MUSIC #
#                      #
########################

'Chaotic Robot Music' nasce come progetto complementare al lavoro di HackLab Terni 'Chaotic Robot' ( http://dev.hacklabterni.org/ ).


NOTE SUL PROGETTO PRINCIPALE
============================
Il progetto 'Chaotic Robots' riguarda lo sviluppo di robot BEAM (BEAM - Biology, Electronics, Aesthetics, and Mechanics). Il comportamento dei robot e' controllato da circuiti High Entropy e fonti di luce opportunamente posizionate. Un'applicazione openFrameworks acquisisce il video da una telecamera sul soffitto e sovrappone delle scie curve che evidenziano le traiettorie dei robot. Alla fine di questa pagina è possibile scaricare l'applicazione.


NOTE SUL PROGETTO COMPLEMENTARE
===============================
'Chaotic Robot Music' e' una patch realizzata usando il linguaggio di programmazione a nodi 'PureData'. 

Le traiettorie dei robots vengono evidenziate e tracciate dall'applicazione principale. Questa stessa applicazione si occupa di inviare messaggi OSC contenenti informazioni relative a queste traiettorie.

La patch si occupa di ricevere questi messaggi OSC e di interpretarli per generare un arrangiamento musicale in tempo reale.
L'arrangiamento musicale finale sarà' caratterizzato dalla presenza di una sezione ritmica di batteria (cassa, rullante e tamburello) e di basso.
Un sintetizzatore polifonico-stereo si occupa di sostenere l'armonia eseguendo le note dell'accordo.
Ci sono poi ulteriori sintetizzatore monofonici i cui parametri di sintesi sono dipendenti dal movimento dei robot.

ANALISI DELLE SEZIONI
=====================

SEZIONE OSC
data la porta di comunicazione, cliccando sul pulsante 'ON' e' possibile avviare la ricezione di messaggi da parte della applicazione principale. Il cerchio nero lampeggiante indica la presenza di messaggi OSC in ingresso.

SEZIONE AREA
Dal momento che i suoni e la generazione delle note musicali si basa direttamente sui dati di posizione X e Y dei robot, occorre indicare nei due campi 'width' e 'height' le dimensioni effettive - in pixel - dello spazio entro il quale le le traiettorie dei robots vengono tracciate nell'applicazione principale.

SEZIONE ROBOTS
In questa sezione occorre cliccare sul simbolo corrispondente al robot, ogni volta che un nuovo robot viene inserito o tolto dall'area di gioco. Di default la patch si apre indicando sempre la presenza di un robot.

SEZIONE CHORDS & STYLE
In questa sezione è possibile avere un rapido riscontro visivo su quale sia l'accordo e lo stile ritmico attuale.

SEZIONE MASTER
In questa sezione e' presente un solo interruttore il cui scopo e' quello di accendere o spegnere tutto l'audio in uscita dalla patch.

SEZIONE MIXER
In questa sezione è possibile regolare singolarmente i volumi di tutti gli strumenti musicali che compongono l'arrangiamento del brano: i fader R0, R1, R2 e R3 sono preposti al controllo del volume dei 4 sintetizzatori monofonici associati ai 4 robots. PADS e BASS regolano rispettivamente il volume per il sintetizzatore polifonico 'pads' e il basso. KICK, SNARE e TAMB sono invece i fader per il controllo dei volumi della batteria (cassa, rullante e tamburello). Gli ultimi due faders, REV e MASTER, sono i rispettivi controlli per l'effetto riverbero e per il volume complessivo. Tutti i faders, ad eccezione di R0, R1, R2, R3 e MASTER, possiedono un ulteriore controllo ad interruttore per mettere il suono in MUTE.

ANALISI DEL FUNZIONAMENTO
=========================

Tutta la struttura del brano musicale di basa su un tempo BPM di circa 120 e sulla unità di tempo della biscroma (pari a 62 millisecondi). L'arrangiamento è fisso, gli stili si susseguono sempre allo stesso modo: 96 battute di musica + 8 battute di silenzio. Nelle successive versioni sarà' possibile implementare un controllo manuale sul tempo BPM (tap tempo) e modificare l'arrangiamento in modo che venga costruito in tempo reale.
Questa parte del programma e' visibile dalle sub-patch 'time-contol', 'mix-presets' e 'score-generator' dalla sezione MASTER.





SELEZIONE DELL'ACCORDO
la media aritmetica delle posizioni dei robots definisce in ogni istante una posizione intermedia che, spostandosi all'interno di 4 quadranti immaginari in cui è suddiviso lo spazio, definisce l'accordo musicale tra i 4 accordi disponibili (Do, Fa, Sol, Re minore);

CHIMES1

CHIMES2

PROPH

SINGER


