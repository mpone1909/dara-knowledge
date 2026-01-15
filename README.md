# DaRa Dataset Expert Skill – Version 3.0
Dieser Skill dient der Analyse von Manuellen Kommissioniertätigkeiten anhand des DaRa Datensatzen im Rahmen einer Masterarbeit an der TU Dortmund Fakultät Maschinenbau Lehrstuhl FLW
**Titel der Abschlussarbeit:**
**Referenzarchitektur für Agentic AI in der Intralogistik: Multi-Agent-Framework zur generativen Prozessanalyse von HAR-Daten mit LLM-Orchestrierung und REFA-Konfirmität**
**Autor: Markus Phillip Fiur**
**Berteut von Friedrich Niemann M. Sc. Logistik**
TU Dortmund
Fakultät Maschinenbau
Lehrstuhl flw - förder und Lagerwesen

**Vollständig entwickelter Claude-Skill für Warehouse-Prozessanalyse mit KI-gesteuerter Szenarioerkennung + Lagerlayout + 74 Artikel-Stammdaten**

[![Version](https://img.shields.io/badge/version-3.0-blue.svg)](https://github.com/mpone1909/dara-knowledge)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Claude](https://img.shields.io/badge/Claude-Sonnet%204.5-orange.svg)](https://claude.ai)

---

## 📦 Überblick

Der **DaRa Dataset Expert Skill** ermöglicht Claude die automatisierte Analyse von Warehouse-Kommissionierungsprozessen basierend auf dem DaRa-Datensatz. Version 3.0 erweitert den Skill um **vollständige Lagerlayout-Dokumentation**, **74 Artikel mit Lagerorten** und **MTM-1 Zeitbausteine**.

**Kernfähigkeiten:**
- 🎯 **8 Szenarien** (S1-S8) + "Other"-Restkategorie
- 🏷️ **207 Labels** über 12 Klassenkategorien (CC01-CC12)
- 📦 **74 Artikel** mit Storage Compartment IDs (Orders 2904/2905/2906)
- 🏭 **Lagerlayout vollständig** (12,76m × 17,35m, 8 Regalkomplexe, 5 Gassen)
- 🤖 **Frame-Level-Algorithmus** mit 30 erkennungsrelevanten Labels
- ⚖️ **REFA/MTM-Zeitarten-Analytik** für arbeitswissenschaftliche Studien
- ✅ **Validierungslogik** mit 10+ formalen Regeln
- 🔄 **Score-System** zur Fehlerkorrektur (CC10-Marker überschreiben CC08)

---

## 📂 Verzeichnisstruktur (v3.0)

```
dara-dataset-expert/
├── SKILL.md                                    # Hauptdokumentation & Orchestrierung (15 KB)
├── README.md                                   # Diese Datei
├── knowledge/
│   ├── core/                                   # Zentrale Erkennungslogik + Lagerlayout
│   │   ├── ground_truth_central.md             # Ground Truth Matrix, Szenario-Profile (25 KB)
│   │   ├── recognition_algorithm_v2.6.md       # Vollständiger Algorithmus (16 KB)
│   │   ├── labels_207.md                       # Alle 207 Labels + Systematik (24 KB)
│   │   ├── validation_rules.md                 # Validierungsregeln (20 KB)
│   │   ├── articles_inventory.md               # 🆕 74 Artikel mit Lagerorten (12 KB)
│   │   └── warehouse_layout.md                 # 🆕 Lagerlayout (5 Gassen, 8 Regalkomplexe) (10 KB)
│   ├── processes/                              # Prozess-Hierarchie + MTM-Codes
│   │   ├── process_hierarchy.md                # BPMN-Logik CC08-CC10 (17 KB)
│   │   ├── refa_analytics.md                   # REFA-Zeitarten & Formeln (10 KB)
│   │   └── mtm_codes.md                        # 🆕 MTM-1 Codes (R, G, M, P, RL, B, W) (8 KB)
│   ├── auxiliary/                              # Zusatzinformationen
│   │   ├── chunking.md                         # Trigger T1-T10 (18 KB)
│   │   ├── semantics.md                        # Semantische Grundlagen (19 KB)
│   │   ├── data_structure.md                   # Frame-Format (10 KB)
│   │   └── dataset_core.md                     # Probanden, Hardware (12 KB)
│   └── changelogs/                             # Versionsverwaltung
│       ├── CHANGELOG_v2.3_to_v2.4.md
│       ├── CHANGELOG_v2.4_to_v2.5.md
│       ├── CHANGELOG_v2.5_to_v2.6.md
│       └── CHANGELOG_v2.6_to_v3.0.md           # 🆕 Lagerlayout + Artikel + MTM
└── templates/
    ├── query_patterns.md                       # Fragetypen & Best Practices (14 KB)
    └── scenario_report_template.md             # Szenario-Bericht-Format (5 KB)
```

**Gesamt:** 18 Dateien, ~290 KB  
**Neu in v3.0:** +3 Dateien (articles_inventory.md, warehouse_layout.md, mtm_codes.md)

---

## ✨ Neue Features v3.0 (Januar 2026)

### 📦 Vollständige Artikel-Stammdaten

**74 Artikel mit präzisen Lagerorten:**
- Order 2904 (CL100): 15 Positionen mit Storage IDs (z.B. R7.3.1.A = Palmenerde)
- Order 2905 (CL101): 15 Positionen
- Order 2906 (CL102): 15 Positionen
- Multi-Order (S7/S8): 30 Positionen kombiniert

**Gewichtsklassen dokumentiert:**
| Klasse | Gewichtsbereich | DaRa-Label | Beispiele |
|--------|-----------------|------------|-----------|
| Small [S] | ≤ 50g | CL036/CL071 | M5 Mutter (~1g), Bits |
| Medium [M] | 50-800g | CL036/CL071 | Softshell-Jacke (700g) |
| Large [L] | > 800g | CL035/CL070 | Palmenerde (5149g) |

**Datei:** `knowledge/core/articles_inventory.md`

---

### 🏭 Lagerlayout (Fraunhofer IML Picking Lab)

**Räumliche Abmessungen:**
- Gesamtlänge Regalbereich: 12,76 m
- Gesamtlänge vor Hallentor: 17,35 m
- Breite Regalblock: 4,09 m

**8 Regalkomplexe in 5 Gassen:**
- Aisle 1 (R1): Kleinteile
- Aisle 2 (R2-R3): Textilien
- Aisle 3 (R4-R5): Werkzeuge
- Aisle 4 (R6-R7): Schwere Güter
- Aisle 5 (R8): Abschlussbereich

**9 funktionale Hauptbereiche:**
Office, Cart Area, Cardboard Box Area, Base, Packing/Sorting Area, Issuing/Receiving Area, Path, Cross Aisle Path, Aisle Path – alle mit DaRa-Labels (CC11/CC12) dokumentiert

**Storage Compartment ID Logik:**
- Format: R<Komplex>.<Regal>.<Ebene>.<Fach>
- Beispiel: R1.2.7.A = Komplex 1, Regal 2, Ebene 7, Fach A
- Ebene 1 = Bodenebene (bestätigt)

**Regalfach-Maße:**
- Standard: 95,5 × 39,5 × 21 cm (L × B × H)
- Textilien: Höhe 104 cm
- Schwere Güter: Höhe 41 cm

**Datei:** `knowledge/core/warehouse_layout.md`

---

### ⏱️ MTM-1 Grundbewegungen

**7 MTM-Codes mit TMU-Werten dokumentiert:**

| Code | Bewegung | TMU-Wert | Zeit (s) | DaRa-Label |
|------|----------|----------|----------|------------|
| R | Reach | R50B: 18,4 | 0,66s | CL149 |
| G | Grasp | G1A: 2,0 | 0,07s | CL150 |
| M | Move | M40B: 15,6 | 0,56s | CL146 |
| P | Position | P1SE: 5,6 | 0,20s | CL146 |
| RL | Release | RL1: 2,0 | 0,07s | CL146 |
| B | Bend | B: 29,0 | 1,04s | CL129 + CL025 |
| W | Walk | W: 15,0 | 0,54s | CL137 + CL022 |

**TMU-Einheit:** 1 TMU = 0,036 Sekunden

**Datei:** `knowledge/processes/mtm_codes.md`

---

## 🚀 Installation

### Option 1: Manuelles Einfügen (Lokal)

1. **ZIP-Archiv entpacken**
2. **3 neue Dateien hinzufügen:**
   - `knowledge/core/articles_inventory.md`
   - `knowledge/core/warehouse_layout.md`
   - `knowledge/processes/mtm_codes.md`
3. **5 Dateien ersetzen:**
   - `SKILL.md` (Version 3.0)
   - `README.md` (diese Datei)
   - `knowledge/core/ground_truth_central.md` (Order-Zuordnung aktualisiert)
   - `knowledge/processes/refa_analytics.md` (MTM-Verweis hinzugefügt)
   - `knowledge/auxiliary/dataset_core.md` (Probanden-Erfahrung hinzugefügt)
4. **ZIP neu erstellen:** `dara-dataset-expert_v3.0.zip`

### Option 2: Claude.ai Skill-Upload (Empfohlen)

1. In Claude.ai → **Settings → Profile → Skills**
2. **"Add Skill"** → ZIP-Datei hochladen
3. Skill aktivieren

---

## 📖 Schnellstart

### Beispiel-Queries (v3.0)

```python
# Lagerlayout-Queries
"Wo ist der Artikel 'Palmenerde' gelagert?"
→ R7.3.1.A (Aisle 4, Regalkomplex 7, Ebene 1 = Bodenebene)

"Welche Artikel sind in Gasse 2 (Aisle 2)?"
→ Textilien (Softshell-Jacken, Handschuhe, Hoodies, Poloshirts)

"Was bedeutet Storage Compartment ID R1.2.7.A?"
→ Komplex 1, Regal 2, Ebene 7, Fach A

"Wie groß sind die Regalfächer?"
→ Standard: 95,5 × 39,5 × 21 cm (L × B × H)

"Welche Gewichtsklasse hat 'Softshell Jacket'?"
→ Medium [M] (700g)

# MTM-Queries
"Was ist MTM-Code B (Bend) und wie viele TMU hat er?"
→ Beugen, 29,0 TMU = 1,04 Sekunden, DaRa-Labels: CL129 + CL025

"Wie wird 'Gehen' (Walk) in DaRa annotiert?"
→ MTM-Code W (15,0 TMU), DaRa-Labels: CL137 + CL022

# Klassische Queries (v2.6)
"Wie erkenne ich Szenario S2?"
→ PDT (CL107) ist 100% eindeutig

"Welche DaRa-Labels entsprechen der Haupttätigkeit (t_MH)?"
→ CC09: CL116, CL120 + CC10: CL149, CL150, CL146

"Validiere: Darf man 'Scanning' ohne Scanner-Tool annotieren?"
→ Nein, Master-Slave-Regel verletzt
```

---

## 🎓 Anwendungsfälle

### 1. Arbeitswissenschaft & REFA

**Use Case:** Berechne Kommissionierzeit für Order 2904
```
1. Lade REFA/MTM-Dateien
2. Analysiere Artikel-Gewichte (Small/Medium/Large)
3. Berechne Wegstrecke (Gasse 1 → Gasse 5)
4. Summiere MTM-Codes (R + G + M + P + RL + B + W)
5. Addiere Erholungszeit für Large [L]-Artikel (Palmenerde)
```

### 2. Datensatz-Validierung

**Use Case:** Prüfe Konsistenz von CSV-Annotationen
```
1. Frame-by-Frame-Analyse
2. Master-Slave-Abhängigkeiten prüfen
3. Szenario-Erkennung (S1-S8 vs. "Other")
4. Error-Flag-Detection (CL135)
5. Validierungsreport generieren
```

### 3. Prozess-Optimierung

**Use Case:** Optimiere Kommissionier-Wegstrecke
```
1. Analysiere Artikel-Verteilung (Gassen 1-5)
2. Identifiziere Hotspots (schwere Artikel in Aisle 4)
3. Simuliere alternative Order-Abarbeitung
4. Berechne Zeit-Ersparnis (MTM-basiert)
```

### 4. Lagerlayout-Analyse

**Use Case:** Ergonomische Bewertung
```
1. Identifiziere Large [L]-Artikel in Ebene 1 (Bodenzone)
2. Berechne Beugen-Häufigkeit (MTM-Code B)
3. Prüfe Überkopf-Artikel (Ebene 6-7, hypothetisch)
4. Empfehle Umplatzierung für Ergonomie
```

---

## 🔧 Technische Details

### Datensatz-Umfang

| Komponente | Anzahl | Beschreibung |
|------------|--------|--------------|
| Probanden | 18 | S01-S18 (14 männlich, 4 weiblich) |
| Sessions | 6 | 3 parallele Subjekte pro Session |
| Szenarien | 8 | S1-S8 (Retrieval + Storage) |
| Orders | 3 | 2904 (CL100), 2905 (CL101), 2906 (CL102) |
| Artikel | 74 | Mit Storage Compartment IDs |
| Labels | 207 | CC01-CC12 (12 Kategorien) |
| Regalkomplexe | 8 | R1-R8 |
| Gassen | 5 | Aisle 1-5 |
| Funktionsbereiche | 9 | Office, Cart Area, Base, etc. |
| MTM-Codes | 7 | R, G, M, P, RL, B, W |

### Algorithmus-Performance (v2.6)

| Metrik | Wert | Erklärung |
|--------|------|-----------|
| Szenario-Erkennungsrate | ~95% | Basierend auf Ground Truth |
| "Other"-Precision | ~90% | CL134 als Hard Cut |
| False-Positive-Rate | <5% | Score-System korrigiert Fehler |
| Durchsatz | ~1000 Frames/s | Optimierte Regelprüfung |

---

## 📚 Dokumentations-Struktur

### Core-Dateien

| Datei | Zweck | Größe |
|-------|-------|-------|
| `SKILL.md` | Orchestrierung + Navigationslogik | 15 KB |
| `ground_truth_central.md` | Szenarien S1-S8, Matrix, Profile | 25 KB |
| `recognition_algorithm_v2.6.md` | Vollständiger Erkennungsalgorithmus | 16 KB |
| `labels_207.md` | Alle 207 Labels + Hierarchie | 24 KB |
| `validation_rules.md` | Master-Slave + Szenario-Regeln | 20 KB |
| `articles_inventory.md` | 74 Artikel mit Lagerorten | 12 KB |
| `warehouse_layout.md` | Lagerlayout (5 Gassen, 8 Regalkomplexe) | 10 KB |

### Process-Dateien

| Datei | Zweck | Größe |
|-------|-------|-------|
| `process_hierarchy.md` | BPMN-Logik CC08-CC10 | 17 KB |
| `refa_analytics.md` | REFA-Zeitarten + Formeln | 10 KB |
| `mtm_codes.md` | MTM-1 Codes + TMU-Werte | 8 KB |

### Auxiliary-Dateien

| Datei | Zweck | Größe |
|-------|-------|-------|
| `dataset_core.md` | Probanden, Hardware, Sessions | 12 KB |
| `data_structure.md` | Frame-Format, Synchronisation | 10 KB |
| `chunking.md` | Trigger T1-T10 | 18 KB |
| `semantics.md` | Semantische Grundlagen | 19 KB |

---

## 🔄 Version-History

### v3.0 (14.01.2026) – Lagerlayout & Artikel-Integration

**Neue Dateien:**
- ✅ `knowledge/core/articles_inventory.md` (74 Artikel, Orders 2904/2905/2906)
- ✅ `knowledge/core/warehouse_layout.md` (Lagerlayout, 5 Gassen, 8 Regalkomplexe)
- ✅ `knowledge/processes/mtm_codes.md` (MTM-1 Codes, TMU-Werte)

**Aktualisierte Dateien:**
- ✅ `SKILL.md` → Version 3.0 (Lagerlayout-Sektion, Gewichtsklassen)
- ✅ `README.md` → Diese Datei (Changelog v3.0)
- ✅ `knowledge/core/ground_truth_central.md` → Order-Zuordnung S1-S3 korrigiert
- ✅ `knowledge/processes/refa_analytics.md` → MTM-Verweis hinzugefügt
- ✅ `knowledge/auxiliary/dataset_core.md` → Probanden-Erfahrungslevel hinzugefügt

**Änderungen:**
- Lagerlayout vollständig dokumentiert (12,76m × 17,35m)
- 74 Artikel mit Storage Compartment IDs (R<Komplex>.<Regal>.<Ebene>.<Fach>)
- Gewichtsklassen (Small/Medium/Large) mit Artikel-Beispielen
- 9 funktionale Hauptbereiche (Office, Cart Area, Base, etc.) mit DaRa-Labels
- MTM-1 Codes (7 Grundbewegungen) mit TMU-Werten + DaRa-Mapping
- Regalfach-Maße präzise (95,5 × 39,5 × 21 cm Standard, 104cm Textilien)
- Storage Compartment ID Logik (Ebene 1 = Bodenebene bestätigt)

**Breaking Changes:** Keine

---

### v2.6 (07.01.2026) – Hybrid-Logic + Score-System

**Änderungen:**
- Hybrid-Identification-Logic (IT für S1-S3, Order für S4-S6)
- Evidence-Based Scoring (CC10-Marker überschreiben CC08)
- CL134 als Global Interrupt (Hard Cut für "Other")
- Konsolidierung: -40% Dateien durch Merge

---

### v2.5 (05.01.2026) – CC09-Integration

**Änderungen:**
- CC09 als primäre Erkennungsdimension
- "Other"-Restkategorie aktiv erkennbar
- Frame-Level-Prüfung aller Labels

---

### v2.3 (31.12.2025) – Flexible Szenarioerkennung

**Änderungen:**
- Merkmalbasierte Erkennung (5 Dimensionen)
- Keine harten Grenzen (keine Frame-Nummern)
- S8 Order-Set korrigiert (CL100 + CL101)

---

## 📞 Support & Wartung

**Skill-Version:** 3.0  
**Datensatz-Stand:** 20.10.2025 (DaRa Dataset Description)  
**Letztes Update:** 14.01.2026  

**Wartung:** Bei Aktualisierungen der DaRa Dataset Description überarbeiten

**Autor:** Markus Phillip Fiur 
**Lizenz:** MIT  

---

## 🙏 Credits

- **DaRa Dataset:** TU Dortmund (FLW) + Fraunhofer IML
- **Hauptforscher:** Friedrich Niemann
- **Publikation:** "DaRa Dataset Description" (Stand 20.10.2025)
- **PDF-Quelle:** "Anatomisch-Biomechanische Bewegungsanalyse der manuellen Kommissionierung"
- **Lagerlayout-Quelle:** Fraunhofer IML Picking Lab Dokumentation

---

**Hinweis:** Dieser Skill ist für wissenschaftliche Forschungszwecke entwickelt und basiert ausschließlich auf verifizierten Quellen (DaRa Dataset Description + Lagerlayout-Dokumentation).
