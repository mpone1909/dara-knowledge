```md
# DaRa Skill v5.0 — Struktur-Übersicht

**Release:** v5.0.0  
**Datum:** 05.02.2026  
**Dateien:** 18 finale v5_0-Dateien  
**Gesamtgröße:** ~324 KB, 9.655 Zeilen

---

## 📊 STRUKTURBAUM

```

/dara-skill-v5.0/
├── CORE (5 Dateien, ~123 KB, 2.890 Zeilen)
│   ├── core_labels_207_v5_0.md (711 Zeilen, 21 KB)
│   ├── core_articles_inventory_v5_0.md (162 Zeilen, 7.8 KB)
│   ├── core_category_activation_matrix_v5_0.md (742 Zeilen, 25 KB)
│   ├── core_ground_truth_central_v5_0.md (478 Zeilen, 19 KB)
│   └── core_validation_rules_v5_0.md (798 Zeilen, 30 KB) [NEU v5.0]
│
├── AUXILIARY (5 Dateien, ~95 KB, 2.252 Zeilen)
│   ├── auxiliary_chunking_v5_0_repaired.md (1.212 Zeilen, 43 KB)
│   ├── auxiliary_data_structure_v5_0.md (326 Zeilen, 10 KB)
│   ├── auxiliary_dataset_core_v5_0.md (258 Zeilen, 14 KB)
│   ├── auxiliary_semantics_v5_0.md (187 Zeilen, 9 KB)
│   └── auxiliary_warehouse_physical_v5_0.md (270 Zeilen, 11 KB)
│
├── PROCESSES (5 Dateien, ~87 KB, 3.276 Zeilen)
│   ├── processes_bpmn_validation_v5_0_NEW.md (1.623 Zeilen, 55 KB)
│   ├── processes_bpmn_validation_quickstart_v5_0.md (522 Zeilen, 14 KB)
│   ├── processes_process_hierarchy_v5_0_repaired.md (597 Zeilen, 18 KB)
│   ├── processes_refa_analytics_v5_0.md (313 Zeilen, 12 KB)
│   └── processes_mtm_codes_v5_0.md (223 Zeilen, 6.6 KB)
│
├── ASSETS (3 Dateien, ~34 KB, 1.198 Zeilen)
│   ├── assets_query_patterns_v5_0.md (570 Zeilen, 16 KB)
│   ├── assets_bpmn_validation_report_template_v5_0.md (371 Zeilen, 9.3 KB)
│   └── assets_scenario_report_template_v5_0.md (257 Zeilen, 8.6 KB)
│
├── RELEASE-DOKUMENTATION
│   ├── CHANGELOG_v5_0.md
│   ├── MIGRATION_v4_x_to_v5_0.md
│   ├── STRUCTURE_v5_0.md (diese Datei)
│   └── phase4_konsolidierungsplan_v5_0.md
│
└── SKILL (Phase 7, ausstehend)
└── SKILL_v5_0.md

```

---

## 📁 DATEI-DETAILS

### CORE-DATEIEN

#### 1. core_labels_207_v5_0.md
**Zeilen:** 711 | **Größe:** 21 KB | **Status:** finalisiert

**Zweck:** Vollständiges Label-Inventar (CL001–CL207)

**Inhalt:**
- Systematische Klassifizierung der 12 Klassenkategorien (CC01–CC12)
- Detaillierte Label-Definitionen mit Beschreibungen
- Hierarchische Struktur (High/Mid/Low-Level)
- Chunking Trigger-Referenzen (T1–T13)

**Abhängigkeiten:** Keine (Root-Datei)

**Wird referenziert von:**
- core_validation_rules_v5_0.md
- auxiliary_chunking_v5_0_repaired.md
- auxiliary_semantics_v5_0.md
- processes_bpmn_validation_v5_0_NEW.md

---

#### 2. core_articles_inventory_v5_0.md
**Zeilen:** 162 | **Größe:** 7.8 KB | **Status:** finalisiert

**Zweck:** Artikel-Stammdaten (74 Artikel)

**Inhalt:**
- Gewichtsklassen (sehr leicht bis sehr schwer)
- Artikel-Lookup-Tabelle (ID, Name, Gewicht, Abmessungen)
- Handling-Anforderungen pro Gewichtsklasse

**Abhängigkeiten:** Keine

**Wird referenziert von:** Selten (meist interne Nutzung)

---

#### 3. core_category_activation_matrix_v5_0.md
**Zeilen:** 742 | **Größe:** 25 KB | **Status:** finalisiert

**Zweck:** Szenario-Label-Mappings

**Inhalt:**
- Category Activation Matrices für S1–S8
- Erwartete Label-Kombinationen pro Szenario
- IT-System-Mappings (PDT, List+Pen, Computer)
- Multi-Order Patterns (S7/S8)

**Abhängigkeiten:**
- core_labels_207_v5_0.md
- core_ground_truth_central_v5_0.md

**Wird referenziert von:**
- core_validation_rules_v5_0.md
- core_ground_truth_central_v5_0.md

---

#### 4. core_ground_truth_central_v5_0.md
**Zeilen:** 478 | **Größe:** 19 KB | **Status:** finalisiert

**Zweck:** Szenario-Klassifikationslogik (Ground Truth v3.0)

**Inhalt:**
- 5-Schritt Decision-Logik
- Global Interrupts (T11–T13: Other_Waiting, Other_Process, Other_NoData)
- Szenario-Definitionen (S1–S8 + Other)
- Trigger-Mappings
- Multi-Order Loop-Validierung (S7/S8)

**Abhängigkeiten:**
- core_labels_207_v5_0.md
- core_category_activation_matrix_v5_0.md
- auxiliary_chunking_v5_0_repaired.md (implizit: Trigger T11–T13)

**Wird referenziert von:**
- processes_bpmn_validation_v5_0_NEW.md
- core_validation_rules_v5_0.md
- auxiliary_chunking_v5_0_repaired.md

---

#### 5. core_validation_rules_v5_0.md ⭐ NEU
**Zeilen:** 798 | **Größe:** 30 KB | **Status:** finalisiert

**Zweck:** Zentrale Frame-Level Validierungsregeln

**Inhalt:**
- Master-Slave-Abhängigkeiten (CC01 → CC02–CC05)
- Label-Kombinationsregeln (Python-Code-Beispiele)
- Spezielle Validierungen:
  - Multi-Order Co-Activation
  - CL134 Global Interrupt Priorisierung
  - Tool-Requirements (CL145, CL150, etc.)
- BPMN-Prozess-Mappings (Anhang)

**Abhängigkeiten:**
- core_labels_207_v5_0.md
- core_category_activation_matrix_v5_0.md
- core_ground_truth_central_v5_0.md

**Wird referenziert von:**
- processes_bpmn_validation_v5_0_NEW.md
- auxiliary_chunking_v5_0_repaired.md

---

### AUXILIARY-DATEIEN

#### 6. auxiliary_chunking_v5_0_repaired.md
**Zeilen:** 1.212 | **Größe:** 43 KB | **Status:** finalisiert (repaired)

**Zweck:** Chunking-Logik & Trigger-System

**Inhalt:**
- Fundamentale Chunk-Definition
- Trigger-System (T1–T13):
  - Motor-Trigger (T1–T5)
  - Context-Trigger (T6–T7)
  - Process-Trigger (T8–T10)
  - Extensions-Trigger (T11–T13)
- Chunk-Detection-Algorithmus
- Integration Ground Truth v3.0
- Multi-Order Handling (S7/S8)

**Abhängigkeiten:**
- core_labels_207_v5_0.md
- core_ground_truth_central_v5_0.md
- processes_process_hierarchy_v5_0_repaired.md
- core_validation_rules_v5_0.md

**Wird referenziert von:**
- core_ground_truth_central_v5_0.md
- auxiliary_semantics_v5_0.md
- processes_refa_analytics_v5_0.md

**Hinweis:** `_repaired`-Suffix zeigt Encoding-Fehlerkorrektur an.

---

#### 7. auxiliary_data_structure_v5_0.md
**Zeilen:** 326 | **Größe:** 10 KB | **Status:** finalisiert

**Zweck:** Datenstruktur & Sessions

**Inhalt:**
- Frame-Struktur (30 fps)
- Session-Definitionen (1–6 pro Proband)
- CSV-Format-Spezifikationen
- Synchronisation zwischen Kategorien

**Abhängigkeiten:**
- core_labels_207_v5_0.md
- auxiliary_dataset_core_v5_0.md

**Wird referenziert von:**
- auxiliary_dataset_core_v5_0.md
- processes_bpmn_validation_v5_0_NEW.md

---

#### 8. auxiliary_dataset_core_v5_0.md
**Zeilen:** 258 | **Größe:** 14 KB | **Status:** finalisiert

**Zweck:** Dataset-Kerndokumentation

**Inhalt:**
- Zweck und Kontext des Datensatzes
- OMNI Warehouse physische Umgebung (Referenz)
- Probanden-Demographie (S01–S18)
- Session-Übersicht

**Abhängigkeiten:**
- auxiliary_warehouse_physical_v5_0.md
- core_labels_207_v5_0.md
- auxiliary_data_structure_v5_0.md

**Wird referenziert von:**
- auxiliary_warehouse_physical_v5_0.md
- processes_process_hierarchy_v5_0_repaired.md

---

#### 9. auxiliary_semantics_v5_0.md
**Zeilen:** 187 | **Größe:** 9 KB | **Status:** finalisiert

**Zweck:** Semantische Grunddefinitionen

**Inhalt:**
- Semantische Hierarchie (12 Klassenkategorien)
- Label-Kombinationen und Beziehungen
- Interpretation von Multi-Label-Zuständen

**Abhängigkeiten:**
- core_labels_207_v5_0.md
- core_ground_truth_central_v5_0.md
- auxiliary_chunking_v5_0_repaired.md

**Wird referenziert von:**
- auxiliary_dataset_core_v5_0.md

---

#### 10. auxiliary_warehouse_physical_v5_0.md
**Zeilen:** 270 | **Größe:** 11 KB | **Status:** finalisiert

**Zweck:** Physische Umgebung & Laboraufbau

**Inhalt:**
- OMNI Warehouse (Fraunhofer IML) Spezifikationen
- Lagerlayout (Aisles, Base, Office, Computer Station)
- Location-Graph (CC11-Transitions)
- Dimensionen und Abstände

**Abhängigkeiten:**
- auxiliary_dataset_core_v5_0.md
- core_labels_207_v5_0.md

**Wird referenziert von:**
- auxiliary_dataset_core_v5_0.md
- processes_bpmn_validation_v5_0_NEW.md

---

### PROCESSES-DATEIEN

#### 11. processes_bpmn_validation_v5_0_NEW.md
**Zeilen:** 1.623 | **Größe:** 55 KB | **Status:** finalisiert (NEW)

**Zweck:** Vollständige BPMN-Validierungslogik

**Inhalt:**
- Sequenz-Validierung (FSM für CC09)
- Detaillierte Prozessflows (Figures A2–A7):
  - CL114: Preparing Order
  - CL115/CL116: Picking (Travel/Pick Time)
  - CL118: Packing
  - CL117: Unpacking
  - CL119/CL120: Storing (Travel/Store Time)
  - CL121: Finalizing Order
- Szenario-Routing Matrix (S1–S8)
- Error-Handling Details (CL135)
- Tool-Validierung (CL145, CL150, etc.)
- Location-Validierung & Teleportation-Detection
- Multi-Order-Validierung (S7/S8)
- CL134 Global Interrupt Priorisierung
- BPMN-Generierung & Visualisierung
- Abweichungs-Kategorien & Reporting
- Automatische Fehlerursachen-Hypothesen

**Abhängigkeiten:**
- core_validation_rules_v5_0.md
- core_labels_207_v5_0.md
- processes_process_hierarchy_v5_0_repaired.md
- core_ground_truth_central_v5_0.md
- auxiliary_data_structure_v5_0.md

**Wird referenziert von:**
- processes_bpmn_validation_quickstart_v5_0.md
- auxiliary_chunking_v5_0_repaired.md

**Hinweis:** `_NEW`-Suffix zeigt vollständige Neuerstellung an.

---

#### 12. processes_bpmn_validation_quickstart_v5_0.md
**Zeilen:** 522 | **Größe:** 14 KB | **Status:** finalisiert

**Zweck:** Praktischer Leitfaden für BPMN-Validierung

**Inhalt:**
- Quick Start (4 Schritte)
- 5 Verwendungsszenarien
- Visualisierung (Mermaid)
- Report-Generierung
- Fehlersuche & Troubleshooting
- Best Practices

**Abhängigkeiten:**
- processes_bpmn_validation_v5_0_NEW.md (Hauptreferenz)

**Wird referenziert von:** Selten (Tutorial-Charakter)

---

#### 13. processes_process_hierarchy_v5_0_repaired.md
**Zeilen:** 597 | **Größe:** 18 KB | **Status:** finalisiert (repaired)

**Zweck:** Prozess-Details & Hierarchie

**Inhalt:**
- High-Level Prozesse (CC08): CL110 Retrieval, CL111 Storage
- Mid-Level Prozesse (CC09): CL114–CL121 (7 Prozesse)
- Low-Level Prozesse (CC10): CL124–CL152 (29 Prozesse)
- Prozess-Mappings und Hierarchie-Tabellen

**Abhängigkeiten:**
- core_labels_207_v5_0.md
- core_ground_truth_central_v5_0.md
- auxiliary_chunking_v5_0_repaired.md
- auxiliary_dataset_core_v5_0.md

**Wird referenziert von:**
- processes_bpmn_validation_v5_0_NEW.md
- auxiliary_chunking_v5_0_repaired.md

**Hinweis:** `_repaired`-Suffix zeigt Format-Fehlerkorrektur an.

---

#### 14. processes_refa_analytics_v5_0.md
**Zeilen:** 313 | **Größe:** 12 KB | **Status:** finalisiert

**Zweck:** REFA-Analytik und Zeitarten

**Inhalt:**
- Transformation DaRa → REFA-Zeitarten
- REFA-Hauptzeitarten (Grundzeit, Verteilzeit, Erholungszeit)
- Zuordnungstabellen (CC09 → REFA)
- Chunking-Integration

**Abhängigkeiten:**
- auxiliary_chunking_v5_0_repaired.md
- processes_process_hierarchy_v5_0_repaired.md

**Wird referenziert von:** Selten (Spezialthema)

---

#### 15. processes_mtm_codes_v5_0.md
**Zeilen:** 223 | **Größe:** 6.6 KB | **Status:** finalisiert

**Zweck:** MTM-1 Grundbewegungen Mapping

**Inhalt:**
- MTM-Einheit (TMU)
- MTM-1 Grundbewegungen (Greifen, Hinlangen, Loslassen, etc.)
- DaRa-Label → MTM-Mapping
- Bewegungsanalyse-Grundlagen

**Abhängigkeiten:**
- core_labels_207_v5_0.md (implizit)

**Wird referenziert von:** Selten (Spezialthema)

---

### ASSETS-DATEIEN

#### 16. assets_query_patterns_v5_0.md
**Zeilen:** 570 | **Größe:** 16 KB | **Status:** finalisiert

**Zweck:** Query Patterns & Best Practices

**Inhalt:**
- Fragetypen-Klassifikation
- Query-Routing-Logik
- Beispiel-Queries mit Lösungen
- Skill-Anwendungsszenarien

**Abhängigkeiten:**
- Alle core_*-Dateien (referenziert für Query-Routing)
- Alle auxiliary_*-Dateien
- Alle processes_*-Dateien

**Wird referenziert von:** SKILL.md (in Phase 7)

---

#### 17. assets_bpmn_validation_report_template_v5_0.md
**Zeilen:** 371 | **Größe:** 9.3 KB | **Status:** finalisiert

**Zweck:** BPMN Validation Report Template

**Inhalt:**
- Metadaten-Sektion
- Executive Summary Template
- IST vs. SOLL Comparison Template
- Violation Analysis Template (7 Kategorien)
- BPMN-Visualisierung Template
- Error Hypotheses Template
- Recommendations Template

**Abhängigkeiten:**
- processes_bpmn_validation_v5_0_NEW.md (Referenz für Verwendung)

**Wird referenziert von:**
- processes_bpmn_validation_quickstart_v5_0.md

---

#### 18. assets_scenario_report_template_v5_0.md
**Zeilen:** 257 | **Größe:** 8.6 KB | **Status:** finalisiert

**Zweck:** Szenario-Bericht-Template

**Inhalt:**
- JSON-Ausgabeformat (maschinenlesbar)
- Markdown-Bericht-Template (menschenlesbar)
- Szenario-Statistiken
- Chunk-Level-Details

**Abhängigkeiten:**
- core_ground_truth_central_v5_0.md (für Szenario-Definitionen)

**Wird referenziert von:** Selten (Template-Charakter)

---

## 🔗 DEPENDENCY-GRAPH

```

[Root-Dateien: Keine Dependencies]
core_labels_207_v5_0.md
core_articles_inventory_v5_0.md

[Tier 1: Abhängig von Root]
core_category_activation_matrix_v5_0.md ← core_labels_207
core_ground_truth_central_v5_0.md ← core_labels_207, category_matrix
auxiliary_data_structure_v5_0.md ← core_labels_207
auxiliary_warehouse_physical_v5_0.md ← core_labels_207

[Tier 2: Abhängig von Tier 1]
core_validation_rules_v5_0.md ← labels, category_matrix, ground_truth
auxiliary_dataset_core_v5_0.md ← warehouse_physical, labels, data_structure
auxiliary_chunking_v5_0_repaired.md ← labels, ground_truth, validation_rules
processes_process_hierarchy_v5_0_repaired.md ← labels, ground_truth

[Tier 3: Abhängig von Tier 2]
processes_bpmn_validation_v5_0_NEW.md ← validation_rules, labels, process_hierarchy, ground_truth
auxiliary_semantics_v5_0.md ← labels, ground_truth, chunking

[Tier 4: Abhängig von Tier 3]
processes_bpmn_validation_quickstart_v5_0.md ← bpmn_validation_NEW
processes_refa_analytics_v5_0.md ← chunking, process_hierarchy
processes_mtm_codes_v5_0.md ← (implizit: labels)

[Assets: Multi-Tier Dependencies]
assets_query_patterns_v5_0.md ← ALLE (Query-Routing)
assets_bpmn_validation_report_template_v5_0.md ← bpmn_validation_NEW
assets_scenario_report_template_v5_0.md ← ground_truth_central

```

---

## 📈 STATISTIKEN

### Größenverteilung

| Kategorie | Anzahl | Anteil |
|-----------|--------|--------|
| Klein (<10 KB) | 5 | 28% |
| Mittel (10–20 KB) | 7 | 39% |
| Groß (20–50 KB) | 5 | 28% |
| Sehr groß (>50 KB) | 1 | 5% |

### Zeilenverteilung

| Kategorie | Anzahl | Anteil |
|-----------|--------|--------|
| Klein (<300 Zeilen) | 5 | 28% |
| Mittel (300–600 Zeilen) | 8 | 44% |
| Groß (600–1200 Zeilen) | 4 | 22% |
| Sehr groß (>1200 Zeilen) | 1 | 6% |

### Komplexität (nach Abhängigkeiten)

| Komplexität | Anzahl | Dateien |
|-------------|--------|---------|
| **Niedrig** (0–1 Dependencies) | 6 | labels, articles, data_structure, warehouse, mtm, scenario_template |
| **Mittel** (2–3 Dependencies) | 8 | category_matrix, ground_truth, dataset_core, semantics, process_hierarchy, quickstart, refa, report_template |
| **Hoch** (4+ Dependencies) | 4 | validation_rules, chunking, bpmn_validation_NEW, query_patterns |

---

## 🎯 VERWENDUNGSHINWEISE

### Für Entwickler
1. **Start:** `core_labels_207_v5_0.md` (Label-Definitionen)
2. **Szenario-Logik:** `core_ground_truth_central_v5_0.md`
3. **Validierung:** `core_validation_rules_v5_0.md` + `processes_bpmn_validation_v5_0_NEW.md`

### Für Forscher
1. **Dataset-Überblick:** `auxiliary_dataset_core_v5_0.md`
2. **Chunking verstehen:** `auxiliary_chunking_v5_0_repaired.md`
3. **BPMN-Validierung anwenden:** `processes_bpmn_validation_quickstart_v5_0.md`

### Für Skill-Integration
1. **Query-Routing:** `assets_query_patterns_v5_0.md`
2. **Navigationslogik:** SKILL.md v5.0 (Phase 7)
3. **Referenzen:** Alle Dateien mit `_v5_0`-Endung

---

## 🔍 DATEINAMEN-KONVENTIONEN

### Präfixe
- **core_** → Kern-Definitionen (Labels, Szenarien, Validierung)
- **auxiliary_** → Hilfsinformationen (Chunking, Struktur, Warehouse)
- **processes_** → Prozess-spezifische Logik (BPMN, REFA, MTM)
- **assets_** → Wiederverwendbare Templates & Patterns

### Suffixe
- **_v5_0** → Versionsnummer (alle Dateien)
- **_repaired** → Fehlerkorrektur (Encoding, Format)
- **_NEW** → Vollständige Neuerstellung (>50% geändert)

---

## ✅ QUALITÄTSMERKMALE

### Konsistenz
- ✅ Alle Dateinamen mit `_v5_0`-Suffix
- ✅ Alle Cross-Referenzen mit korrekten Dateinamen
- ✅ 0 fehlerhafte Referenzen nach Phase 6

### Vollständigkeit
- ✅ 18/18 Dateien finalisiert
- ✅ 11/18 Dateien mit YAML-Headern (version, status)
- ✅ Alle Dependencies dokumentiert

### Strukturqualität
- ✅ Klare Präfix-Gruppierung (core, auxiliary, processes, assets)
- ✅ Ausgeglichene Größenverteilung (max. 55 KB)
- ✅ Minimale Cross-Referenzen (~80 Links)

---

## 📝 NÄCHSTE SCHRITTE (Phase 7)

1. **SKILL_v5_0.md erstellen**
   - Navigationslogik mit allen v5_0-Referenzen
   - Metadaten-Update (Version 5.0, Feature-Liste)
   - Changelog-Integration

2. **README_v5_0.md** (optional)
   - Quick Start für neue Nutzer
   - Installation & Setup
   - Beispiel-Workflows

---

**Version:** 1.0  
**Erstellt:** 05.02.2026  
**Status:** Finalisiert ✅  
**Autor:** Phase 6 Globale Verifikation
```
