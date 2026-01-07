# DaRa Dataset Expert Skill – Version 2.5 – Version 2.3 – Installation & Übersicht

## 📦 Lieferumfang

Dieses Paket enthält einen vollständig entwickelten Claude-Skill für die Arbeit mit dem DaRa-Datensatz (Warehouse-Prozessanalyse), erweitert um REFA-Methodik und Validierungslogik.

### Verzeichnisstruktur

```
dara-dataset-expert/
├── SKILL.md                           # Hauptdokumentation (15 KB)
├── README.md                          # Diese Datei
├── knowledge/
│   ├── class_hierarchy.md             # Alle 207 Labels + Systematik (25 KB)
│   ├── analytics_refa.md              # REFA-Zeitarten & Formeln (9 KB) [NEU]
│   ├── validation_logic.md            # Abhängigkeitsregeln (8 KB) [NEU]
│   ├── dataset_core.md                # Probanden, BPMN, Sessions (12 KB)
│   ├── data_structure.md              # Frame-Synchronisation, CSV-Format (9 KB)
│   ├── processes.md                   # Prozess-Details CC08-CC10 (17 KB)
│   ├── chunking.md                    # Chunking-Logik, Trigger T1-T10 (18 KB)
│   ├── scenarios.md                   # Szenarien S1-S8 (15 KB)
│   └── semantics.md                   # Semantische Struktur (19 KB)
└── templates/
    └── query_patterns.md              # Fragetypen & Best Practices (14 KB)
```

### ⚠️ Wichtig für v2.5:

Version 2.5 integriert **CC09 (Mid-Level Process)** als primäre Erkennungsdimension und macht die **"Other"-Restkategorie** aktiv erkennbar. Diese Änderungen sind kritisch für korrekte Szenarioerkennung.

**Neue Features:**
- 🔧 CC09-Integration (8 Labels: CL114-CL121)
- 🎯 "Other"-Erkennung (verhindert False-Positives)
- 📊 Frame-Level-Algorithmus (21 erkennungsrelevante Labels)
- 📖 Erweiterte Dokumentation (~21 KB neu)

Siehe [`CHANGELOG_v2.4_to_v2.5.md`](knowledge/CHANGELOG_v2.4_to_v2.5.md) für Details.


**Gesamt:** 12 Dateien, ~175 KB

---

## 🎯 Skill-Fähigkeiten

Der Skill ermöglicht Claude:

### 1. Datensatz-Struktur-Expertise


- 18 Probanden (S01-S18) mit Demographie
- 6 Sessions mit je 3 parallelen Subjekten
- 8 Szenarien (S1-S8)
- 12 Klassenkategorien (CC01-CC12)
- 207 Labels (CL001-CL207)

### 2. Label-Lookups & Klassifikation


- Schnelle Label-ID-Suche (z.B. "Was ist CL052?")
- Kategorie-Zuordnung (z.B. "Alle Labels für CC09?")
- Hierarchische Navigation (Hand-Kategorien, Locations)
- Systematische Klassifizierung (REFA-Relevanz, Abhängigkeits-Typ)

### 3. BPMN-Prozesslogik


- Retrieval-Pfad (Kommissionierung)
- Storage-Pfad (Einlagerung)
- Prozess-Hierarchie (High → Mid → Low Level)
- Entscheidungspunkte und Schleifen

### 4. Frame-basierte Datenstruktur


- Synchronisation über 12 Klassendateien
- Frame-zu-Zeit-Umrechnung (30 fps)
- CSV-Format-Verständnis
- Multi-Label-Annotation

### 5. REFA-Analytik [NEU in v1.4.1]


- Zeitarten-Mapping ($t_R$, $t_{MH}$, $t_{MN}$, $t_v$)
- Auftragszeit-Berechnung ($T = t_R + t_A + t_E$)
- Erholungszeitermittlung basierend auf CC03/CC04/CC05
- Python-Algorithmus für Zeitberechnungen

### 6. Validierungslogik [NEU in v1.4.1]


- Master-Slave-Prinzip (CC01 → CC02-05)
- Prozess-Hierarchie-Validierung (CC08 → CC09 → CC10)
- Cross-Validierung (Motorik vs. Prozess)
- 10 formale Regeln (M-01 bis K-02)
- Python-Funktion für Integritätschecks

### 7. Epistemische Integrität


- **Null Halluzinationen:** Nur dokumentierte Fakten
- Quellenangaben bei jeder Aussage
- Transparente Wissenslücken
- Korrekte Label-IDs (CL001-CL207)

---

## 🚀 Installation

### Variante A: Manuell in Claude.ai

1. **Skill-Verzeichnis erstellen:**
   ```
   Öffne Claude.ai → Settings → Skills → Create Skill
   Name: "dara-dataset-expert"
   ```

2. **Dateien hochladen:**
   - Lade alle 12 Dateien aus diesem Ordner hoch
   - Behalte die Verzeichnisstruktur bei (knowledge/, templates/)

3. **Skill aktivieren:**
   - Toggle "Enabled" für den Skill
   - Starte neue Konversation

### Variante B: Über Skill-System (falls verfügbar)

Wenn du Zugriff auf `/mnt/skills/user/` hast:

```bash
# Kopiere komplettes Verzeichnis

cp -r dara-dataset-expert /mnt/skills/user/

# Prüfe Installation

ls -lh /mnt/skills/user/dara-dataset-expert/
```

---

## 🧪 Funktionstest

Teste den Skill mit diesen Anfragen:

### Test 1: Label-Lookup

```
Was ist CL115?
```
**Erwartete Antwort:** "CL115 ist Picking – Travel Time und gehört zu CC09 – Mid-Level Process. Im REFA-Kontext entspricht es der Nebentätigkeit ($t_{MN}$)..."

### Test 2: Prozess-Logik

```
Was passiert nach Picking Pick Time im Retrieval-Pfad?
```
**Erwartete Antwort:** BPMN-Entscheidungspunkt mit Schleife zurück oder weiter zu Packing

### Test 3: REFA-Analyse [NEU]

```
Welche DaRa-Labels entsprechen der Haupttätigkeit (t_MH)?
```
**Erwartete Antwort:** "CL116 (Picking Pick Time) und CL120 (Storing Store Time) werden der Haupttätigkeit ($t_{MH}$) zugeordnet..."

### Test 4: Validierungs-Check [NEU]

```
Darf man 'Walking' annotieren, wenn die Beine 'Standing Still' sind?
```
**Erwartete Antwort:** "Nein, das ist ungültig. Regel M-01 (Geh-Konsistenz) besagt..."

### Test 5: Kategorie-Übersicht

```
Welche Labels gehören zu CC04?
```
**Erwartete Antwort:** 35 Labels in 4 Unterkategorien (Position, Movement, Object, Tool)

### Test 6: Probanden-Statistik

```
Wie viele Probanden sind linkshändig?
```
**Erwartete Antwort:** "1 Proband (S04)"

---

## 📚 Datei-Beschreibung

### SKILL.md (Hauptdatei)


- **Zweck:** Orchestrierung und Navigation
- **Inhalt:** Workflow-Logik, Beispiele, Quick Reference
- **Verwendung:** Erste Anlaufstelle für alle Anfragen

### class_hierarchy.md


- **Zweck:** Vollständige Label-Referenz mit Systematik
- **Inhalt:** Alle 207 Labels, Hierarchien, REFA-Zuordnungen
- **Verwendung:** Label-Lookups, Kategorie-Queries

### analytics_refa.md [NEU]


- **Zweck:** REFA-Zeitarten-Mapping
- **Inhalt:** Formeln, Mapping-Tabellen, Python-Algorithmus
- **Verwendung:** Zeitstudien, Erholungszeitermittlung

### validation_logic.md [NEU]


- **Zweck:** Logische Abhängigkeitsregeln
- **Inhalt:** Master-Slave-Matrizen, 10 Validierungsregeln
- **Verwendung:** Integritätschecks, Annotationsvalidierung

### dataset_core.md


- **Zweck:** Fundamentale Datensatzbeschreibung
- **Inhalt:** Probanden-Tabelle, BPMN-Diagramm, Session-Definition
- **Verwendung:** Strukturelle Fragen, Prozess-Logik

### data_structure.md


- **Zweck:** Technische Datenstruktur
- **Inhalt:** Frame-Synchronisation, CSV-Format, Zeitliche Struktur
- **Verwendung:** Frame-basierte Analysen, Datenverarbeitung

### processes.md


- **Zweck:** Detaillierte Prozessbeschreibung
- **Inhalt:** CC08-CC10 Hierarchie, BPMN-Details
- **Verwendung:** Prozess-Ablauf-Fragen

### chunking.md


- **Zweck:** Segmentierungslogik
- **Inhalt:** Trigger T1-T10, Chunk-Definition
- **Verwendung:** Chunking-Fragen, Trigger-Analyse

### scenarios.md


- **Zweck:** Szenario-Beschreibungen
- **Inhalt:** S1-S8 mit Auftragszuordnung
- **Verwendung:** Szenario-Vergleiche

### semantics.md


- **Zweck:** Semantische Grundlagen
- **Inhalt:** Bedeutungsebenen, Abhängigkeiten
- **Verwendung:** Semantik-Fragen

### query_patterns.md


- **Zweck:** Anwendungsbeispiele
- **Inhalt:** 7 Fragetypen mit Beispiel-Antworten
- **Verwendung:** Best Practices, Optimierung

---

## 🎓 Verwendungsszenarien

### Szenario 1: Thesis-Arbeit


- Schnelle Label-Nachschläge während der Analyse
- REFA-Zeitarten-Mapping für arbeitswissenschaftliche Analysen
- Validierung von Annotationshypothesen
- Frame-zu-Zeit-Umrechnungen

### Szenario 2: Datenverarbeitung


- CSV-Format-Verständnis für Parser
- Frame-Synchronisation für Multi-Label-Training
- Integritätschecks vor Modelltraining
- Kategorie-Hierarchien für Feature Engineering

### Szenario 3: Dokumentation


- Automatische Prozess-Beschreibungen
- Label-Glossar-Generierung
- BPMN-Dokumentation
- REFA-konforme Zeitstudien-Reports

### Szenario 4: Code-Review


- Prüfung von Label-IDs im Code
- Validierung von Prozess-Sequenzen
- Szenario-Zuordnung
- Konsistenzprüfung von Annotationen

---

## 🔍 Qualitätsmerkmale

### ✅ Vollständigkeit


- **Alle 207 Labels** vollständig dokumentiert
- **REFA-Methodik** integriert
- **Validierungslogik** mit 10 formalen Regeln
- **Komplette Probanden-Tabelle** (18 Subjekte)

### ✅ Präzision


- Offizielle Label-IDs (CL001-CL207)
- Korrekte BPMN-Sequenzen
- Verifizierte Zahlen (207 Labels, 18 Probanden, 6 Sessions)
- Mathematisch korrekte REFA-Formeln

### ✅ Navigierbarkeit


- Modulare Dateistruktur (12 Dateien)
- Cross-References zwischen Dateien
- Quick-Reference-Tabellen
- Systematische Klassifizierung

### ✅ Wartbarkeit


- Klare Abschnitte für Updates
- Versionierung implementiert
- Erweiterbar (z.B. weitere Validierungsregeln)

---

## 📝 Changelog

### Version 1.4 (23.12.2025)


- ✅ **REFA-Analytik integriert** (analytics_refa.md)
  - Zeitarten-Mapping ($t_R$, $t_{MH}$, $t_{MN}$, $t_v$)
  - Auftragszeit-Formel ($T = t_R + t_A + t_E$)
  - Erholungszeitermittlung basierend auf CC03/CC04/CC05
  - Python-Algorithmus `calculate_refa_times()`

- ✅ **Validierungslogik integriert** (validation_logic.md)
  - Master-Slave-Prinzip dokumentiert
  - 10 formale Regeln (M-01, M-02, M-03, P-01, P-02, C-01, C-02, C-03, K-01, K-02)
  - Python-Funktion `validate_frame()`

- ✅ **class_hierarchy.md erweitert**
  - Systematische Klassifizierung (Multi-dimensionale Matrix)
  - REFA-Relevanz für jede Kategorie
  - Funktionsgruppen A, B, C definiert

- ✅ **SKILL.md überarbeitet**
  - Navigationslogik auf 10 Verzweigungen erweitert
  - REFA- und Validierungs-Workflows hinzugefügt
  - Quick Reference mit REFA-Relevanz-Spalte
  - Label-Ranges korrigiert

### Version 1.0 (04.12.2025)


- ✅ Initiale Skill-Entwicklung
- ✅ 10 Dateien erstellt (SKILL.md + 7 Knowledge-Dateien + 1 Template + README)
- ✅ Vollständige Integration der Wissensbasis (keine Kürzungen)
- ✅ 207 Labels vollständig dokumentiert
- ✅ BPMN-Prozesslogik integriert
- ✅ Query-Patterns-Template erstellt

---

## 📊 Statistik

**Wissensbasis-Abdeckung:**

- Skill v1.4.1: ~4.500 Zeilen (aufgeteilt in 12 Dateien)
- Abdeckung: ~99% DaRa-Dokumentation + REFA-Erweiterung

**Label-Abdeckung:**

- CC01-CC12: Alle 12 Kategorien ✓
- CL001-CL207: Alle 207 Labels ✓
- Hierarchien: Alle 4 Hand-Unterkategorien + 5 Location-Gruppen ✓
- REFA-Zuordnungen: Alle relevanten CC09/CC10-Labels ✓

**Prozess-Abdeckung:**

- BPMN Retrieval-Pfad: Vollständig ✓
- BPMN Storage-Pfad: Vollständig ✓
- CC08-CC10 Hierarchie: Vollständig ✓
- Validierungsregeln: 10 formale Regeln ✓

**Neue Komponenten (v1.4.1):**

- REFA-Formeln: 4 Hauptformeln ✓
- Validierungsregeln: 10 (M-01 bis K-02) ✓
- Python-Algorithmen: 2 (REFA + Validierung) ✓

---

## 🤝 Support & Feedback

**Bei Problemen:**
1. Prüfe, ob alle 12 Dateien korrekt installiert sind
2. Teste mit den 6 Funktions-Tests oben
3. Prüfe Verzeichnisstruktur (knowledge/, templates/)

**Bei Erweiterungswünschen:**

- Weitere REFA-Zeitarten hinzufügen?
- Zusätzliche Validierungsregeln?
- Code-Beispiele ergänzen?

**Kontakt:**
Erstellt für Markus' Master-Thesis an der TU Dortmund
Datum: 23.12.2025

---

## 📖 Zitation

Wenn du den Skill in deiner Thesis erwähnst:

```
DaRa Dataset Expert Skill (Version 1.4), entwickelt als Claude-Skill 
für die automatisierte Prozesserkennung in intralogistischen Szenarien.
Erweitert um REFA-Zeitarten-Analytik und formale Validierungslogik.
Basierend auf: DaRa Dataset Description (Stand 20.10.2025).
```

---

**Viel Erfolg mit deiner Thesis! 🎓**
