---
version: 5.0
status: finalisiert
created: 2026-02-05
---

# DaRa Dataset â€“ Query Patterns & Best Practices

Diese Datei enthÃ¤lt **hÃ¤ufige Fragetypen** und Best Practices fÃ¼r die Arbeit mit dem DaRa-Dataset-Skill.

---

## Ãœbersicht: Fragetypen

Der Skill deckt 7 Haupttypen von Anfragen ab:

1. **Strukturelle Fragen** â€“ Datensatzaufbau, Probanden, Sessions
2. **Label-Lookups** â€“ "Was ist CL052?"
3. **Kategorie-Queries** â€“ "Alle Labels fÃ¼r CC09?"
4. **Prozess-Logik** â€“ BPMN-Ablauf, Retrieval vs. Storage
5. **Datenstruktur** â€“ Frame-Synchronisation, CSV-Format
6. **Statistiken** â€“ Anzahl Probanden, Frames, Dauer
7. **Validierung** â€“ "Ist CL115 Teil von CC09?"

---

## 1. Strukturelle Fragen

### Typische Anfragen

- "Wie viele Probanden gibt es?"
- "Wie sind Sessions aufgebaut?"
- "Was sind die 8 Szenarien?"
- "Wie viele Klassenkategorien existieren?"

### Antwort-Workflow

**Schritt 1:** Identifiziere Thema

- Probanden â†’ `auxiliary_dataset_core_v5.0.md`, Abschnitt 1.4
- Sessions â†’ `auxiliary_dataset_core_v5.0.md`, Abschnitt 1.5 ODER `auxiliary_data_structure_v5.0.md`, Abschnitt 5.2
- Szenarien â†’ `auxiliary_dataset_core_v5.0.md` (kurze ErwÃ¤hnung)
- Kategorien â†’ `core_labels_207_v5.0.md`, Ãœberblick

**Schritt 2:** Extrahiere Fakten

- Nur dokumentierte Zahlen verwenden
- Tabellen direkt zitieren

**Schritt 3:** Formatiere Antwort

- Kurz und prÃ¤zise
- Quellenangabe (Dateiname + Abschnitt)

### Beispiel-Antworten

**Anfrage:** "Wie viele Probanden gibt es?"

**Antwort:**
Der DaRa-Datensatz umfasst **18 Probanden** (S01-S18).

**Demographische Verteilung:**

- 14 mÃ¤nnlich (M)
- 4 weiblich (F)
- 17 rechtshÃ¤ndig (R)
- 1 linkshÃ¤ndig (L) â€“ S04

*Quelle: auxiliary_dataset_core_v5.0.md, Abschnitt 1.4, Tabelle 4*

---

**Anfrage:** "Wie sind Sessions strukturiert?"

**Antwort:**
Eine **Session** ist ein zusammenhÃ¤ngender Aufzeichnungsblock mit folgenden Eigenschaften:

- **3 Subjekte gleichzeitig** â€“ Parallele Aufzeichnung
- **Mehrere Szenarien mÃ¶glich** â€“ Keine feste Sequenz
- **Synchroner Zeitstrahl** â€“ Alle 3 Subjekte teilen Frame-Indices
- **EigenstÃ¤ndige DatensÃ¤tze** â€“ Jedes Subjekt hat eigene 12 Klassendateien

Insgesamt gibt es **6 Sessions** im Datensatz (6 Sessions Ã— 3 Subjekte = 18 Probanden).

*Quelle: auxiliary_data_structure_v5.0.md, Abschnitt 5.2*

---

## 2. Label-Lookups

### Typische Anfragen

- "Was ist CL052?"
- "Was bedeutet Label CL115?"
- "Zeige mir Label CL024"

### Antwort-Workflow

**Schritt 1:** Ã–ffne `core_labels_207_v5.0.md`

**Schritt 2:** Suche Label-ID (z.B. "CL052")

**Schritt 3:** Extrahiere:

- Label-Name
- Kategorie (CC-ID)
- Unterkategorie (falls hierarchisch)

**Schritt 4:** Formatiere kompakt

### Beispiel-Antworten

**Anfrage:** "Was ist CL052?"

**Antwort:**
**CL052** ist **Portable Data Terminal** und gehÃ¶rt zur Kategorie **CC04 â€“ Sub-Activity: Left Hand**, Unterkategorie **Tool**.

Das Portable Data Terminal (PDT) ist ein mobiles ErfassungsgerÃ¤t fÃ¼r AuftrÃ¤ge und BestÃ¤tigungen.

*Quelle: core_labels_207_v5.0.md, CC04-Sektion*

---

**Anfrage:** "Was bedeutet CL115?"

**Antwort:**
**CL115** ist **Picking â€“ Travel Time** und gehÃ¶rt zur Kategorie **CC09 â€“ Mid-Level Process**.

Diese Phase beschreibt die Bewegung zum Lagerort wÃ¤hrend des Picking-Prozesses (Retrieval). Sie ist Teil des BPMN-Retrieval-Pfads zwischen "Preparing Order" und "Picking Pick Time".

*Quelle: core_labels_207_v5.0.md, CC09-Sektion + core_ground_truth_central_v5.0.md, BPMN Abschnitt 1.6*

---

## 3. Kategorie-Queries

### Typische Anfragen

- "Welche Labels gehÃ¶ren zu CC04?"
- "Zeige mir alle Mid-Level-Prozesse"
- "Wie viele Labels hat CC10?"

### Antwort-Workflow

**Schritt 1:** Ã–ffne `core_labels_207_v5.0.md`

**Schritt 2:** Navigiere zur Kategorie-Sektion

**Schritt 3:** Liste alle Labels auf

- Bei >10 Labels: Gruppiere nach Unterkategorien
- Bei hierarchischen Kategorien: Zeige Struktur

**Schritt 4:** ErgÃ¤nze Kontext (Label-Range, Anzahl)

### Beispiel-Antworten

**Anfrage:** "Welche Labels gehÃ¶ren zu CC09?"

**Antwort:**
**CC09 â€“ Mid-Level Process** umfasst **10 Labels** (CL114-CL123):

**Retrieval-Prozesse:**

- CL114 | Preparing Order
- CL115 | Picking â€“ Travel Time
- CL116 | Picking â€“ Pick Time
- CL118 | Packing

**Storage-Prozesse:**

- CL117 | Unpacking
- CL119 | Storing â€“ Travel Time
- CL120 | Storing â€“ Store Time

**Gemeinsame Prozesse:**

- CL121 | Finalizing Order

**Sonstige:**

- CL122 | Another Mid-Level Process
- CL123 | Mid-Level Process Unknown

*Quelle: core_labels_207_v5.0.md, CC09-Sektion*

---

**Anfrage:** "Wie viele Labels hat CC04?"

**Antwort:**
**CC04 â€“ Sub-Activity: Left Hand** hat **35 Labels** (CL030-CL064).

Die Kategorie ist **hierarchisch aufgebaut** in 4 Unterkategorien:

- **Primary Position:** 4 Labels (Upwards, Centered, Downwards, Unknown)
- **Type of Movement:** 6 Labels (Reaching/Grasping, Manipulating, Holding, etc.)
- **Object:** 12 Labels (Items, Cart, Box, etc.)
- **Tool:** 13 Labels (PDT, Scanner, Pen, Knife, etc.)

*Quelle: core_labels_207_v5.0.md, CC04-Sektion*

---

## 4. Prozess-Logik

### Typische Anfragen

- "ErklÃ¤re den Retrieval-Pfad"
- "Was passiert nach 'Picking Pick Time'?"
- "Unterschied zwischen Storage und Retrieval?"

### Antwort-Workflow

**Schritt 1:** Identifiziere Prozess-Level

- High-Level (CC08) â†’ Retrieval/Storage
- Mid-Level (CC09) â†’ Travel Time, Pick Time, etc.
- Low-Level (CC10) â†’ Retrieving Items, Moving, etc.

**Schritt 2:** Ã–ffne relevante Datei

- BPMN-Logik â†’ `core_ground_truth_central_v5.0.md`, Abschnitt 1.6
- Label-Details â†’ `core_labels_207_v5.0.md`, CC08-CC10

**Schritt 3:** ErklÃ¤re Sequenz

- Nutze BPMN-Struktur
- Zeige Entscheidungspunkte
- Markiere Schleifen

### Beispiel-Antworten

**Anfrage:** "Was passiert nach 'Picking Pick Time'?"

**Antwort:**
Nach **Picking Pick Time (CL116)** folgt ein **Entscheidungspunkt** im BPMN-Prozess:

**"All positions completed?"**

â†’ **NEIN:** Prozess kehrt zurÃ¼ck zu **Picking Travel Time (CL115)**
   - Weitere Items mÃ¼ssen gepickt werden
   - Schleife wiederholt sich

â†’ **JA:** Prozess geht weiter zu **Packing (CL118)**
   - Alle Items wurden entnommen
   - Verpackungsphase beginnt

Nach Packing folgt ein weiterer Entscheidungspunkt, bevor **Finalizing Order (CL121)** erreicht wird.

*Quelle: core_ground_truth_central_v5.0.md, Abschnitt 1.6 (BPMN Retrieval-Pfad)*

---

**Anfrage:** "Unterschied zwischen Retrieval und Storage?"

**Antwort:**
**Retrieval (CL110)** und **Storage (CL111)** sind die beiden **High-Level-Prozesse (CC08)** im DaRa-Datensatz:

**Retrieval (Kommissionierung):**

- **Ziel:** Waren aus Lager entnehmen
- **Mid-Level:** Preparing â†’ Picking Travel â†’ Picking Pick â†’ Packing â†’ Finalizing
- **Typische Low-Level:** Retrieving Items (CL139), Moving to Next Position (CL137)
- **IT:** Meist Portable Data Terminal (CL107)

**Storage (Einlagerung):**

- **Ziel:** Waren ins Lager einrÃ¤umen
- **Mid-Level:** Preparing â†’ Unpacking â†’ Storing Travel â†’ Storing Store â†’ Finalizing
- **Typische Low-Level:** Placing Items on Rack (CL138), Opening Cardboard Box (CL142)
- **IT:** Meist List and Pen (CL105) oder keine IT

Beide Prozesse folgen eigenen BPMN-Pfaden mit spezifischen Entscheidungspunkten und Schleifen.

*Quellen: core_ground_truth_central_v5.0.md (BPMN), core_labels_207_v5.0.md (Prozess-Labels)*

---

## 5. Datenstruktur-Fragen

### Typische Anfragen

- "Wie sind Frames synchronisiert?"
- "Wie viele Klassendateien hat ein Subjekt?"
- "Was ist die Frame-Rate?"

### Antwort-Workflow

**Schritt 1:** Ã–ffne `auxiliary_data_structure_v5.0.md`

**Schritt 2:** Navigiere zu relevanter Sektion

- Frames â†’ Abschnitt 5.6
- Klassendateien â†’ Abschnitt 5.5
- Synchronisation â†’ Abschnitt 5.7

**Schritt 3:** ErklÃ¤re technische Details

- Nutze konkrete Zahlen
- Zeige Beispiele (Frame-zu-Zeit-Umrechnung)

### Beispiel-Antworten

**Anfrage:** "Wie sind Frames Ã¼ber Klassendateien synchronisiert?"

**Antwort:**
**Frame-Synchronisation im DaRa-Datensatz:**

1. **Identische Zeilenzahl:** Alle 12 Klassendateien eines Subjekts haben die **gleiche Anzahl Zeilen** (Frames)

2. **Zeitliche Entsprechung:** 
   - Frame N in CC01 (Main Activity) = **genau derselbe Zeitpunkt** wie Frame N in CC04 (Left Hand), CC09 (Mid-Level), etc.
   - Beispiel: Frame 1000 beschreibt den **identischen Moment** Ã¼ber alle 12 Kategorien

3. **Frame-Rate:** 
   - **29,97 fps** (tatsÃ¤chlich)
   - **30 fps** (gerundet fÃ¼r Modellierung)
   - 1 Frame = 1/30 Sekunde â‰ˆ 0,0333 Sekunden

4. **VollstÃ¤ndigkeit:**
   - Keine LÃ¼cken zwischen Frames
   - Jeder Frame hat Annotationen in allen 12 Dateien

*Quelle: auxiliary_data_structure_v5.0.md, Abschnitte 5.5-5.7*

---

**Anfrage:** "Wie rechne ich Frames in Zeit um?"

**Antwort:**
**Frame-zu-Zeit-Umrechnung (bei 30 fps):**

**Formel:**
```
Zeit_in_Sekunden = Frame_Nummer / 30
Zeit_in_Minuten = Frame_Nummer / 1800
```

**Beispiele:**

- Frame 900 = 30 Sekunden
- Frame 1800 = 1 Minute
- Frame 3600 = 2 Minuten
- Frame 54000 = 30 Minuten
- Frame 108000 = 1 Stunde

**Umgekehrt (Zeit â†’ Frame):**
```
Frame_Nummer = Zeit_in_Sekunden Ã— 30
```

**Beispiel:**

- 5 Minuten = 300 Sekunden Ã— 30 = **Frame 9000**

*Quelle: auxiliary_data_structure_v5.0.md, Abschnitt 5.6*

---

## 6. Statistik-Fragen

### Typische Anfragen

- "Wie viele Probanden sind Studenten?"
- "Wie lange ist der Datensatz?"
- "Wie viele Labels gibt es insgesamt?"

### Antwort-Workflow

**Schritt 1:** Identifiziere Statistik-Typ

- Probanden-Demographie â†’ `auxiliary_dataset_core_v5.0.md`, Tabelle 4
- Datensatzumfang â†’ `auxiliary_data_structure_v5.0.md`, Abschnitt 5.8
- Label-Anzahl â†’ `core_labels_207_v5.0.md`, Ãœberblick

**Schritt 2:** Extrahiere oder berechne

- Direkt aus Tabellen ablesen
- Bei Bedarf aggregieren (z.B. Studenten zÃ¤hlen)

**Schritt 3:** PrÃ¤sentiere kompakt

### Beispiel-Antworten

**Anfrage:** "Wie viele Probanden sind Studenten?"

**Antwort:**
**7 Probanden** haben den BeschÃ¤ftigungsstatus "Student":

- S01 (F, 32 Jahre)
- S02 (M, 27 Jahre)
- S06 (M, 24 Jahre)
- S08 (F, 29 Jahre)
- S09 (M, 21 Jahre)
- S10 (M, 28 Jahre)
- S18 (M, 26 Jahre)

**Weitere BeschÃ¤ftigungsstatus:**

- 8 Angestellte (Employee)
- 1 Rentner (Retiree)
- 1 Arbeitssuchender (Job seeker)

*Quelle: auxiliary_dataset_core_v5.0.md, Abschnitt 1.4, Tabelle 4*

---

**Anfrage:** "Wie viele Labels gibt es insgesamt?"

**Antwort:**
Der DaRa-Datensatz umfasst **207 Labels** (CL001-CL207) Ã¼ber **12 Klassenkategorien**:

| Kategorie | Anzahl Labels |
|-----------|---------------|
| CC01 (Main Activity) | 15 |
| CC02 (Legs) | 8 |
| CC03 (Torso) | 6 |
| CC04 (Left Hand) | 35 |
| CC05 (Right Hand) | 35 |
| CC06 (Order) | 5 |
| CC07 (IT) | 5 |
| CC08 (High-Level) | 4 |
| CC09 (Mid-Level) | 10 |
| CC10 (Low-Level) | 31 |
| CC11 (Location Human) | 26 |
| CC12 (Location Cart) | 27 |
| **Gesamt** | **207** |

Durch Kombination aller Kategorien entstehen Ã¼ber **68.000 theoretisch mÃ¶gliche Zustandskombinationen**.

*Quelle: core_labels_207_v5.0.md, Statistik-Tabelle*

---

## 7. Validierungs-Fragen

### Typische Anfragen

- "GehÃ¶rt CL115 zu CC09?"
- "Ist 'Portable Data Terminal' ein Tool?"
- "Kann CC08 und CC09 gleichzeitig auftreten?"

### Antwort-Workflow

**Schritt 1:** Verstehe Frage-Typ

- Label-Zuordnung â†’ PrÃ¼fe Label-Range
- Semantische Validierung â†’ PrÃ¼fe Kategorie-Definition
- Logische Konsistenz â†’ PrÃ¼fe Datenstruktur

**Schritt 2:** Verifiziere

- Nutze `core_labels_207_v5.0.md` fÃ¼r Label-Checks
- Nutze `auxiliary_data_structure_v5.0.md` fÃ¼r Frame-Logik

**Schritt 3:** Antworte mit BegrÃ¼ndung

### Beispiel-Antworten

**Anfrage:** "GehÃ¶rt CL115 zu CC09?"

**Antwort:**
**Ja**, CL115 gehÃ¶rt zur Kategorie **CC09 â€“ Mid-Level Process**.

**Verifikation:**

- **CC09 Label-Range:** CL114-CL123
- **CL115:** "Picking â€“ Travel Time"
- **Position:** 2. Label in CC09 (nach CL114 Preparing Order)

CL115 beschreibt die Bewegungsphase wÃ¤hrend des Picking-Prozesses im Retrieval-Pfad.

*Quelle: core_labels_207_v5.0.md, CC09-Sektion*

---

**Anfrage:** "Ist 'Portable Data Terminal' ein Tool?"

**Antwort:**
**Ja**, "Portable Data Terminal" ist ein **Tool-Label** in zwei Kategorien:

- **CL052** â€“ CC04 (Left Hand) â†’ Tool-Unterkategorie
- **CL087** â€“ CC05 (Right Hand) â†’ Tool-Unterkategorie

ZusÃ¤tzlich erscheint es als:

- **CL107** â€“ CC07 (Information Technology)

Das PDT ist sowohl ein physisches Werkzeug (in den HÃ¤nden gehalten) als auch ein IT-System (fÃ¼r Auftragserfassung).

*Quelle: core_labels_207_v5.0.md, CC04/CC05/CC07-Sektionen*

---

**Anfrage:** "KÃ¶nnen CC08 und CC09 gleichzeitig auftreten?"

**Antwort:**
**Ja, immer**. CC08 (High-Level) und CC09 (Mid-Level) treten **zwingend gleichzeitig** in jedem Frame auf.

**BegrÃ¼ndung:**

- Jeder Frame enthÃ¤lt Annotationen aus **allen 12 Klassenkategorien**
- CC08 definiert den Makro-Prozess (Retrieval/Storage)
- CC09 definiert die Phase innerhalb dieses Prozesses
- CC10 definiert die atomare AktivitÃ¤t

**Beispiel:**

- **Frame 1000:**
  - CC08: CL110 (Retrieval)
  - CC09: CL115 (Picking Travel Time)
  - CC10: CL137 (Moving to Next Position)

Die drei Prozess-Kategorien bilden eine **Hierarchie**, nicht Alternativen.

*Quelle: auxiliary_data_structure_v5.0.md, Abschnitt 5.5 + core_labels_207_v5.0.md, Prozess-Hierarchie*

---

## Best Practices

### FÃ¼r prÃ¤zise Antworten

1. **Immer Quelle angeben:** Dateiname + Abschnitt
2. **Offizielle IDs nutzen:** "CL115" statt "Picking Travel"
3. **Keine Interpretation:** Nur dokumentierte Fakten
4. **Unsicherheiten markieren:** "Nicht dokumentiert" statt Vermutung

### FÃ¼r komplexe Queries

1. **Mehrere Dateien kombinieren:** BPMN (core_ground_truth_central_v5.0.md) + Labels (core_labels_207_v5.0.md)
2. **Hierarchie beachten:** CC08 â†’ CC09 â†’ CC10
3. **Kontext bereitstellen:** Retrieval vs. Storage unterscheiden

### FÃ¼r Fehler-Handling

**Bei fehlenden Informationen:**

- "Diese Information ist in der Dokumentation (Stand 2026-02-05) nicht enthalten"
- "Abschnitt X.X wurde noch nicht ausgearbeitet"
- "VerfÃ¼gbare Informationen: [Liste]"

**Bei widersprÃ¼chlichen Anfragen:**

- "Die Anfrage enthÃ¤lt einen logischen Widerspruch"
- "Beispiel: CC08 kann nicht gleichzeitig Retrieval UND Storage sein"

### FÃ¼r Effizienz

1. **HÃ¤ufige Queries cachen:** Anzahl Probanden (18), Labels (207), Sessions (6)
2. **Pattern erkennen:** "Was ist CL..." â†’ Immer core_labels_207_v5.0.md
3. **Shortcuts nutzen:** Quick Reference Tabellen

---

## Metadaten

**Skill-Version:** 5.0 (Konsolidierte Neufassung mit v5.0-Referenzen)  
**UrsprÃ¼ngliche Version:** 1.1 (22.01.2026)  
**Erstellt:** 04.02.2026  
**Status:** finalisiert  
**Verwendung:** ErgÃ¤nzung zu SKILL_v5.0.md fÃ¼r Query-Optimierung

**Ã„nderungen gegenÃ¼ber v1.1:**
- Alle Datei-Referenzen mit `_v5.0`-Endung versehen
- class_hierarchy.md â†’ core_labels_207_v5.0.md (wo anwendbar)
- dataset_core.md â†’ auxiliary_dataset_core_v5.0.md
- data_structure.md â†’ auxiliary_data_structure_v5.0.md
- Statistik-Tabelle (CC09): 11 â†’ 10 Labels korrigiert
