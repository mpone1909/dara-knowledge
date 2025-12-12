# DaRa Dataset – Query Patterns & Best Practices

Diese Datei enthält **häufige Fragetypen** und Best Practices für die Arbeit mit dem DaRa-Dataset-Skill.

---

## Übersicht: Fragetypen

Der Skill deckt 7 Haupttypen von Anfragen ab:

1. **Strukturelle Fragen** – Datensatzaufbau, Probanden, Sessions
2. **Label-Lookups** – "Was ist CL052?"
3. **Kategorie-Queries** – "Alle Labels für CC09?"
4. **Prozess-Logik** – BPMN-Ablauf, Retrieval vs. Storage
5. **Datenstruktur** – Frame-Synchronisation, CSV-Format
6. **Statistiken** – Anzahl Probanden, Frames, Dauer
7. **Validierung** – "Ist CL115 Teil von CC09?"

---

## 1. Strukturelle Fragen

### Typische Anfragen

- "Wie viele Probanden gibt es?"
- "Wie sind Sessions aufgebaut?"
- "Was sind die 8 Szenarien?"
- "Wie viele Klassenkategorien existieren?"

### Antwort-Workflow

**Schritt 1:** Identifiziere Thema
- Probanden → `dataset_core.md`, Abschnitt 1.4
- Sessions → `dataset_core.md`, Abschnitt 1.5 ODER `data_structure.md`, Abschnitt 5.2
- Szenarien → `dataset_core.md` (kurze Erwähnung)
- Kategorien → `class_hierarchy.md`, Überblick

**Schritt 2:** Extrahiere Fakten
- Nur dokumentierte Zahlen verwenden
- Tabellen direkt zitieren

**Schritt 3:** Formatiere Antwort
- Kurz und präzise
- Quellenangabe (Dateiname + Abschnitt)

### Beispiel-Antworten

**Anfrage:** "Wie viele Probanden gibt es?"

**Antwort:**
Der DaRa-Datensatz umfasst **18 Probanden** (S01-S18).

**Demographische Verteilung:**
- 14 männlich (M)
- 4 weiblich (F)
- 17 rechtshändig (R)
- 1 linkshändig (L) – S04

*Quelle: dataset_core.md, Abschnitt 1.4, Tabelle 4*

---

**Anfrage:** "Wie sind Sessions strukturiert?"

**Antwort:**
Eine **Session** ist ein zusammenhängender Aufzeichnungsblock mit folgenden Eigenschaften:

- **3 Subjekte gleichzeitig** – Parallele Aufzeichnung
- **Mehrere Szenarien möglich** – Keine feste Sequenz
- **Synchroner Zeitstrahl** – Alle 3 Subjekte teilen Frame-Indices
- **Eigenständige Datensätze** – Jedes Subjekt hat eigene 12 Klassendateien

Insgesamt gibt es **6 Sessions** im Datensatz (6 Sessions × 3 Subjekte = 18 Probanden).

*Quelle: data_structure.md, Abschnitt 5.2*

---

## 2. Label-Lookups

### Typische Anfragen

- "Was ist CL052?"
- "Was bedeutet Label CL115?"
- "Zeige mir Label CL024"

### Antwort-Workflow

**Schritt 1:** Öffne `class_hierarchy.md`

**Schritt 2:** Suche Label-ID (z.B. "CL052")

**Schritt 3:** Extrahiere:
- Label-Name
- Kategorie (CC-ID)
- Unterkategorie (falls hierarchisch)

**Schritt 4:** Formatiere kompakt

### Beispiel-Antworten

**Anfrage:** "Was ist CL052?"

**Antwort:**
**CL052** ist **Portable Data Terminal** und gehört zur Kategorie **CC04 – Sub-Activity: Left Hand**, Unterkategorie **Tool**.

Das Portable Data Terminal (PDT) ist ein mobiles Erfassungsgerät für Aufträge und Bestätigungen.

*Quelle: class_hierarchy.md, CC04-Sektion*

---

**Anfrage:** "Was bedeutet CL115?"

**Antwort:**
**CL115** ist **Picking – Travel Time** und gehört zur Kategorie **CC09 – Mid-Level Process**.

Diese Phase beschreibt die Bewegung zum Lagerort während des Picking-Prozesses (Retrieval). Sie ist Teil des BPMN-Retrieval-Pfads zwischen "Preparing Order" und "Picking Pick Time".

*Quelle: class_hierarchy.md, CC09-Sektion + dataset_core.md, BPMN Abschnitt 1.6*

---

## 3. Kategorie-Queries

### Typische Anfragen

- "Welche Labels gehören zu CC04?"
- "Zeige mir alle Mid-Level-Prozesse"
- "Wie viele Labels hat CC10?"

### Antwort-Workflow

**Schritt 1:** Öffne `class_hierarchy.md`

**Schritt 2:** Navigiere zur Kategorie-Sektion

**Schritt 3:** Liste alle Labels auf
- Bei >10 Labels: Gruppiere nach Unterkategorien
- Bei hierarchischen Kategorien: Zeige Struktur

**Schritt 4:** Ergänze Kontext (Label-Range, Anzahl)

### Beispiel-Antworten

**Anfrage:** "Welche Labels gehören zu CC09?"

**Antwort:**
**CC09 – Mid-Level Process** umfasst **11 Labels** (CL114-CL123):

**Retrieval-Prozesse:**
- CL114 | Preparing Order
- CL115 | Picking – Travel Time
- CL116 | Picking – Pick Time
- CL118 | Packing

**Storage-Prozesse:**
- CL117 | Unpacking
- CL119 | Storing – Travel Time
- CL120 | Storing – Store Time

**Gemeinsame Prozesse:**
- CL121 | Finalizing Order

**Sonstige:**
- CL122 | Another Mid-Level Process
- CL123 | Mid-Level Process Unknown

*Quelle: class_hierarchy.md, CC09-Sektion*

---

**Anfrage:** "Wie viele Labels hat CC04?"

**Antwort:**
**CC04 – Sub-Activity: Left Hand** hat **35 Labels** (CL030-CL064).

Die Kategorie ist **hierarchisch aufgebaut** in 4 Unterkategorien:
- **Primary Position:** 4 Labels (Upwards, Centered, Downwards, Unknown)
- **Type of Movement:** 6 Labels (Reaching/Grasping, Manipulating, Holding, etc.)
- **Object:** 12 Labels (Items, Cart, Box, etc.)
- **Tool:** 13 Labels (PDT, Scanner, Pen, Knife, etc.)

*Quelle: class_hierarchy.md, CC04-Sektion*

---

## 4. Prozess-Logik

### Typische Anfragen

- "Erkläre den Retrieval-Pfad"
- "Was passiert nach 'Picking Pick Time'?"
- "Unterschied zwischen Storage und Retrieval?"

### Antwort-Workflow

**Schritt 1:** Identifiziere Prozess-Level
- High-Level (CC08) → Retrieval/Storage
- Mid-Level (CC09) → Travel Time, Pick Time, etc.
- Low-Level (CC10) → Retrieving Items, Moving, etc.

**Schritt 2:** Öffne relevante Datei
- BPMN-Logik → `dataset_core.md`, Abschnitt 1.6
- Label-Details → `class_hierarchy.md`, CC08-CC10

**Schritt 3:** Erkläre Sequenz
- Nutze BPMN-Struktur
- Zeige Entscheidungspunkte
- Markiere Schleifen

### Beispiel-Antworten

**Anfrage:** "Was passiert nach 'Picking Pick Time'?"

**Antwort:**
Nach **Picking Pick Time (CL116)** folgt ein **Entscheidungspunkt** im BPMN-Prozess:

**"All positions completed?"**

→ **NEIN:** Prozess kehrt zurück zu **Picking Travel Time (CL115)**
   - Weitere Items müssen gepickt werden
   - Schleife wiederholt sich

→ **JA:** Prozess geht weiter zu **Packing (CL118)**
   - Alle Items wurden entnommen
   - Verpackungsphase beginnt

Nach Packing folgt ein weiterer Entscheidungspunkt, bevor **Finalizing Order (CL121)** erreicht wird.

*Quelle: dataset_core.md, Abschnitt 1.6 (BPMN Retrieval-Pfad)*

---

**Anfrage:** "Unterschied zwischen Retrieval und Storage?"

**Antwort:**
**Retrieval (CL110)** und **Storage (CL111)** sind die beiden **High-Level-Prozesse (CC08)** im DaRa-Datensatz:

**Retrieval (Kommissionierung):**
- **Ziel:** Waren aus Lager entnehmen
- **Mid-Level:** Preparing → Picking Travel → Picking Pick → Packing → Finalizing
- **Typische Low-Level:** Retrieving Items (CL139), Moving to Next Position (CL137)
- **IT:** Meist Portable Data Terminal (CL107)

**Storage (Einlagerung):**
- **Ziel:** Waren ins Lager einräumen
- **Mid-Level:** Preparing → Unpacking → Storing Travel → Storing Store → Finalizing
- **Typische Low-Level:** Placing Items on Rack (CL138), Opening Cardboard Box (CL142)
- **IT:** Meist List and Pen (CL105) oder keine IT

Beide Prozesse folgen eigenen BPMN-Pfaden mit spezifischen Entscheidungspunkten und Schleifen.

*Quellen: dataset_core.md (BPMN), class_hierarchy.md (CC08-CC10)*

---

## 5. Datenstruktur-Fragen

### Typische Anfragen

- "Wie sind Frames synchronisiert?"
- "Wie viele Klassendateien hat ein Subjekt?"
- "Was ist die Frame-Rate?"

### Antwort-Workflow

**Schritt 1:** Öffne `data_structure.md`

**Schritt 2:** Navigiere zu relevanter Sektion
- Frames → Abschnitt 5.6
- Klassendateien → Abschnitt 5.5
- Synchronisation → Abschnitt 5.7

**Schritt 3:** Erkläre technische Details
- Nutze konkrete Zahlen
- Zeige Beispiele (Frame-zu-Zeit-Umrechnung)

### Beispiel-Antworten

**Anfrage:** "Wie sind Frames über Klassendateien synchronisiert?"

**Antwort:**
**Frame-Synchronisation im DaRa-Datensatz:**

1. **Identische Zeilenzahl:** Alle 12 Klassendateien eines Subjekts haben die **gleiche Anzahl Zeilen** (Frames)

2. **Zeitliche Entsprechung:** 
   - Frame N in CC01 (Main Activity) = **genau derselbe Zeitpunkt** wie Frame N in CC04 (Left Hand), CC09 (Mid-Level), etc.
   - Beispiel: Frame 1000 beschreibt den **identischen Moment** über alle 12 Kategorien

3. **Frame-Rate:** 
   - **29,97 fps** (tatsächlich)
   - **30 fps** (gerundet für Modellierung)
   - 1 Frame = 1/30 Sekunde ≈ 0,0333 Sekunden

4. **Vollständigkeit:**
   - Keine Lücken zwischen Frames
   - Jeder Frame hat Annotationen in allen 12 Dateien

*Quelle: data_structure.md, Abschnitte 5.5-5.7*

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

**Umgekehrt (Zeit → Frame):**
```
Frame_Nummer = Zeit_in_Sekunden × 30
```

**Beispiel:**
- 5 Minuten = 300 Sekunden × 30 = **Frame 9000**

*Quelle: data_structure.md, Abschnitt 5.6*

---

## 6. Statistik-Fragen

### Typische Anfragen

- "Wie viele Probanden sind Studenten?"
- "Wie lange ist der Datensatz?"
- "Wie viele Labels gibt es insgesamt?"

### Antwort-Workflow

**Schritt 1:** Identifiziere Statistik-Typ
- Probanden-Demographie → `dataset_core.md`, Tabelle 4
- Datensatzumfang → `data_structure.md`, Abschnitt 5.8
- Label-Anzahl → `class_hierarchy.md`, Überblick

**Schritt 2:** Extrahiere oder berechne
- Direkt aus Tabellen ablesen
- Bei Bedarf aggregieren (z.B. Studenten zählen)

**Schritt 3:** Präsentiere kompakt

### Beispiel-Antworten

**Anfrage:** "Wie viele Probanden sind Studenten?"

**Antwort:**
**7 Probanden** haben den Beschäftigungsstatus "Student":

- S01 (F, 32 Jahre)
- S02 (M, 27 Jahre)
- S06 (M, 24 Jahre)
- S08 (F, 29 Jahre)
- S09 (M, 21 Jahre)
- S10 (M, 28 Jahre)
- S18 (M, 26 Jahre)

**Weitere Beschäftigungsstatus:**
- 8 Angestellte (Employee)
- 1 Rentner (Retiree)
- 1 Arbeitssuchender (Job seeker)

*Quelle: dataset_core.md, Abschnitt 1.4, Tabelle 4*

---

**Anfrage:** "Wie viele Labels gibt es insgesamt?"

**Antwort:**
Der DaRa-Datensatz umfasst **207 Labels** (CL001-CL207) über **12 Klassenkategorien**:

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
| CC09 (Mid-Level) | 11 |
| CC10 (Low-Level) | 32 |
| CC11 (Location Human) | 26 |
| CC12 (Location Cart) | 27 |
| **Gesamt** | **207** |

Durch Kombination aller Kategorien entstehen über **68.000 theoretisch mögliche Zustandskombinationen**.

*Quelle: class_hierarchy.md, Statistik-Tabelle*

---

## 7. Validierungs-Fragen

### Typische Anfragen

- "Gehört CL115 zu CC09?"
- "Ist 'Portable Data Terminal' ein Tool?"
- "Kann CC08 und CC09 gleichzeitig auftreten?"

### Antwort-Workflow

**Schritt 1:** Verstehe Frage-Typ
- Label-Zuordnung → Prüfe Label-Range
- Semantische Validierung → Prüfe Kategorie-Definition
- Logische Konsistenz → Prüfe Datenstruktur

**Schritt 2:** Verifiziere
- Nutze `class_hierarchy.md` für Label-Checks
- Nutze `data_structure.md` für Frame-Logik

**Schritt 3:** Antworte mit Begründung

### Beispiel-Antworten

**Anfrage:** "Gehört CL115 zu CC09?"

**Antwort:**
**Ja**, CL115 gehört zur Kategorie **CC09 – Mid-Level Process**.

**Verifikation:**
- **CC09 Label-Range:** CL114-CL123
- **CL115:** "Picking – Travel Time"
- **Position:** 2. Label in CC09 (nach CL114 Preparing Order)

CL115 beschreibt die Bewegungsphase während des Picking-Prozesses im Retrieval-Pfad.

*Quelle: class_hierarchy.md, CC09-Sektion*

---

**Anfrage:** "Ist 'Portable Data Terminal' ein Tool?"

**Antwort:**
**Ja**, "Portable Data Terminal" ist ein **Tool-Label** in zwei Kategorien:

- **CL052** – CC04 (Left Hand) → Tool-Unterkategorie
- **CL087** – CC05 (Right Hand) → Tool-Unterkategorie

Zusätzlich erscheint es als:
- **CL107** – CC07 (Information Technology)

Das PDT ist sowohl ein physisches Werkzeug (in den Händen gehalten) als auch ein IT-System (für Auftragserfassung).

*Quelle: class_hierarchy.md, CC04/CC05/CC07-Sektionen*

---

**Anfrage:** "Können CC08 und CC09 gleichzeitig auftreten?"

**Antwort:**
**Ja, immer**. CC08 (High-Level) und CC09 (Mid-Level) treten **zwingend gleichzeitig** in jedem Frame auf.

**Begründung:**
- Jeder Frame enthält Annotationen aus **allen 12 Klassenkategorien**
- CC08 definiert den Makro-Prozess (Retrieval/Storage)
- CC09 definiert die Phase innerhalb dieses Prozesses
- CC10 definiert die atomare Aktivität

**Beispiel:**
- **Frame 1000:**
  - CC08: CL110 (Retrieval)
  - CC09: CL115 (Picking Travel Time)
  - CC10: CL137 (Moving to Next Position)

Die drei Prozess-Kategorien bilden eine **Hierarchie**, nicht Alternativen.

*Quelle: data_structure.md, Abschnitt 5.5 + class_hierarchy.md, Prozess-Hierarchie*

---

## Best Practices

### Für präzise Antworten

1. **Immer Quelle angeben:** Dateiname + Abschnitt
2. **Offizielle IDs nutzen:** "CL115" statt "Picking Travel"
3. **Keine Interpretation:** Nur dokumentierte Fakten
4. **Unsicherheiten markieren:** "Nicht dokumentiert" statt Vermutung

### Für komplexe Queries

1. **Mehrere Dateien kombinieren:** BPMN (dataset_core.md) + Labels (class_hierarchy.md)
2. **Hierarchie beachten:** CC08 → CC09 → CC10
3. **Kontext bereitstellen:** Retrieval vs. Storage unterscheiden

### Für Fehler-Handling

**Bei fehlenden Informationen:**
- "Diese Information ist in der Dokumentation (Stand 20.10.2025) nicht enthalten"
- "Abschnitt X.X wurde noch nicht ausgearbeitet"
- "Verfügbare Informationen: [Liste]"

**Bei widersprüchlichen Anfragen:**
- "Die Anfrage enthält einen logischen Widerspruch"
- "Beispiel: CC08 kann nicht gleichzeitig Retrieval UND Storage sein"

### Für Effizienz

1. **Häufige Queries cachen:** Anzahl Probanden (18), Labels (207), Sessions (6)
2. **Pattern erkennen:** "Was ist CL..." → Immer class_hierarchy.md
3. **Shortcuts nutzen:** Quick Reference Tabellen

---

## Metadaten

**Skill-Version:** 1.0  
**Erstellt:** 04.12.2025  
**Verwendung:** Ergänzung zu SKILL.md für Query-Optimierung
