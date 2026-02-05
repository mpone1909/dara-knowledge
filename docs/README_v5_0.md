# DaRa Skill v5.0 — Quick Start Guide

**Version:** 5.0.0  
**Release-Datum:** 05.02.2026  
**Status:** Production-Ready ✅

---

## 🎯 Was ist der DaRa Skill?

Der **DaRa Dataset Expert Skill** ermöglicht Claude die präzise, faktenbasierte Analyse des DaRa-Datensatzes für intralogistische Warehouse-Prozesse.

**Kern-Features:**
- ✅ **207 Labels** in 12 Klassenkategorien (CC01–CC12)
- ✅ **8 Szenarien** (S1–S8) für Retrieval/Storage-Prozesse
- ✅ **18 Probanden** (S01–S18) mit vollständiger Demographie
- ✅ **BPMN-Validierung** für IST/SOLL-Vergleich
- ✅ **REFA/MTM-Integration** für Zeitartenanalyse
- ✅ **Chunking-System** mit 13 Triggern (T1–T13)
- ✅ **Ground Truth v3.0** mit 5-Schritt Decision-Logik

---

## 🚀 Quick Start (3 Schritte)

### Schritt 1: Skill aktivieren

Der Skill ist bereits in diesem Projekt aktiviert. Alle 18 v5_0-Dateien sind verfügbar.

### Schritt 2: Erste Frage stellen

**Beispiel-Fragen:**
"Wie viele Probanden gibt es im DaRa-Datensatz?"
"Erkläre das Chunking-System"
"Was ist der Unterschied zwischen S1 und S7?"
"Validiere einen Retrieval-Prozess gegen BPMN"


### Schritt 3: Tiefere Analysen

**Für Forscher:**
- Szenario-Klassifikation
- BPMN-Validierung
- Multi-Order Analysen (S7/S8)

**Für Entwickler:**
- Label-Kombinationsregeln
- Validierungslogik implementieren
- REFA-Zeitarten-Mapping

---

## 📁 Dateistruktur

/dara-skill-v5.0/
├── CORE (5 Dateien)
│ ├── core_labels_207_v5_0.md → 207 Label-Definitionen
│ ├── core_ground_truth_central_v5_0.md → Szenario-Klassifikation
│ ├── core_validation_rules_v5_0.md → Frame-Level Validierung
│ ├── core_category_activation_matrix_v5_0.md
│ └── core_articles_inventory_v5_0.md
│
├── AUXILIARY (5 Dateien)
│ ├── auxiliary_chunking_v5_0_repaired.md → Chunking & Trigger
│ ├── auxiliary_dataset_core_v5_0.md → Dataset-Übersicht
│ ├── auxiliary_data_structure_v5_0.md
│ ├── auxiliary_semantics_v5_0.md
│ └── auxiliary_warehouse_physical_v5_0.md
│
├── PROCESSES (5 Dateien)
│ ├── processes_bpmn_validation_v5_0_NEW.md → BPMN-Validierung
│ ├── processes_bpmn_validation_quickstart_v5_0.md
│ ├── processes_process_hierarchy_v5_0_repaired.md
│ ├── processes_refa_analytics_v5_0.md
│ └── processes_mtm_codes_v5_0.md
│
└── ASSETS (3 Dateien)
├── assets_query_patterns_v5_0.md
├── assets_bpmn_validation_report_template_v5_0.md
└── assets_scenario_report_template_v5_0.md


**Gesamt:** 18 Dateien, ~324 KB, 9.655 Zeilen

---

## 🎓 Lernpfad

### Stufe 1: Einsteiger (1–2 Stunden)

**Ziel:** Verstehen der Grundstruktur

1. **Dataset-Überblick**
   - Lies: `auxiliary_dataset_core_v5_0.md`
   - Verstehe: 18 Probanden, Sessions, Szenarien

2. **Label-System**
   - Lies: `core_labels_207_v5_0.md` (Überblick)
   - Lerne: 12 Kategorien (CC01–CC12)

3. **Erste Analyse**
   - Stelle Fragen: "Wie funktioniert Szenario S1?"
   - Nutze: Claude's Antworten basieren auf den Skill-Dateien

---

### Stufe 2: Fortgeschritten (3–5 Stunden)

**Ziel:** Arbeiten mit Validierung & Chunking

1. **Chunking-System**
   - Lies: `auxiliary_chunking_v5_0_repaired.md`
   - Verstehe: Trigger T1–T13

2. **Szenario-Klassifikation**
   - Lies: `core_ground_truth_central_v5_0.md`
   - Verstehe: 5-Schritt Decision-Logik

3. **Validierungsregeln**
   - Lies: `core_validation_rules_v5_0.md`
   - Implementiere: Master-Slave-Abhängigkeiten

---

### Stufe 3: Experte (5–10 Stunden)

**Ziel:** BPMN-Validierung & vollständige Analysen

1. **BPMN-Validierung**
   - Lies: `processes_bpmn_validation_v5_0_NEW.md`
   - Tutorial: `processes_bpmn_validation_quickstart_v5_0.md`

2. **Vollständige Analysen**
   - Multi-Order Szenarien (S7/S8)
   - IST/SOLL-Vergleich
   - Conformity Scores

3. **REFA/MTM Integration**
   - Zeitarten-Mapping
   - MTM-Grundbewegungen

---

## 💡 Häufige Anwendungsfälle

### Use Case 1: Szenario-Erkennung

**Frage:** "Wie erkenne ich, ob ein Frame zu S7 gehört?"

**Antwort nutzt:**
- `core_ground_truth_central_v5_0.md` → 5-Schritt Logik
- `core_labels_207_v5_0.md` → Label-Definitionen
- `auxiliary_chunking_v5_0_repaired.md` → Trigger T6 (Order Addition)

---

### Use Case 2: BPMN-Validierung

**Frage:** "Validiere diesen Retrieval-Prozess gegen BPMN"

**Antwort nutzt:**
- `processes_bpmn_validation_v5_0_NEW.md` → Sequenz-FSM
- `core_validation_rules_v5_0.md` → Tool-Requirements
- `processes_process_hierarchy_v5_0_repaired.md` → Prozess-Details

**Tutorial:** `processes_bpmn_validation_quickstart_v5_0.md`

---

### Use Case 3: Multi-Order Analyse (S7/S8)

**Frage:** "Wie unterscheiden sich S7 und S8?"

**Antwort nutzt:**
- `core_ground_truth_central_v5_0.md` → S7/S8 Definitionen
- `auxiliary_chunking_v5_0_repaired.md` → Multi-Order Handling (Kapitel 4.6)
- `core_category_activation_matrix_v5_0.md` → IT-Switch Patterns

---

### Use Case 4: REFA-Zeitarten

**Frage:** "Welche DaRa-Labels entsprechen der Haupttätigkeit?"

**Antwort nutzt:**
- `processes_refa_analytics_v5_0.md` → REFA-Mapping
- `core_labels_207_v5_0.md` → Label-Definitionen
- `processes_process_hierarchy_v5_0_repaired.md` → CC09-Prozesse

---

## 📊 Skill-Capabilities (Übersicht)

### ✅ Kann beantwortet werden

| Domäne | Beispiel-Fragen |
|--------|-----------------|
| **Labels** | "Welche Labels gehören zu CC04?", "Was ist CL115?" |
| **Szenarien** | "Unterschied S1 vs S4?", "Wie erkenne ich S7?" |
| **Validierung** | "Darf CC01=Walking wenn CC02=Standing Still?", "Tool-Requirements für CL145?" |
| **BPMN** | "Validiere Prozess gegen BPMN", "IST/SOLL-Vergleich" |
| **Chunking** | "Was sind Trigger T1–T13?", "Wann endet ein Chunk?" |
| **REFA** | "Was ist $t_{MH}$?", "Erholungszeit für CC03=Bending?" |
| **Warehouse** | "Wie groß ist Aisle 3?", "Location-Transitions?" |
| **Artikel** | "Gewicht von Artikel 2904-001?", "Alle Large-Artikel?" |

### ❌ Kann NICHT beantwortet werden

| Domäne | Warum nicht |
|--------|-------------|
| **Rohdaten-Analyse** | Keine CSV-Dateien im Skill |
| **Statistik** | Keine Frame-Daten, nur Dokumentation |
| **Vorhersagen** | Skill ist deskriptiv, nicht prädiktiv |
| **Modelltraining** | Außerhalb des Scopes |
| **Video-Analyse** | Keine Video-Daten |

---

## 🔧 Für Entwickler

### Integration in eigene Anwendung

**Python-Beispiel:**
```python
from claude_api import Claude

# Initialisiere Claude mit DaRa Skill
claude = Claude(project="dara-skill-v5.0")

# Stelle Frage
response = claude.query("Validiere diesen Frame gegen CC01-Master-Slave-Regeln")

# Antwort basiert auf core_validation_rules_v5_0.md
print(response)
Wichtige Dateien für Entwickler
Aufgabe	Datei
Label-Lookup	core_labels_207_v5_0.md
Validierung	core_validation_rules_v5_0.md
Szenario-Klassifikation	core_ground_truth_central_v5_0.md
BPMN-Validierung	processes_bpmn_validation_v5_0_NEW.md
Query-Patterns	assets_query_patterns_v5_0.md
📚 Dokumentation
Release-Dokumente (v5.0)
CHANGELOG_v5_0.md — Vollständige Änderungshistorie

MIGRATION_v4_x_to_v5_0.md — Upgrade-Anleitung von v4.x

STRUCTURE_v5_0.md — Detaillierte Dateistruktur-Übersicht

README_v5_0.md — Dieses Dokument

Prozess-Dokumentation
phase4_konsolidierungsplan_v5_0.md — Konsolidierungsanalyse

phase6_abschlussbericht.md — Verifikations-Bericht

🔘 Häufige Probleme & Lösungen
Problem 1: "Skill antwortet nicht präzise"
Lösung: Stelle spezifischere Fragen

❌ "Was ist DaRa?"

✅ "Wie viele Labels gibt es in CC04?"

Problem 2: "Referenz auf alte Dateinamen"
Lösung: Nutze v5_0-Dateinamen

❌ chunking.md

✅ auxiliary_chunking_v5_0_repaired.md

Problem 3: "Wie finde ich die richtige Datei?"
Lösung: Nutze assets_query_patterns_v5_0.md

Enthält Query-Routing-Logik

Zeigt, welche Datei für welche Frage relevant ist

🚦 Nächste Schritte
Für Anfänger
✅ Lies dieses README

✅ Öffne auxiliary_dataset_core_v5_0.md

✅ Stelle erste Frage: "Wie viele Probanden gibt es?"

Für Fortgeschrittene
✅ Lies core_ground_truth_central_v5_0.md

✅ Verstehe 5-Schritt Decision-Logik

✅ Analysiere Multi-Order Szenarien (S7/S8)

Für Experten
✅ Lies processes_bpmn_validation_v5_0_NEW.md

✅ Implementiere Validierung in eigener Anwendung

✅ Erweitere Skill mit eigenen Analysen

📞 Support & Community
Fragen zu v5.0?

Siehe MIGRATION_v4_x_to_v5_0.md für Upgrade-Hilfe

Siehe CHANGELOG_v5_0.md für alle Änderungen

Feature-Requests?

Kontaktiere das Anthropic-Team

Nutze Feedback-Button in Claude.ai

Bug-Reports?

Dokumentiere: Welche Frage, welche Antwort, was erwartet

Referenz: Relevante Skill-Datei

🎉 Zusammenfassung
DaRa Skill v5.0 bietet:

✅ 18 finale, verifizierte Dateien

✅ 0 fehlerhafte Referenzen

✅ 100% Referenzintegrität

✅ Vollständige BPMN-Validierung

✅ Ground Truth v3.0 Integration

✅ Multi-Order Support (S7/S8)

✅ REFA/MTM-Methodik

✅ Produktions-reif

Viel Erfolg mit dem DaRa Skill v5.0! 🚀

Version: 1.0
Erstellt: 05.02.2026
Autor: Phase 7 Finaler Skill-Aufbau
Status: Production-Ready ✅