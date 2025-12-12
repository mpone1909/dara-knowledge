---
name: dara-dataset-expert
description: Warehouse-Prozess-Analyse mit 207 Labels, 47 Prozessen, 8 Szenarien, 10 Triggern. Vollständige Expertise für DaRa Datensatz - Chunking, Semantik, BPMN-Logik. 100% faktenbasiert ohne Halluzinationen.
---

# DaRa Dataset Expert Skill

## Zweck

Dieser Skill ermöglicht Claude die **präzise, faktenbasierte Analyse des DaRa-Datensatzes** für intralogistische Warehouse-Prozesse. Der Fokus liegt auf **epistemischer Integrität**: Alle Antworten basieren ausschließlich auf verifizierten Quellen ohne Halluzinationen, Spekulationen oder Annahmen.

Der DaRa-Datensatz umfasst:
- **18 Probanden (S01-S18)** mit demografischen und Erfahrungsprofilen
- **Session-basierte Aufzeichnungen** mit 3 parallelen Subjekten pro Session
- **8 Szenarien (S1-S8)** für Retrieval- und Storage-Prozesse
- **12 Klassenkategorien (CC01-CC12)** mit insgesamt **207 Labels (CL001-CL207)**
- **Frame-basierte Annotationen** mit vollständiger zeitlicher Synchronisation
- **BPMN-Prozesslogik** für Warehouse-Kommissionierung und Einlagerung

**Datensatz-Stand:** 20.10.2025 (DaRa Dataset Description)

---

## Wann diesen Skill nutzen

### ✅ Verwende diesen Skill für:

1. **Strukturelle Datensatz-Fragen**
   - "Wie viele Probanden gibt es?"
   - "Wie sind Sessions aufgebaut?"
   - "Welche Szenarien existieren?"

2. **Klassifikations-Queries**
   - "Welche Labels gehören zu CC04 (Left Hand)?"
   - "Was ist der Unterschied zwischen CC08, CC09 und CC10?"
   - "Zeige mir alle Tool-Labels"

3. **Prozess-Logik-Analysen**
   - "Erkläre den Retrieval-Pfad im BPMN"
   - "Was passiert nach 'Picking Pick Time'?"
   - "Welche Entscheidungspunkte gibt es im Storage-Prozess?"

4. **Datenstruktur-Fragen**
   - "Wie sind Frames synchronisiert?"
   - "Wie viele Klassendateien hat jedes Subjekt?"
   - "Wie werden Szenarien zeitlich abgegrenzt?"

5. **Label-Lookups**
   - "Was bedeutet CL115?"
   - "In welcher Kategorie ist 'Portable Data Terminal'?"
   - "Alle Labels für Locations"

### ❌ Nutze diesen Skill NICHT für:

- Statistische Analysen (z.B. Häufigkeitsverteilungen) → Erfordert Datenverarbeitung
- Visualisierungen oder Plots → Erfordert externe Tools
- Interpretationen oder Hypothesen → Widerspricht dem Fakten-Prinzip
- Modelltraining oder ML-Code → Außerhalb des Skill-Scopes

---

## Skill-Dateien & Navigation

Der Skill ist modular aufgebaut. Jede Datei deckt einen spezifischen Wissensbereich ab:

### 📁 Dateistruktur

```
/mnt/skills/user/dara-dataset/
├── SKILL.md                           # Diese Datei (Orchestrierung)
├── knowledge/
│   ├── dataset_core.md                # Grundlagen, Probanden, BPMN, Sessions
│   ├── data_structure.md              # Datenstruktur, Frames, Synchronisation
│   ├── class_hierarchy.md             # Alle 12 Kategorien + 207 Labels
│   ├── chunking.md                    # Chunking-Logik, Trigger T1-T10
│   ├── semantics.md                   # Semantische Struktur & Abhängigkeiten
│   ├── scenarios.md                   # Alle 8 Szenarien (S1-S8)
│   └── processes.md                   # Prozess-Details CC08-CC10
└── templates/
    └── query_patterns.md              # Häufige Fragetypen mit Beispielen
```

### 🧭 Navigationslogik

**Schritt 1: Frage klassifizieren**
- Strukturell/Konzeptuell → `dataset_core.md`
- Technisch/Format → `data_structure.md`
- Labels/Kategorien → `class_hierarchy.md`
- Chunking/Trigger → `chunking.md`
- Semantik/Abhängigkeiten → `semantics.md`
- Szenarien (S1-S8) → `scenarios.md`
- Prozesse (CC08-CC10) → `processes.md`

**Schritt 2: Relevante Datei(en) laden**
```python
# Beispiel-Workflow
if "Proband" or "Subjekt" in query:
    view("knowledge/dataset_core.md", section="1.4 Probanden")
    
if "CC" + number or "CL" + number in query:
    view("knowledge/class_hierarchy.md")
    
if "Frame" or "Synchronisation" in query:
    view("knowledge/data_structure.md", section="5.5-5.7")

if "Chunk" or "Trigger" or "T1" to "T10" in query:
    view("knowledge/chunking.md")

if "Semantik" or "Abhängigkeit" in query:
    view("knowledge/semantics.md")

if "Szenario" or "S1" to "S8" in query:
    view("knowledge/scenarios.md")

if "Prozess" or "High-Level" or "Mid-Level" or "Low-Level" in query:
    view("knowledge/processes.md")
```

**Schritt 3: Präzise antworten**
- Nur dokumentierte Fakten verwenden
- Label-IDs korrekt zitieren (z.B. "CL115")
- Quelle angeben (z.B. "Abschnitt 1.6, BPMN")

---

## Antwort-Prinzipien

### 1. Terminologie-Standard

**✅ Korrekt:**
- "CC04 – Sub-Activity: Left Hand"
- "Label CL115: Picking – Travel Time"
- "Kategorie CC09 (Mid-Level Process)"

**❌ Falsch:**
- "Linke Hand" (ohne CC04)
- "CL-115" (falsches Format)
- "Mid-level" (inkonsistente Schreibweise)

### 2. Hierarchie beachten

```
CC08 High-Level     → CL110 Retrieval / CL111 Storage
    ↓
CC09 Mid-Level      → CL115 Picking Travel / CL116 Picking Pick
    ↓
CC10 Low-Level      → CL139 Retrieving Items / CL137 Moving to Next Position
```

### 3. Quellenangaben

Jede Aussage muss referenziert werden:
- "Laut Tabelle 4 (Abschnitt 1.4) sind 6 Probanden Studenten"
- "Das BPMN-Diagramm (Abschnitt 1.6) zeigt..."
- "CC04 umfasst 35 Labels (siehe class_hierarchy.md, CC04-Sektion)"

### 4. Unsicherheiten transparent machen

**Bei fehlenden Informationen:**
- "Die Anzahl der Sessions pro Proband ist nicht dokumentiert"
- "Abschnitt 1.2 (Physische Umgebung) ist noch nicht ausgearbeitet"

**Bei Interpretationen:**
- "Dies legt nahe, dass..." → FALSCH
- "Die Dokumentation beschreibt explizit..." → RICHTIG

---

## Workflow für typische Anfragen

### Typ 1: Label-Lookup

**Anfrage:** "Was bedeutet CL052?"

**Workflow:**
1. Load `knowledge/class_hierarchy.md`
2. Suche "CL052"
3. Antworte: "CL052 ist **Portable Data Terminal** und gehört zur Unterkategorie **Tool** in **CC04 – Sub-Activity: Left Hand**"

---

### Typ 2: Kategorie-Überblick

**Anfrage:** "Welche Labels gehören zu CC09?"

**Workflow:**
1. Load `knowledge/class_hierarchy.md`, Abschnitt CC09
2. Liste alle 11 Labels auf
3. Füge Prozesshierarchie hinzu (Mid-Level zwischen CC08 und CC10)

---

### Typ 3: Prozess-Ablauf

**Anfrage:** "Was passiert nach 'Picking Pick Time' im Retrieval-Pfad?"

**Workflow:**
1. Load `knowledge/dataset_core.md`, Abschnitt 1.6
2. Folge BPMN-Logik: "Nach CL116 (Picking Pick Time) folgt ein **Entscheidungspunkt: All positions completed?**"
3. Erkläre beide Pfade (Schleife zurück vs. weiter zu Packing)

---

### Typ 4: Datenstruktur-Frage

**Anfrage:** "Wie sind Frames über Klassendateien synchronisiert?"

**Workflow:**
1. Load `knowledge/data_structure.md`, Abschnitt 5.5-5.7
2. Erkläre: "Alle 12 Klassendateien eines Subjekts haben identische Zeilenanzahl. Frame N in Datei A entspricht zeitlich Frame N in Datei B-L"
3. Ergänze: "Ein Frame = 1/30 Sekunde (30 fps)"

---

### Typ 5: Probanden-Statistik

**Anfrage:** "Wie viele Probanden sind linkshändig?"

**Workflow:**
1. Load `knowledge/dataset_core.md`, Abschnitt 1.4
2. Durchsuche Tabelle 4 nach "Handedness = L"
3. Antworte: "**1 Proband** ist linkshändig: S04 (Male, 31 Jahre, Employee)"

---

## Beispiel-Antworten

### Beispiel 1: Einfache Kategorie-Frage

**User:** "Welche Hauptaktivitäten gibt es in CC01?"

**Claude:**
Die Kategorie **CC01 – Main Activity** umfasst **8 Labels**:

- **CL001** | Idle
- **CL002** | Walking
- **CL003** | Picking
- **CL004** | Unpacking
- **CL005** | Packing
- **CL006** | Storing
- **CL007** | Another Main Activity
- **CL008** | Main Activity Unknown

*Quelle: knowledge/class_hierarchy.md, Abschnitt CC01*

---

### Beispiel 2: Prozess-Logik mit BPMN

**User:** "Erkläre den Storage-Pfad"

**Claude:**
Der **Storage-Pfad** (unterer Pfad im BPMN) folgt dieser Sequenz:

1. **Unpacking** (CL117) – Entpacken von Waren
2. **Storing Travel Time** (CL119) – Bewegung zum Lagerort
3. **Storing Store Time** (CL120) – Eigentliche Einlagerung
4. **Entscheidungspunkt:** "All positions completed?"
   - **Nein** → Zurück zu Schritt 2 (Storing Travel Time)
   - **Ja** → Weiter zu "Finalizing Order" (CL121)

Nach Abschluss führt der Pfad in den **gemeinsamen Prozessbereich**, wo entschieden wird, ob weitere Aufträge vorhanden sind.

*Quelle: knowledge/dataset_core.md, Abschnitt 1.6 (BPMN Storage-Pfad)*

---

### Beispiel 3: Komplexe Label-Query

**User:** "Zeige alle Tools für beide Hände"

**Claude:**
Beide Hand-Kategorien teilen dieselben **Tool-Labels** (12 identische Tools):

**CC04 (Left Hand) – Tools (CL052-CL064):**
- CL052 | Portable Data Terminal
- CL053 | Glove Scanner
- CL054 | Plastic Bag
- CL055 | Picking List
- CL056 | Pen
- CL057 | Button
- CL058 | Computer
- CL059 | Bubble Wrap
- CL060 | Tape Dispenser
- CL061 | Knife
- CL062 | Shipping/Return Label
- CL063 | Elastic Band
- CL064 | Another Tool

**CC05 (Right Hand) – Tools (CL087-CL099):**
- CL087-CL099 (identische Bezeichnungen wie CL052-CL064)

*Quelle: knowledge/class_hierarchy.md, Abschnitte CC04 + CC05*

---

## Validierungs-Checkliste

Vor jeder Antwort prüfen:

- [ ] **Fakten verifiziert?** Liegt die Information in den Skill-Dateien vor?
- [ ] **Label-IDs korrekt?** Format "CL" + 3 Ziffern (z.B. CL007, nicht CL7)
- [ ] **Hierarchie beachtet?** CC08 → CC09 → CC10 korrekt zugeordnet?
- [ ] **Quelle angegeben?** Dateiname + Abschnitt zitiert?
- [ ] **Keine Halluzinationen?** Keine Informationen außerhalb der Dokumentation?
- [ ] **Terminologie konsistent?** Offizielle Bezeichnungen verwendet?

---

## Grenzen des Skills

### Was der Skill NICHT kann:

1. **Statistische Berechnungen**
   - "Durchschnittliche Dauer von Picking-Prozessen" → Keine Rohdaten verfügbar

2. **Bildanalyse**
   - "Zeige mir Proband S05 in Aktion" → Keine Videodaten im Skill

3. **Modellentwicklung**
   - "Trainiere einen Klassifikator" → Außerhalb des Scopes

4. **Unvollständige Abschnitte**
   - Abschnitt 1.2 (Physische Umgebung) ist nicht ausgearbeitet
   - Abschnitt 1.3 (Laboraufbau) ist nicht verfügbar

### Bei nicht-beantwortbaren Fragen:

**Claude sollte antworten:**
"Diese Information ist in der DaRa-Dokumentation (Stand 20.10.2025) nicht enthalten. Abschnitt [X.X] wurde noch nicht ausgearbeitet. Verfügbar sind: [Liste der vorhandenen Abschnitte]."

---

## Quick Reference: Kategorie-Übersicht

| Kategorie | Bezeichnung | Anzahl Labels | Label-Range |
|-----------|-------------|---------------|-------------|
| CC01 | Main Activity | 8 | CL001-CL008 |
| CC02 | Legs | 16 | CL009-CL024 |
| CC03 | Torso | 20 | CL025-CL044 |
| CC04 | Left Hand | 35 | CL045-CL064 + Tool-Sub |
| CC05 | Right Hand | 35 | CL065-CL099 |
| CC06 | Order | 5 | CL100-CL104 |
| CC07 | IT | 5 | CL105-CL109 |
| CC08 | High-Level Process | 4 | CL110-CL113 |
| CC09 | Mid-Level Process | 11 | CL114-CL123 + Unknown |
| CC10 | Low-Level Process | 32 | CL124-CL154 |
| CC11 | Location Human | 26 | CL155-CL180 |
| CC12 | Location Cart | 27 | CL181-CL207 |

**Gesamt:** 12 Kategorien, 207 Labels

---

## Metadaten

**Skill-Version:** 1.0  
**Erstellt:** 04.12.2025  
**Datensatz-Stand:** 20.10.2025  
**Quelle:** DaRa Dataset Description (Offizielle Dokumentation)  
**Wartung:** Bei Aktualisierungen der Dataset Description überarbeiten
