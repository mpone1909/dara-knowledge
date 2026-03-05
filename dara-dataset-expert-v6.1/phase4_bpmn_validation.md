---
version: 6.1.2
status: finalisiert
created: 2026-02-25
updated: 2026-02-26
references:
  - reference_bpmn_flows.md
  - reference_validation_rules.md
  - reference_labels.md
---

# Phase 4: BPMN-Validierung — IST/SOLL-Vergleich

**Version:** 6.1.1 (2026-02-26)
**Quelle:** BPMN_PROZESSE_DARA.pdf (Figures A2–A7)
**KRITISCHE KORREKTUR:** CC09→CC10 Mapping komplett neu aus Figures A2–A7

---

## 1. Zweck

Validierung von DaRa-Daten gegen idealisierte BPMN-Prozessmodelle:

- **Sequenzvalidierung:** Sind CC09-Übergänge BPMN-konform?
- **CC09→CC10 Mapping:** Sind Low-Level-Prozesse für die aktive Phase korrekt?
- **Tool-Validierung:** Sind Pflicht-Tools bei entsprechenden CC10-Labels aktiv?
- **Location-Validierung:** Entsprechen CC11-Transitions den räumlichen Pfaden?
- **CL134-Priorisierung:** Wird Waiting als Global Interrupt behandelt?

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

| Szenario | CC09 Sequenz | Error-Handling |
|:---------|:-------------|:---------------|
| **S1** | CL114→CL115→CL116→CL118→CL121 | CL135 in Picking (intentional) |
| **S2** | CL114→CL115→CL116→CL121 | Kein Packing, kein CL135 geplant |
| **S3** | CL114→CL115→CL116→CL118→CL121 | CL135 in Picking (intentional) |
| **S4** | CL114→CL117→CL119→CL120→CL121 | Kein CL135 geplant |
| **S5** | CL114→CL117→CL119→CL120→CL121 | CL135 möglich in Storing |
| **S6** | CL114→CL117→CL119→CL120→CL121 | Kein CL135 geplant |
| **S7** | [CL114→CL115→CL116→CL118]×2→CL121 | Perfect Run, kein CL135 |
| **S8** | [CL114→CL117→CL119→CL120]×2→CL121 | Perfect Run, kein CL135 |

---

## 8. CL135 Error-Handling — Picking vs. Storing

**CL135 — Reporting and Clarifying the Incident** wird in unterschiedlichen
Kontexten durch verschiedene Gateway-Bedingungen aktiviert:

### Picking (Figure A3) — Szenarien S1, S3

| Gateway | Bedingung | Fehlertyp |
|:--------|:----------|:----------|
| „Information on the next position complete?" | = NO | Listenfehler (fehlende Info) |
| „Items can be picked?" | = NO | Item fehlt, beschädigt, falsche Menge |

- **Verhindert:** CL139 (Retrieving), CL140 (Moving), CL151 (Placing)
- **Loop-Ziel:** CL137 (Moving to the Next Position)
- **Fehlergrund:** Problem bei der ENTNAHME aus dem Regal

### Storing (Figure A6) — Szenario S5

| Gateway | Bedingung | Fehlertyp |
|:--------|:----------|:----------|
| „Information on the next position complete?" | = NO | Einlagerungs-Listenfehler |
| „Items can be placed?" | = NO | Regalfach besetzt, voll oder beschädigt |

- **Verhindert:** CL138 (Placing Items on Rack)
- **Loop-Ziel:** CL137 oder Storing Travel Time
- **Fehlergrund:** Problem bei der ABLAGE ins Regal

### Nicht in Packing/Unpacking

Figures A4 (Packing) und A5 (Unpacking) haben keine Error-Gateways —
nur Schleifen für mehrere Kartons.

---

## 9. CL134 (Waiting) — Global Interrupt

CL134 wird als Global Interrupt mit höchster Priorität behandelt:

- In Phase 1 (Szenarioerkennung): CL134=1 → "Other_Waiting"
- In Phase 2 (REFA): CL134 → $t_w$ oder $t_s$ (kontextabhängig)
- In Phase 4 (BPMN): CL134 ist in ALLEN CC09-Phasen erlaubt

---

## 10. Abweichungs-Kategorien

| Severity | Typ | Beispiel |
|:---------|:----|:---------|
| CRITICAL | Unmögliche CC09-Transition | CL114→CL120 (Skip Unpacking) |
| CRITICAL | CC10 nicht in erlaubter Liste | CL138 während CL116 (Store in Pick) |
| CRITICAL | Pflicht-Tool fehlt | CL142 ohne Knife |
| WARNING | Unerwartete Location | CL139 nicht im Aisle |
| WARNING | CL135 in Perfect Run (S7/S8) | Ungeplanter Fehler |
| INFO | Längere Wartezeit (CL134) | >30s am Stück |
| INFO | Rückwärts-Transition | CL116→CL115 (normal bei Loop) |

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
    # CC10 → (CC04/CC05 Tool-Label, Beschreibung)
    'CL139': [('CL052/CL087', 'PDT'), ('CL053/CL088', 'Glove Scanner')],  # Retrieving: Scan erforderlich
    'CL142': [('CL061/CL096', 'Knife')],       # Opening Box: Messer obligatorisch
    'CL146': [('CL058/CL093', 'Computer')],     # Printing Label: Computer obligatorisch
    'CL148': [('CL062/CL097', 'Shipping Label')],  # Attaching Label
    'CL150': [('CL060/CL095', 'Tape Dispenser')],  # Sealing Box
    'CL152': [('CL063/CL098', 'Elastic Band')],    # Tying Elastic Band
}
# Mehrere Tools = mindestens eines muss vorhanden sein (OR-Logik)
```

### 11.2 EXPECTED_LOCATIONS — Lookup-Tabelle

```python
EXPECTED_LOCATIONS = {
    # CC10 → Erwartete CC11 Main Area Labels
    'CL124': ['CL155'],  # Collecting Order → Office
    'CL125': ['CL156'],  # Collecting Cart → Cart Area
    'CL126': ['CL157'],  # Collecting Boxes → Cardboard Box Area
    'CL127': ['CL160'],  # Collecting Packed Boxes → Issuing Area
    'CL128': ['CL161', 'CL162', 'CL163'],  # Transport Cart → Path/Aisle
    'CL129': ['CL161', 'CL162'],            # Transport → Path
    'CL130': ['CL160'],  # Handing Over → Issuing Area
    'CL131': ['CL157'],  # Returning Boxes → Cardboard Box Area
    'CL132': ['CL156'],  # Returning Cart → Cart Area
    'CL133': ['CL155'],  # Returning Hardware → Office
    'CL137': ['CL162', 'CL163'],  # Moving Next Position → Cross Aisle/Aisle
    'CL138': ['CL163'],  # Placing on Rack → Aisle
    'CL139': ['CL163'],  # Retrieving Items → Aisle
    'CL140': ['CL163', 'CL162'],  # Moving to Cart → Aisle/Cross Aisle
    'CL141': ['CL159'],  # Placing on Table → Packing Area
    'CL142': ['CL159'],  # Opening Box → Packing Area
    'CL144': ['CL159'],  # Sorting → Packing Area
    'CL145': ['CL159'],  # Filling Box → Packing Area
    'CL146': ['CL159'],  # Printing Label → Packing Area
    'CL148': ['CL159'],  # Attaching Label → Packing Area
    'CL150': ['CL159'],  # Sealing Box → Packing Area
    'CL151': ['CL159', 'CL163'],  # Placing in Cart → Packing/Aisle
}
# Abweichung = WARNING (nicht CRITICAL), da Probanden sich irren können
```

---

## 12. Ergebnis-Ausgabeformat (Pflichtausgabe)

Nach der BPMN-Validierung **MÜSSEN** folgende Ergebnistabellen ausgegeben werden.

### 12.1 BPMN-Konformitäts-Zusammenfassung

```markdown
### BPMN-Konformität — Proband S{XX}, Szenario {SN}

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
| Geplante Fehler | Ja (S1, S3) / Nein (S2, S4, S5, S6, S7, S8) |
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

## 13. Verwandte Dateien

| Datei | Relevanz für Phase 4 |
|:------|:---------------------|
| `reference_bpmn_flows.md` | Detaillierte BPMN-Diagramme (Figures A2–A7) |
| `reference_labels.md` | CC09/CC10 Label-Definitionen |
| `reference_validation_rules.md` | Frame-Level Validierung |
| `reference_warehouse.md` | Warehouse-Layout, Abmessungen, Distanzen |
| `reference_articles.md` | Artikel-Stammdaten, Lagerorte, Gewichtsklassen |
| `phase1_scenario_recognition.md` | Szenario-Zuordnung (Input für Phase 4) |
| `phase2_refa_analysis.md` | REFA-Zeitarten pro CC09-Phase |
