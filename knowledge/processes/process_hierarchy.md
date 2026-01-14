# DaRa Dataset – Prozess-Details

Diese Datei beschreibt die **vollständige Prozesshierarchie** des DaRa-Datensatzes mit allen drei Ebenen (High-Level, Mid-Level, Low-Level).

**Quelle:** DaRa Dataset Description (Stand 20.10.2025), Teil 8

---

## 8.1 Überblick

Die Prozessannotation im DaRa-Datensatz bildet die vollständige prozedurale Struktur der beobachteten logistischen Arbeitsabläufe ab. Sie beschreibt, **welcher Prozess zu welchem Zeitpunkt aktiv ist**, wie sich Prozesse in einzelne Phasen gliedern, wie sie sich voneinander unterscheiden und wie sie sich durch Bewegungs-, Objekt- und Kontextmuster erkennen lassen. Alle Prozessklassen sind vollständig annotiert und framegenau dokumentiert.

Die Prozesshierarchie besteht aus drei Ebenen:

- **High-Level Process (CC08)** – grobe Prozesskategorie wie Retrieval oder Storage.
- **Mid-Level Process (CC09)** – prozedurale Hauptphasen wie Travel Time, Pick Time oder Packing.
- **Low-Level Process (CC10)** – atomare, kleingranulare Handlungsschritte.

Diese Ebenen bilden zusammen die vollständige prozedurale Beschreibung aller Szenarien.

---

## 8.2 Prozesshierarchie (High-Level, Mid-Level, Low-Level)

Die Prozesshierarchie ist streng strukturiert und eindeutig definiert. Jede Ebene hat klar abgegrenzte Rollen und dient der Beschreibung von prozeduralen Zusammenhängen in unterschiedlicher Granularität.

### 8.2.1 High-Level Process (CC08)

Die höchste Ebene der Prozessannotation klassifiziert den übergeordneten logistischen Prozess. Es existieren vier High-Level-Prozesslabels:

- **CL110 | Retrieval** – Prozesse der Entnahme.
- **CL111 | Storage** – Prozesse der Einlagerung.
- **CL112 | Another High-Level Process** – alternative Prozesse außerhalb der Hauptpfade.
- **CL113 | High-Level Process Unknown** – Fälle ohne eindeutige Zuordnung.

**Eigenschaften:**

- Definiert den **globalen Aufgabenkontext** des Subjekts
- Bleibt typischerweise über längere Frame-Sequenzen stabil
- Wechsel zwischen Retrieval und Storage markieren signifikante Szenarioübergänge

---

### 8.2.2 Mid-Level Process (CC09)

Mid-Level-Prozesse gliedern die High-Level-Prozesse in logische Hauptphasen. Es existieren elf Mid-Level-Prozesslabels:

- **CL114 | Preparing Order** – Vorbereitende Tätigkeiten, z. B. Erhalt der Orderinformationen
- **CL115 | Picking – Travel Time** – Weg vom aktuellen Standort zum Zielregal innerhalb eines Retrieval-Prozesses
- **CL116 | Picking – Pick Time** – Entnahmephase direkt am Regal
- **CL117 | Unpacking** – Öffnen und Vorbereiten von Kartons in Storage- oder Packaging-Kontexten
- **CL118 | Packing** – Verpackungsschritte
- **CL119 | Storing – Travel Time** – Weg zum Einlagerungsort
- **CL120 | Storing – Store Time** – Einlagern am Regal
- **CL121 | Finalizing Order** – Abschließen eines Auftrags
- **CL122 | Another Mid-Level Process** – Mid-Level-Prozess außerhalb der definierten Kategorien
- **CL123 | Mid-Level Process Unknown** – Nicht eindeutig bestimmbarer Mid-Level-Prozess

**Eigenschaften:**

- Mid-Level-Prozesse beschreiben **klar abgegrenzte Arbeitsphasen**
- Bilden eine **Zwischenebene** zwischen High-Level (globaler Prozessrahmen) und Low-Level (konkrete Feinschritte)
- Jeder Frame besitzt genau einen Mid-Level-Prozess
- Mehrere Low-Level-Prozesse können einem Mid-Level-Prozess zugeordnet sein

**Beziehung zu High-Level:**

- CL114, CL115, CL116, CL118, CL121 → typisch für **CL110 Retrieval**
- CL117, CL119, CL120, CL121 → typisch für **CL111 Storage**
- CL121 (Finalizing) → gemeinsamer Abschluss für beide Pfade

---

### 8.2.3 Low-Level Process (CC10)

Low-Level-Prozesse sind die detailliertesten, atomaren Handlungseinheiten. Insgesamt sind 32 Low-Level-Prozesslabels definiert:

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

- CC10 enthält die **feinste** prozessorientierte Annotationsebene
- Ein Low-Level-Prozess beschreibt eine **konkrete, atomare Handlungseinheit**
- Pro Frame ist genau eine Low-Level-Prozessannotation aktiv
- Low-Level-Prozesse sind **nicht exklusiv** an einzelne Mid-Level-Prozesse gebunden

**Beziehung zu anderen Kategorien:**

- Low-Level-Prozesse sind **Mid-Level-Prozessen untergeordnet**
- Sie sind **High-Level-Prozessen indirekt zugeordnet**
- Sie korrelieren oft mit bestimmten Bewegungsmustern (CC01-CC05) und Tools (CC04-CC05)

---

## 8.3 Prozessdefinitionen

Dieser Abschnitt beschreibt die genaue Bedeutung der Prozesse, wie sie im Datensatz dokumentiert sind.

### 8.3.1 High-Level-Prozesse

**Retrieval (CL110)**
Beschreibt alle Tätigkeiten zur Entnahme von Artikeln aus Regalen, inklusive:

- Wege zum Lagerort
- Scans und Bestätigungen
- Entnahme der Artikel
- Rücktransport zur Base
- Ablage auf dem Cart

**Storage (CL111)**
Beschreibt alle Tätigkeiten zur Einlagerung von Artikeln, einschließlich:

- Öffnen von Kartons
- Vorbereitung der Artikel
- Transport zum Lagerort
- Platzierung im Regal
- Dokumentation

**Another High-Level Process (CL112)**
Umfasst alternative oder nicht standardisierte Prozessabläufe außerhalb der Hauptpfade Retrieval und Storage.

**High-Level Process Unknown (CL113)**
Wird verwendet, wenn der globale Prozesskontext nicht eindeutig bestimmbar ist.

---

### 8.3.2 Mid-Level-Prozesse

**Preparing Order (CL114)**
Vorbereitende Tätigkeiten zu Beginn eines Auftrags:

- Erhalt der Orderinformationen
- Abholen von Hardware (PDT, Scanner)
- Vorbereitung des Carts
- Initialisierung der IT-Systeme

**Picking – Travel Time (CL115)**
Bewegungsphase vom aktuellen Standort zum Zielregal:

- Walking entlang von Aisle Paths
- Navigation durch das Warehouse
- Mitführen des Carts
- Suche nach der Zielposition

**Picking – Pick Time (CL116)**
Eigentliche Entnahmephase direkt am Regal:

- Bending zum Erreichen der Artikel
- Scannen der Items oder Compartments
- Greifen und Entnehmen
- Confirming der Entnahme
- Ablage auf dem Cart

**Unpacking (CL117)**
Öffnen und Vorbereiten von Kartons:

- Opening Cardboard Box
- Removing Filling Material
- Sortieren der Inhalte
- Vorbereitung für Storage

**Packing (CL118)**
Verpackungsschritte:

- Filling mit Füllmaterial
- Sealing der Kartons
- Attaching Labels
- Vorbereitung für Transport

**Storing – Travel Time (CL119)**
Bewegung zum Einlagerungsort:

- Transport der Artikel
- Navigation zu Zielregalen
- Mitführen von Kartons/Items

**Storing – Store Time (CL120)**
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

Low-Level-Prozesse bilden die **präziseste Beschreibung der Tätigkeit** und werden framegenau annotiert.

---

## 8.4 Prozessübergänge und -logik

Prozessübergänge entstehen immer durch klar definierte semantische Änderungen. Die Übergänge sind nicht zeitlich, sondern inhaltlich motiviert.

### 1. Übergänge zwischen High-Level-Prozessen

Ein Wechsel zwischen Retrieval, Storage erfolgt nur, wenn:

- Die Aufgabenstellung wechselt (von Entnahme zu Einlagerung oder umgekehrt)
- Alle relevanten semantischen Klassen (CC01–CC12) konsistent darauf hinweisen
- Ein neues Szenario beginnt

**Typische Übergänge:**

- CL110 (Retrieval) → CL111 (Storage): Nach Abschluss aller Retrieval-Orders, Beginn Storage-Aufträge
- CL111 (Storage) → CL110 (Retrieval): Nach Abschluss Storage, neue Retrieval-Orders

---

### 2. Übergänge zwischen Mid-Level-Prozessen

Mid-Level-Prozesse folgen **klaren Pfaden** gemäß BPMN-Logik:

**Retrieval-Pfad:**
```
CL114 (Preparing) 
  → CL115 (Travel Time) 
  → CL116 (Pick Time) 
  → [Loop if more positions] 
  → CL118 (Packing) 
  → CL121 (Finalizing)
```

**Storage-Pfad:**
```
CL114 (Preparing)
  → CL117 (Unpacking) 
  → CL119 (Store Travel) 
  → CL120 (Store Time) 
  → [Loop if more positions] 
  → CL121 (Finalizing)
```

**Packaging-Sequenz:**
```
CL142 (Opening) 
  → CL145 (Filling) 
  → CL150 (Sealing) 
  → CL144 (Sorting)
```

---

### 3. Übergänge zwischen Low-Level-Prozessen

Low-Level-Prozesse ändern sich **häufig** (hohe Granularität). Jeder Wechsel markiert eine atomare Handlung.

**Typische Sequenzen:**

**Retrieval-Sequenz:**
```
CL137 (Moving to Position) 
  → CL139 (Retrieving Items) 
  → CL140 (Moving to Cart) 
  → CL151 (Placing in Cart)
```

**Storage-Sequenz:**
```
CL142 (Opening Box) 
  → CL143 (Disposing Material) 
  → CL137 (Moving to Position) 
  → CL138 (Placing on Rack)
```

**Packaging-Sequenz:**
```
CL142 (Opening) 
  → CL145 (Filling) 
  → CL146 (Printing Label) 
  → CL148 (Attaching Label) 
  → CL150 (Sealing)
```

---

### 4. Chunks als Prozessmikrostruktur

- Prozessphasen sind **stabil innerhalb eines Chunks**
- Ein Prozesswechsel (T8) führt **automatisch zu einem neuen Chunk**
- Die Chunk-Struktur ermöglicht präzise Analyse von Prozesssequenzen

---

## 8.5 Prozessrollen im Szenariokontext

Jedes Szenario besitzt eine charakteristische Prozessarchitektur.

### Retrieval-Szenarien (S1, S2, S3, S7)

**High-Level:** CL110 (Retrieval)

**Typische Mid-Level-Sequenzen:**

- CL114 (Preparing Order)
- CL115 (Travel Time) – wiederholt
- CL116 (Pick Time) – wiederholt
- CL118 (Packing) – optional
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
- CL119 (Store Travel Time) – wiederholt
- CL120 (Store Time) – wiederholt
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

## 8.6 Prozessabhängigkeiten zu Bewegung, Raum und Tools

Prozesse stehen in direkter Abhängigkeit zu anderen Klassen.

### Bewegungsabhängigkeiten (CC01–CC05)

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

### Raumabhängigkeiten (CC11–CC12)

**Travel Time:**

- Cross Aisle Paths (CL162-CL165, CL189-CL192)
- Aisle Paths (CL163-CL170, CL190-CL197)
- Paths between areas

**Pick/Store Time:**

- Aisle Paths (bei Regalen)
- Specific storage locations

**Packing:**

- Packing Area (CL159, CL186)
- Tables (stationär)

**Preparing/Finalizing:**

- Base (CL158, CL185)
- Office (CL155, CL182)

---

### Tool-Abhängigkeiten (CC04–CC05)

**Scanning-Aktivitäten:**

- Portable Data Terminal (CL052, CL087)
- Glove Scanner (in CC07)

**Pick/Store:**

- No Tool oder Pen (dokumentation)
- Items in Händen

**Packing:**

- Knife (CL057, CL092)
- Tape Dispenser (CL058, CL093)
- Bubble Wrap (CL062, CL097)

---

## 8.7 Prozesskonfiguration im Datensatz

Die Prozesskonfiguration im DaRa-Datensatz beschreibt, wie High-Level-, Mid-Level- und Low-Level-Prozesse im realen annotierten Material gemeinsam auftreten.

### Strukturprinzipien

- Alle Prozesskategorien (CC08, CC09, CC10) werden **framegenau** annotiert
- Jeder Frame enthält genau **einen High-Level**, **einen Mid-Level** und **einen Low-Level** Prozess
- Die Kombinationen spiegeln reale prozedurale Abläufe wider (BPMN-Modell)
- Die Prozessketten werden kontinuierlich und ohne Lücken abgebildet

### Allgemeine Konfigurationen

**High-Level bestimmt globalen Kontext:**

- CL110 (Retrieval)
- CL111 (Storage)
- CL112 (Another)
- CL113 (Unknown)

**Mid-Level strukturiert Arbeitsphasen:**

- Retrieval-Pfad: CL114–CL116, CL118
- Storage-Pfad: CL117, CL119, CL120
- Gemeinsam: CL121 (Finalizing)
- Sonder: CL122, CL123

**Low-Level = konkrete Handlungen:**

- Können in vielen Mid-Level-Kontexten auftreten
- Sind nicht exklusiv an einzelne Mid-Level gebunden

### Prozessfluss im Datensatz

Folgt exakt der BPMN-Logik:

1. **CL114 (Preparing Order)** → Start
2. Entscheidung: **Retrieval oder Storage**
3. Innerhalb des gewählten Pfads:
   - Travel Time
   - Pick/Store Time
   - Gateway: Weitere Positionen? → Loop
4. **CL121 (Finalizing Order)** → Gemeinsam
5. Gateway: Weitere Orders? → Loop zu Start oder Ende

### Auftreten mehrerer Szenarien

- Sessions enthalten **mehrere Szenarien**
- Szenarioübergänge sind **prozessgetrieben**
- Prozesse bilden **klare, kontinuierliche Sequenzen**

### Konsistente Eigenschaften

- Prozessannotationen sind über alle drei Subjekte einer Session **synchron**
- Alle Prozesslabels entsprechen **exakt den BPMN-Logiken**
- Prozesskonfiguration ist **vollständig durch Klassendateien bestimmt**

---

## Verwendungshinweise

**Diese Datei nutzen für:**

- Verständnis der Prozesshierarchie (CC08-CC10)
- Prozessübergänge und -logik
- Abhängigkeiten zu Bewegung, Raum, Tools
- Szenariospezifische Prozesskonfigurationen

**Nicht in dieser Datei:**

- BPMN-Grafik → Siehe `dataset_core.md`
- Label-Definitionen aller Kategorien → Siehe `class_hierarchy.md`
- Szenario-Details → Siehe `scenarios.md`
- Chunking-Logik → Siehe `chunking.md`

---

**Skill-Version:** 1.2 (erweitert mit Prozess-Details)  
**Erstellt:** 08.12.2025  
**Quelle:** DaRa Dataset Description, Teil 8 – Prozesse
