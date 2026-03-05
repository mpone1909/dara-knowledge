# Referenz: Dataset — Probanden, Sessions, Datenstruktur

**Version:** 6.1.4 (2026-03-05)
**Quelle:** DaRa Dataset Description (Stand 20.10.2025)
**Rückführung v6.1.2:** CSV-Spaltenformat, SARA-Details und Inter-Rater-Reliability aus v5.0 ergänzt
**Update v6.1.4:** Session-/Probanden-/Cart-Zuordnung (Cart Nummern 55/56/57) ergänzt

---

## 1. Probanden (S01–S18)

| Session | ID | Sex | Age | Weight | Height | Hand | Employment | Exp.Pick | Exp.Pack | Exp.Study |
|:--------|:---|:----|:----|:-------|:-------|:-----|:-----------|:---------|:---------|:----------|
| 1 | S01 | F | 32 | 68kg | 171cm | R | Student | 2 | 3 | 6 |
| 1 | S02 | M | 27 | 76kg | 167cm | R | Student | 3 | 6 | 6 |
| 1 | S03 | M | 64 | 69kg | 171cm | R | Employee | 6 | 5 | 5 |
| 2 | S04 | M | 31 | 85kg | 183cm | L | Employee | 5 | 4 | 6 |
| 2 | S05 | M | 67 | 100kg | 177cm | R | Retiree | 6 | 3 | 6 |
| 2 | S06 | M | 24 | 82kg | 178cm | R | Student | 4 | 6 | 6 |
| 3 | S07 | M | 41 | 70kg | 180cm | R | Employee | 6 | 5 | 6 |
| 3 | S08 | F | 29 | 62kg | 163cm | R | Student | 6 | 6 | 6 |
| 3 | S09 | M | 21 | 85kg | 180cm | R | Student | 6 | 6 | 6 |
| 4 | S10 | M | 28 | 85kg | 160cm | R | Student | 3 | 3 | 6 |
| 4 | S11 | M | 59 | 85kg | 178cm | R | Employee | 3 | 2 | 6 |
| 4 | S12 | M | 43 | 103kg | 186cm | R | Job seeker | 6 | 6 | 4 |
| 5 | S13 | F | 52 | 66kg | 175cm | R | Employee | 5 | 4 | 6 |
| 5 | S14 | M | 32 | 80kg | 176cm | R | Employee | 6 | 5 | 5 |
| 5 | S15 | M | 43 | 88kg | 177cm | R | Employee | 6 | 5 | 6 |
| 6 | S16 | M | 29 | 100kg | 175cm | R | Student | 6 | 3 | 6 |
| 6 | S17 | F | 25 | 75kg | 180cm | R | Employee | 6 | 5 | 6 |
| 6 | S18 | M | 26 | 80kg | 187cm | R | Student | 6 | 6 | 6 |

**Erfahrungsskala:** 1 = Extensive, 6 = None

**Zusammenfassung:**

- Geschlecht: 14M, 4F
- Händigkeit: 17R, 1L (S04)
- Beschäftigung: 7 Studenten, 8 Angestellte, 1 Rentner, 1 Arbeitssuchend
- Alter: 21 (S09) bis 67 (S05)
- Picking-Erfahrung: 61% (11/18) Level 6 (keine)

---

## 2. Sessions

**Definition:** Ein aufgezeichneter Block mit 3 Subjekten gleichzeitig.
6 Sessions insgesamt.

| Session | Subjekte |
|:--------|:---------|
| 1 | S01, S02, S03 |
| 2 | S04, S05, S06 |
| 3 | S07, S08, S09 |
| 4 | S10, S11, S12 |
| 5 | S13, S14, S15 |
| 6 | S16, S17, S18 |

### 2.1 Session-/Probanden-/Cart-Zuordnung

Die Cart-Nummer ist die physische Wagen-ID je Proband innerhalb einer Session.

| Session | SXY Bezeichnung | Cart Nummer |
|:--------|:----------------|:------------|
| 1 | S01 | 55 |
| 1 | S02 | 57 |
| 1 | S03 | 56 |
| 2 | S04 | 57 |
| 2 | S05 | 55 |
| 2 | S06 | 56 |
| 3 | S07 | 55 |
| 3 | S08 | 57 |
| 3 | S09 | 56 |
| 4 | S10 | 57 |
| 4 | S11 | 55 |
| 4 | S12 | 56 |
| 5 | S13 | 55 |
| 5 | S14 | 57 |
| 5 | S15 | 56 |
| 6 | S16 | 57 |
| 6 | S17 | 56 |
| 6 | S18 | 55 |

Aufzeichnung erfolgt synchron. Szenario-Reihenfolge war NICHT standardisiert
(variierte zwischen Sessions). Wiederholungen möglich.

**Nicht jeder Proband hat alle Szenarien S1–S8 durchlaufen.** Die Zuordnung
variiert erheblich je nach Session-Ablauf und Order/Prozess-Pairing.

---

## 3. Datenstruktur

### 3.1 Frame-Struktur

- **Framerate:** 30 fps (technisch 29,97 fps, für Modellierung auf 30 gerundet)
- **Annotation:** Binäre Vektoren (0/1) pro Frame pro Label
- **Synchronisation:** Alle 12 Kategorien synchron — gleiche Zeile = gleicher Zeitpunkt
- **CSV-Format:** Eine CSV-Datei pro Kategorie pro Proband

**Frame ↔ Zeit Umrechnung:**

| Frames | Zeit |
|:-------|:-----|
| 1 | 0,0333 s |
| 30 | 1 Sekunde |
| 1.800 | 1 Minute |
| 108.000 | 1 Stunde |

```text
Zeit_Sekunden = (Zeilennummer - 1) / 30
Frame_Nummer  = Zeit_Sekunden × 30
```

**Dateiname-Konvention:**
`Revised_Annotation__CC{NN}_{Kategoriename}__{SXX}.csv`

**WICHTIG:** Kategorie-Namen verwenden **Leerzeichen und Bindestriche**, NICHT Unterstriche.

| CC | Dateiname (Beispiel S12) |
|:---|:-------------------------|
| CC01 | `Revised_Annotation__CC01_Main Activity__S12.csv` |
| CC02 | `Revised_Annotation__CC02_Sub-Activity - Legs__S12.csv` |
| CC03 | `Revised_Annotation__CC03_Sub-Activity - Torso__S12.csv` |
| CC04 | `Revised_Annotation__CC04_Sub-Activity - Left Hand__S12.csv` |
| CC05 | `Revised_Annotation__CC05_Sub-Activity - Right Hand__S12.csv` |
| CC06 | `Revised_Annotation__CC06_Order__S12.csv` |
| CC07 | `Revised_Annotation__CC07_Information Technology__S12.csv` |
| CC08 | `Revised_Annotation__CC08_High-Level Process__S12.csv` |
| CC09 | `Revised_Annotation__CC09_Mid-Level Process__S12.csv` |
| CC10 | `Revised_Annotation__CC10_Low-Level Process__S12.csv` |
| CC11 | `Revised_Annotation__CC11_Location - Human__S12.csv` |
| CC12 | `Revised_Annotation__CC12_Location - Cart__S12.csv` |

Probanden: S01–S18 (18 Probanden × 12 CCs = 216 CSV-Dateien total)

**Hinweis zu CC12 vs. Cart Nummer:**

- Die `Cart Nummer` (55/56/57) ist Session-Metadaten zur Identifikation des physischen Wagens pro Proband.
- `CC12` enthält weiterhin die frameweise Wagenposition im Lager (CL181–CL207), nicht die Wagen-ID.

### 3.2 CSV-Spaltenformat (Detail)

Jede CSV-Datei hat folgendes Layout:

**Header (Zeile 1):** CL-Label-IDs mit Pipe-separiertem Labelnamen

```text
CL181|Transition between Areas,CL182|Office,CL183|Cart Area,...,CL207|Cart Location Unknown
```

**Daten (ab Zeile 2):** Binäre Werte (0/1) pro Label

```text
0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
...
```

| Element | Format | Beschreibung |
|:--------|:-------|:-------------|
| Spaltenheader | `CL{NNN}\|{Labelname}` | Label-ID + Klartextname, pipe-separiert |
| Datenzeilen | Binary (0/1) | Ein Wert pro Label-Spalte |
| Zeile 2 | = Frame 1 | Erste Datenzeile = erster Frame |
| Zeilennummer | = Synchronisation | Gleiche Zeile in allen 12 CSVs = gleicher Zeitpunkt |

**WICHTIG — Keine Frame- oder Timestamp-Spalte:**

- Es gibt **KEINE** `Frame`- oder `Timestamp`-Spalte in den CSV-Dateien
- Die Frame-Nummer ergibt sich implizit aus der Zeilennummer: `Frame = Zeilennummer - 1`
- Der Zeitstempel ergibt sich rechnerisch: `Timestamp = (Zeilennummer - 1) / 30.0` Sekunden

**Synchronisation über Dateien hinweg:**

- Zeile 2 (Frame 1) in `CC01_Main_Activity__S10.csv` entspricht **exakt dem gleichen Zeitpunkt**
  wie Zeile 2 in `CC12_Location_Cart__S10.csv` (und allen anderen CCs)
- Alle 12 CSV-Dateien eines Probanden haben die gleiche Anzahl Datenzeilen

**Wichtige Konventionen:**

- Pro Frame ist genau ein Label (bei Single-Select) oder eine gültige Kombination aktiv
- Leere Frames (alle 0) deuten auf Annotationslücken hin
- Die Spaltenreihenfolge entspricht der Label-ID-Reihenfolge (CL001 vor CL002 etc.)

### 3.3 Kategorien und Label-Anzahlen

| CC | Kategorie | Labels | Spalten |
|:---|:----------|:-------|:--------|
| CC01 | Main Activity | 15 | CL001–CL015 |
| CC02 | SubActivity Legs | 8 | CL016–CL023 |
| CC03 | SubActivity Torso | 6 | CL024–CL029 |
| CC04 | SubActivity Left Hand | 35 | CL030–CL064 |
| CC05 | SubActivity Right Hand | 35 | CL065–CL099 |
| CC06 | Order | 5 | CL100–CL104 |
| CC07 | Information Technology | 5 | CL105–CL109 |
| CC08 | HighLevel Process | 4 | CL110–CL113 |
| CC09 | MidLevel Process | 10 | CL114–CL123 |
| CC10 | LowLevel Process | 31 | CL124–CL154 |
| CC11 | Location Human | 26 | CL155–CL180 |
| CC12 | Location Cart | 27 | CL181–CL207 |

**Gesamt:** 207 Labels über 12 Kategorien

### 3.4 Frame-Zahlen (bekannte Probanden)

| Proband | Frames | Sekunden (~) | Minuten (~) |
|:--------|:-------|:-------------|:------------|
| S10 | 199.427 | 6.648 | 110,8 |
| S11 | 167.627 | 5.588 | 93,1 |
| S12 | 217.583 | 7.253 | 120,9 |

### 3.5 SARA-Annotationstool

**Tool:** SARA (Sensor-Based Activity Recognition Annotation) — webbasiertes
Annotationstool für multimodale Zeitreihendaten.

**Annotations-Workflow (mehrstufig):**

1. **Primär-Annotation:** Ein Annotator pro Kategorie setzt alle Labels für
   einen Probanden über die gesamte Session-Dauer
2. **Cross-Review:** Annotatoren von CC02–CC05 fungieren gleichzeitig als
   Revisoren für CC01 (gegenseitige Qualitätskontrolle)
3. **Dependency-Checks:** Im Tool implementierte Abhängigkeitsregeln
   erzwingen/verbieten bestimmte Label-Kombinationen automatisch:
   - CC01=Walking → CC02 muss Gait Cycle sein
   - CC01=Standing → CC02 muss Standing Still sein
   - CC01=Sitting → CC02 muss Sitting sein
4. **Revision:** Bei Inkonsistenzen wird der Primär-Annotator zur Korrektur
   aufgefordert

**Inter-Rater-Reliability:**

- Cohens Kappa nicht explizit berichtet, aber durch mehrstufigen Review-Prozess
  und automatische Dependency-Checks indirekt sichergestellt
- Höchste Konsistenz bei CC08–CC10 (Prozess-Labels) durch klare BPMN-Definition
- Niedrigste Konsistenz erwartet bei CC03 (Torso) aufgrund subjektiver
  Winkelschätzung (10° vs. 30°)

### 3.6 Annotationsqualität

- Annotatoren von CC02–CC05 fungieren gleichzeitig als Revisoren für CC01
- Abhängigkeiten (Dependencies) im SARA-Annotationstool implementiert
- QA: Bestimmte CC01-Labels erzwingen/verbieten bestimmte CC02–CC05-Labels

### 3.7 Datensatz-Gesamtumfang

| Dimension | Anzahl | Beschreibung |
|:----------|:-------|:-------------|
| Probanden | 18 | S01–S18 |
| Sessions | 6 | Je 3 Subjekte parallel |
| Szenarien | 8 (+Other) | S1–S8 + Wartezeiten |
| Klassenkategorien | 12 | CC01–CC12 |
| Labels gesamt | 207 | CL001–CL207 |
| CSV-Dateien | 216 | 18 × 12 |
| Gesamtdauer | ~32 Stunden | Alle Probanden zusammen |
| Geschätzte Frames | ~1,94 Mio. | Bei Ø 1,78h pro Proband |
| Speicherbedarf | ~1,15 GB | Reine CSV-Daten, unkomprimiert |

### 3.8 Semantische Abhängigkeiten (Kurzreferenz)

Die Semantik eines Frames ergibt sich aus der Kombination aller 12 CCs:

**Motorische Abhängigkeiten (CC01↔CC02↔CC03):**

- Walking (CC01) → Gait Cycle (CC02) + No/Slightly Bending (CC03)
- Handling Up/Center/Down (CC01) → häufig Bending/Rotation (CC03)
- Standing (CC01) → Standing Still (CC02)

**Hand-Prozess-Kopplung (CC04/CC05 ↔ CC10):**

- Retrieving Items (CL139) → Reaching/Grasping in CC04/CC05
- Opening Box (CL142) → Knife-Tool in CC04/CC05
- Tools sind prozessschritt-abhängig (→ phase4_bpmn_validation.md §11.1)

**Kontext-Prozess-Kopplung (CC06↔CC08, CC07↔CC08):**

- Retrieval nutzt CL105 (List+Pen), CL106 (Glove Scanner) oder CL107 (PDT)
- Storage nutzt typischerweise CL105 konstant
- Multi-Order (S7/S8): CL100 + CL101 gleichzeitig aktiv

**Räumliche Semantik (CC11↔CC12↔CC09):**

- CC11 (Human) und CC12 (Cart) können unterschiedlich sein
- CC09-Phase bestimmt erwartete Location (→ reference_validation_rules.md §5.4)

### 3.9 Datenfluss-Schema

```text
Session (3 Subjekte parallel)
    ↓
Subjekt S{XX} (eigener Datensatz)
    ↓
12 CSV-Dateien (CC01–CC12)
    ↓
Pro CSV: Zeile 1 = Header (CL-Labels), Zeile 2..N+1 = Frames
    ↓
Pro Frame: 0/1-Werte für alle Labels dieser Kategorie
```

---

## 4. Szenarien-Zuordnung zu Probanden

**WICHTIG:** Nicht jeder Proband (S01–S18) hat alle Szenarien (S1–S8)
durchlaufen. Die tatsächliche Zuordnung muss aus den Annotationsdaten
empirisch ermittelt werden (CC08 + CC06 + CC07 → Phase 1 Szenarioerkennung).

Bekannte Einschränkungen variieren je nach:

- Order-Labels: Welche CL100/CL101/CL102 sind aktiv?
- Prozess-Labels: CL110 (Retrieval) vs. CL111 (Storage)
- IT-System: CL105/CL106/CL107

---

## 5. Implikationen für Analyse

**Hohe Varianz in Prozesszeiten:** 61% der Probanden haben keine
Picking-Erfahrung → längere Haupttätigkeitszeiten, höhere Fehlerrate.

**Lernkurven-Effekt:** Erste Sessions können weniger effiziente
Bewegungsmuster zeigen. Multi-Order (S7/S8) besonders herausfordernd.

**Anthropometrische Extremwerte:**

- S10: 160cm (kleinster), erfahren (Level 3)
- S18: 187cm (größter), unerfahren (Level 6)
- S05: 67 Jahre, 100kg, unerfahren
- S12: 103kg (schwerster), einziger mit Studien-Erfahrung (Level 4)

---

## 6. Verwandte Dateien

| Datei | Inhalt | Wann nutzen |
|:------|:-------|:------------|
| `reference_labels.md` | 207 Label-Definitionen (CL001–CL207) | Label-Bedeutung, Hierarchien |
| `reference_validation_rules.md` | Frame-Level Validierung | Label-Konsistenz prüfen |
| `reference_chunking.md` | Chunk-Bildung aus Frames | Segmentierung, stabile Zustände |
| `reference_articles.md` | Artikel-Inventar mit IDs | Artikel-Details, Gewichte |
| `reference_warehouse.md` | Warehouse-Layout, Zonen | Räumliche Zuordnung |
| `phase1_scenario_recognition.md` | Szenarioerkennung | Welches Szenario hat ein Frame? |
| `phase2_refa_analysis.md` | REFA-Zeitanalyse | Zeitarten aus Frame-Daten |
| `phase4_bpmn_validation.md` | BPMN-Prozessvalidierung | CC09→CC10 Mapping prüfen |
