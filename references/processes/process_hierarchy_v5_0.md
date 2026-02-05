---
version: 5.0
status: finalisiert
created: 2026-02-04
---

# DaRa Dataset â€“ Prozess-Details

Diese Datei beschreibt die **vollstÃ¤ndige Prozesshierarchie** des DaRa-Datensatzes mit allen drei Ebenen (High-Level, Mid-Level, Low-Level).

**Quelle:** DaRa Dataset Description (Stand 20.10.2025), Teil 8

---

## 8.1 Ãœberblick

Die Prozessannotation im DaRa-Datensatz bildet die vollstÃ¤ndige prozedurale Struktur der beobachteten logistischen ArbeitsablÃ¤ufe ab. Sie beschreibt, **welcher Prozess zu welchem Zeitpunkt aktiv ist**, wie sich Prozesse in einzelne Phasen gliedern, wie sie sich voneinander unterscheiden und wie sie sich durch Bewegungs-, Objekt- und Kontextmuster erkennen lassen. Alle Prozessklassen sind vollstÃ¤ndig annotiert und framegenau dokumentiert.

Die Prozesshierarchie besteht aus drei Ebenen:

- **High-Level Process (CC08)** â€“ grobe Prozesskategorie wie Retrieval oder Storage.
- **Mid-Level Process (CC09)** â€“ prozedurale Hauptphasen wie Travel Time, Pick Time oder Packing.
- **Low-Level Process (CC10)** â€“ atomare, kleingranulare Handlungsschritte.

Diese Ebenen bilden zusammen die vollstÃ¤ndige prozedurale Beschreibung aller Szenarien.

---

## 8.2 Prozesshierarchie (High-Level, Mid-Level, Low-Level)

Die Prozesshierarchie ist streng strukturiert und eindeutig definiert. Jede Ebene hat klar abgegrenzte Rollen und dient der Beschreibung von prozeduralen ZusammenhÃ¤ngen in unterschiedlicher GranularitÃ¤t.

### 8.2.1 High-Level Process (CC08)

Die hÃ¶chste Ebene der Prozessannotation klassifiziert den Ã¼bergeordneten logistischen Prozess. Es existieren vier High-Level-Prozesslabels:

- **CL110 | Retrieval** â€“ Prozesse der Entnahme.
- **CL111 | Storage** â€“ Prozesse der Einlagerung.
- **CL112 | Another High-Level Process** â€“ alternative Prozesse auÃŸerhalb der Hauptpfade.
- **CL113 | High-Level Process Unknown** â€“ FÃ¤lle ohne eindeutige Zuordnung.

**Eigenschaften:**

- Definiert den **globalen Aufgabenkontext** des Subjekts
- Bleibt typischerweise Ã¼ber lÃ¤ngere Frame-Sequenzen stabil
- Wechsel zwischen Retrieval und Storage markieren signifikante SzenarioÃ¼bergÃ¤nge

---

### 8.2.2 Mid-Level Process (CC09)

Mid-Level-Prozesse gliedern die High-Level-Prozesse in logische Hauptphasen. Es existieren zehn Mid-Level-Prozesslabels:

- **CL114 | Preparing Order** â€“ Vorbereitende TÃ¤tigkeiten, z. B. Erhalt der Orderinformationen
- **CL115 | Picking â€“ Travel Time** â€“ Weg vom aktuellen Standort zum Zielregal innerhalb eines Retrieval-Prozesses
- **CL116 | Picking â€“ Pick Time** â€“ Entnahmephase direkt am Regal
- **CL117 | Unpacking** â€“ Ã–ffnen und Vorbereiten von Kartons in Storage- oder Packaging-Kontexten
- **CL118 | Packing** â€“ Verpackungsschritte
- **CL119 | Storing â€“ Travel Time** â€“ Weg zum Einlagerungsort
- **CL120 | Storing â€“ Store Time** â€“ Einlagern am Regal
- **CL121 | Finalizing Order** â€“ AbschlieÃŸen eines Auftrags
- **CL122 | Another Mid-Level Process** â€“ Mid-Level-Prozess auÃŸerhalb der definierten Kategorien
- **CL123 | Mid-Level Process Unknown** â€“ Nicht eindeutig bestimmbarer Mid-Level-Prozess

**Eigenschaften:**

- Mid-Level-Prozesse beschreiben **klar abgegrenzte Arbeitsphasen**
- Bilden eine **Zwischenebene** zwischen High-Level (globaler Prozessrahmen) und Low-Level (konkrete Feinschritte)
- Jeder Frame besitzt genau einen Mid-Level-Prozess
- Mehrere Low-Level-Prozesse kÃ¶nnen einem Mid-Level-Prozess zugeordnet sein

**Beziehung zu High-Level:**

- CL114, CL115, CL116, CL118, CL121 â†’ typisch fÃ¼r **CL110 Retrieval**
- CL117, CL119, CL120, CL121 â†’ typisch fÃ¼r **CL111 Storage**
- CL121 (Finalizing) â†’ gemeinsamer Abschluss fÃ¼r beide Pfade

---

### 8.2.3 Low-Level Process (CC10)

Low-Level-Prozesse sind die detailliertesten, atomaren Handlungseinheiten. Insgesamt sind 31 Low-Level-Prozesslabels definiert:

- **CL124** | Collecting Order and Hardware
- **CL125** | Collecting Cart
- **CL126** | Collecting Empty Cardboard Boxes
- **CL127** | Collecting Packed Cardboard Boxes
- **CL128** | Transporting a Cart to the Base
- **CL129** | Transporting to the Packaging/Sorting Area
- **CL130** | Handing Over Packed Cardboard Boxes
- **CL131** | Returning Empty Cardboard Boxes
- **CL132** | Returning Cart
- **CL133** | Returning Hardware
- **CL134** | Waiting
- **CL135** | Reporting and Clarifying the Incident
- **CL136** | Removing Cardboard Box/Item from the Cart
- **CL137** | Moving to the Next Position
- **CL138** | Placing Items on a Rack
- **CL139** | Retrieving Items
- **CL140** | Moving to a Cart
- **CL141** | Placing Cardboard Box/Item on a Table
- **CL142** | Opening Cardboard Box
- **CL143** | Disposing of Filling Material or Shipping Label
- **CL144** | Sorting
- **CL145** | Filling Cardboard Box with Filling Material
- **CL146** | Printing Shipping Label and Return Slip
- **CL147** | Preparing or Adding Return Label
- **CL148** | Attaching Shipping Label
- **CL149** | Removing Elastic Band
- **CL150** | Sealing Cardboard Box
- **CL151** | Placing Cardboard Box/Item in a Cart
- **CL152** | Tying Elastic Band Around Cardboard
- **CL153** | Another Low-Level Process
- **CL154** | Low-Level Process Unknown

**Eigenschaften:**

- CC10 enthÃ¤lt die **feinste** prozessorientierte Annotationsebene
- Ein Low-Level-Prozess beschreibt eine **konkrete, atomare Handlungseinheit**
- Pro Frame ist genau eine Low-Level-Prozessannotation aktiv
- Low-Level-Prozesse sind **nicht exklusiv** an einzelne Mid-Level-Prozesse gebunden

**Beziehung zu anderen Kategorien:**

- Low-Level-Prozesse sind **Mid-Level-Prozessen untergeordnet**
- Sie sind **High-Level-Prozessen indirekt zugeordnet**
- Sie korrelieren oft mit bestimmten Bewegungsmustern (CC01-CC05) und Objekt-Labels (CC06-CC07)

---

## 8.3 Prozessdefinitionen

Dieser Abschnitt beschreibt die genaue Bedeutung der Prozesse, wie sie im Datensatz dokumentiert sind.

### 8.3.1 High-Level-Prozesse

**Retrieval (CL110)**
Beschreibt alle TÃ¤tigkeiten zur Entnahme von Artikeln aus Regalen, inklusive:

- Wege zum Lagerort
- Scans und BestÃ¤tigungen
- Entnahme der Artikel
- RÃ¼cktransport zur Base
- Ablage auf dem Cart

**Storage (CL111)**
Beschreibt alle TÃ¤tigkeiten zur Einlagerung von Artikeln, einschlieÃŸlich:

- Ã–ffnen von Kartons
- Vorbereitung der Artikel
- Transport zum Lagerort
- Platzierung im Regal
- Dokumentation

**Another High-Level Process (CL112)**
Umfasst alternative oder nicht standardisierte ProzessablÃ¤ufe auÃŸerhalb der Hauptpfade Retrieval und Storage.

**High-Level Process Unknown (CL113)**
Wird verwendet, wenn der globale Prozesskontext nicht eindeutig bestimmbar ist.

---

### 8.3.2 Mid-Level-Prozesse

**Preparing Order (CL114)**
Vorbereitende TÃ¤tigkeiten zu Beginn eines Auftrags:

- Erhalt der Orderinformationen
- Abholen von Hardware (PDT, Scanner)
- Vorbereitung des Carts
- Initialisierung der IT-Systeme

**Picking â€“ Travel Time (CL115)**
Bewegungsphase vom aktuellen Standort zum Zielregal:

- Walking entlang von Aisle Paths
- Navigation durch das Warehouse
- MitfÃ¼hren des Carts
- Suche nach der Zielposition

**Picking â€“ Pick Time (CL116)**
Eigentliche Entnahmephase direkt am Regal:

- Bending zum Erreichen der Artikel
- Scannen der Items oder Compartments
- Greifen und Entnehmen
- Confirming der Entnahme
- Ablage auf dem Cart

**Unpacking (CL117)**
Ã–ffnen und Vorbereiten von Kartons:

- Opening Cardboard Box
- Removing Filling Material
- Sortieren der Inhalte
- Vorbereitung fÃ¼r Storage

**Packing (CL118)**
Verpackungsschritte:

- Filling mit FÃ¼llmaterial
- Sealing der Kartons
- Attaching Labels
- Vorbereitung fÃ¼r Transport

**Storing â€“ Travel Time (CL119)**
Bewegung zum Einlagerungsort:

- Transport der Artikel
- Navigation zu Zielregalen
- MitfÃ¼hren von Kartons/Items

**Storing â€“ Store Time (CL120)**
Einlagerungsphase am Regal:

- Placing Items on Rack
- Positionierung in Compartments
- Dokumentation der Einlagerung

**Finalizing Order (CL121)**
Abschluss eines Auftrags:

- Returning Hardware
- Returning Cart
- Handing Over Results
- Dokumentation des Abschlusses

---

### 8.3.3 Low-Level-Prozesse (Detailliert)

Die Low-Level-Prozesse beschreiben atomare Einzelschritte. Wichtigste Kategorien:

**Transport & Bewegung:**

- CL125: Collecting Cart
- CL128: Transporting Cart to Base
- CL129: Transporting to Packaging/Sorting Area
- CL137: Moving to Next Position
- CL140: Moving to Cart

**Handling & Manipulation:**

- CL136: Removing Cardboard Box/Item from Cart
- CL138: Placing Items on Rack
- CL139: Retrieving Items
- CL141: Placing Cardboard Box/Item on Table
- CL151: Placing Cardboard Box/Item in Cart

**Packaging Operations:**

- CL142: Opening Cardboard Box
- CL143: Disposing of Filling Material
- CL145: Filling Cardboard Box
- CL149: Removing Elastic Band
- CL150: Sealing Cardboard Box
- CL152: Tying Elastic Band

**Documentation & IT:**

- CL146: Printing Shipping Label
- CL147: Preparing Return Label
- CL148: Attaching Shipping Label

**Administrative:**

- CL124: Collecting Order and Hardware
- CL133: Returning Hardware
- CL134: Waiting
- CL135: Reporting Incident

**Processing:**

- CL144: Sorting

Low-Level-Prozesse bilden die **prÃ¤ziseste Beschreibung der TÃ¤tigkeit** und werden framegenau annotiert.

---

## 8.4 ProzessÃ¼bergÃ¤nge und -logik

ProzessÃ¼bergÃ¤nge entstehen immer durch klar definierte semantische Ã„nderungen. Die ÃœbergÃ¤nge sind nicht zeitlich, sondern inhaltlich motiviert.

### 1. ÃœbergÃ¤nge zwischen High-Level-Prozessen

Ein Wechsel zwischen Retrieval, Storage erfolgt nur, wenn:

- Die Aufgabenstellung wechselt (von Entnahme zu Einlagerung oder umgekehrt)
- Ein neuer Vorgang beginnt oder endet
- Der Kontext sich grundlegend verschiebt

**Beispiel:** Retrieval (CL110) â†’ Storage (CL111) bei Lagerbestands-Umschlag

---

### 2. ÃœbergÃ¤nge zwischen Mid-Level-Prozessen

Mid-Level-Prozesse wechseln **hÃ¤ufiger** als High-Level (ca. alle 10-30 Sekunden). Typische Sequenzen:

**Retrieval-Sequenz:**
```
CL114 (Preparing Order) 
  â†’ CL115 (Travel Time) 
  â†’ CL116 (Pick Time) 
  â†’ [Loop if more positions] 
  â†’ CL119 (Store Travel) 
  â†’ CL120 (Store Time) 
  â†’ [Loop if more positions] 
  â†’ CL121 (Finalizing)
```

**Packaging-Sequenz:**
```
CL142 (Opening) 
  â†’ CL145 (Filling) 
  â†’ CL150 (Sealing) 
  â†’ CL144 (Sorting)
```

---

### 3. ÃœbergÃ¤nge zwischen Low-Level-Prozessen

Low-Level-Prozesse Ã¤ndern sich **hÃ¤ufig** (hohe GranularitÃ¤t). Jeder Wechsel markiert eine atomare Handlung.

**Typische Sequenzen:**

**Retrieval-Sequenz:**
```
CL137 (Moving to Position) 
  â†’ CL139 (Retrieving Items) 
  â†’ CL140 (Moving to Cart) 
  â†’ CL151 (Placing in Cart)
```

**Storage-Sequenz:**
```
CL142 (Opening Box) 
  â†’ CL143 (Disposing Material) 
  â†’ CL137 (Moving to Position) 
  â†’ CL138 (Placing on Rack)
```

**Packaging-Sequenz:**
```
CL142 (Opening) 
  â†’ CL145 (Filling) 
  â†’ CL146 (Printing Label) 
  â†’ CL148 (Attaching Label) 
  â†’ CL150 (Sealing)
```

---

### 4. Chunks als Prozessmikrostruktur

- Prozessphasen sind **stabil innerhalb eines Chunks**
- Ein Prozesswechsel (T8) fÃ¼hrt **automatisch zu einem neuen Chunk**
- Die Chunk-Struktur ermÃ¶glicht prÃ¤zise Analyse von Prozesssequenzen

---

## 8.5 Prozessrollen im Szenariokontext

Jedes Szenario besitzt eine charakteristische Prozessarchitektur.

### Retrieval-Szenarien (S1, S2, S3, S7)

**High-Level:** CL110 (Retrieval)

**Typische Mid-Level-Sequenzen:**

- CL114 (Preparing Order)
- CL115 (Travel Time) â€“ wiederholt
- CL116 (Pick Time) â€“ wiederholt
- CL118 (Packing) â€“ optional
- CL121 (Finalizing Order)

**Typische Low-Level:**

- CL137 (Moving to Next Position)
- CL139 (Retrieving Items)
- CL151 (Placing in Cart)
- Scanning & Confirming (in CC01)

---

### Storage-Szenarien (S4, S5, S8)

**High-Level:** CL111 (Storage)

**Typische Mid-Level-Sequenzen:**

- CL114 (Preparing Order)
- CL117 (Unpacking)
- CL119 (Store Travel Time) â€“ wiederholt
- CL120 (Store Time) â€“ wiederholt
- CL121 (Finalizing Order)

**Typische Low-Level:**

- CL142 (Opening Cardboard Box)
- CL143 (Disposing Material)
- CL138 (Placing Items on Rack)
- CL133 (Returning Hardware)

---

### Packaging/Sorting (S6)

**High-Level:** Variabel (oft CL112 oder Teil von Retrieval/Storage)

**Typische Mid-Level:**

- CL118 (Packing)

**Intensive Tool-Nutzung:**

- Knife (CL057)
- Tape Dispenser (CL058)
- Bubble Wrap (CL062)

**Typische Low-Level:**

- CL142 (Opening)
- CL145 (Filling)
- CL146 (Printing Label)
- CL148 (Attaching Label)
- CL150 (Sealing)
- CL144 (Sorting)

---

## 8.6 ProzessabhÃ¤ngigkeiten zu Bewegung, Raum und Tools

Prozesse stehen in direkter AbhÃ¤ngigkeit zu anderen Klassen.

### BewegungsabhÃ¤ngigkeiten (CC01â€“CC05)

**Travel Time (CL115, CL119):**

- Typisch: Walking (CL011)
- Typisch: Gait Cycle (CL016)
- Typisch: No Bending / Slightly Bending (CL024-CL025)
- Cart Movement oft aktiv

**Pick Time (CL116) / Store Time (CL120):**

- Typisch: Handling activities (CL007-CL009)
- Typisch: Strongly Bending (CL026)
- Typisch: Reaching/Grasping (CL034, CL069)
- Hand-Object-Interaktionen aktiv

**Packing (CL118):**

- Typisch: Standing (CL012)
- Typisch: Manipulating hands (CL035, CL070)
- Intensive Tool-Nutzung

---

### RaumabhÃ¤ngigkeiten (CC11â€“CC12)

**Travel Time:**

- Cross Aisle Paths (CL162-CL165, CL189-CL192)
- Aisle Paths (CL163-CL170, CL190-CL197)
- Paths between areas

**Pick/Store Time:**

- Aisle Paths (bei Regalen)
- Specific storage locations

**Packing:**

- Packing Area (CL159, CL186)
- Tables (stationÃ¤r)

**Preparing/Finalizing:**

- Base (CL158, CL185)
- Office (CL155, CL182)

---

### Tool-AbhÃ¤ngigkeiten (CC04â€“CC05)

**Scanning-AktivitÃ¤ten:**

- Portable Data Terminal (CL052, CL087)
- Glove Scanner (in CC07)

**Pick/Store:**

- No Tool oder Pen (dokumentation)
- Items in HÃ¤nden

**Packing:**

- Knife (CL057, CL092)
- Tape Dispenser (CL058, CL093)
- Bubble Wrap (CL062, CL097)

---

## 8.7 Prozesskonfiguration im Datensatz

Die Prozesskonfiguration im DaRa-Datensatz beschreibt, wie High-Level-, Mid-Level- und Low-Level-Prozesse im realen annotierten Material gemeinsam auftreten.

### Strukturprinzipien

- Alle Prozesskategorien (CC08, CC09, CC10) werden **framegenau** annotiert
- Jeder Frame enthÃ¤lt genau **einen High-Level**, **einen Mid-Level** und **einen Low-Level** Prozess
- Die Kombinationen spiegeln reale prozedurale AblÃ¤ufe wider (BPMN-Modell)
- Die Prozessketten werden kontinuierlich und ohne LÃ¼cken abgebildet

### Allgemeine Konfigurationen

**High-Level bestimmt globalen Kontext:**

- CL110 (Retrieval)
- CL111 (Storage)
- CL112 (Another)
- CL113 (Unknown)

**Mid-Level strukturiert Arbeitsphasen:**

- Retrieval-Pfad: CL114â€“CL116, CL118
- Storage-Pfad: CL117, CL119, CL120
- Gemeinsam: CL121 (Finalizing)
- Sonder: CL122, CL123

**Low-Level = konkrete Handlungen:**

- KÃ¶nnen in vielen Mid-Level-Kontexten auftreten
- Sind nicht exklusiv an einzelne Mid-Level gebunden

### Prozessfluss im Datensatz

Folgt exakt der BPMN-Logik:

1. **CL114 (Preparing Order)** â†’ Start
2. Entscheidung: **Retrieval oder Storage**
3. Innerhalb des gewÃ¤hlten Pfads:
   - Travel Time
   - Pick/Store Time
   - Gateway: Weitere Positionen? â†’ Loop
4. **CL121 (Finalizing Order)** â†’ Gemeinsam
5. Gateway: Weitere Orders? â†’ Loop zu Start oder Ende

### Auftreten mehrerer Szenarien

- Sessions enthalten **mehrere Szenarien**
- SzenarioÃ¼bergÃ¤nge sind **prozessgetrieben**
- Prozesse bilden **klare, kontinuierliche Sequenzen**

### Konsistente Eigenschaften

- Prozessannotationen sind Ã¼ber alle drei Subjekte einer Session **synchron**
- Alle Prozesslabels entsprechen **exakt den BPMN-Logiken**
- Prozesskonfiguration ist **vollstÃ¤ndig durch Klassendateien bestimmt**

---

## Verwendungshinweise

**Diese Datei nutzen fÃ¼r:**

- VerstÃ¤ndnis der Prozesshierarchie (CC08-CC10)
- ProzessÃ¼bergÃ¤nge und -logik
- AbhÃ¤ngigkeiten zu Bewegung, Raum, Tools
- Szenariospezifische Prozesskonfigurationen

**Nicht in dieser Datei:**

- BPMN-Grafik â†’ Siehe [dataset_core_v5.0.md](../auxiliary/dataset_core_v5.0.md)
- Label-Definitionen â†’ Siehe [labels_207_v5.0.md](../core/labels_207_v5.0.md)
- Szenario-Details â†’ Siehe [ground_truth_central_v5.0.md](../core/ground_truth_central_v5.0.md)
- Chunking-Logik â†’ Siehe [chunking_v5.0.md](../auxiliary/chunking_v5.0.md)

---

**Skill-Version:** 1.4 (korrigierte Label-Anzahlen, aktualisierte Verweise, konzeptuelle Korrektur CC04-CC05)  
**Erstellt:** 08.12.2025  
**Update:** 04.02.2026  
**Quelle:** DaRa Dataset Description, Teil 8 â€“ Prozesse


---

## Validierung und Sequenzregeln

Die Prozessabfolgen mÃ¼ssen konsistent mit den **Validierungsregeln** sein. Siehe `core_validation_rules_v5_0.md` fÃ¼r:
- Master-Slave-AbhÃ¤ngigkeiten zwischen Prozessebenen (CC08 â†’ CC09 â†’ CC10)
- Sequenzvalidierung: Welche Prozesswechsel sind zulÃ¤ssig?
- Fehlerszenarien bei ungÃ¼ltigen ProzessÃ¼bergÃ¤ngen
