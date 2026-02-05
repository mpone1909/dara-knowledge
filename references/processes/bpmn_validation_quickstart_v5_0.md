---
version: 5.0
status: finalisiert
created: 2026-02-04
---

# BPMN-Validierung â€“ Quick Start Guide

**Praktischer Leitfaden zur Verwendung der BPMN-Validierungslogik**

**Version:** 1.0  
**Erstellt:** 04.02.2026  
**Zielgruppe:** Forscher, Entwickler, DaRa-Nutzer

---

## ðŸŽ¯ ZWECK DIESES GUIDES

Dieser Guide zeigt, wie die BPMN-Validierungslogik praktisch angewendet wird, um:
1. Probandendaten gegen ideale BPMN-Prozesse zu validieren
2. Abweichungen systematisch zu identifizieren
3. IST-Prozesse als BPMN-Graphen zu visualisieren
4. Conformity Scores zu berechnen

---

## ðŸ“‹ VORAUSSETZUNGEN

### Erforderliche Daten

- **CSV-Dateien** fÃ¼r Subject (z.B. S14):
  - `Revised_Annotation__CC01_Main_Activity__S14.csv`
  - `Revised_Annotation__CC09_MidLevel_Process__S14.csv`
  - `Revised_Annotation__CC10_LowLevel_Process__S14.csv`
  - `Revised_Annotation__CC04_SubActivity__Left_Hand__S14.csv`
  - `Revised_Annotation__CC05_SubActivity__Right_Hand__S14.csv`
  - `Revised_Annotation__CC11_Location__Human__S14.csv`
  - (Optional) Weitere Kategorien

### Skill-Module

- `bpmn_validation_v5.0.md` (Hauptlogik)
- `ground_truth_central_v5.0.md` (Szenario-Definitionen)
- `process_hierarchy_v5.0.md` (Prozess-Kontext)

---

## ðŸš€ QUICK START

### Schritt 1: Daten laden (Konzeptionell)

```python
import pandas as pd

# Lade alle relevanten CSV-Dateien
cc09_df = pd.read_csv('Revised_Annotation__CC09_MidLevel_Process__S14.csv')
cc10_df = pd.read_csv('Revised_Annotation__CC10_LowLevel_Process__S14.csv')
cc04_df = pd.read_csv('Revised_Annotation__CC04_SubActivity__Left_Hand__S14.csv')
cc05_df = pd.read_csv('Revised_Annotation__CC05_SubActivity__Right_Hand__S14.csv')
cc11_df = pd.read_csv('Revised_Annotation__CC11_Location__Human__S14.csv')

# Merge zu einem DataFrame
df = pd.concat([cc09_df, cc10_df, cc04_df, cc05_df, cc11_df], axis=1)
df['frame'] = range(len(df))
df['chunk_id'] = assign_chunks(df)  # Chunk-Detection-Algorithmus
```

### Schritt 2: Validierung durchfÃ¼hren

```python
# Importiere Validierungsfunktionen (aus bpmn_validation_v5.0.md)
from bpmn_validation import (
    validate_cc09_sequence,
    validate_tool_requirements,
    validate_location_transitions,
    detect_teleportations,
    validate_multi_order_co_activation,
    validate_cl134_global_interrupt,
)

# Sammle alle Violations
violations = []

# 1. Sequenz-Validierung (Chunk-Level)
violations.extend(validate_cc09_sequence(df, chunk_level=True))

# 2. Tool-Validierung (Frame-Level)
violations.extend(validate_tool_requirements(df))

# 3. Location-Validierung (Frame-Level)
violations.extend(validate_location_transitions(df))
violations.extend(detect_teleportations(df))

# 4. Multi-Order-Validierung
violations.extend(validate_multi_order_co_activation(df, scenario="S1"))

# 5. CL134-Validierung
violations.extend(validate_cl134_global_interrupt(df))

print(f"Total Violations: {len(violations)}")
```

### Schritt 3: BPMN-Graph generieren

```python
from bpmn_validation import generate_bpmn_from_data, generate_mermaid_from_bpmn

# Generiere BPMN-JSON
bpmn_json = generate_bpmn_from_data(
    df, 
    subject_id="S14", 
    scenario="S1", 
    session=1
)

# FÃ¼ge Violations hinzu
bpmn_json["deviations"] = violations

# Generiere Mermaid-Code
mermaid_code = generate_mermaid_from_bpmn(bpmn_json)

print("Mermaid Diagram:")
print(mermaid_code)

# Speichere JSON
import json
with open('S14_S1_BPMN.json', 'w') as f:
    json.dump(bpmn_json, f, indent=2)
```

### Schritt 4: IST vs. SOLL Vergleich

```python
from bpmn_validation import compare_bpmn_ist_soll

# Vergleiche gegen idealen BPMN
diff = compare_bpmn_ist_soll(bpmn_json, scenario="S1")

print(f"Conformity Score: {diff['conformity_score']}%")
print(f"Missing Nodes: {diff['missing_nodes']}")
print(f"Extra Nodes: {diff['extra_nodes']}")
print(f"Sequence Deviations: {diff['sequence_deviations']}")
```

---

## ðŸ“Š VERWENDUNGSSZENARIEN

### Szenario 1: Einzelne Proband-Validierung

**Frage:** *"Wie gut entspricht Subject S14 in Szenario S1 dem idealen BPMN?"*

**Workflow:**
1. Lade Daten fÃ¼r S14, Szenario S1
2. FÃ¼hre alle Validierungen durch
3. Berechne Conformity Score
4. Generiere Report

**Erwartetes Ergebnis:**
```
Conformity Score: 87.5%
Critical Violations: 3
Warning Violations: 12
Info Violations: 5
```

---

### Szenario 2: Vergleich mehrerer Szenarien

**Frage:** *"In welchem Szenario hat S14 die hÃ¶chste BPMN-KonformitÃ¤t?"*

**Workflow:**
```python
scenarios = ["S1", "S2", "S3", "S4", "S5", "S8"]
results = {}

for scenario in scenarios:
    df = load_subject_data("S14", scenario=scenario)
    violations = run_all_validations(df, scenario)
    bpmn = generate_bpmn_from_data(df, "S14", scenario, 1)
    diff = compare_bpmn_ist_soll(bpmn, scenario)
    
    results[scenario] = {
        "conformity_score": diff["conformity_score"],
        "violations": len(violations)
    }

# Bestes Szenario
best = max(results, key=lambda s: results[s]["conformity_score"])
print(f"Best Conformity: {best} with {results[best]['conformity_score']}%")
```

**Erwartetes Ergebnis:**
```
Best Conformity: S2 with 94.3%
Reason: S2 uses PDT (CL107), which has strict process flow
```

---

### Szenario 3: Tool-Compliance-Audit

**Frage:** *"Welche Packing-Prozesse haben fehlende Tools?"*

**Workflow:**
```python
df = load_subject_data("S14", scenario="S1")
tool_violations = validate_tool_requirements(df)

# Filtere nur Packing-bezogene Violations
packing_violations = [
    v for v in tool_violations 
    if v["cc10"] in ["CL145", "CL150", "CL146", "CL148"]
]

for v in packing_violations:
    print(f"Frame {v['frame']}: {v['cc10']} - Missing {v['required_tool']}")
```

**Erwartetes Ergebnis:**
```
Frame 5678: CL150 (Sealing) - Missing Tape Dispenser
Frame 6789: CL146 (Printing) - Missing Computer
```

---

### Szenario 4: Location-Teleportation-Detection

**Frage:** *"Gibt es unrealistische Location-SprÃ¼nge in S14?"*

**Workflow:**
```python
df = load_subject_data("S14", scenario="S1")
teleportations = detect_teleportations(df, max_distance=2)

for t in teleportations:
    print(f"Frame {t['frame']}: {t['prev_location']} â†’ {t['curr_location']}")
    print(f"  Distance: {t['max_distance']}, Severity: {t['severity']}")
```

**Erwartetes Ergebnis:**
```
Frame 1234: CL155 (Office) â†’ CL176 (Aisle 5)
  Distance: 2, Severity: CRITICAL
  â†’ Unrealistic jump, should pass through paths
```

---

### Szenario 5: Multi-Order-Loop-PrÃ¼fung (S7/S8)

**Frage:** *"Hat S14 in Szenario S7 den erwarteten Order-Loop?"*

**Workflow:**
```python
df = load_subject_data("S14", scenario="S7")
loop_violations = validate_multi_order_loops(df, scenario="S7")

if len(loop_violations) == 0:
    print("âœ… Multi-Order loop detected correctly")
else:
    for v in loop_violations:
        print(f"âŒ {v['description']}")
```

**Erwartetes Ergebnis:**
```
âœ… Multi-Order loop detected correctly
Loop Transition: Frame 15000 (CL121 â†’ CL114)
Order 1 (CL100): Frames 1000-14999
Order 2 (CL101): Frames 15000-30000
```

---

## ðŸŽ¨ VISUALISIERUNG

### Mermaid-Diagramm erstellen

**Schritt 1: Mermaid-Code generieren**
```python
mermaid_code = generate_mermaid_from_bpmn(bpmn_json)
```

**Schritt 2: Rendern mit Mermaid Chart Tool**
```python
# In Claude-Chat: Nutze Mermaid Chart Tool
mermaid_chart_tool.render(mermaid_code)
```

**Schritt 3: SVG exportieren**
```python
# Speichere gerenderten SVG-Link
svg_url = mermaid_chart_tool.get_svg_url()
print(f"Diagram URL: {svg_url}")
```

### Diff-Visualisierung

**Beispiel: IST vs. SOLL**
```python
from bpmn_validation import generate_diff_mermaid

diff_mermaid = generate_diff_mermaid(bpmn_json, soll_sequence, scenario="S1")
mermaid_chart_tool.render(diff_mermaid)
```

**Farbcodierung:**
- ðŸŸ¢ GrÃ¼n: Korrekte Nodes (in SOLL, im IST vorhanden)
- ðŸŸ  Orange: Extra Nodes (nicht in SOLL, im IST vorhanden)
- ðŸ”´ Rot (gestrichelt): Fehlende Nodes (in SOLL, im IST nicht vorhanden)

---

## ðŸ“„ REPORT-GENERIERUNG

### Strukturierter Report

**Template:** `bpmn_validation_report_template_v5.0.md`

**Workflow:**
```python
from bpmn_validation import generate_report

report = generate_report(
    bpmn_json=bpmn_json,
    violations=violations,
    diff=diff,
    subject_id="S14",
    scenario="S1"
)

# Speichere Report
with open('S14_S1_Report.md', 'w') as f:
    f.write(report)
```

**Report-Sektionen:**
1. Metadata (Subject, Scenario, Date)
2. Executive Summary (Violation Overview, Conformity Score)
3. IST vs. SOLL Comparison
4. Detailed Violation Analysis (7 Kategorien)
5. BPMN-Visualisierung (JSON + Mermaid)
6. Error Hypotheses
7. Recommendations

---

## ðŸ” FEHLERSUCHE

### HÃ¤ufige Probleme

#### Problem 1: Zu viele CRITICAL Violations

**Symptom:** 50+ CRITICAL Violations in einem Szenario

**Diagnose:**
```python
critical_violations = [v for v in violations if v["severity"] == "CRITICAL"]
violation_types = {}
for v in critical_violations:
    violation_types[v["type"]] = violation_types.get(v["type"], 0) + 1

print(violation_types)
```

**MÃ¶gliche Ursachen:**
- **sequence_violation:** Chunk-Detection-Algorithmus fehlerhaft â†’ ÃœberprÃ¼fe Chunk-Grenzen
- **tool_violation:** Tool-Labels unter-annotiert â†’ PrÃ¼fe CC04/CC05 Annotationen
- **teleportation:** Location-Graph unvollstÃ¤ndig â†’ Erweitere Location-Transitions

---

#### Problem 2: Conformity Score = 0%

**Symptom:** Alle Nodes als "Extra" markiert

**Diagnose:**
```python
print(f"IST Sequence: {ist_sequence}")
print(f"SOLL Sequence: {soll_sequence}")
```

**MÃ¶gliche Ursachen:**
- **Falsches Szenario:** S1 geladen, aber S4 erwartet â†’ PrÃ¼fe Szenario-Zuordnung
- **CC09-Labels fehlerhaft:** Alle CL123 (Unknown) â†’ PrÃ¼fe AnnotationsqualitÃ¤t

---

#### Problem 3: Mermaid-Diagramm rendert nicht

**Symptom:** Syntax-Fehler in Mermaid

**Diagnose:**
```python
# PrÃ¼fe Mermaid-Syntax manuell
print(mermaid_code[:500])  # Erste 500 Zeichen
```

**MÃ¶gliche Ursachen:**
- **Sonderzeichen in Labels:** Entferne/escape Sonderzeichen
- **UngÃ¼ltige Node-IDs:** Node-IDs mÃ¼ssen alphanumerisch sein

---

## ðŸ“š WEITERFÃœHRENDE RESSOURCEN

### Skill-Dokumentation

- **`bpmn_validation_v5.0.md`** â€“ VollstÃ¤ndige Validierungslogik (700+ Zeilen)
- **`bpmn_validation_report_template_v5.0.md`** â€“ Report-Template
- **`CHANGELOG_v5.0.md`** â€“ Alle Ã„nderungen in v4.2
- **`process_hierarchy_v5.0.md`** â€“ Prozess-Kontext
- **`ground_truth_central_v5.0.md`** â€“ Szenario-Erwartungen

### Externe Quellen

- **`BPMN_PROZESSE_DARA.pdf`** â€“ Ideale BPMN-Modelle (Figures 11, A2-A7)
- **DaRa Dataset Description** â€“ Offizielle Label-Definitionen

---

## ðŸ’¡ TIPPS & BEST PRACTICES

### Tipp 1: Chunk-Detection zuerst validieren

Bevor BPMN-Validierung:
```python
# PrÃ¼fe Chunk-Grenzen
chunk_stats = df.groupby('chunk_id')['CC09'].nunique()
unstable_chunks = chunk_stats[chunk_stats > 2]

if len(unstable_chunks) > 10:
    print("âš ï¸ Warning: Viele instabile Chunks, Chunk-Detection Ã¼berprÃ¼fen!")
```

### Tipp 2: Severity-Levels strategisch nutzen

```python
# Filtere nach Severity fÃ¼r PrioritÃ¤ten
critical = [v for v in violations if v["severity"] == "CRITICAL"]
print(f"Fix these {len(critical)} CRITICAL issues first!")
```

### Tipp 3: Batch-Processing fÃ¼r mehrere Probanden

```python
subjects = ["S01", "S02", ..., "S18"]
results = {}

for subject in subjects:
    df = load_subject_data(subject, scenario="S1")
    violations = run_all_validations(df, scenario="S1")
    results[subject] = len(violations)

# Ranking
sorted_subjects = sorted(results, key=results.get)
print(f"Best Subject: {sorted_subjects[0]} with {results[sorted_subjects[0]]} violations")
```

---

## ðŸŽ“ LERNPFAD

### Stufe 1: Basis (AnfÃ¤nger)

1. Verstehe BPMN-Grundlagen (Figures 11, A2-A7)
2. FÃ¼hre Single-Subject-Validierung durch
3. Interpretiere Conformity Score

### Stufe 2: Erweitert (Fortgeschritten)

1. Analysiere spezifische Violation-Typen (Tool, Location)
2. Generiere Mermaid-Diagramme
3. Vergleiche mehrere Szenarien

### Stufe 3: Experte (Profi)

1. Entwickle eigene Validierungsregeln
2. Erweitere Location-Graph
3. Optimiere Chunk-Detection-Algorithmus
4. Implementiere Probabilistic Severity Scoring

---

## ðŸ“ž SUPPORT

**Fragen zur Verwendung:**
- Siehe `bpmn_validation_v5.0.md` Sektion 5 (Verwendungsbeispiele)
- Siehe `CHANGELOG_v5.0.md` fÃ¼r Feature-Details

**Fehlerreports:**
- Dokumentiere: Violation-Typ, Frame, Scenario, Subject
- FÃ¼ge hinzu: Erwartetes vs. TatsÃ¤chliches Verhalten

**Feature-Requests:**
- Beschreibe Use-Case detailliert
- Beispiel-Daten (falls mÃ¶glich)

---

## ðŸ ZUSAMMENFASSUNG

Dieser Guide zeigt die **praktische Anwendung** der BPMN-Validierungslogik:

âœ… **5 Quick-Start-Schritte** (Daten laden â†’ Validieren â†’ BPMN generieren â†’ Vergleichen â†’ Visualisieren)  
âœ… **5 Verwendungsszenarien** (Single-Subject, Multi-Scenario, Tool-Audit, Teleportation, Multi-Order)  
âœ… **3 Visualisierungsmethoden** (JSON, Mermaid, Diff)  
âœ… **3 Fehlersuche-Tipps** (Zu viele Violations, Score = 0%, Render-Fehler)  
âœ… **3 Best Practices** (Chunk-Detection validieren, Severity nutzen, Batch-Processing)

**Start now:** Lade S14-Daten, fÃ¼hre Validierung durch, und erstelle dein erstes BPMN-Diagramm!

---

**Version:** 5.0  
**Erstellt:** 04.02.2026  
**Autor:** DaRa Expert System  
**Status:** Production-Ready
