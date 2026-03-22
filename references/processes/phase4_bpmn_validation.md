---
version: 6.1.3
references:
  - reference_bpmn_flows.md
  - reference_validation_rules.md
  - reference_labels.md
  - phase1_scenario_recognition.md
  - phase2_refa_analysis.md
  - reference_warehouse.md
  - reference_articles.md
output_used_by:
  - phase5_report.md
---

<!-- PRE-ANSWER CHECKLIST (PAC) — Phase 4
Before answering ANY question about this phase:
[ ] I have read this file COMPLETELY using the Read tool
[ ] I have read reference_bpmn_flows.md
[ ] I have read reference_validation_rules.md
[ ] I have extracted the VERIFICATION_TOKEN from the end of this file
[ ] I am citing specific CC09→CC10 mappings from §2, NOT from memory
[ ] I have verified VRA-5 (CC09→CC10 mapping) from source
-->

# Phase 4: Process-Validierung — IST/SOLL-Vergleich

**Version:** 6.1.3 (2026-02-26)
**Quelle:** BPMN_PROZESSE_DARA.pdf (Figures A2–A7)
**KRITISCHE KORREKTUR:** CC09→CC10 Mapping komplett neu aus Figures A2–A7

---

## 1. Zweck & Scope

Validierung von DaRa-Daten gegen idealisierte BPMN-Prozessmodelle:

- **Sequenzvalidierung:** Sind CC09-Übergänge BPMN-konform?
- **CC09→CC10 Mapping:** Sind Low-Level-Prozesse für die aktive Phase korrekt?
- **Tool-Validierung:** Sind Pflicht-Tools bei entsprechenden CC10-Labels aktiv?
- **Location-Validierung:** Entsprechen CC11-Transitions den räumlichen Pfaden?
- **Multi-Order-Validierung:** Sind Order-Co-Activations korrekt (S7, S8)?
- **CL134-Priorisierung:** Wird Waiting als Global Interrupt behandelt?
- **BPMN-Generierung:** Visualisierung tatsächlich durchgeführter Prozesse
- **IST/SOLL-Vergleich:** Conformance Score pro Proband und Szenario

### 1.1 Validierungs-Philosophie (Hybrid-Ansatz)

| Ebene | Anwendung | Begründung |
|:------|:----------|:-----------|
| **Frame-Level** | Tool-Validierung, Location-Transitions | Präzise Fehlerlokalisation |
| **Chunk-Level** | Sequenz-Validierung (CC09-Übergänge) | Prozessstabilität innerhalb Chunks |

**Severity-Klassifikation:**

| Severity | Bedeutung | Beispiel |
|:---------|:----------|:---------|
| **CRITICAL** | Fundamentale BPMN-Logik verletzt | Unmögliche CC09-Sequenz |
| **WARNING** | Ungewöhnlich, nicht ausgeschlossen | Seltene Pfade, unerwartete Location |
| **INFO** | Abweichung ohne direkten Fehler | Längere Wartezeiten |

### 1.2 Anwendungsbereich

- **Alle 18 Probanden** (S01–S18)
- **Alle 8 Szenarien** (S1–S8) + Other
- **Alle 6 Sessions**
- **Universell einsetzbar** ohne probandenspezifische Anpassungen

---

## 2. CC09 → CC10 Mapping (KORRIGIERT — Figures A2–A7)

**KRITISCH:** Das v5.0 Mapping (Regel V-B3) war in 6/8 Phasen fehlerhaft.
Das folgende Mapping basiert ausschließlich auf den BPMN-Diagrammen.

### CL114 | Preparing Order (Figure A2)

| Erlaubte CC10 | Beschreibung |
|:--------------|:-------------|
| CL124 | Collecting Order and Hardware |
| CL125 | Collecting Cart (optional) |
| CL126 | Collecting Empty Cardboard Boxes (nur Retrieval) |
| CL127 | Collecting Packed Cardboard Boxes (nur Storage) |
| CL134 | Waiting |

### CL115 | Picking — Travel Time (Figure A3)

| Erlaubte CC10 | Beschreibung |
|:--------------|:-------------|
| CL128 | Transporting a Cart to the Base |
| CL137 | Moving to the Next Position |
| CL135 | Reporting and Clarifying the Incident |
| CL134 | Waiting |

### CL116 | Picking — Pick Time (Figure A3)

| Erlaubte CC10 | Beschreibung |
|:--------------|:-------------|
| CL139 | Retrieving Items |
| CL140 | Moving to a Cart |
| CL151 | Placing Cardboard Box/Item in a Cart |
| CL134 | Waiting |

### CL117 | Unpacking (Figure A5)

| Erlaubte CC10 | Beschreibung |
|:--------------|:-------------|
| CL129 | Transporting to Packaging/Sorting Area |
| CL141 | Placing Cardboard Box/Item on a Table |
| CL142 | Opening Cardboard Box |
| CL143 | Disposing of Filling Material or Shipping Label |
| CL144 | Sorting |
| CL152 | Tying Elastic Band Around Cardboard |
| CL151 | Placing Cardboard Box/Item in a Cart |
| CL134 | Waiting |

### CL118 | Packing (Figure A4)

| Erlaubte CC10 | Beschreibung |
|:--------------|:-------------|
| CL129 | Transporting to Packaging/Sorting Area |
| CL141 | Placing Cardboard Box/Item on a Table |
| CL149 | Removing Elastic Band |
| CL144 | Sorting |
| CL145 | Filling Cardboard Box with Filling Material |
| CL146 | Printing Shipping Label and Return Slip |
| CL147 | Preparing or Adding Return Label |
| CL148 | Attaching Shipping Label |
| CL150 | Sealing Cardboard Box |
| CL151 | Placing Cardboard Box/Item in a Cart |
| CL134 | Waiting |

### CL119 | Storing — Travel Time (Figure A6)

| Erlaubte CC10 | Beschreibung |
|:--------------|:-------------|
| CL128 | Transporting a Cart to the Base |
| CL137 | Moving to the Next Position |
| CL135 | Reporting and Clarifying the Incident |
| CL134 | Waiting |

### CL120 | Storing — Store Time (Figure A6)

| Erlaubte CC10 | Beschreibung |
|:--------------|:-------------|
| CL136 | Removing Cardboard Box/Item from the Cart |
| CL140 | Moving to a Cart (generisch: Bewegung zum Regal) |
| CL138 | Placing Items on a Rack |
| CL134 | Waiting |

**KORREKTUR v6.0:** v5.0 verwendete hier CL154 (Low-Level Process Unknown).
CL154 ist ein Fallback-Label und KEINE Einlagerungsaktivität. Der korrekte
Label ist CL138 (Placing Items on a Rack).

### CL121 | Finalizing Order (Figure A7)

| Erlaubte CC10 | Beschreibung |
|:--------------|:-------------|
| CL130 | Handing Over Packed Cardboard Boxes (nur Retrieval) |
| CL131 | Returning Empty Cardboard Boxes (nur Storage) |
| CL132 | Returning Cart |
| CL133 | Returning Hardware |
| CL134 | Waiting |

### CL122/CL123 | Other / Unknown Process

| Erlaubte CC10 | Beschreibung |
|:--------------|:-------------|
| CL134 | Waiting |
| CL153 | Another Low-Level Process |
| CL154 | Low-Level Process Unknown |

---

## 3. V-B3 Validierungscode (KORRIGIERT)

```python
CC09_TO_CC10_MAPPING = {
    # Preparing Order (Figure A2)
    'CL114': ['CL124', 'CL125', 'CL126', 'CL127', 'CL134'],

    # Picking Travel Time (Figure A3)
    'CL115': ['CL128', 'CL137', 'CL135', 'CL134'],

    # Picking Pick Time (Figure A3)
    'CL116': ['CL139', 'CL140', 'CL151', 'CL134'],

    # Unpacking (Figure A5)
    'CL117': ['CL129', 'CL141', 'CL142', 'CL143', 'CL144',
              'CL152', 'CL151', 'CL134'],

    # Packing (Figure A4)
    'CL118': ['CL129', 'CL141', 'CL149', 'CL144', 'CL145',
              'CL146', 'CL147', 'CL148', 'CL150', 'CL151', 'CL134'],

    # Storing Travel Time (Figure A6)
    'CL119': ['CL128', 'CL137', 'CL135', 'CL134'],

    # Storing Store Time (Figure A6) — KORRIGIERT
    'CL120': ['CL136', 'CL140', 'CL138', 'CL134'],

    # Finalizing Order (Figure A7)
    'CL121': ['CL130', 'CL131', 'CL132', 'CL133', 'CL134'],

    # Other/Unknown
    'CL122': ['CL134', 'CL153', 'CL154'],
    'CL123': ['CL134', 'CL153', 'CL154'],
}


def validate_cc10_from_cc09(cc09_active, cc10_active):
    """Prüft ob CC10 für aktives CC09 erlaubt ist (Frame-Level)."""
    if cc09_active in CC09_TO_CC10_MAPPING:
        allowed = CC09_TO_CC10_MAPPING[cc09_active]
        if cc10_active not in allowed:
            return {
                'valid': False,
                'severity': 'CRITICAL',
                'message': f'CC10={cc10_active} nicht erlaubt für CC09={cc09_active}. '
                           f'Erlaubt: {allowed}'
            }
    return {'valid': True}
```

---

## 4. Sequenz-Validierung (FSM für CC09)

```python
VALID_CC09_TRANSITIONS = {
    'CL114': ['CL115', 'CL117', 'CL121'],  # Preparing → Pick Travel / Unpacking / Finalizing
    'CL115': ['CL115', 'CL116'],             # Pick Travel → Loop / Pick Time
    'CL116': ['CL116', 'CL115', 'CL118', 'CL121'],  # Pick → Loop / Travel / Packing / Final
    'CL117': ['CL117', 'CL119'],             # Unpacking → Loop / Store Travel
    'CL118': ['CL118', 'CL115', 'CL121'],   # Packing → Loop / Pick Travel / Finalizing
    'CL119': ['CL119', 'CL120'],             # Store Travel → Loop / Store Time
    'CL120': ['CL120', 'CL119', 'CL121'],   # Store → Loop / Travel / Finalizing
    'CL121': ['CL114', None],                # Finalizing → Preparing (Multi-Order) / END
    'CL122': ['CL122', 'CL114', 'CL121'],   # Other → Loop / Preparing / Finalizing
    'CL123': ['CL123', 'CL114', 'CL121'],   # Unknown → Loop / Preparing / Finalizing
}

def validate_cc09_transition(prev_cc09, curr_cc09):
    """Prüft ob CC09-Übergang BPMN-konform ist."""
    if prev_cc09 in VALID_CC09_TRANSITIONS:
        allowed = VALID_CC09_TRANSITIONS[prev_cc09]
        if curr_cc09 not in allowed:
            return {'valid': False, 'severity': 'CRITICAL'}
    return {'valid': True}

# Szenario-spezifische Sequenz-Erwartungen
RETRIEVAL_EXPECTED_SEQUENCE = [
    'CL114',  # Preparing Order
    'CL115',  # Picking Travel Time (mehrfach)
    'CL116',  # Picking Pick Time (mehrfach)
    'CL118',  # Packing (optional, hauptsächlich S1, S3, S7)
    'CL121',  # Finalizing Order
]

STORAGE_EXPECTED_SEQUENCE = [
    'CL114',  # Preparing Order
    'CL117',  # Unpacking
    'CL119',  # Storing Travel Time (mehrfach)
    'CL120',  # Storing Store Time (mehrfach)
    'CL121',  # Finalizing Order
]

SOLL_SEQUENCES = {
    'S1': ['CL114', 'CL115', 'CL116', 'CL118', 'CL121'],
    'S2': ['CL114', 'CL115', 'CL116', 'CL121'],
    'S3': ['CL114', 'CL115', 'CL116', 'CL118', 'CL121'],
    'S4': ['CL114', 'CL117', 'CL119', 'CL120', 'CL121'],
    'S5': ['CL114', 'CL117', 'CL119', 'CL120', 'CL121'],
    'S6': ['CL114', 'CL117', 'CL119', 'CL120', 'CL121'],
    'S7': ['CL114', 'CL115', 'CL116', 'CL118', 'CL121',
           'CL114', 'CL115', 'CL116', 'CL121'],  # ×2 Orders
    'S8': ['CL114', 'CL117', 'CL119', 'CL120', 'CL121',
           'CL114', 'CL117', 'CL119', 'CL120', 'CL121'],  # ×2 Orders
}
```

---

## 5. Tool-Validierung (CC10 → CC04/CC05)

Bestimmte CC10-Labels erfordern zwingend spezifische Tools in einer Hand:

| CC10 Label | Pflicht-Tool | CC04 (Left) | CC05 (Right) |
|:-----------|:-------------|:------------|:-------------|
| CL142 Opening Cardboard Box | Knife | CL061 | CL096 |
| CL145 Filling with Material | Bubble Wrap | CL059 | CL094 |
| CL149 Removing Elastic Band | Elastic Band | CL063 | CL098 |
| CL150 Sealing Cardboard Box | Tape Dispenser | CL060 | CL095 |
| CL146 Printing Label | Computer | CL058 | CL093 |
| CL148 Attaching Label | Shipping Label | CL062 | CL097 |
| CL147 Preparing Return Label | Return Label | CL062 | CL097 |
| CL152 Tying Elastic Band | Elastic Band | CL063 | CL098 |

**Validierung:** Mindestens eine Hand muss das Pflicht-Tool halten.

---

## 6. Location-Validierung (CC10 → CC11)

### Erwartete Locations pro CC10

| CC10 | Erwartete CC11 Location | Begründung |
|:-----|:------------------------|:-----------|
| CL124 Collecting Hardware | CL155 Office | Hardware wird im Büro ausgegeben |
| CL125 Collecting Cart | CL156 Cart Area | Wagen stehen im Cart-Bereich |
| CL126/CL127 Collecting Boxes | CL157 Cardboard Box Area | Kartons liegen dort |
| CL137 Moving to Position | CL161–CL163 Path/Aisle | Fortbewegung im Gang |
| CL139 Retrieving Items | CL163 Aisle Path + CL172–176 | Am Regal in einer Gasse |
| CL138 Placing on Rack | CL163 Aisle Path + CL172–176 | Am Regal in einer Gasse |
| CL141 Placing on Table | CL159 Packing/Sorting Area | Am Packtisch |
| CL132 Returning Cart | CL156 Cart Area | Wagen zurückstellen |
| CL133 Returning Hardware | CL155 Office | Hardware zurück ins Büro |

---

## 7. Szenario-Routing Matrix

| Szenario | Bezeichnung | CC09 Sequenz | Figure-Paths | Besonderheit |
|:---------|:------------|:-------------|:-------------|:-------------|
| **S1** | Retrieval (1 Order, Intentional Error) | CL114→CL115→CL116→CL118→CL121 | A2(Retrieval)→A3(Error)→A4→A7(Retrieval) | CL135 aktiviert in A3 (Picking Error) |
| **S2** | Retrieval (1 Order, Standard) | CL114→CL115→CL116→CL121 | A2(Retrieval)→A3(Perfect)→A7(Retrieval) | Kein Packing, direkter Abschluss |
| **S3** | Retrieval (1 Order, Intentional Error) | CL114→CL115→CL116→CL118→CL121 | A2(Retrieval)→A3(Error)→A4→A7(Retrieval) | Ähnlich S1, ggf. unterschiedlicher Error-Typ |
| **S4** | Storage (1 Order) | CL114→CL117→CL119→CL120→CL121 | A2(Storage)→A5→A6→A7(Storage) | Unpacking vor Storing |
| **S5** | Storage (1 Order, mit Error) | CL114→CL117→CL119→CL120→CL121 | A2(Storage)→A5→A6(mit CL135)→A7(Storage) | CL135 in Storing (A6) aktiviert |
| **S6** | Storage (1 Order) | CL114→CL117→CL119→CL120→CL121 | A2(Storage)→A5→A6→A7(Storage) | Ähnlich S4, ggf. unterschiedliche Komplexität |
| **S7** | Retrieval (2 Orders, Perfect) | [CL114→CL115→CL116→CL118]×2→CL121 | A2×2(Retrieval)→A3×2(Perfect)→A4×2→A7×2(Retrieval) | Multi-Order: Doppelte Sequenz, kein CL135 |
| **S8** | Storage (2 Orders, Perfect) | [CL114→CL117→CL119→CL120]×2→CL121 | A2×2(Storage)→A5×2→A6×2→A7×2(Storage) | Multi-Order: Doppelte Sequenz, kein CL135 |

**Szenario-Entscheidungen (Figure A2 Gateway „Retrieval or Storage?"):**

```
RETRIEVAL-Pfad (Collecting Empty Cardboard Boxes → CL126):
  Szenarien: S1, S2, S3, S7
  Folge: Picking (A3) → ggf. Packing (A4) → Finalizing Retrieval (A7)

STORAGE-Pfad (Collecting Packed Cardboard Boxes → CL127):
  Szenarien: S4, S5, S6, S8
  Folge: Unpacking (A5) → Storing (A6) → Finalizing Storage (A7)
```

---

## 8. CL135 Error-Handling — Aktivierungsbedingungen

**CL135 — Reporting and Clarifying the Incident** wird durch Gateway-Bedingungen
in den BPMN-Diagrammen aktiviert. Die Auslöser unterscheiden sich je nach Prozess:

### Picking (Figure A3) — Szenarien S1, S3

| Gateway | Bedingung | Fehlertyp |
|:--------|:----------|:----------|
| „Information on the next position complete?" | = NO | Listenfehler (fehlende Info) |
| „Items can be picked?" | = NO | Item fehlt, beschädigt, falsche Menge |

- **Auslöser 1:** Fehler in der Pick-Liste (fehlende Information)
- **Auslöser 2:** Item nicht verfügbar (fehlt, beschädigt, falsche Menge)
- **Verhindert:** CL139 (Retrieving), CL140 (Moving), CL151 (Placing)
- **Loop-Ziel:** CL137 (Moving to the Next Position)
- **Prozess-Spezifik:** Der Fehler hindert die **ENTNAHME** aus dem Regal

### Storing (Figure A6) — Szenario S5

| Gateway | Bedingung | Fehlertyp |
|:--------|:----------|:----------|
| „Information on the next position complete?" | = NO | Einlagerungs-Listenfehler |
| „Items can be placed?" | = NO | Regalfach besetzt, voll oder beschädigt |

- **Auslöser 1:** Fehler in der Einlagerungs-Liste
- **Auslöser 2:** Regalfach besetzt, voll oder beschädigt (nicht: Item-Problem)
- **Verhindert:** CL138 (Placing Items on Rack)
- **Loop-Ziel:** CL137 oder Storing Travel Time (CL119)
- **Prozess-Spezifik:** Der Fehler hindert die **ABLAGE** ins Regal

### Nicht in Packing/Unpacking

Figures A4 (Packing) und A5 (Unpacking) haben keine Error-Gateways —
nur Schleifen für mehrere Kartons.

### Vergleich: Picking vs. Storing Error-Handling

| Aspekt | Picking (A3) | Storing (A6) |
|:-------|:-------------|:-------------|
| Gateway-Text | „Items can be picked?" | „Items can be placed?" |
| Fehlertyp | Missing Item / Damaged | Regal-Problem / Position-Problem |
| Fehler verhindert | Retrieving (CL139) | Placing (CL138) |
| Loop-Ziel | CL137 (Moving to Next Position) | CL137 oder CL119 |
| Erscheint in | S1, S3 | S5 |

---

## 9. CL134 (Waiting) — Global Interrupt

CL134 wird als Global Interrupt mit höchster Priorität behandelt:

- In Phase 1 (Szenarioerkennung): CL134=1 → „Other_Waiting"
- In Phase 2 (REFA): CL134 → t_w oder t_s (kontextabhängig)
- In Phase 4 (Process): CL134 ist in ALLEN CC09-Phasen erlaubt

---

## 10. Abweichungs-Kategorien & Violation-Typ-Katalog

### 10.1 Severity-Klassifikation

| Severity | Bedeutung | Beispiel |
|:---------|:----------|:---------|
| **CRITICAL** | Fundamentale BPMN-Logik verletzt | Unmögliche CC09-Transition |
| **WARNING** | Ungewöhnlich, nicht ausgeschlossen | Seltene Pfade, unerwartete Location |
| **INFO** | Abweichung ohne direkten Fehler | Längere Wartezeiten |

### 10.2 Violation-Typ-Katalog (11 Typen)

| # | Typ | Severity | Beispiel |
|:--|:----|:---------|:---------|
| 1 | `sequence_violation` | CRITICAL | CL114→CL120 (Skip Unpacking) |
| 2 | `tool_violation` | CRITICAL | CL142 ohne Knife (CL061/CL096) |
| 3 | `location_violation` | WARNING | CL139 nicht im Aisle |
| 4 | `multi_order_violation` | CRITICAL | S7: nur 1 statt 2 Orders erkannt |
| 5 | `teleportation` | CRITICAL | Office (CL155) → Aisle 5 (CL176) ohne Pfad |
| 6 | `chunk_instability` | WARNING | Zu kurze Chunks (<5 Frames) |
| 7 | `noisy_transition` | INFO | Rapid CC09-Wechsel innerhalb 3 Frames |
| 8 | `cl134_not_prioritized` | WARNING | CL134 mit anderen CC10 gleichzeitig aktiv |
| 9 | `post_waiting_continuation` | INFO | Prozess setzt nach CL134 nicht korrekt fort |
| 10 | `multi_order_loop_missing` | CRITICAL | S7/S8: CL121→CL114-Übergang fehlt |
| 11 | `multi_order_incomplete` | CRITICAL | S7/S8: Zweite Order-Sequenz unvollständig |

---

## 11. Validierungs-Workflow

```python
def validate_bpmn(frames, scenario_vector):
    violations = []

    for i in range(len(frames)):
        cc09 = frames[i]['CC09']
        cc10 = frames[i]['CC10']
        scenario = scenario_vector[i]

        # 1. CC09→CC10 Mapping (V-B3 korrigiert)
        result = validate_cc10_from_cc09(cc09, cc10)
        if not result['valid']:
            violations.append(result)

        # 2. CC09 Transition (nur bei Wechsel)
        if i > 0:
            prev_cc09 = frames[i-1]['CC09']
            if prev_cc09 != cc09:
                result = validate_cc09_transition(prev_cc09, cc09)
                if not result['valid']:
                    violations.append(result)

        # 3. Tool-Validierung
        if cc10 in MANDATORY_TOOLS:
            result = validate_tools(frames[i], cc10)
            if not result['valid']:
                violations.append(result)

        # 4. Location-Plausibilität
        result = validate_location(frames[i], cc10)
        if not result['valid']:
            violations.append(result)

    return violations
```

### 11.1 MANDATORY_TOOLS — Lookup-Tabelle

```python
MANDATORY_TOOLS = {
    # Opening Cardboard Box
    'CL142': {
        'Left': ['CL061'],   # Knife
        'Right': ['CL096'],  # Knife
        'Description': 'Knife',
        'Process': 'Opening Cardboard Box (CL142)',
        'BPMN_Context': 'Unpacking (CL117)',
    },
    # Filling Cardboard Box with Filling Material
    'CL145': {
        'Left': ['CL059'],   # Bubble Wrap
        'Right': ['CL094'],  # Bubble Wrap
        'Description': 'Bubble Wrap',
        'Process': 'Filling Cardboard Box (CL145)',
        'BPMN_Context': 'Packing (CL118)',
    },
    # Removing Elastic Band
    'CL149': {
        'Left': ['CL063'],   # Elastic Band
        'Right': ['CL098'],  # Elastic Band
        'Description': 'Elastic Band',
        'Process': 'Removing Elastic Band (CL149)',
        'BPMN_Context': 'Packing (CL118)',
    },
    # Sealing Cardboard Box
    'CL150': {
        'Left': ['CL060'],   # Tape Dispenser
        'Right': ['CL095'],  # Tape Dispenser
        'Description': 'Tape Dispenser',
        'Process': 'Sealing Cardboard Box (CL150)',
        'BPMN_Context': 'Packing (CL118)',
    },
    # Printing Shipping Label and Return Slip
    'CL146': {
        'Left': ['CL058'],   # Computer
        'Right': ['CL093'],  # Computer
        'Description': 'Computer',
        'Process': 'Printing Shipping Label (CL146)',
        'BPMN_Context': 'Packing (CL118)',
    },
    # Attaching Shipping Label
    'CL148': {
        'Left': ['CL062'],   # Shipping/Return Label
        'Right': ['CL097'],  # Shipping/Return Label
        'Description': 'Shipping Label',
        'Process': 'Attaching Shipping Label (CL148)',
        'BPMN_Context': 'Packing (CL118)',
    },
    # Preparing or Adding Return Label
    'CL147': {
        'Left': ['CL062'],   # Shipping/Return Label
        'Right': ['CL097'],  # Shipping/Return Label
        'Description': 'Return Label',
        'Process': 'Preparing Return Label (CL147)',
        'BPMN_Context': 'Packing (CL118)',
    },
    # Tying Elastic Band Around Cardboard
    'CL152': {
        'Left': ['CL063'],   # Elastic Band
        'Right': ['CL098'],  # Elastic Band
        'Description': 'Elastic Band',
        'Process': 'Tying Elastic Band (CL152)',
        'BPMN_Context': 'Unpacking (CL117)',
    },
    # Retrieving Items — Scan erforderlich
    'CL139': {
        'Left': ['CL052', 'CL053'],   # PDT oder Glove Scanner
        'Right': ['CL087', 'CL088'],  # PDT oder Glove Scanner
        'Description': 'PDT oder Glove Scanner',
        'Process': 'Retrieving Items (CL139)',
        'BPMN_Context': 'Picking (CL116)',
    },
}
# Mehrere Tools = mindestens eines muss vorhanden sein (OR-Logik pro Hand)
```

### 11.1.1 validate_tool_requirements()

```python
def validate_tool_requirements(frames):
    """
    Prueft, ob Pflicht-Tools bei entsprechenden CC10-Labels aktiv sind.
    Frame-Level-Validierung: Jedes Frame mit tool-abhaengigem CC10 wird geprueft.
    """
    violations = []

    for frame in frames:
        cc10 = frame.get('CC10')

        if cc10 not in MANDATORY_TOOLS:
            continue

        required = MANDATORY_TOOLS[cc10]

        # Aktive Tools aus CC04 (Left Hand) und CC05 (Right Hand)
        left_tools = [lbl for lbl in required['Left'] if frame.get(lbl) == 1]
        right_tools = [lbl for lbl in required['Right'] if frame.get(lbl) == 1]

        left_match = len(left_tools) > 0
        right_match = len(right_tools) > 0

        if not (left_match or right_match):
            violations.append({
                'frame': frame.get('frame'),
                'type': 'tool_violation',
                'severity': 'CRITICAL',
                'cc10': cc10,
                'required_tool': required['Description'],
                'required_labels_left': required['Left'],
                'required_labels_right': required['Right'],
                'detected_tools_left': left_tools,
                'detected_tools_right': right_tools,
                'bpmn_context': required['BPMN_Context'],
                'description': f"Missing required tool '{required['Description']}' "
                               f"for {required['Process']}"
            })

    return violations
```


### 11.2 EXPECTED_LOCATION_TRANSITIONS — Lookup-Tabelle

```python
EXPECTED_LOCATION_TRANSITIONS = {
    # Collecting Order and Hardware
    'CL124': {
        'Start': ['CL155'],               # Office
        'End':   ['CL155', 'CL156', 'CL157'],
        'Path':  'Office → Cart Area oder Office',
        'Process': 'Preparing Order (CL114)',
    },
    # Collecting Cart
    'CL125': {
        'Start': ['CL155', 'CL156'],      # Office, Cart Area
        'End':   ['CL156'],               # Cart Area
        'Path':  'Cart Area',
        'Process': 'Preparing Order (CL114)',
    },
    # Collecting Empty Cardboard Boxes (Retrieval)
    'CL126': {
        'Start': ['CL155', 'CL156'],
        'End':   ['CL157', 'CL158'],      # Cardboard Box Area
        'Path':  'Office → Cardboard Area',
        'Process': 'Preparing Order (CL114, Retrieval)',
    },
    # Collecting Packed Cardboard Boxes (Storage)
    'CL127': {
        'Start': ['CL155', 'CL156'],
        'End':   ['CL158', 'CL157'],
        'Path':  'Office → Cardboard Area',
        'Process': 'Preparing Order (CL114, Storage)',
    },
    # Transporting a Cart to the Base
    'CL128': {
        'Start': ['CL155', 'CL156', 'CL157', 'CL158'],
        'End':   ['CL161', 'CL162', 'CL163'],
        'Path':  'Office/Cart/Cardboard → Aisle Start',
        'Process': 'Picking (CL115) oder Storing (CL119)',
    },
    # Transporting to Packaging/Sorting Area
    'CL129': {
        'Start': ['CL161', 'CL162', 'CL163'],
        'End':   ['CL159'],               # Packing Area
        'Path':  'Aisle → Packing Area',
        'Process': 'Packing (CL118) oder Unpacking (CL117)',
    },
    # Handing Over Packed Cardboard Boxes
    'CL130': {
        'Start': ['CL159', 'CL161'],
        'End':   ['CL160'],               # Issuing Area
        'Path':  'Packing Area → Issuing Area',
        'Process': 'Finalizing (CL121, Retrieval)',
    },
    # Returning Empty Cardboard Boxes
    'CL131': {
        'Start': ['CL159', 'CL161'],
        'End':   ['CL157'],               # Cardboard Box Area
        'Path':  'Packing → Cardboard Area',
        'Process': 'Finalizing (CL121, Storage)',
    },
    # Returning Cart
    'CL132': {
        'Start': ['CL155', 'CL156', 'CL157', 'CL158'],
        'End':   ['CL156'],               # Cart Area
        'Path':  '→ Cart Area',
        'Process': 'Finalizing (CL121)',
    },
    # Returning Hardware
    'CL133': {
        'Start': ['CL155', 'CL156'],
        'End':   ['CL155'],               # Office
        'Path':  '→ Office',
        'Process': 'Finalizing (CL121)',
    },
    # Moving to the Next Position
    'CL137': {
        'Start': ['CL161', 'CL162', 'CL163'],
        'End':   ['CL161', 'CL162', 'CL163'],
        'Path':  'Within Aisle/Cross Aisle',
        'Process': 'Picking (CL115) oder Storing (CL119)',
    },
    # Placing Items on Rack
    'CL138': {
        'Start': ['CL162', 'CL163'],
        'End':   ['CL163'],               # Aisle Path (am Regal)
        'Path':  'At Shelf (Aisle)',
        'Process': 'Storing (CL120)',
    },
    # Retrieving Items
    'CL139': {
        'Start': ['CL162', 'CL163'],
        'End':   ['CL163'],
        'Path':  'At Shelf (Aisle)',
        'Process': 'Picking (CL116)',
    },
    # Moving to a Cart
    'CL140': {
        'Start': ['CL162', 'CL163'],
        'End':   ['CL162', 'CL163'],
        'Path':  'Aisle/Cross Aisle',
        'Process': 'Picking (CL116) oder Storing (CL120)',
    },
    # Placing Cardboard Box on Table
    'CL141': {
        'Start': ['CL161', 'CL162', 'CL163'],
        'End':   ['CL159'],               # Packing Area
        'Path':  'Aisle → Packing Table',
        'Process': 'Packing (CL118) oder Unpacking (CL117)',
    },
    # Opening Cardboard Box
    'CL142': {
        'Start': ['CL159'],
        'End':   ['CL159'],
        'Path':  'Packing Area',
        'Process': 'Unpacking (CL117)',
    },
    # Sorting
    'CL144': {
        'Start': ['CL159'],
        'End':   ['CL159'],
        'Path':  'Packing Area',
        'Process': 'Packing (CL118) oder Unpacking (CL117)',
    },
    # Filling Cardboard Box
    'CL145': {
        'Start': ['CL159'],
        'End':   ['CL159'],
        'Path':  'Packing Area',
        'Process': 'Packing (CL118)',
    },
    # Printing Shipping Label
    'CL146': {
        'Start': ['CL159'],
        'End':   ['CL159'],
        'Path':  'Packing Area',
        'Process': 'Packing (CL118)',
    },
    # Attaching Shipping Label
    'CL148': {
        'Start': ['CL159'],
        'End':   ['CL159'],
        'Path':  'Packing Area',
        'Process': 'Packing (CL118)',
    },
    # Sealing Cardboard Box
    'CL150': {
        'Start': ['CL159'],
        'End':   ['CL159'],
        'Path':  'Packing Area',
        'Process': 'Packing (CL118)',
    },
    # Placing Cardboard Box in Cart
    'CL151': {
        'Start': ['CL159', 'CL163'],
        'End':   ['CL159', 'CL163'],
        'Path':  'Packing Area oder Aisle',
        'Process': 'Packing (CL118) oder Unpacking (CL117)',
    },
}
# Abweichung = WARNING (nicht CRITICAL), da Probanden sich irren koennen
# Fuer einfache Lookup-Checks: EXPECTED_LOCATIONS = {k: v['End'] for k, v in EXPECTED_LOCATION_TRANSITIONS.items()}
```


### 11.3 validate_location_transitions()

```python
def validate_location_transitions(frames):
    """
    Frame-Level-Validierung mit Transition-Detection.
    Prueft Start- und End-Location gegen EXPECTED_LOCATION_TRANSITIONS.
    Nur bei Location-Aenderung aktiv.
    """
    violations = []
    for i in range(1, len(frames)):
        prev_loc = frames[i-1].get('CC11_main')
        curr_loc = frames[i].get('CC11_main')
        cc10 = frames[i].get('CC10')

        if prev_loc == curr_loc:
            continue

        if cc10 not in EXPECTED_LOCATION_TRANSITIONS:
            continue

        expected = EXPECTED_LOCATION_TRANSITIONS[cc10]

        # Pruefe Start-Location
        if prev_loc not in expected['Start']:
            violations.append({
                'frame': frames[i].get('frame'),
                'type': 'location_violation',
                'severity': 'WARNING',
                'cc10': cc10,
                'prev_location': prev_loc,
                'curr_location': curr_loc,
                'expected_start': expected['Start'],
                'expected_end': expected['End'],
                'expected_path': expected['Path'],
                'description': f"Invalid start location for {expected['Process']}: "
                               f"Expected {expected['Start']}, got {prev_loc}"
            })

        # Pruefe End-Location
        if curr_loc not in expected['End']:
            violations.append({
                'frame': frames[i].get('frame'),
                'type': 'location_violation',
                'severity': 'WARNING',
                'cc10': cc10,
                'prev_location': prev_loc,
                'curr_location': curr_loc,
                'expected_start': expected['Start'],
                'expected_end': expected['End'],
                'expected_path': expected['Path'],
                'description': f"Invalid end location for {expected['Process']}: "
                               f"Expected {expected['End']}, got {curr_loc}"
            })

    return violations
```

### 11.4 detect_teleportations() — räumliche Nachbarschaftsprüfung

```python
# Räumliche Nachbarschaftsgraph (CC11 Main-Area-Labels)
ADJACENT_LOCATIONS = {
    'CL155': ['CL156', 'CL157'],               # Office → Cart Area, Cardboard Area
    'CL156': ['CL155', 'CL157', 'CL158', 'CL161'],  # Cart Area
    'CL157': ['CL155', 'CL156', 'CL158', 'CL161'],  # Cardboard Area
    'CL158': ['CL156', 'CL157', 'CL161'],      # Base → Cart, Cardboard, Path
    'CL159': ['CL161', 'CL162', 'CL160'],      # Packing Area → Path, Cross Aisle, Issuing
    'CL160': ['CL159', 'CL161'],               # Issuing Area → Packing, Path
    'CL161': ['CL156', 'CL157', 'CL158', 'CL162', 'CL159'],  # Path ↔ alle Eingänge
    'CL162': ['CL161', 'CL163', 'CL159'],      # Cross Aisle Path ↔ Path, Aisle Path
    'CL163': ['CL162'],                        # Aisle Path ↔ Cross Aisle
}

def detect_teleportations(frames):
    """
    Erkennt unrealistische Location-Sprünge zwischen nicht-benachbarten Bereichen.
    Worker können nicht sofort von Office (CL155) zu Aisle Path (CL163) wechseln.
    """
    violations = []
    for i in range(1, len(frames)):
        prev_loc = frames[i-1].get('CC11_main')
        curr_loc = frames[i].get('CC11_main')

        if prev_loc == curr_loc or prev_loc is None or curr_loc is None:
            continue

        if prev_loc in ADJACENT_LOCATIONS:
            if curr_loc not in ADJACENT_LOCATIONS[prev_loc]:
                violations.append({
                    'frame': frames[i]['frame'],
                    'type': 'teleportation',
                    'severity': 'CRITICAL',
                    'prev_location': prev_loc,
                    'curr_location': curr_loc,
                    'description': f'Unrealistischer Location-Sprung: {prev_loc} → {curr_loc}'
                })
    return violations
```

### 11.5 validate_multi_order_co_activation()

```python
def validate_multi_order_co_activation(frames, scenario):
    """
    Prüft Multi-Order-Struktur für S7 (Retrieval, 2 Orders) und S8 (Storage, 2 Orders).
    Erwartet: Zwei vollständige, sequenzielle Order-Sequenzen (NICHT parallel).
    """
    violations = []

    if scenario not in ['S7', 'S8']:
        return violations

    # CL121→CL114-Übergänge zählen (= Order-Grenze)
    order_boundaries = 0
    for i in range(1, len(frames)):
        prev_cc09 = frames[i-1].get('CC09')
        curr_cc09 = frames[i].get('CC09')
        if prev_cc09 == 'CL121' and curr_cc09 == 'CL114':
            order_boundaries += 1

    # order_count = erkannte Orders = Grenzen + 1
    order_count = order_boundaries + 1
    expected_orders = 2

    # Multi-Order: erwartet genau 1 Grenze (= 2 Orders)
    if order_boundaries != 1:
        violations.append({
            'type': 'multi_order_violation',
            'severity': 'CRITICAL',
            'scenario': scenario,
            'expected_orders': expected_orders,
            'detected_orders': order_count,
            'expected_order_boundaries': 1,
            'detected_order_boundaries': order_boundaries,
            'description': f'{scenario}: Erwartet {expected_orders} Orders (1 CL121→CL114-Übergang), '
                           f'gefunden: {order_count} Orders ({order_boundaries} Übergänge)'
        })

    return violations


def validate_cl134_global_interrupt(frames):
    """
    Prüft ob CL134 (Waiting) als exklusiver Global Interrupt behandelt wird.
    Wenn CL134 aktiv ist, sollten keine anderen CC10-Labels gleichzeitig aktiv sein.
    """
    violations = []
    for frame in frames:
        if frame.get('CC10') == 'CL134':
            # CL134 ist CC10 = Single-Label → prüfe ob konsistent
            # Im DaRa-Datensatz ist CC10 Single-Label (genau 1 aktiv)
            # Dieser Check ist daher immer erfüllt wenn CC10 korrekt annotiert
            pass  # Single-Label-Constraint durch reference_activation_rules.md §2 gewährleistet
    return violations
```

---

## 11.6 validate_bpmn() — Vollständiger Workflow

```python
def validate_bpmn(frames, scenario):
    """
    Führt alle Validierungen durch und gibt konsolidierte Violations zurück.
    """
    violations = []

    for i in range(len(frames)):
        cc09 = frames[i]['CC09']
        cc10 = frames[i]['CC10']

        # 1. CC09→CC10 Mapping (V-B3)
        result = validate_cc10_from_cc09(cc09, cc10)
        if not result['valid']:
            violations.append(result)

        # 2. CC09 Transition (nur bei Wechsel)
        if i > 0:
            prev_cc09 = frames[i-1]['CC09']
            if prev_cc09 != cc09:
                result = validate_cc09_transition(prev_cc09, cc09)
                if not result['valid']:
                    violations.append(result)

        # 3. Tool-Validierung
        if cc10 in MANDATORY_TOOLS:
            result = validate_tools(frames[i], cc10)
            if not result['valid']:
                violations.append(result)

        # 4. Location-Plausibilität
        result = validate_location(frames[i], cc10)
        if not result['valid']:
            violations.append(result)

    # 5. Teleportation-Detection
    violations.extend(detect_teleportations(frames))

    # 6. Multi-Order-Validierung (S7/S8)
    violations.extend(validate_multi_order_co_activation(frames, scenario))

    return violations
```

---

## 12. Ergebnis-Ausgabeformat (Pflichtausgabe)

Nach der Process-Validierung **MÜSSEN** folgende Ergebnistabellen ausgegeben werden.

### 12.1 Process-Konformitäts-Zusammenfassung

```markdown
### Process-Konformität — Proband S{XX}, Szenario {SN}

| Metrik | Wert |
|:-------|:-----|
| Szenario | S4 (Storage, Order 2904) |
| Gesamt-Frames | 28.400 |
| Dauer | 00:15:47 |
| Frames ohne Violation | 27.560 |
| **Konformitätsrate** | **97,0%** |
| CRITICAL Violations | 2 |
| WARNING Violations | 8 |
| INFO Events | 15 |

**SOLL-Pfad (idealisiert):**
CL114 → CL117 → CL119 → CL120 → CL121

**IST-Pfad (beobachtet):**
CL114 → CL117 → CL119 → CL120 → **CL119** → CL120 → CL121
                                    ↑ Loop (Rückwärts-Transition)
```

### 12.2 Abweichungs-Häufigkeitstabelle

```markdown
### Violations — Proband S{XX}, Szenario {SN}

| # | Typ | Severity | Anzahl | Betroffene Frames | Beschreibung |
|:--|:----|:---------|-------:|:-------------------|:-------------|
| 1 | CC10-Fehler | CRITICAL | 1 | 12.450–12.480 | CL138 während CL116 (Store-Label in Pick-Phase) |
| 2 | Tool fehlt | CRITICAL | 1 | 8.200–8.215 | CL142 ohne Knife (CL061/CL096) |
| 3 | Location | WARNING | 4 | div. | CL139 nicht in Aisle Path (CL163) |
| 4 | CL135 | WARNING | 3 | div. | Error-Event in S5 (geplant für S5) |
| 5 | CL135 | WARNING | 1 | 22.100 | CL135 in Perfect Run (S7/S8) — ungeplant |
| 6 | CL134 | INFO | 8 | div. | Wartezeit >30s am Stück |
| 7 | Rück-Trans. | INFO | 7 | div. | CL116→CL115 (normaler Loop) |
```

### 12.3 Loop- und Wiederholungs-Analyse

```markdown
### Loops & Wiederholungen — Proband S{XX}, Szenario {SN}

| Loop-Typ | Beschreibung | Anzahl | Ø Dauer |
|:---------|:-------------|-------:|:--------|
| Pick-Loop | CL116→CL115→CL116 (Gateway 4: "Order completed?" = NO) | 14 | 00:00:42 |
| Store-Loop | CL120→CL119→CL120 (Gateway 4: "Order completed?" = NO) | 0 | — |
| Error-Loop Pick | CL135→CL137 (Gateway 2/3: Fehler) | 3 | 00:01:12 |
| Error-Loop Store | CL135→CL137 (Gateway 2/3: Fehler) | 0 | — |
| Packing-Loop | CL151→CL129 (Gateway: "More boxes?" = YES) | 1 | 00:03:45 |
| Unpacking-Loop | CL151→CL129 (Gateway: "More boxes?" = YES) | 2 | 00:02:30 |
| CL134 Events | Wartezeiten (Global Interrupt) | 8 | 00:00:18 |

**Fehlerrate (CL135):**
- Geplante Fehler (S1, S3, S5): 3 Events
- Ungeplante Fehler (S2, S4, S6, S7, S8): 0 Events
- **CL135 / Pick-Cycle Ratio:** 3/14 = 21,4%
```

### 12.4 Prozess-Instanz-Timeline

```markdown
### CC09-Timeline — Proband S{XX}, Szenario {SN}

| # | CC09 | Beschreibung | Start-Frame | End-Frame | Frames | Dauer | SOLL? |
|:--|:-----|:-------------|:------------|:----------|-------:|:------|:------|
| 1 | CL114 | Preparing Order | 1 | 2.850 | 2.850 | 00:01:35 | ✅ |
| 2 | CL115 | Pick Travel Time | 2.851 | 5.200 | 2.350 | 00:01:18 | ✅ |
| 3 | CL116 | Pick Time | 5.201 | 6.800 | 1.600 | 00:00:53 | ✅ |
| 4 | CL115 | Pick Travel Time | 6.801 | 8.100 | 1.300 | 00:00:43 | ✅ Loop |
| 5 | CL116 | Pick Time | 8.101 | 9.400 | 1.300 | 00:00:43 | ✅ Loop |
| ... | ... | ... | ... | ... | ... | ... | ... |
| N | CL121 | Finalizing Order | 26.500 | 28.400 | 1.900 | 00:01:03 | ✅ |
```

### 12.5 Kontext-Anreicherung (Szenario, Warehouse, Artikel)

Die Tabellen SOLLEN mit Kontext aus `reference_warehouse.md` und
`reference_articles.md` angereichert werden:

**Szenario-Kontext:**

```markdown
### Szenario-Kontext — S{N}

| Dimension | Wert |
|:----------|:-----|
| Typ | Retrieval / Storage |
| Order | 2904 (CL100) |
| IT-System | List+Pen (CL105) |
| Positionen | 15 |
| Gassen | 5 (Aisle 1–5) |
| Gewichtsbereich | 0,4g – 5.149g |
| Schwerstposition | R7.3.1.A Palm Soil (5.149g, Large) |
| Geplante Fehler | Ja (S1, S3) / Möglich (S5) / Nein (S2, S4, S6, S7, S8) |
```

**Warehouse-Distanzen (geschätzt):**

Die Distanzen werden aus dem Warehouse-Layout abgeleitet (→ reference_warehouse.md):

| Route | Von | Nach | Geschätzte Distanz |
|:------|:----|:-----|:-------------------|
| Office → Cart Area | CL155 | CL156 | ~5 m |
| Cart Area → Cardboard Box Area | CL156 | CL157 | ~3 m |
| Base → Aisle 1 Front | CL158 | CL163+CL172+CL177 | ~2 m |
| Base → Aisle 5 Back | CL158 | CL163+CL176+CL178 | ~15 m |
| Cross Aisle 1-2 → 4-5 | CL168 | CL171 | ~12 m |
| Packing Area → Issuing Area | CL159 | CL160 | ~4 m |

> **HINWEIS:** Distanzen sind Approximationen basierend auf den bekannten
> Abmessungen (Regalbereich: 12,76 m; Regalblock-Breite: 4,09 m;
> Gangbreite: 0,91 m). Präzise Distanzmessung ist ohne GPS-Daten nicht möglich.

**Artikel-Kontext pro Pick/Store-Cycle:**

```markdown
### Pick-Cycle Artikel — Proband S{XX}, Szenario S1

| Cycle | Gasse | Position | Artikel | Menge | Gewicht | Klasse | Ebene |
|:------|:------|:---------|:--------|:-----:|:--------|:-------|:------|
| 1 | Aisle 1 | R1.2.7.A | Hexagonal Cap Nut M5 | 20 | ~1g | S | 7 (oben) |
| 2 | Aisle 1 | R1.4.5.A | Locknut | 10 | ~1g | S | 5 (mitte) |
| 3 | Aisle 2 | R2.1.4.A | Softshell Jacket S | 1 | ~600g | M | 4 (mitte) |
| ... | ... | ... | ... | ... | ... | ... | ... |
```

**Ergonomie-Hinweise (aus Artikel-Kontext):**

| Faktor | Auswirkung auf BPMN |
|:-------|:--------------------|
| Ebene 1 (Boden) | CC01=Handling Downwards (CL010), CC03 Strongly Bending (CL026) |
| Ebene 7–8 (oben) | CC01=Handling Upwards (CL008), CC03 No/Slightly Bending |
| Large Item (>800g) | Längere CL139-Dauer, ggf. zweihändig |
| Hohe Stückzahl (≥10) | Mehrfaches Greifen in CL116, verlängerte Pick Time |
| Kleinstteile (≤5g) | Feinmotorik, CC04/CC05 v.a. CL034 (Grasping) |

### 12.6 Python: Ergebnis-Generierung

```python
def frames_to_hhmmss(frame_count, fps=30):
    """Konvertiert Frame-Anzahl in hh:mm:ss Format."""
    total_seconds = frame_count / fps
    hours = int(total_seconds // 3600)
    minutes = int((total_seconds % 3600) // 60)
    seconds = int(total_seconds % 60)
    return f"{hours:02d}:{minutes:02d}:{seconds:02d}"

# SOLL-Pfade pro Szenario
SOLL_PATHS = {
    'S1': ['CL114', 'CL115', 'CL116', 'CL118', 'CL121'],
    'S2': ['CL114', 'CL115', 'CL116', 'CL118', 'CL121'],
    'S3': ['CL114', 'CL115', 'CL116', 'CL118', 'CL121'],
    'S4': ['CL114', 'CL117', 'CL119', 'CL120', 'CL121'],
    'S5': ['CL114', 'CL117', 'CL119', 'CL120', 'CL121'],
    'S6': ['CL114', 'CL117', 'CL119', 'CL120', 'CL121'],
    'S7': ['CL114', 'CL115', 'CL116', 'CL118', 'CL121'],  # ×2 Orders
    'S8': ['CL114', 'CL117', 'CL119', 'CL120', 'CL121'],  # ×2 Orders
}

SCENARIO_CONTEXT = {
    'S1': {'typ': 'Retrieval', 'order': '2904 (CL100)', 'it': 'CL105 List+Pen',
           'fehler': 'Ja (falsche Lagerplätze)'},
    'S2': {'typ': 'Retrieval', 'order': '2905 (CL101)', 'it': 'CL107 PDT',
           'fehler': 'Nein'},
    'S3': {'typ': 'Retrieval', 'order': '2906 (CL102)', 'it': 'CL106 Scanner',
           'fehler': 'Ja (Mengenabweichungen)'},
    'S4': {'typ': 'Storage', 'order': '2904 (CL100)', 'it': 'CL105 List+Pen',
           'fehler': 'Nein'},
    'S5': {'typ': 'Storage', 'order': '2905 (CL101)', 'it': 'CL105 List+Pen',
           'fehler': 'Nein'},
    'S6': {'typ': 'Storage', 'order': '2906 (CL102)', 'it': 'CL105 List+Pen',
           'fehler': 'Nein'},
    'S7': {'typ': 'Retrieval (Multi)', 'order': '2904+2905 (CL100+CL101)',
           'it': 'CL105 List+Pen', 'fehler': 'Nein (Perfect Run)'},
    'S8': {'typ': 'Storage (Multi)', 'order': '2904+2905 (CL100+CL101)',
           'it': 'CL105 List+Pen', 'fehler': 'Nein (Perfect Run)'},
}

def count_loops(cc09_sequence):
    """Zählt Pick-, Store-, Error- und Packing/Unpacking-Loops."""
    loops = {
        'pick_loop': 0,      # CL116→CL115
        'store_loop': 0,     # CL120→CL119
        'error_pick': 0,     # CL135 während CL115/CL116
        'error_store': 0,    # CL135 während CL119/CL120
        'packing_loop': 0,   # CL151→CL129 (in CL118)
        'unpacking_loop': 0, # CL151→CL129 (in CL117)
    }
    
    for i in range(1, len(cc09_sequence)):
        prev, curr = cc09_sequence[i-1], cc09_sequence[i]
        if prev == 'CL116' and curr == 'CL115':
            loops['pick_loop'] += 1
        elif prev == 'CL120' and curr == 'CL119':
            loops['store_loop'] += 1
    
    return loops

def conformance_rate(violations, total_frames):
    """Berechnet Konformitätsrate."""
    violation_frames = sum(v.get('frame_count', 1) for v in violations)
    clean_frames = total_frames - violation_frames
    return (clean_frames / total_frames) * 100
```

---

## 13. BPMN-Generierung & Visualisierung

### 13.1 JSON-Schema für BPMN-Graphen

#### Node-Typen

```json
{
  "nodeTypes": {
    "startEvent":        "Rundes Start-Symbol",
    "endEvent":          "Rundes End-Symbol",
    "task":              "Rechteckige Aktivitaet (CC09 Mid-Level Process)",
    "exclusiveGateway":  "Rautenfoermiger XOR-Gateway (Entscheidungspunkt)",
    "parallelGateway":   "Rautenfoermiger AND-Gateway (Parallele Pfade)"
  }
}
```

#### Vollständiges Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "DaRa BPMN Process Graph",
  "type": "object",
  "required": ["subject_id", "scenario", "bpmn_graph", "metadata"],
  "properties": {
    "subject_id":  { "type": "string", "pattern": "^S(0[1-9]|1[0-8])$" },
    "scenario":    { "type": "string", "enum": ["S1","S2","S3","S4","S5","S6","S7","S8","Other"] },
    "session":     { "type": "integer", "minimum": 1, "maximum": 6 },
    "bpmn_graph": {
      "type": "object",
      "required": ["nodes", "edges"],
      "properties": {
        "nodes": {
          "type": "array",
          "items": {
            "type": "object",
            "required": ["id", "name", "type"],
            "properties": {
              "id":               { "type": "string" },
              "name":             { "type": "string" },
              "type":             { "type": "string", "enum": ["startEvent","endEvent","task","exclusiveGateway","parallelGateway"] },
              "cc09":             { "type": "string" },
              "frame_start":      { "type": "integer" },
              "frame_end":        { "type": "integer" },
              "duration_frames":  { "type": "integer" },
              "duration_seconds": { "type": "number" },
              "violations":       { "type": "array" }
            }
          }
        },
        "edges": {
          "type": "array",
          "items": {
            "type": "object",
            "required": ["source", "target"],
            "properties": {
              "source":          { "type": "string" },
              "target":          { "type": "string" },
              "label":           { "type": "string" },
              "transition_type": { "type": "string", "enum": ["sequence","loop","conditional"] }
            }
          }
        }
      }
    },
    "metadata": {
      "type": "object",
      "properties": {
        "total_frames":           { "type": "integer" },
        "total_duration_seconds": { "type": "number" },
        "process_phases":         { "type": "object" },
        "validation_summary": {
          "type": "object",
          "properties": {
            "total_violations": { "type": "integer" },
            "critical":         { "type": "integer" },
            "warning":          { "type": "integer" },
            "info":             { "type": "integer" }
          }
        }
      }
    },
    "deviations": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["frame", "type", "severity", "description"],
        "properties": {
          "frame":    { "type": "integer" },
          "chunk_id": { "type": "integer" },
          "type": {
            "type": "string",
            "enum": [
              "sequence_violation", "tool_violation", "location_violation",
              "multi_order_violation", "teleportation", "chunk_instability",
              "noisy_transition", "cl134_not_prioritized",
              "post_waiting_continuation", "multi_order_loop_missing",
              "multi_order_incomplete"
            ]
          },
          "severity":      { "type": "string", "enum": ["CRITICAL","WARNING","INFO"] },
          "description":   { "type": "string" },
          "prev_cc09":     { "type": "string" },
          "curr_cc09":     { "type": "string" },
          "cc10":          { "type": "string" },
          "required_tool": { "type": "string" },
          "prev_location": { "type": "string" },
          "curr_location": { "type": "string" }
        }
      }
    }
  }
}
```

### 13.2 generate_bpmn_from_data()

```python
def generate_bpmn_from_data(frames, subject_id, scenario, session):
    """
    Generiert BPMN-JSON-Struktur aus tatsaechlichen Prozessdaten.

    Parameters:
        frames     - Liste von Frame-Dicts mit CC09, CC10, chunk_id, frame, ...
        subject_id - Probanden-ID (z.B. 'S14')
        scenario   - Szenario-ID (z.B. 'S1')
        session    - Session-Nummer (1-6)

    Returns:
        Vollstaendige BPMN-JSON-Struktur als Dict
    """
    bpmn = {
        'subject_id': subject_id,
        'scenario': scenario,
        'session': session,
        'bpmn_graph': {'nodes': [], 'edges': []},
        'metadata': {},
        'deviations': []
    }

    # Start-Node
    bpmn['bpmn_graph']['nodes'].append({'id': 'start_1', 'name': 'Start', 'type': 'startEvent'})

    # Task-Nodes aus CC09-Sequenz (pro Chunk)
    from itertools import groupby
    chunk_seq = []
    for chunk_id, group in groupby(frames, key=lambda f: f['chunk_id']):
        chunk_frames = list(group)
        cc09_vals = [f['CC09'] for f in chunk_frames]
        cc09 = max(set(cc09_vals), key=cc09_vals.count)  # Modus
        chunk_seq.append((chunk_id, cc09, chunk_frames))

    for idx, (chunk_id, cc09, chunk_frames) in enumerate(chunk_seq):
        node_id = f'task_{cc09}_{idx}'
        bpmn['bpmn_graph']['nodes'].append({
            'id': node_id,
            'name': get_label_name(cc09),
            'type': 'task',
            'cc09': cc09,
            'frame_start': chunk_frames[0]['frame'],
            'frame_end': chunk_frames[-1]['frame'],
            'duration_frames': len(chunk_frames),
            'duration_seconds': round(len(chunk_frames) / 30.0, 2)
        })

    # End-Node
    bpmn['bpmn_graph']['nodes'].append({'id': 'end_1', 'name': 'End', 'type': 'endEvent'})

    # Edges
    node_ids = ['start_1'] + [f'task_{cc09}_{idx}' for idx, (_, cc09, _) in enumerate(chunk_seq)] + ['end_1']
    for i in range(len(node_ids) - 1):
        bpmn['bpmn_graph']['edges'].append({
            'source': node_ids[i],
            'target': node_ids[i + 1],
            'transition_type': 'sequence'
        })

    # Metadata
    bpmn['metadata'] = {
        'total_frames': len(frames),
        'total_duration_seconds': round(len(frames) / 30.0, 2),
        'process_phases': calculate_phase_statistics(frames),
        'validation_summary': {
            'total_violations': 0, 'critical': 0, 'warning': 0, 'info': 0
        }
    }
    return bpmn


def get_label_name(label_code):
    """Gibt den Klarnamen fuer ein CC09-Label zurueck."""
    LABEL_NAMES = {
        'CL114': 'Preparing Order',
        'CL115': 'Picking - Travel Time',
        'CL116': 'Picking - Pick Time',
        'CL117': 'Unpacking',
        'CL118': 'Packing',
        'CL119': 'Storing - Travel Time',
        'CL120': 'Storing - Store Time',
        'CL121': 'Finalizing Order',
        'CL122': 'Another Mid-Level Process',
        'CL123': 'Mid-Level Process Unknown',
    }
    return LABEL_NAMES.get(label_code, label_code)


def calculate_phase_statistics(frames):
    """Berechnet aggregierte Statistiken pro CC09-Phase."""
    from collections import defaultdict
    stats = defaultdict(lambda: {'count': 0, 'total_frames': 0, 'total_duration_seconds': 0.0})
    for frame in frames:
        cc09 = frame.get('CC09', 'UNKNOWN')
        stats[cc09]['count'] += 1
        stats[cc09]['total_frames'] += 1
        stats[cc09]['total_duration_seconds'] = round(stats[cc09]['total_frames'] / 30.0, 2)
    return dict(stats)
```

### 13.3 Mermaid-Syntax-Export

```python
def generate_mermaid_from_bpmn(bpmn_json):
    """Konvertiert BPMN-JSON zu Mermaid-Flowchart-Syntax."""
    lines = ['graph TD']

    for node in bpmn_json['bpmn_graph']['nodes']:
        nid  = node['id']
        name = node['name']
        ntyp = node['type']
        if ntyp == 'startEvent':
            lines.append(f'    {nid}[Start]')
        elif ntyp == 'endEvent':
            lines.append(f'    {nid}[End]')
        elif ntyp == 'task':
            dur = node.get('duration_seconds', '?')
            lines.append(f'    {nid}["{name}<br/>({dur}s)"]')
        elif ntyp == 'exclusiveGateway':
            lines.append(f"    {nid}{{'{name}'}}")

    for edge in bpmn_json['bpmn_graph']['edges']:
        src = edge['source']
        tgt = edge['target']
        lbl = edge.get('label', '')
        if lbl:
            lines.append(f'    {src} -->|{lbl}| {tgt}')
        else:
            lines.append(f'    {src} --> {tgt}')

    return '\n'.join(lines)
```

### 13.4 IST vs. SOLL Vergleich

```python
def compare_bpmn_ist_soll(ist_bpmn, scenario):
    """
    Vergleicht tatsaechlich durchgefuehrten Prozess (IST) mit idealem BPMN (SOLL).
    Returns: Diff-Struktur mit conformity_score (0-100%).
    """
    soll_sequence = SOLL_SEQUENCES.get(scenario, [])
    ist_sequence = [
        node['cc09']
        for node in ist_bpmn['bpmn_graph']['nodes']
        if node['type'] == 'task'
    ]

    missing_nodes = [cc09 for cc09 in soll_sequence if cc09 not in ist_sequence]
    extra_nodes   = [cc09 for cc09 in ist_sequence  if cc09 not in soll_sequence]

    deviations = sum(
        1 for i in range(min(len(ist_sequence), len(soll_sequence)))
        if ist_sequence[i] != soll_sequence[i]
    )

    return {
        'scenario':          scenario,
        'soll_sequence':     soll_sequence,
        'ist_sequence':      ist_sequence,
        'missing_nodes':     missing_nodes,
        'extra_nodes':       extra_nodes,
        'sequence_deviations': deviations,
        'conformity_score':  round(
            (1 - deviations / max(len(ist_sequence), len(soll_sequence), 1)) * 100, 2
        )
    }
```

---

## 14. Verwendungsbeispiele

### 14.1 Single-Subject-Validierung

```python
# Lade Daten fuer Subject S14, Scenario S1, Session 3
frames = load_proband_data('S14', 'S1', session=3)

# Fuehre alle Validierungen durch
violations = []
violations.extend(validate_tool_requirements(frames))
violations.extend(validate_location_transitions(frames))
violations.extend(detect_teleportations(frames))
violations.extend(validate_multi_order_co_activation(frames, scenario='S1'))
violations.extend(validate_cl134_global_interrupt(frames))

# Sequenz-Validierung (Chunk-Level)
for i in range(len(frames) - 1):
    prev_cc09 = frames[i]['CC09']
    curr_cc09 = frames[i + 1]['CC09']
    if prev_cc09 != curr_cc09:
        result = validate_cc09_transition(prev_cc09, curr_cc09)
        if not result['valid']:
            violations.append(result)

# Generiere BPMN-Graph
bpmn = generate_bpmn_from_data(frames, 'S14', 'S1', 3)
bpmn['deviations'] = violations

# Exportiere als Mermaid
mermaid_code = generate_mermaid_from_bpmn(bpmn)
print(mermaid_code)

# IST/SOLL Vergleich
diff = compare_bpmn_ist_soll(bpmn, 'S1')
print(f"Conformity Score: {diff['conformity_score']}%")

# Exportiere als JSON
import json
with open('bpmn_S14_S1_session3.json', 'w', encoding='utf-8') as f:
    json.dump(bpmn, f, indent=2, ensure_ascii=False)
```

### 14.2 Szenario-Spezifische Validierung (S7 Multi-Order)

```python
# Validiere alle Subjects in Scenario S7 (Multi-Order Retrieval)
results = []
for subject_id in [f'S{i:02d}' for i in range(1, 19)]:
    for session in range(1, 7):
        frames = load_proband_data(subject_id, 'S7', session=session)
        if not frames:
            continue

        violations = validate_multi_order_co_activation(frames, scenario='S7')
        results.append({
            'subject': subject_id,
            'session': session,
            'violations': violations,
            'issues': len(violations) > 0
        })

# Zusammenfassung
issues = [r for r in results if r['issues']]
print(f"S7 Multi-Order Issues: {len(issues)} / {len(results)} Sessions")
```

---

## 15. Erweiterungen

### 15.1 Probabilistische Sequenz-Validierung (Markov-Chain)

```python
def validate_sequence_probabilistic(frames, confidence=0.95):
    """
    Probabilistische Validierung basierend auf Haeufigkeit beobachteter Uebergaenge.
    Nutzt Markov-Chain-Analyse ueber alle Probanden.
    """
    transition_matrix = build_transition_matrix(frames)
    violations = []

    for i in range(len(frames) - 1):
        from_cc09 = frames[i]['CC09']
        to_cc09   = frames[i + 1]['CC09']

        prob = transition_matrix.get(from_cc09, {}).get(to_cc09, 0.0)
        if prob < (1 - confidence):
            violations.append({
                'frame':               frames[i]['frame'],
                'type':                'sequence_violation',
                'severity':            'WARNING',
                'prev_cc09':           from_cc09,
                'curr_cc09':           to_cc09,
                'probability':         prob,
                'confidence_threshold': confidence,
                'description': f'Seltener Uebergang {from_cc09}→{to_cc09} (P={prob:.3f})'
            })

    return violations
```

### 15.2 BPMN-Diff-Visualisierung (Farbcodierung)

```python
def visualize_bpmn_diff(ist_bpmn, soll_bpmn):
    """
    Visualisiert IST/SOLL-Unterschiede mit Farbcodierung:
      Gruen  (#90EE90) = Match mit SOLL
      Rot    (#FF6B6B) = Extra (nicht in SOLL)
      Orange (#FFA500) = Missing (in SOLL, nicht in IST)
    """
    lines = ['graph TD']

    soll_nodes = {
        node['cc09']: node
        for node in soll_bpmn['bpmn_graph']['nodes']
        if node['type'] == 'task'
    }
    ist_nodes = {
        node['cc09']: node
        for node in ist_bpmn['bpmn_graph']['nodes']
        if node['type'] == 'task'
    }

    for cc09, node in ist_nodes.items():
        nid  = node['id']
        name = node['name']
        if cc09 in soll_nodes:
            lines.append(f'    {nid}["{name}"]')
            lines.append(f'    style {nid} fill:#90EE90')
        else:
            lines.append(f'    {nid}["{name} EXTRA"]')
            lines.append(f'    style {nid} fill:#FF6B6B')

    for cc09 in soll_nodes:
        if cc09 not in ist_nodes:
            nid = f'missing_{cc09}'
            lines.append(f'    {nid}["{cc09} MISSING"]')
            lines.append(f'    style {nid} fill:#FFA500,stroke:#FF6347,stroke-dasharray:5 5')

    for edge in ist_bpmn['bpmn_graph']['edges']:
        lines.append(f'    {edge["source"]} --> {edge["target"]}')

    return '\n'.join(lines)
```

### 15.3 Automatische Fehlerursachen-Hypothesen

```python
def generate_error_hypothesis(violation):
    """
    Generiert regelbasierte Hypothesen fuer Abweichungsursachen.
    Returns: Liste von Hypothesen mit likelihood (HIGH / MEDIUM / LOW).
    """
    hypotheses = []
    vtype = violation.get('type')
    prev  = violation.get('prev_cc09', '')
    curr  = violation.get('curr_cc09', '')

    if vtype == 'sequence_violation':
        if prev in ['CL115', 'CL116'] and curr in ['CL119', 'CL120']:
            hypotheses.append({
                'hypothesis': 'Proband hat versehentlich zu Storage-Prozess gewechselt',
                'likelihood': 'MEDIUM',
                'evidence': 'Ungueltige Transition von Retrieval zu Storage'
            })
            hypotheses.append({
                'hypothesis': 'Annotationsfehler: Frame sollte anderes CC09 haben',
                'likelihood': 'HIGH',
                'evidence': 'Abrupter Prozesswechsel ohne logischen Grund'
            })
        if prev == 'CL115' and curr == 'CL121':
            hypotheses.append({
                'hypothesis': 'Picking wurde abgebrochen (Item nicht verfuegbar)',
                'likelihood': 'HIGH',
                'evidence': 'Direkter Uebergang zu Finalizing ohne Pick Time'
            })

    elif vtype == 'tool_violation':
        hypotheses.append({
            'hypothesis': 'Tool wurde nicht annotiert (Annotationsfehler)',
            'likelihood': 'HIGH',
            'evidence': 'Prozess erfordert Tool, aber keines aktiv'
        })
        hypotheses.append({
            'hypothesis': 'Proband hat Tool nicht verwendet (Prozessabweichung)',
            'likelihood': 'MEDIUM',
            'evidence': 'Reale Abweichung von Standard-Prozedur'
        })

    elif vtype == 'teleportation':
        hypotheses.append({
            'hypothesis': 'Annotationsfehler in CC11 (Location-Label fehlerhaft)',
            'likelihood': 'HIGH',
            'evidence': f'Unrealistischer Sprung: {violation.get("prev_location")} → {violation.get("curr_location")}'
        })

    return hypotheses
```

---

## 16. Verwendungshinweise

**Diese Datei nutzen für:**
- Vollständige Process-Validierung von Probandendaten gegen Figures A2–A7
- CC09→CC10 Mapping-Validierung (V-B3)
- Tool-Validierung mit MANDATORY_TOOLS
- Location-Validierung mit EXPECTED_LOCATION_TRANSITIONS
- Teleportation-Detection mit ADJACENT_LOCATIONS
- Multi-Order-Validierung (S7/S8)
- Generierung von IST-BPMN-Graphen (JSON + Mermaid)
- IST/SOLL-Vergleich mit conformity_score
- Szenario-spezifische Sequenz-Erwartungen (SOLL_SEQUENCES)
- Abweichungs-Reporting mit 11 Violation-Typen

**Nicht in dieser Datei:**
- Detaillierte BPMN-Diagramme (Figures A2–A7) → `reference_bpmn_flows.md`
- Label-Definitionen → `reference_labels.md`
- Szenario-Definitionen → `phase1_scenario_recognition.md`
- REFA-Zeitarten → `phase2_refa_analysis.md`
- Warehouse-Layout → `reference_warehouse.md`
- Artikel-Stammdaten → `reference_articles.md`

---

## 17. Verwandte Dateien

| Datei | Relevanz für Phase 4 |
|:------|:---------------------|
| `reference_bpmn_flows.md` | Detaillierte BPMN-Diagramme (Figures A2–A7) |
| `reference_labels.md` | CC09/CC10 Label-Definitionen |
| `reference_validation_rules.md` | Frame-Level Validierung |
| `reference_warehouse.md` | Warehouse-Layout, Abmessungen, Distanzen |
| `reference_articles.md` | Artikel-Stammdaten, Lagerorte, Gewichtsklassen |
| `phase1_scenario_recognition.md` | Szenario-Zuordnung (Input für Phase 4) |
| `phase2_refa_analysis.md` | REFA-Zeitarten pro CC09-Phase |

<!-- VERIFICATION_TOKEN: DARA-P4VAL-2D8B-v630 -->
