---
version: 6.1.1
status: finalisiert
created: 2026-02-25
updated: 2026-02-26
references:
  - reference_labels.md
  - reference_dataset.md
---

# Phase 1: Szenarioerkennung — 5-Schritt Decision-Logik

**Version:** 6.1.1 (2026-02-26)
**Basis:** Ground Truth v3.0 + v5.0 Klarstellungen
**Quelle:** DaRa Dataset Description (Table 3) + DaRA Logic v9

---

## 1. Szenario-Übersicht

### Retrieval-Szenarien (Kommissionierung)

| Szenario | Order | IT-System | Geplante Fehler |
|----------|-------|-----------|-----------------|
| **S1** | 2904 (CL100) | List+Pen (CL105) | Ja (falsche Lagerplätze) |
| **S2** | 2905 (CL101) | PDT (CL107) | Nein |
| **S3** | 2906 (CL102) | Scanner (CL106) | Ja (Mengenabweichungen) |
| **S7** | 2904+2905 (CL100+CL101) | List+Pen (CL105) | Nein (Perfect Run) |

### Storage-Szenarien (Einlagerung)

| Szenario | Order | IT-System | Geplante Fehler |
|----------|-------|-----------|-----------------|
| **S4** | 2904 (CL100) | List+Pen (CL105) | Nein |
| **S5** | 2905 (CL101) | List+Pen (CL105) | Nein |
| **S6** | 2906 (CL102) | List+Pen (CL105) | Nein |
| **S8** | 2904+2905 (CL100+CL101) | List+Pen (CL105) | Nein (Perfect Run) |

### Restkategorie "Other"

- **Other_Waiting:** CL134=1 (Global Interrupt, höchste Priorität)
- **Other_Process:** CL112/CL113=1 ohne CL110/CL111
- **Other_NoData:** CL103=1 AND CL108=1 (No Order + No IT)

---

## 2. Ground Truth Matrix

| Szenario | CC08 (High) | CC07 (IT) | CC06 (Order) | Bedingungen |
|:--------:|:-----------:|:---------:|:------------:|:-----------|
| **S1** | CL110 | CL105 | CL100 | Process=Retrieval, IT=List+Pen, Order=2904 |
| **S2** | CL110 | CL107 | CL101 | Process=Retrieval, IT=PDT, Order=2905 |
| **S3** | CL110 | CL106 | CL102 | Process=Retrieval, IT=Scanner, Order=2906 |
| **S4** | CL111 | CL105 | CL100 | Process=Storage, IT=List+Pen, Order=2904 |
| **S5** | CL111 | CL105 | CL101 | Process=Storage, IT=List+Pen, Order=2905 |
| **S6** | CL111 | CL105 | CL102 | Process=Storage, IT=List+Pen, Order=2906 |
| **S7** | CL110 | CL105 | CL100+CL101 | Process=Retrieval, Multi(2904+2905) |
| **S8** | CL111 | CL105 | CL100+CL101 | Process=Storage, Multi(2904+2905) |
| **Other** | CL112/CL113 | CL108 | CL103 | CL134=1 OR (CL112/113 AND NOT Retr/Stor) |

**Hinweis:** CC09-Labels (CL115/116/118 für Retrieval, CL117/119/120 für Storage) sind
INFORMATIV — sie charakterisieren das Szenario, sind aber NICHT erforderlich für die
Klassifikation. Die primäre Klassifikation basiert auf CC08 + CC06 + CC07.

**Jeder Frame erfüllt EXAKT EINE Zeile dieser Matrix.**

---

## 3. 5-Schritt Decision-Logik

### SCHRITT 1: GLOBAL INTERRUPTS (Priorität 1 — STOP Condition)

Für jeden Frame i — IMMER ZUERST PRÜFEN:

```python
IF cl134[i] == 1:  # CL134 = Waiting
    scenario[i] = "Other_Waiting"
    RETURN  # KEINE weitere Verarbeitung

IF (cl112[i] == 1 OR cl113[i] == 1) AND NOT (cl110[i] == 1 OR cl111[i] == 1):
    scenario[i] = "Other_Process"
    RETURN

IF (cl103[i] == 1 AND cl108[i] == 1):  # No Order AND No IT
    scenario[i] = "Other_NoData"
    RETURN

# Falls keine Bedingung erfüllt → Weiter zu Schritt 2
```

Geprüfte Labels: CL134 (Waiting), CL112 (Another Process), CL113 (Unknown Process),
CL110 (Retrieval), CL111 (Storage), CL103 (No Order), CL108 (No IT).

CL134 hat absolute Priorität (Global Interrupt).

---

### SCHRITT 2: PROCESS_TYPE DETERMINATION (Retrieval vs Storage)

```python
# Primary Indicators (High-Level CC08)
IF cl110[i] == 1:
    process_type = "RETRIEVAL"

ELIF cl111[i] == 1:
    process_type = "STORAGE"

ELSE:
    # Fallback: Low-Level Indikatoren (CC10)
    retrieval_evidence = MAX(
        cl126[i],  # Collecting Empty Cardboard Boxes
        cl130[i]   # Handing Over Packed Cardboard Boxes
    )

    storage_evidence = MAX(
        cl127[i],  # Collecting Packed Cardboard Boxes
        cl131[i],  # Returning Empty Cardboard Boxes
        cl152[i],  # Tying Elastic Band Around Cardboard
        cl142[i]   # Opening Cardboard Box
    )

    IF retrieval_evidence > storage_evidence:
        process_type = "RETRIEVAL"
    ELIF storage_evidence > retrieval_evidence:
        process_type = "STORAGE"
    ELSE:  # Gleichstand
        process_type = "STORAGE"  # Default bei Gleichstand
```

High-Level Labels (CL110/CL111) haben Priorität. Low-Level nur als Fallback
für mehrdeutige Frames (~10-20% der Frames).

---

### SCHRITT 3: ORDER_STRATEGY DETERMINATION (Single vs Multi)

```python
active_orders = [cl100[i], cl101[i], cl102[i]]
active_count = sum(active_orders)

IF (cl100[i] == 1 AND cl101[i] == 1):
    strategy = "MULTI_ORDER"
    multi_combo = "2904_2905"  # Erlaubte Kombination

ELIF (cl100[i] == 1 AND cl102[i] == 1) OR (cl101[i] == 1 AND cl102[i] == 1):
    strategy = "MULTI_ORDER"
    multi_combo = "OTHER"  # ⚠️ ANOMALIE

ELIF active_count == 1:
    strategy = "SINGLE_ORDER"

ELSE:  # active_count == 0
    strategy = "NO_ORDER"  # ⚠️ ANOMALIE
```

---

### SCHRITT 4: IT_SYSTEM IDENTIFICATION (Nur für Retrieval)

```python
IF process_type == "RETRIEVAL":
    IF cl105[i] == 1:    it_system = "LIST_PEN"
    ELIF cl106[i] == 1:  it_system = "SCANNER"
    ELIF cl107[i] == 1:  it_system = "PDT"
    ELSE:                it_system = "NONE"  # ⚠️ ANOMALIE

ELSE:  # Storage
    it_system = "STORAGE_CONST"  # Immer List+Pen in S4-S6, S8
```

IT-System ist der Diskriminator zwischen S1 (List+Pen), S2 (PDT), S3 (Scanner).
Für Storage-Szenarien ist IT konstant List+Pen.

---

### SCHRITT 5: FINALE SZENARIO-ZUORDNUNG

```python
# ═══════════════════════════════════════════════════
# RETRIEVAL-SZENARIEN (process_type == "RETRIEVAL")
# ═══════════════════════════════════════════════════

IF strategy == "SINGLE_ORDER":
    IF it_system == "LIST_PEN" AND cl100[i] == 1:
        → scenario[i] = "S1"  # CL110=1, CL105=1, CL100=1
    ELIF it_system == "PDT" AND cl101[i] == 1:
        → scenario[i] = "S2"  # CL110=1, CL107=1, CL101=1
    ELIF it_system == "SCANNER" AND cl102[i] == 1:
        → scenario[i] = "S3"  # CL110=1, CL106=1, CL102=1
    ELSE:
        → scenario[i] = "Retrieval_Mismatch"  # ⚠️

ELIF strategy == "MULTI_ORDER":
    IF multi_combo == "2904_2905":
        → scenario[i] = "S7"  # CL110=1, CL105=1, CL100=1, CL101=1
    ELSE:
        → scenario[i] = "Multi_Retrieval_Anomaly"  # ⚠️

# ═══════════════════════════════════════════════════
# STORAGE-SZENARIEN (process_type == "STORAGE")
# ═══════════════════════════════════════════════════

IF strategy == "SINGLE_ORDER":
    IF cl100[i] == 1:    → scenario[i] = "S4"
    ELIF cl101[i] == 1:  → scenario[i] = "S5"
    ELIF cl102[i] == 1:  → scenario[i] = "S6"
    ELSE:                → scenario[i] = "Storage_Mismatch"  # ⚠️

ELIF strategy == "MULTI_ORDER":
    IF multi_combo == "2904_2905":
        → scenario[i] = "S8"  # CL111=1, CL105=1, CL100=1, CL101=1
    ELSE:
        → scenario[i] = "Multi_Storage_Anomaly"  # ⚠️

ELSE:  # strategy == "NO_ORDER"
    → scenario[i] = "Storage_Unclassified"  # ⚠️
```

---

## 4. Validierung nach Szenarioerkennung

Nach Abschluss IMMER prüfen:

1. Jeder Frame hat EXAKT ein Szenario zugewiesen
2. Summe aller Frames = 100.0%
3. Anomalien klar gekennzeichnet (Mismatch, Anomaly, Unclassified)
4. Kein Frame ist leer/nicht klassifiziert

```
Anomalien-Report:
⚠️ Retrieval_Mismatch: [count] Frames
⚠️ Storage_Mismatch: [count] Frames
⚠️ Multi_Retrieval_Anomaly: [count] Frames
⚠️ Multi_Storage_Anomaly: [count] Frames
⚠️ Storage_Unclassified: [count] Frames
```

### 4.1 Szenario-Ergebnistabelle (Pflichtausgabe)

Nach erfolgreicher Szenarioerkennung **MUSS** folgende Zusammenfassungstabelle
ausgegeben werden. Die Szenarien werden in der **chronologischen Reihenfolge**
ihres ersten Auftretens im Datenstrom sortiert, "Other" wird **immer als
letztes** aufgeführt.

**Tabellenformat:**

```markdown
### Szenario-Zusammenfassung — Proband S{XX}

| # | Szenario | Typ | Frames | Dauer (hh:mm:ss) | Anteil (%) |
|:--|:---------|:----|-------:|:-----------------|:-----------|
| 1 | S4 | Storage | 15.230 | 00:08:27 | 7,6% |
| 2 | S1 | Retrieval | 42.815 | 00:23:47 | 21,5% |
| 3 | S2 | Retrieval | 38.100 | 00:21:10 | 19,1% |
| 4 | S5 | Storage | 28.400 | 00:15:47 | 14,2% |
| 5 | S7 | Retrieval (Multi) | 35.600 | 00:19:47 | 17,9% |
| — | Other | Wartezeit/Sonstig | 39.282 | 00:21:49 | 19,7% |
|   | **GESAMT** | | **199.427** | **01:50:47** | **100,0%** |
```

**Sortierregeln:**

1. Szenarien nach **erstem Frame-Index** aufsteigend sortieren (chronologisch)
2. "Other" (Other_Waiting + Other_Process + Other_NoData) wird **zusammengefasst**
   und **immer als letzter Eintrag** vor GESAMT aufgeführt
3. Nur tatsächlich erkannte Szenarien aufführen (nicht alle S1–S8)

**Frame→Zeit Umrechnung:**

```python
def frames_to_hhmmss(frame_count, fps=30):
    """Konvertiert Frame-Anzahl in hh:mm:ss Format."""
    total_seconds = frame_count / fps
    hours = int(total_seconds // 3600)
    minutes = int((total_seconds % 3600) // 60)
    seconds = int(total_seconds % 60)
    return f"{hours:02d}:{minutes:02d}:{seconds:02d}"

def generate_scenario_table(scenario_assignments, total_frames):
    """
    Erzeugt die Szenario-Zusammenfassungstabelle.
    
    Args:
        scenario_assignments: dict mit {frame_index: scenario_name}
        total_frames: Gesamtzahl der Frames des Probanden
    
    Returns:
        Sortierte Liste von (scenario, first_frame, count, duration, percentage)
    """
    from collections import Counter, defaultdict
    
    # Frames pro Szenario zählen + ersten Frame merken
    counts = Counter()
    first_occurrence = {}
    
    for frame_idx, scenario in sorted(scenario_assignments.items()):
        counts[scenario] += 1
        if scenario not in first_occurrence:
            first_occurrence[scenario] = frame_idx
    
    # Other-Varianten zusammenfassen
    other_count = 0
    other_first = float('inf')
    for key in list(counts.keys()):
        if key.startswith("Other"):
            other_count += counts.pop(key)
            other_first = min(other_first, first_occurrence.pop(key, float('inf')))
    
    # Nach erstem Auftreten sortieren (chronologisch)
    sorted_scenarios = sorted(counts.keys(), 
                               key=lambda s: first_occurrence.get(s, 0))
    
    # Tabelle aufbauen
    results = []
    for idx, scenario in enumerate(sorted_scenarios, 1):
        frames = counts[scenario]
        duration = frames_to_hhmmss(frames)
        percentage = (frames / total_frames) * 100
        results.append((idx, scenario, frames, duration, f"{percentage:.1f}%"))
    
    # Other als letztes
    if other_count > 0:
        duration = frames_to_hhmmss(other_count)
        percentage = (other_count / total_frames) * 100
        results.append(("—", "Other", other_count, duration, f"{percentage:.1f}%"))
    
    # GESAMT-Zeile
    total_duration = frames_to_hhmmss(total_frames)
    results.append(("", "GESAMT", total_frames, total_duration, "100,0%"))
    
    return results
```

**Typ-Zuordnung für Tabelle:**

| Szenario | Typ-Spalte |
|:---------|:-----------|
| S1, S2, S3 | Retrieval |
| S4, S5, S6 | Storage |
| S7 | Retrieval (Multi) |
| S8 | Storage (Multi) |
| Other | Wartezeit/Sonstig |

## 5. Bekannte Befunde

**Nicht alle Probanden haben alle Szenarien durchlaufen.** Die Zuordnung von
Szenarien zu Probanden variiert erheblich. Beispiel: Manche Probanden haben
keine Storage-Szenarien, weil ihre Order-Labels nur mit Retrieval annotiert
sind. Dies ist NORMAL für ein Experiment mit variablen Bedingungen.

**Low-Level Evidence ist wichtig:** In ~10-20% der Frames können CL110 und
CL111 beide 0 sein. Dann ist Low-Level Evidence (CL126/CL130 vs.
CL127/CL131/CL142/CL152) entscheidend.

---

## 6. Migration v2.7 → v3.0/v6.0

```python
# v2.7 (VERALTET — NICHT VERWENDEN):
score_retr = (cl110 * 3) + (max(cl126, cl130, cl149) * 5)

# v3.0/v6.0 (AKTUELL):
if cl134 == 1:
    scenario = "Other_Waiting"
elif cl110 == 1:
    process_type = "RETRIEVAL"
elif cl111 == 1:
    process_type = "STORAGE"
else:
    # Low-Level Fallback ...
```

Der v2.7 Evidence-Based Scoring ist vollständig deprecated und entfernt.

---

## 7. Verwandte Dateien

| Datei | Relevanz für Phase 1 |
|:------|:---------------------|
| `reference_dataset.md` | Probanden-Demographie, Session→Proband-Zuordnung |
| `reference_labels.md` | Label-Definitionen für CC06/CC07/CC08 |
| `reference_activation_rules.md` | Szenario-Aktivierungsmatrix (CC-Kombinationen) |
| `reference_validation_rules.md` | Frame-Level Validierung der Szenariozuordnung |
| `phase2_refa_analysis.md` | Folge-Phase: REFA-Zeitanalyse pro erkanntem Szenario |
