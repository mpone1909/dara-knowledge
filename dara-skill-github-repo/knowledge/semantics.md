# DaRa Dataset – Semantik

Diese Datei beschreibt die **semantische Struktur** des DaRa-Datensatzes – wie die Bedeutung jedes Frames aus den 12 Klassenkategorien entsteht.

**Quelle:** DaRa Dataset Description (Stand 20.10.2025), Teil 6

---

## 6.1 Semantische Grunddefinition

Die Semantik im DaRa-Datensatz beschreibt die vollständige inhaltliche Bedeutung jedes einzelnen Frames. Ein Frame stellt die **atomare semantische Einheit** dar, in der der gesamte körperliche, prozedurale und kontextuelle Zustand eines Subjekts vollständig erfasst wird. Die Semantik ergibt sich ausschließlich aus den aktiv annotierten Labels der 12 Klassenkategorien (CC01–CC12), die gemeinsam den vollständigen interpretierbaren Zustand bilden.

Die Semantik eines Frames setzt sich aus den folgenden Komponenten zusammen:

- **Motorische Aktivitäten:** Hauptaktivität, Sub-Aktivitäten der Beine, des Torsos und der Hände.  
- **Kontextinformationen:** Kundenauftrag, Informationstechnologie, Prozessphasen und räumliche Position.  
- **Prozedurale Einordnung:** High-Level-, Mid-Level- und Low-Level-Prozesse beschreiben, was das Subjekt im logistischen Ablauf gerade tut.

Die Bedeutung eines Frames ist vollständig durch die Kombination aller aktiven Labels bestimmt und ist damit eindeutig interpretierbar. Ein Frame enthält nie unvollständige oder widersprüchliche Informationen, da jede Klassendatei exakt ein aktives Label (oder einen aktiven Labelzustand) für jeden Zeitpunkt definiert.

---

## 6.2 Semantische Struktur der Klassen

Die Semantik aller annotierten Daten basiert vollständig auf der Struktur der zwölf Klassenkategorien (CC01–CC12). Jede dieser Kategorien trägt einen eindeutig definierten semantischen Anteil zum Gesamtzustand eines Frames bei. Zusammen bilden sie eine geschlossene, vollständige und interpretierbare Beschreibung des Verhaltens, der Interaktion, der Position und der Prozesssituation des Subjekts.

Die Klassen gliedern sich in zwei Hauptgruppen:

### (1) Motorische Semantik – CC01 bis CC05

Diese Kategorien beschreiben ausschließlich körperliche Bewegungen oder körpernahe Zustände des Subjekts. Sie bilden die motorische Ebene der Frame-Semantik.

- **CC01 – Main Activity:** Erfasst die dominante körperliche Handlung, z. B. Walking, Standing, Sitting, Handling-Bewegungen, Scanning oder Cart Movement.  
- **CC02 – Sub-Activity Legs:** Beschreibt die spezifischen Bewegungsphasen der Beine, z. B. Gait Cycle, Step, Standing Still, Sitting.  
- **CC03 – Sub-Activity Torso:** Präzisiert die Rücken- und Oberkörperbewegung, z. B. No Bending, Bending, Rotation.  
- **CC04 – Sub-Activity Left Hand:** Beschreibt Position, Bewegungstyp, Objekt und Tool der linken Hand.  
- **CC05 – Sub-Activity Right Hand:** Analog zu CC04, jedoch für die rechte Hand.

Die motorischen Klassen definieren die semantische Beschreibung des körperlichen Handelns des Subjekts im kleinsten Detail.

### (2) Kontextuelle Semantik – CC06 bis CC12

Diese Kategorien situieren das körperliche Verhalten in einem prozeduralen, technologischen und räumlichen Kontext.

- **CC06 – Order:** Ordnet den Frame einem spezifischen Auftrag zu (z. B. 2904, 2905, 2906) oder kennzeichnet das Fehlen eines Auftrags.  
- **CC07 – Information Technology:** Beschreibt das aktive IT-Artefakt, z. B. Pen & List, Glove Scanner, Portable Data Terminal.  
- **CC08 – High-Level Process:** Definiert die globale Prozessphase (Retrieval, Storage, Another, Unknown).  
- **CC09 – Mid-Level Process:** Beschreibt prozedurale Zwischenphasen wie Travel Time, Pick Time, Unpacking, Packing.  
- **CC10 – Low-Level Process:** Erfasst atomare Handlungsschritte, z. B. Retrieving Items, Moving to Cart, Opening Cardboard Box.  
- **CC11 – Location Human:** Bestimmt die genaue räumliche Position der Person anhand definierter Zonen, Pfade, Aisle Paths und Areas.  
- **CC12 – Location Cart:** Analog zu CC11, jedoch für den Standort des Kommissionierwagens.

Die kontextuellen Klassen definieren die semantischen Rahmenbedingungen, in denen motorische Aktivitäten stattfinden.

### Zusammenspiel der Klassen

Die Semantik eines Frames entsteht ausschließlich durch die **Kombination aller aktiven Labels**. Keine Klasse kann allein die vollständige Bedeutung eines Frames erzeugen — erst das Zusammenwirken aller Ebenen ergibt eine vollständige, eindeutige, interpretierbare Zustandsbeschreibung.

---

## 6.3 Semantische Abhängigkeiten

Die Semantik im DaRa-Datensatz entsteht nicht nur durch die isolierte Bedeutung einzelner Klassenlabels, sondern vor allem durch das Zusammenspiel und die gegenseitige Abhängigkeit der verschiedenen Ebenen. Die folgenden Abhängigkeiten sind eindeutig aus den annotierten Strukturen ableitbar.

### 1. Bewegungsabhängigkeiten (CC01–CC03)

Motorische Klassen stehen in einer engen semantischen Beziehung zueinander.

- **Walking (CC01)** tritt typischerweise gemeinsam auf mit:  
  - Gait Cycle oder Step (CC02)  
  - No Bending oder Slightly Bending (CC03)  

- **Handling-Aktivitäten (Handling Upwards/Centered/Downwards)** (CC01) zeigen häufig:  
  - Bending, Rotation oder Slightly Bending (CC03)  

- **Standing oder Sitting** (CC01) korrelieren stark mit:  
  - Standing Still oder Sitting (CC02)  
  - fehlender Rotations- oder Bending-Bewegung (CC03)

Diese Abhängigkeiten ergeben sich aus der physischen Logik der Bewegungen und spiegeln sich in den annotierten Frame-Kombinationen wider.

### 2. Handinteraktionsabhängigkeiten (CC04–CC05)

Die Handkategorien bestehen aus vier Unterdimensionen: Position, Movement, Object und Tool. Diese Dimensionen sind semantisch miteinander verbunden.

Beispiele für typische Abhängigkeiten:

- Wird ein Tool wie ein **Portable Data Terminal** gehalten, tritt meist gleichzeitig **Holding** als Movement-Type auf.  
- Bei **Retrieving Items** (Low-Level Process) sind häufig Handbewegungen in Form von **Reaching / Grasping** annotiert.  
- Ein Objekt wie **Cardboard Box** in der linken oder rechten Hand korreliert oft mit **Handling Centered/Downwards** in CC01.

Handsemantik wirkt insbesondere auf die prozeduralen Prozesse (CC08–CC10), da bestimmte Aktionen ohne Handinteraktion nicht vorkommen können.

### 3. Kontextabhängigkeiten (CC06–CC12)

Kontextkategorien ergänzen und spezifizieren die Semantik des motorischen Zustands.

- **Order (CC06)** ist eng gekoppelt mit den High-Level-Prozessen:  
  - Retrieval: typischerweise Order 2904–2906  
  - Storage: kann ebenfalls dieselben Ordernummern umfassen, jedoch andere Low-Level-Schritte.

- **Information Technology (CC07)** beeinflusst Hand- und Bewegungssemantik:  
  - Bei "List and Pen" treten häufig kurze Stationary- oder Standing-Phasen auf.  
  - "Portable Data Terminal" ist stark mit Scanning- und Confirming-Aktivitäten verbunden.

- **Process-Level (CC08–CC10)** hat direkte Abhängigkeit zu Bewegungen und Location:  
  - Travel Time (Mid-Level) korreliert oft mit Walking und Gait Cycle.  
  - Pick Time hat häufig Bending und Handbewegungen.  
  - Packaging/Sorting-Phasen sind eng mit den Werkzeugen (Tape Dispenser, Knife etc.) verbunden.

- **Location Human / Cart (CC11–CC12)** ist semantisch prozedural eingebettet:  
  - Cross Aisle Paths treten typischerweise während Travel Time auf.  
  - Base, Packing Area etc. entsprechen bestimmten Prozessblöcken.

### 4. Hierarchische Abhängigkeiten zwischen Prozessen (CC08–CC10)

Die Prozessebenen sind strikt hierarchisch organisiert:

- **High-Level Process** definiert den globalen Aufgabenrahmen.  
- **Mid-Level Process** beschreibt die Phase innerhalb dieses Rahmens.  
- **Low-Level Process** beschreibt die atomaren Schritte innerhalb der Phase.

Jede Ebene enthält semantische Anforderungen an darunterliegende Ebenen:

- Während „Picking – Pick Time" sind bestimmte Hand- und Körperhaltungen typischerweise aktiv.  
- Während „Travel Time" ist mindestens Walking aktiv, häufig zusätzlich mit Gait Cycle.

### 5. Frame-Semantik als Gesamtkomposition

Die vollständige Semantik eines Frames entsteht aus der **kompletten Kombination aller 12 Klassen**, da:

- jede Klasse ein Element der Semantik beiträgt,  
- keine Klasse optional ist,  
- die Kombination widerspruchsfrei ist,  
- jede Frame-Situation eindeutig beschrieben wird.

Ein Frame kann daher als **multidimensionale semantische Signatur** betrachtet werden, die motorische, prozedurale und räumliche Information gemeinsam trägt.

---

## 6.4 Semantische Konsistenzregeln

Die Semantik des DaRa-Datensatzes folgt klar definierten Konsistenzregeln, die sicherstellen, dass jeder Frame, jeder Chunk und jede Prozess- oder Szenarioeinheit eindeutig interpretierbar bleibt. Diese Regeln ergeben sich unmittelbar aus der Struktur der Annotationen, den Klassendefinitionen und der formalen Organisation des Datensatzes.

### 1. Ein Frame trägt immer einen vollständigen Zustand

Jeder Frame besitzt **für alle 12 Klassenkategorien (CC01–CC12)** genau einen aktiven semantischen Zustand. Dadurch ist sichergestellt:

- kein Frame enthält fehlende Informationen,  
- kein Frame enthält mehrere widersprüchliche Labels innerhalb derselben Klasse,  
- jeder Frame ist eine vollständige semantische Momentaufnahme.

### 2. Keine Mehrdeutigkeit innerhalb eines Frames

Innerhalb eines Frames darf eine Klasse niemals mehrere gleichzeitig konkurrierende Zustände besitzen. Beispiel:

- Ein Subjekt kann nicht gleichzeitig Walking **und** Sitting sein (CC01).  
- Eine Hand kann nicht gleichzeitig Upwards **und** Downwards positioniert sein (CC04/CC05).

Diese Konsistenz ist durch das binäre 0/1-System und die Struktur der CSV-Annotationen garantiert.

### 3. Vollständigkeit über alle Klassen

Kein Frame darf Informationen in einer beliebigen Klasse fehlen haben. Das bedeutet:

- Es existiert immer eine Main Activity (CC01).  
- Es existiert immer ein Prozessstatus (CC08–CC10).  
- Es existiert immer eine Locations-Information (CC11–CC12).

Auch „Unknown"-Labels (z. B. CL014, CL113, CL122) sind gültige semantische Zustände und somit Teil der vollständigen Beschreibung.

### 4. Konsistenz über Klassenhierarchien

Labels müssen mit ihren hierarchischen Strukturen konsistent sein:

- High-Level-Prozess (CC08) und Mid-Level-Prozess (CC09) müssen zueinander passen (z. B. Retrieval → Picking Travel Time).  
- Mid-Level-Prozess (CC09) und Low-Level-Prozess (CC10) müssen konsistent sein (z. B. Picking Pick Time → Retrieving Items).

### 5. Zeitliche Konsistenz über Chunk-Grenzen

Semantik muss sich über Zeit deterministisch verändern:

- Jede Zustandsänderung erzeugt eine neue semantische Signatur.  
- Diese Änderungen sind durch Trigger (T1–T10) definiert.  
- Es existieren keine Sprünge oder Inkonsistenzen zwischen aufeinanderfolgenden Frames.

### 6. Synchronität über alle Klassen

Alle 12 Klassenkategorien müssen für jeden Frame zeitlich synchron sein:

- Frame N in CC01 entspricht Frame N in CC02–CC12.  
- Alle Klassendateien haben identische Zeilenzahl.  
- Zeitstempel sind über alle Klassen konsistent.

---

## 6.5 Rolle der Semantik im Gesamtsystem

Die Semantik ist das zentrale Organisationsprinzip des DaRa-Datensatzes. Sie bestimmt nicht nur die Bedeutung einzelner Frames, sondern strukturiert alle übergeordneten Konzepte wie Chunks, Prozesse, Szenarien und räumliche Abläufe.

### 1. Rolle der Semantik für motorische Beschreibungen

Die motorische Semantik (CC01–CC05) definiert:

- wie sich das Subjekt physisch bewegt,  
- welche Körperhaltung vorliegt,  
- welche Handinteraktionen stattfinden,  
- welche Objekte oder Tools verwendet werden.

Damit bildet sie die Grundlage für die Analyse aller körperbezogenen Aktionen innerhalb der Szenarien und Prozesse.

### 2. Rolle der Semantik für prozedurale Abläufe

Die prozedurale Semantik (CC08–CC10) ordnet jedes motorische Verhalten in den logistischen Arbeitskontext ein. Sie legt fest:

- welcher globale Prozess aktiv ist (Retrieval, Storage),  
- in welcher Phase sich der Ablauf befindet (Travel Time, Pick Time, Store Time etc.),  
- welcher atomare Handlungsschritt ausgeführt wird (z. B. Retrieving Items, Printing Label, Moving to Cart).

Diese Prozessinformation verleiht der motorischen Semantik Bedeutung im Hinblick auf die übergeordnete Tätigkeit.

### 3. Rolle der Semantik für räumliche Interpretation

Die räumliche Semantik (CC11–CC12) definiert die konkrete Position des Subjekts und des Kommissionierwagens im Lagerumfeld. Sie ermöglicht:

- die räumliche Einordnung von Aktivitäten,  
- die Rekonstruktion von Wegen, Routen und Arbeitsbereichen,  
- die Analyse raumbezogener Szenariostrukturen.

Ohne die Location-Semantik wäre die Interpretation von Travel Time, Pick Time oder anderen prozeduralen Phasen nicht möglich.

### 4. Rolle der Semantik für Order- und IT-Kontext

Die semantische Einbettung durch CC06 und CC07 umfasst:

- welchen Auftrag das Subjekt aktuell bearbeitet,  
- welches technische Arbeitsmittel aktiv verwendet wird.

Diese Informationen sind essenziell für:

- die Zuordnung von Aktivitäten zu Aufträgen,  
- die Analyse der Tool- und Objektinteraktionen,  
- die korrekte Prozessinterpretation (z. B. Scanning, Confirming).

### 5. Rolle der Semantik für Szenarien (S1–S8)

Szenarien werden vollständig über Semantik definiert. Die Szenariostruktur ergibt sich ausschließlich aus:

- der Sequenz der Chunks,  
- den damit verbundenen Prozesslabels,  
- den räumlichen und motorischen Abläufen.

Semantik bestimmt damit:

- die Abgrenzung von Szenarien,  
- die inhaltlichen Abläufe innerhalb eines Szenarios,  
- die Interpretation von Szenariotypen (Standard, Variant, Error, Perfect Run).

### 6. Rolle der Semantik für Chunks

Chunks sind die direkt aus der Semantik resultierenden kleinsten, stabilen Zustände. Semantik bestimmt:

- wann ein Chunk beginnt,  
- wann ein Chunk endet,  
- welche inhaltliche Bedeutung ein Chunk hat,  
- wie verschiedene Chunks in Sequenz zueinander stehen.

Ohne Semantik wären Chunks nicht definierbar.

### 7. Rolle der Semantik für Validierung und Analyse

Semantik bildet die Grundlage für:

- die Überprüfung der Konsistenz einzelner Frames,  
- die Rekonstruktion komplexer Abläufe,  
- die algorithmische Verarbeitung der Daten,  
- die zuverlässige Interpretierbarkeit des Datensatzes.

Semantik ist damit nicht nur eine Beschreibungsebene, sondern ein funktionales Kernprinzip des gesamten Datensatzes.

---

## 6.6 Grenzen der Semantik

Die Semantik des DaRa-Datensatzes ist umfassend definiert, jedoch strikt begrenzt auf die belegten und eindeutig dokumentierten Informationen. Die folgenden Grenzen ergeben sich unmittelbar aus der Struktur, den Annotationen und der Dokumentation des Datensatzes.

### 1. Keine ableitungsbasierten Zusatzerklärungen

Semantik entsteht **ausschließlich** aus den annotierten Labels der Klassenkategorien (CC01–CC12). Bedeutungen, die nicht direkt aus:

- Klassendefinitionen,  
- Prozesslogik,  
- Szenariostrukturen,  
- räumlichen Definitionen,  
- offiziellen Beschreibungen ableitbar sind, werden nicht ergänzt.

Es erfolgt **keine semantische Inferenzen** über nicht belegte Zusammenhänge.

### 2. Keine Modellannahmen oder algorithmischen Interpretationen

Semantik beschreibt, **was annotiert wurde**, nicht:

- wie ein Modell die Daten interpretieren würde,  
- wie ein menschlicher Beobachter Bewegungen wahrnehmen könnte,  
- welche zusätzlichen Bedeutungen Bewegungen theoretisch haben könnten.

Algorithmische oder heuristische Ergänzungen sind ausgeschlossen.

### 3. Keine zeitlichen oder quantitativen Ableitungen ohne Quelle

Ohne explizite Angabe werden **keine Aussagen** über:

- Dauer bestimmter Bewegungen oder Prozesse,  
- Häufigkeiten von Zuständen,  
- durchschnittliche Verteilungen,  
- Übergangswahrscheinlichkeiten gemacht.

Diese Werte können nur angegeben werden, wenn sie direkt aus den Daten berechnet werden — und das erfolgt hier nicht.

### 4. Keine Spekulation über fehlende Szenarien oder Prozesszustände

Nur die offiziell dokumentierten Szenarien (S1–S8) und Prozesslabels (CC08–CC10) werden berücksichtigt. Es werden keine zusätzlichen Szenarien oder Prozessvarianten angenommen.

### 5. Keine Erweiterung der Semantik über das definierte Klassensystem hinaus

Die Semantik bleibt auf die 207 offiziell definierten Labels beschränkt. Es werden keine weiteren:

- Bewegungsvarianten,  
- Handpositionsarten,  
- Werkzeugkategorien,  
- räumlichen Orte,  
- Prozessschritte,  
- Auftragsnummern ergänzt.

### 6. Keine Interpretationen von IMU-Daten ohne explizite Beschreibung

Auch wenn IMU-Daten zur Validierung herangezogen werden, erfolgt hier **keine Ableitung zusätzlicher Bedeutungen** aus den Rohsignalen (z. B. keine Spekulation über konkrete Rotationswinkel oder Kraftverläufe), sofern diese nicht in der Dokumentation erklärt wurden.

### 7. Keine subjektive Interpretation menschlichen Verhaltens

Die Semantik beschreibt nur das physisch dokumentierte und annotierte Verhalten. Sie schließt ausdrücklich aus:

- psychologische Interpretationen,  
- Absichten der Subjekte,  
- strategische Entscheidungen,  
- hypothetische Gründe für Bewegungen oder Prozessentscheidungen.

### 8. Keine Kontextanreicherung über externe Wissensquellen

Die Semantik bleibt strikt auf den Datensatz beschränkt. Externe Informationen (z. B. allgemeines Wissen über Logistik, Ergonomie oder Lagerprozesse) werden nicht zur Bedeutungserweiterung hinzugezogen.

### 9. Keine Ergänzung unbekannter Werte

Wenn der Datensatz einen Zustand als „Unknown" oder „Another" klassifiziert (z. B. CL014 Another Main Activity, CL122 Another Mid-Level Process), wird **keine weitere Interpretation** vorgenommen.

### Fazit

Die Semantik des DaRa-Datensatzes ist vollständig definierbar, aber strikt auf belegte Informationen begrenzt. Sie bildet einen **präzisen, vollständigen, aber nicht spekulativen** Bedeutungsrahmen, der alle annotierten Zustände abdeckt — und ausschließlich diese.

---

## Verwendungshinweise

**Diese Datei nutzen für:**
- Verständnis der Frame-Semantik
- Abhängigkeiten zwischen Klassenkategorien
- Konsistenzregeln
- Interpretation der Annotation

**Nicht in dieser Datei:**
- Label-Definitionen → Siehe `class_hierarchy.md`
- Chunking-Logik → Siehe `chunking.md`
- BPMN-Prozesslogik → Siehe `dataset_core.md`
- Frame-Struktur → Siehe `data_structure.md`

---

**Skill-Version:** 1.1 (erweitert mit Semantik-Details)  
**Erstellt:** 05.12.2025  
**Quelle:** DaRa Dataset Description, Teil 6 – Semantik
