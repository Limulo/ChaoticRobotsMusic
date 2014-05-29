########################
#                      #
#  CHAOTIC ROBOT MUSIC #
#                      #
########################

'Chaotic Robot Music' nasce come progetto complementare al lavoro di HackLab Terni 'Chaotic Robot' ( http://dev.hacklabterni.org/ ).


NOTE SUL PROGETTO PRINCIPALE
============================
Il progetto 'Chaotic Robots' riguarda lo sviluppo di robot BEAM (BEAM - Biology, Electronics, Aesthetics, and Mechanics). Il comportamento dei robot e' controllato da circuiti High Entropy e fonti di luce opportunamente posizionate. Un'applicazione openFrameworks acquisisce il video da una telecamera sul soffitto e sovrappone delle scie curve che evidenziano le traiettorie dei robot. Alla fine di questa pagina e' possibile scaricare l'applicazione.


NOTE SUL PROGETTO COMPLEMENTARE
===============================
'Chaotic Robot Music' e' una patch realizzata usando il linguaggio di programmazione a nodi 'PureData'. 

Le traiettorie dei robots vengono evidenziate e tracciate dall'applicazione principale. Questa stessa applicazione si occupa di inviare messaggi OSC contenenti informazioni relative a queste traiettorie.

La patch si occupa di ricevere questi messaggi OSC e di interpretarli per generare un arrangiamento musicale in tempo reale.
L'arrangiamento musicale finale sara'' caratterizzato dalla presenza di una sezione ritmica di batteria (cassa, rullante e tamburello) e di basso.
Un sintetizzatore polifonico-stereo si occupa di sostenere l'armonia eseguendo le note dell'accordo.
Ci sono poi ulteriori sintetizzatore monofonici i cui parametri di sintesi sono dipendenti dal movimento dei robot.

ANALISI DELLE SEZIONI
=====================

# SEZIONE OSC
data la porta di comunicazione, cliccando sul pulsante 'ON' e' possibile avviare la ricezione di messaggi da parte della applicazione principale. Il cerchio nero lampeggiante indica la presenza di messaggi OSC in ingresso.

# SEZIONE AREA
Dal momento che i suoni e la generazione delle note musicali si basa direttamente sui dati di posizione X e Y dei robot, occorre indicare nei due campi 'width' e 'height' le dimensioni effettive - in pixel - dello spazio entro il quale le le traiettorie dei robots vengono tracciate nell'applicazione principale.

# SEZIONE ROBOTS
In questa sezione occorre cliccare sul simbolo corrispondente al robot, ogni volta che un nuovo robot viene inserito o tolto dall'area di gioco. Di default la patch si apre indicando sempre la presenza di un robot.

# SEZIONE CHORDS & STYLE
In questa sezione e' possibile avere un rapido riscontro visivo su quale sia l'accordo e lo stile ritmico attuale.

# SEZIONE MASTER
In questa sezione e' presente un solo interruttore il cui scopo e' quello di accendere o spegnere tutto l'audio in uscita dalla patch.

# SEZIONE MIXER
In questa sezione e' possibile regolare singolarmente i volumi di tutti gli strumenti musicali che compongono l'arrangiamento del brano: i fader R0, R1, R2 e R3 sono preposti al controllo del volume dei 4 sintetizzatori monofonici associati ai 4 robots. PADS e BASS regolano rispettivamente il volume per il sintetizzatore polifonico 'pads' e il basso. KICK, SNARE e TAMB sono invece i fader per il controllo dei volumi della batteria (cassa, rullante e tamburello). Gli ultimi due faders, REV e MASTER, sono i rispettivi controlli per l'effetto riverbero e per il volume complessivo. Tutti i faders, ad eccezione di R0, R1, R2, R3 e MASTER, possiedono un ulteriore controllo ad interruttore per mettere il suono in MUTE.

ANALISI DEL FUNZIONAMENTO
=========================

Tutta la struttura del brano musicale si basa su un tempo BPM di circa 120 e sulla unita' di tempo della biscroma (pari a 62 millisecondi). L'arrangiamento e' fisso: gli stili si susseguono sempre allo stesso modo per una durata complessiva di 96 battute di musica + 8 battute di silenzio. 
Nelle successive versioni sara'' possibile implementare un controllo manuale sul tempo BPM (tap tempo) e modificare l'arrangiamento in modo che venga costruito in tempo reale.
--
Questa parte del programma e' visibile dalle sub-patch 'time-contol', 'mix-presets' e 'score-generator' dalla sezione MASTER.

Tutti gli strumenti melodici/armonici, si intonano sulle note di un accordo. Questo accordo è scelto su base della media aritmetica delle posizioni dei robot selezionati. Gli accordi possibili sono 4: Do, Sol, Fa e Re minore.
Lo spazio di gioco dei robot e' suddiviso virtualmente in 4 riquadri. La posizione media, muovendosi tra un riquadro e l'altro seleziona l'accordo corrispondente. L'accordo cambia in relazione alla posizione media ma viene inviato a tutti gli strumenti solo in corrispondenza del tempo forte della battuta (ogni 8 crome) in modo che il cambiamento armonico avvenga sempre 'a tempo' con l'esecuzione musicale.
--
Questa parte e' visibile dalla sezione CHORDS & STYLES

SYNTH SINGER (con dispositivo automatico di scelta della nota da cantare)
Questo synth implementa un sistema intelligente per scegliere autonomamente la nota che debba seguire quella attualmente in riproduzione su base dei seguenti elementi:
- accordo in cui ci si trovi;
- la direzione (stessa intonazione, più' grave o più' acuta);
- la nota attualmente in riproduzione.
In particolare l'algoritmo implementato calcola, ad ogni nota riprodotta, la probabilita' della nota successiva. Ogni possibile nota avra' una probabilita' differente, pesata in base a 3 regole imposte:
1) la nuova nota dovra' avere una probabilita'' pA di appartenere all'accordo musicale in cui ci si trovi attualmente;
2) la nota dovra' avere una probabilita' pDIR di trovarsi nella stessa direzione prescelta dal movimento del robot ( se il robot si muove ad esempio nella direzione 0, allora avremo probabilita' pDIR che la nota a seguire sia più' grave rispetto a quella attualmente in riproduzione, se invece il robot si muove nella direzione 1 o 2, andando quindi dritto e svoltando a destra, avremo la stessa probabilita' pDIR che la nota successiva mantenga questa volta la stessa intonazione oppure sia più' acuta).
3) la nuova nota dovra' avere una probabilita' pSN (probabilita' a campana distribuita sulle 7 note musicali e centrata sulla nota attuale) d'essere vicina alla nota corrente.
E' stato introdotto un ulteriore elemento che permette al synth di cantare frasi musicali che abbiano una lunghezza media di 2 battute (massima 4 battute); queste frasi musicali sono a loro volta separate da valori di pausa.
La lunghezza della frase musicale e della 
La probabilità' che la nota successiva, anziché' essere una nota, sia invece un valore di pausa-di-croma e' direttamente proporzionale al numero di note (crome) cantante in successione. In altre parole, tanto più' la frase musicale cantata e' lunga, tanto più' si avrà la probabilità' che questa venga interrotta da una pausa-di-croma. 
In maniera simile, una volta che si e' interrotta la frase musicale, la probabilità' che la nota successiva sia effettivamente una nota e non un ulteriore valore di pausa-di-croma è direttamente proporzionale alla durata dell'interruzione.

