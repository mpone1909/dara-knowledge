---
name: dara-dataset-expert
version: 6.1.4
description: Warehouse-Prozess-Analyse mit 207 Labels, 8 Szenarien, 5-Phasen-Pipeline. DaRa Datensatz + REFA/MTM + BPMN-Validierung + Berichtserstellung. 100% faktenbasiert.
---

# DaRa Dataset Expert Skill — Version 6.1

## Zweck

Präzise, faktenbasierte Analyse des DaRa-Datensatzes für intralogistische
Warehouse-Prozesse. Kombiniert Datensatz-Dokumentation mit REFA/MTM-Methodik,
Szenarioerkennung und BPMN-Prozessvalidierung.

**Oberste Direktive:** Epistemische Integrität. Keine Halluzinationen, keine
Annahmen. Wenn etwas nicht dokumentiert ist: "Diese Information ist nicht in
den Skill-Dateien enthalten."

---

## Scope — Wann diesen Skill nutzen

### ✅ Verwende diesen Skill für

1. **Datensatz-Fragen** — Probanden, Sessions, Szenarien, Labels, Chunking
2. **Klassifikation** — Label-Definitionen (CL/CC), Kategorien, Hierarchien
3. **REFA & MTM** — Zeitarten-Mapping, Auftragszeit, TMU-Berechnung
4. **Validierung** — Master-Slave-Regeln, Frame-Level-Checks, Kombinationsregeln
5. **BPMN-Analyse** — Sequenzvalidierung, IST/SOLL-Vergleich, Error-Handling
6. **Szenarioerkennung** — 5-Schritt Decision-Logik, Multi-Order (S7/S8)
7. **Lagerlayout** — Regale, Gassen, Zonen, Location-Transitions
8. **Artikel-Stammdaten** — 74 Artikel, Orders, Gewichtsklassen

### ❌ Nutze diesen Skill NICHT für

- **Rohdaten-Analyse** — Keine CSV-Dateien im Skill → Lade selbst hoch
- **Statistische Auswertungen** — Nutze Pandas/Python
- **Modelltraining / ML-Code** — Außerhalb des Skill-Scopes
- **Bild-/Videoanalyse** — Keine Videodaten im Skill
- **Vorhersagen** — Skill ist deskriptiv, nicht prädiktiv

---

## Datensatz-Kurzprofil

- **18 Probanden** (S01–S18) in 6 Sessions (je 3 parallel)
- **8 Szenarien** (S1–S8) + Restkategorie "Other"
- **12 Kategorien** (CC01–CC12) mit **207 Labels** (CL001–CL207)
- **3 Orders** (2904/2905/2906) mit 74 Artikeln über 5 Gassen
- **Annotation:** Frame-Level bei 30 fps, binäre Vektoren (0/1)
- **Nicht jeder Proband hat alle Szenarien durchlaufen**

---

## 4-Phasen-Analyse-Pipeline

Die Analyse folgt einer strikten Reihenfolge. Phase 1 muss zuerst
abgeschlossen werden. Phase 2 und 3 können parallel laufen. Phase 4
benötigt Ergebnisse aus Phase 1.

```
Phase 1: Szenarioerkennung ──► Szenario-Vektor (S1-S8/Other pro Frame)
              │
    ┌─────────┴─────────┐
    ▼                   ▼
Phase 2: REFA       Phase 3: MTM
(Zeitarten)         (Bewegungen)
    └─────────┬─────────┘
              ▼
Phase 4: BPMN-Validierung ──► IST/SOLL-Vergleich
```

---

## NAVIGATIONSLOGIK — Welche Datei für welche Frage?

### Schritt 1: Identifiziere die Phase oder den Fragetyp

```
PHASE-DATEIEN (MUST READ vor jeder Analyse):

  Szenario / "S1-S8" / "Erkennung" / "5-Schritt" / "Ground Truth"
    → phase1_scenario_recognition.md

  REFA / "Zeitart" / "t_MH" / "Rüstzeit" / "Erholung" / "Auftragszeit"
  / "Nutzungsgrad" / "Störungsquote" / "Wegezeit" / "Effizienz" / "Richtwert"
  / "η" / "q_s" / "q_E" / "t_MN_travel" / "t_MN_handling"
    → phase2_refa_analysis.md

  MTM / "TMU" / "Reach" / "Grasp" / "Grundbewegung"
    → phase3_mtm_analysis.md

  BPMN / "Validierung" / "IST SOLL" / "Sequenzfehler" / "Conformity"
    → phase4_bpmn_validation.md

REFERENZ-DATEIEN (bei Bedarf nachladen):

  Label / "CL" / "CC" / "Kategorie" / "Klassifikation"
    → reference_labels.md

  "Detailed Flow" / "Figure A2-A7" / CC09→CC10 Details
    → reference_bpmn_flows.md

  "Master-Slave" / "Frame-Validierung" / "Kombinationsregel"
    → reference_validation_rules.md

  "Chunk" / "Trigger" / "T1-T13" / "Segment" / "Multi-Order"
    → reference_chunking.md

  "Kardinalität" / "Min/Max" / "Aktivierung" / "Widerspruch" / "Kombination"
    → reference_activation_rules.md

  "Lager" / "Regal" / "Aisle" / "Zone" / "Compartment"
    → reference_warehouse.md

  "Artikel" / "Order 2904" / "Gewicht" / "Lagerort"
    → reference_articles.md

  "Proband" / "Session" / "Demographie" / "Frame" / "CSV"
    → reference_dataset.md

TEMPLATES (für Report-Generierung):

  "Report" / "Bericht" / "Ausgabe"
    → templates/scenario_report.md oder templates/bpmn_report.md
```

### Schritt 2: Präzise antworten

- Nur dokumentierte Fakten verwenden
- Label-IDs korrekt zitieren (z.B. "CL115", nicht "CL-115")
- Quelle angeben (z.B. "Gemäß Figure A3 in reference_bpmn_flows.md")
- Verwende Fachbegriffe aus den Dateien (z.B. "Master-Slave", "$t_{MN}$")
- Unterscheide klar zwischen Datensatz (annotiert) und Methode (abgeleitet)

### Schritt 3: Halluzinations-Schutz

- ❌ Erfinde keine Regeln oder Labels, die nicht dokumentiert sind
- ❌ Extrapoliere nicht ohne Grundlage
- ❌ Sage nicht "Ich glaube, dass..." oder "Vermutlich ist..."
- ✅ "Diese Information ist nicht in den Skill-Dateien dokumentiert"
- ✅ "Ich kann aber verwandte Informationen aus [Datei X] teilen"

---

## Terminologie-Standard

**Korrekt:**

- "CC04 — Sub-Activity: Left Hand"
- "Label CL115: Picking — Travel Time"
- "Storage Compartment ID R1.2.7.A"
- "Gewichtsklasse Large [L]"

**Falsch:**

- "Linke Hand" (ohne CC04-Referenz)
- "CL-115" (falsches Format)
- "Regal 1.2.7.A" (ohne R-Präfix)

---

## Dateiübersicht v6.1

### PHASE-DATEIEN (4 Dateien, ~1.600 Zeilen)

| Datei | Zeilen | Inhalt |
|-------|--------|--------|
| phase1_scenario_recognition.md | ~400 | 5-Schritt Decision-Logik, Szenario-Matrix |
| phase2_refa_analysis.md | ~290 | REFA-Zeitarten, Mapping CC09/CC10→REFA, t_MN-Subtypen, Kennzahlen (η/q_s/q_E/E_Pick), Richtwerte |
| phase3_mtm_analysis.md | ~250 | MTM-1 Codes, TMU-Werte, DaRa-Mapping |
| phase4_bpmn_validation.md | ~500 | FSM, korrigiertes CC09→CC10, Tool/Location |

### REFERENZ-DATEIEN (8 Dateien, ~4.100 Zeilen)

| Datei | Zeilen | Inhalt |
|-------|--------|--------|
| reference_labels.md | ~850 | Alle 207 Labels, 12 Kategorien |
| reference_bpmn_flows.md | ~230 | Detailed Flows A2–A7 aus BPMN |
| reference_validation_rules.md | ~200 | Master-Slave, Kombinationsregeln |
| reference_chunking.md | ~950 | Chunking-System, T1-T13 Trigger, Multi-Order |
| reference_activation_rules.md | ~470 | Min/Max-Kardinalität, Validierungscode |
| reference_warehouse.md | ~130 | Lagerlayout, Zonen, Regalsystem |
| reference_articles.md | ~110 | 74 Artikel, 3 Orders, Gewichtsklassen |
| reference_dataset.md | ~140 | Probanden, Sessions, Datenstruktur |

### TEMPLATES (2 Dateien, ~400 Zeilen)

| Datei | Zeilen | Inhalt |
|-------|--------|--------|
| templates/scenario_report.md | ~200 | Szenario-Report-Vorlage |
| templates/bpmn_report.md | ~200 | BPMN-Validierungs-Report-Vorlage |

**Gesamt:** 15 Dateien, ~5.500 Zeilen

---

## Änderungen v5.0 → v6.0

### Kritische Fehlerkorrekturen

1. **V-B3 CC09→CC10 Mapping komplett korrigiert** — V-B3 in v5.0 hatte
   6/8 Phasen falsch. CL120 verwies auf CL154 (Unknown) statt CL138
   (Placing Items on Rack). Neues Mapping basiert ausschließlich auf
   BPMN Figures A2–A7.

2. **Deprecated v2.7 Scoring entfernt** — Evidence-Based Scoring
   (Score_Retrieval/Score_Storage) komplett gelöscht. Nur v3.0
   5-Schritt-Logik bleibt.

3. **Encoding repariert** — Alle Dateien in sauberem UTF-8. Keine
   Mojibake (ä→Ã¤) mehr.

4. **Falsche Label-Beschreibungen korrigiert** — MTM-Beispiel (5 falsche
   Labels), category_activation CC01/CC02 Beschreibungen.

### Strukturelle Verbesserungen

1. **23 → 15 Dateien** konsolidiert (−35%)
2. **~9.600 → ~5.500 Zeilen** reduziert (−43%)
3. **Max. Dateigröße: ~950 Zeilen** (vorher: 1.623)
4. **Phasen-basierte Struktur** statt domänen-basiert
5. **Chunking-System & Aktivierungsregeln** bereinigt ergänzt (v6.1)

---

**Version:** 6.1.4
**Release-Datum:** 2026-03-05
**Status:** Finalisiert ✅
**Changelog:** Siehe CHANGELOG.md
