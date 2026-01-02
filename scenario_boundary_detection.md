# DaRa Dataset – Szenario-Erkennung (Label-basierte Klassifikation)

Diese Datei beschreibt die **deterministische Szenarioerkennung** basierend auf **expliziten Label-Zuständen** (aktiv=1, inaktiv=0).

**Kernprinzip:** Jedes Szenario S1-S8 ist durch eine eindeutige Kombination von aktiven und inaktiven Labels in den Kategorien CC06, CC07 und CC08 definiert.

**Quelle:** DaRa Dataset Description + Table 3 Ground Truth  
**Skill-Version:** 2.4 (02.01.2026)

---

## 1. Erkennungsrelevante Kategorien und Labels

### 1.1 CC08 – High-Level Process (4 Labels)

| Label | Bezeichnung | Funktion |
|-------|-------------|----------|
| **CL110** | Retrieval | Kommissionierung (Warenentnahme) |
| **CL111** | Storage | Einlagerung (Wareneingang) |
| CL112 | Another High-Level Process | Übergangsphase → **KEIN Szenario** |
| CL113 | High-Level Process Unknown | Unbekannt → **KEIN Szenario** |

**Regel:** Nur CL110=1 oder CL111=1 sind Szenarien. CL112=1 oder CL113=1 → SKIP.

### 1.2 CC07 – Information Technology (5 Labels)

| Label | Bezeichnung | Exklusiv für |
|-------|-------------|--------------|
| **CL105** | List and Pen | S1, S4, S5, S6, S7, S8 |
| **CL106** | List and Glove Scanner | **S3 (100% eindeutig)** |
| **CL107** | Portable Data Terminal (PDT) | **S2 (100% eindeutig)** |
| CL108 | No Information Technology | Transition |
| CL109 | Information Technology Unknown | Transition |

**Regel:** CL107=1 → **immer S2**. CL106=1 → **immer S3**. Keine Ausnahmen.

### 1.3 CC06 – Customer Order (5 Labels)

| Label | Bezeichnung | Order-Nummer |
|-------|-------------|--------------|
| **CL100** | Order 2904 | Erste Order |
| **CL101** | Order 2905 | Zweite Order |
| **CL102** | Order 2906 | Dritte Order |
| CL103 | No Order | Keine aktive Order |
| CL104 | Order Unknown | Unbekannt |

**Regel:** Bei Multi-Order können CL100 UND CL101 gleichzeitig =1 sein!

---

## 2. Vollständige Label-Zustandsmatrix

### 2.1 Szenario-Definitionen mit expliziten Label-Zuständen

Die folgende Matrix zeigt für jedes Szenario, welche Labels **aktiv (=1)** und welche **inaktiv (=0)** sein müssen:

```
╔══════════╦════════════════════════════╦════════════════════════════╦═══════════════════════════════════╗
║          ║        CC08 (High-Level)   ║        CC07 (IT)           ║           CC06 (Order)            ║
║ Szenario ╠══════╦══════╦══════╦══════╬══════╦══════╦══════╦══════╬══════╦══════╦══════╦══════╦══════╣
║          ║CL110 ║CL111 ║CL112 ║CL113 ║CL105 ║CL106 ║CL107 ║CL108 ║CL100 ║CL101 ║CL102 ║CL103 ║CL104 ║
╠══════════╬══════╬══════╬══════╬══════╬══════╬══════╬══════╬══════╬══════╬══════╬══════╬══════╬══════╣
║    S1    ║  1   ║  0   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║  0   ║
║    S2    ║  1   ║  0   ║  0   ║  0   ║  0   ║  0   ║  1   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║
║    S3    ║  1   ║  0   ║  0   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║  0   ║  1   ║  0   ║  0   ║
║    S4    ║  0   ║  1   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║  0   ║
║    S5    ║  0   ║  1   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║
║    S6    ║  0   ║  1   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║  0   ║  0   ║  1   ║  0   ║  0   ║
║    S7    ║  1   ║  0   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║  1   ║  1   ║  0   ║  0   ║  0   ║
║    S8    ║  0   ║  1   ║  0   ║  0   ║  1   ║  0   ║  0   ║  0   ║  1   ║  1   ║  0   ║  0   ║  0   ║
╚══════════╩══════╩══════╩══════╩══════╩══════╩══════╩══════╩══════╩══════╩══════╩══════╩══════╩══════╝
```

### 2.2 Kompakte Darstellung (nur relevante Labels)

| Szenario | CL110 | CL111 | CL105 | CL106 | CL107 | CL100 | CL101 | CL102 |
|:--------:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| **S1** | **1** | 0 | **1** | 0 | 0 | **1** | 0 | 0 |
| **S2** | **1** | 0 | 0 | 0 | **1** | 0 | **1** | 0 |
| **S3** | **1** | 0 | 0 | **1** | 0 | 0 | 0 | **1** |
| **S4** | 0 | **1** | **1** | 0 | 0 | **1** | 0 | 0 |
| **S5** | 0 | **1** | **1** | 0 | 0 | 0 | **1** | 0 |
| **S6** | 0 | **1** | **1** | 0 | 0 | 0 | 0 | **1** |
| **S7** | **1** | 0 | **1** | 0 | 0 | **1** | **1** | 0 |
| **S8** | 0 | **1** | **1** | 0 | 0 | **1** | **1** | 0 |

**Legende:**
- **1** = Label MUSS aktiv sein (fett markiert)
- 0 = Label MUSS inaktiv sein

---

## 3. Eindeutige Erkennungsmerkmale

### 3.1 IT-basierte Eindeutigkeit (höchste Priorität)

| Bedingung | Ergebnis | Konfidenz |
|-----------|----------|-----------|
| `CL107 = 1` | **S2** | 100% |
| `CL106 = 1` | **S3** | 100% |

**Diese Regeln haben IMMER Vorrang!**

### 3.2 Multi-Order-Eindeutigkeit

| Bedingung | Ergebnis | Konfidenz |
|-----------|----------|-----------|
| `CL100 = 1 AND CL101 = 1 AND CL110 = 1` | **S7** | 100% |
| `CL100 = 1 AND CL101 = 1 AND CL111 = 1` | **S8** | 100% |

**Wichtig:** Multi-Order = genau 2 Orders (2904 + 2905), CL102 ist NICHT beteiligt!

### 3.3 Single-Order Retrieval

| Bedingung | Ergebnis | Konfidenz |
|-----------|----------|-----------|
| `CL110 = 1 AND CL105 = 1 AND CL100 = 1 AND CL101 = 0 AND CL102 = 0` | **S1** | 100% |

### 3.4 Single-Order Storage

| Bedingung | Ergebnis | Konfidenz |
|-----------|----------|-----------|
| `CL111 = 1 AND CL105 = 1 AND CL100 = 1 AND CL101 = 0 AND CL102 = 0` | **S4** | 100% |
| `CL111 = 1 AND CL105 = 1 AND CL100 = 0 AND CL101 = 1 AND CL102 = 0` | **S5** | 100% |
| `CL111 = 1 AND CL105 = 1 AND CL100 = 0 AND CL101 = 0 AND CL102 = 1` | **S6** | 100% |

---

## 4. Erkennungsalgorithmus (Pseudocode)

### 4.1 Deterministische Klassifikation

```python
def classify_scenario(labels: dict) -> str:
    """
    Klassifiziert einen Frame/Block in Szenario S1-S8.
    
    Args:
        labels: dict mit Label-Zuständen
            {
                'CL110': 0|1, 'CL111': 0|1, 'CL112': 0|1, 'CL113': 0|1,
                'CL105': 0|1, 'CL106': 0|1, 'CL107': 0|1,
                'CL100': 0|1, 'CL101': 0|1, 'CL102': 0|1
            }
    
    Returns:
        str: 'S1' bis 'S8' oder 'SKIP' oder 'UNKNOWN'
    """
    
    # === FILTER: Übergangsphasen ===
    if labels['CL112'] == 1 or labels['CL113'] == 1:
        return 'SKIP'  # Kein Szenario
    
    # === REGEL 1: IT-System (höchste Priorität) ===
    if labels['CL107'] == 1:  # PDT
        return 'S2'
    
    if labels['CL106'] == 1:  # Scanner
        return 'S3'
    
    # === REGEL 2: Multi-Order (2 Orders aktiv) ===
    if labels['CL100'] == 1 and labels['CL101'] == 1 and labels['CL102'] == 0:
        if labels['CL110'] == 1 and labels['CL111'] == 0:
            return 'S7'  # Multi-Order Retrieval
        if labels['CL111'] == 1 and labels['CL110'] == 0:
            return 'S8'  # Multi-Order Storage
    
    # === REGEL 3: Single-Order Retrieval ===
    if labels['CL110'] == 1 and labels['CL111'] == 0 and labels['CL105'] == 1:
        if labels['CL100'] == 1 and labels['CL101'] == 0 and labels['CL102'] == 0:
            return 'S1'
    
    # === REGEL 4: Single-Order Storage ===
    if labels['CL111'] == 1 and labels['CL110'] == 0 and labels['CL105'] == 1:
        if labels['CL100'] == 1 and labels['CL101'] == 0 and labels['CL102'] == 0:
            return 'S4'
        if labels['CL100'] == 0 and labels['CL101'] == 1 and labels['CL102'] == 0:
            return 'S5'
        if labels['CL100'] == 0 and labels['CL101'] == 0 and labels['CL102'] == 1:
            return 'S6'
    
    return 'UNKNOWN'  # Unerwartete Kombination
```

### 4.2 Block-basierte Klassifikation (Dominanz)

Bei der Analyse ganzer Blöcke wird die **dominante** Label-Kombination verwendet:

```python
def classify_block(block_frames: pd.DataFrame) -> dict:
    """
    Klassifiziert einen Block basierend auf dominanten Labels.
    
    Returns:
        dict: {
            'scenario': str,
            'confidence': float,
            'dominant_labels': dict
        }
    """
    # Relevante Spalten
    cc08_cols = ['CL110|Retrieval', 'CL111|Storage', 'CL112|Another High-Level Process', 'CL113|High-Level Process Unknown']
    cc07_cols = ['CL105|List and Pen', 'CL106|List and Glove Scanner', 'CL107|Portable Data Terminal']
    cc06_cols = ['CL100|2904', 'CL101|2905', 'CL102|2906']
    
    total_frames = len(block_frames)
    
    # Dominante Labels bestimmen (>50% der Frames)
    dominant = {}
    
    # CC08: High-Level
    for col in cc08_cols:
        label = col.split('|')[0]
        count = block_frames[col].sum()
        if count > total_frames * 0.5:
            dominant[label] = 1
        else:
            dominant[label] = 0
    
    # CC07: IT
    for col in cc07_cols:
        label = col.split('|')[0]
        count = block_frames[col].sum()
        if count > total_frames * 0.5:
            dominant[label] = 1
        else:
            dominant[label] = 0
    
    # CC06: Orders (Set-basiert für Multi-Order)
    for col in cc06_cols:
        label = col.split('|')[0]
        count = block_frames[col].sum()
        # Bei Orders: >0 bedeutet "im Block vorhanden"
        if count > 0:
            dominant[label] = 1
        else:
            dominant[label] = 0
    
    # Klassifizieren
    scenario = classify_scenario(dominant)
    
    # Konfidenz berechnen
    confidence = calculate_confidence(block_frames, scenario)
    
    return {
        'scenario': scenario,
        'confidence': confidence,
        'dominant_labels': dominant,
        'total_frames': total_frames
    }
```

---

## 5. Entscheidungsbaum (Visuell)

```
Frame/Block analysieren:
│
├─ CL112=1 oder CL113=1?
│   └─ JA → SKIP (Übergangsphase)
│
├─ CL107=1? (PDT)
│   └─ JA → S2 ✓
│
├─ CL106=1? (Scanner)
│   └─ JA → S3 ✓
│
├─ CL100=1 UND CL101=1 UND CL102=0? (Multi-Order)
│   ├─ CL110=1 → S7 ✓
│   └─ CL111=1 → S8 ✓
│
├─ CL110=1 UND CL105=1? (Single-Order Retrieval)
│   └─ CL100=1, CL101=0, CL102=0 → S1 ✓
│
└─ CL111=1 UND CL105=1? (Single-Order Storage)
    ├─ CL100=1, CL101=0, CL102=0 → S4 ✓
    ├─ CL100=0, CL101=1, CL102=0 → S5 ✓
    └─ CL100=0, CL101=0, CL102=1 → S6 ✓
```

---

## 6. Szenario-Steckbriefe

### 6.1 S1 – Single-Order Retrieval mit List+Pen

**Label-Signatur:**
| Label | Zustand | Beschreibung |
|-------|---------|--------------|
| CL110 | **1** | Retrieval aktiv |
| CL111 | 0 | Storage inaktiv |
| CL105 | **1** | List+Pen aktiv |
| CL106 | 0 | Scanner inaktiv |
| CL107 | 0 | PDT inaktiv |
| CL100 | **1** | Order 2904 aktiv |
| CL101 | 0 | Order 2905 inaktiv |
| CL102 | 0 | Order 2906 inaktiv |

**Erkennungsformel:**
```
S1 = (CL110=1) ∧ (CL105=1) ∧ (CL100=1) ∧ (CL101=0) ∧ (CL102=0)
```

**Besonderheit:** Enthält intentionale Fehler (CL135 kann auftreten)

---

### 6.2 S2 – Single-Order Retrieval mit PDT

**Label-Signatur:**
| Label | Zustand | Beschreibung |
|-------|---------|--------------|
| CL110 | **1** | Retrieval aktiv |
| CL111 | 0 | Storage inaktiv |
| CL105 | 0 | List+Pen inaktiv |
| CL106 | 0 | Scanner inaktiv |
| CL107 | **1** | **PDT aktiv (EINDEUTIG!)** |
| CL100 | 0 | Order 2904 inaktiv |
| CL101 | **1** | Order 2905 aktiv |
| CL102 | 0 | Order 2906 inaktiv |

**Erkennungsformel:**
```
S2 = (CL107=1)  ← NUR diese Bedingung nötig!
```

**Besonderheit:** 100% eindeutig durch CL107. Kein anderes Szenario nutzt PDT.

---

### 6.3 S3 – Single-Order Retrieval mit Scanner

**Label-Signatur:**
| Label | Zustand | Beschreibung |
|-------|---------|--------------|
| CL110 | **1** | Retrieval aktiv |
| CL111 | 0 | Storage inaktiv |
| CL105 | 0 | List+Pen inaktiv |
| CL106 | **1** | **Scanner aktiv (EINDEUTIG!)** |
| CL107 | 0 | PDT inaktiv |
| CL100 | 0 | Order 2904 inaktiv |
| CL101 | 0 | Order 2905 inaktiv |
| CL102 | **1** | Order 2906 aktiv |

**Erkennungsformel:**
```
S3 = (CL106=1)  ← NUR diese Bedingung nötig!
```

**Besonderheit:** 100% eindeutig durch CL106. Enthält intentionale Fehler.

---

### 6.4 S4 – Single-Order Storage (Order 2904)

**Label-Signatur:**
| Label | Zustand | Beschreibung |
|-------|---------|--------------|
| CL110 | 0 | Retrieval inaktiv |
| CL111 | **1** | Storage aktiv |
| CL105 | **1** | List+Pen aktiv |
| CL106 | 0 | Scanner inaktiv |
| CL107 | 0 | PDT inaktiv |
| CL100 | **1** | Order 2904 aktiv |
| CL101 | 0 | Order 2905 inaktiv |
| CL102 | 0 | Order 2906 inaktiv |

**Erkennungsformel:**
```
S4 = (CL111=1) ∧ (CL105=1) ∧ (CL100=1) ∧ (CL101=0) ∧ (CL102=0)
```

---

### 6.5 S5 – Single-Order Storage (Order 2905)

**Label-Signatur:**
| Label | Zustand | Beschreibung |
|-------|---------|--------------|
| CL110 | 0 | Retrieval inaktiv |
| CL111 | **1** | Storage aktiv |
| CL105 | **1** | List+Pen aktiv |
| CL106 | 0 | Scanner inaktiv |
| CL107 | 0 | PDT inaktiv |
| CL100 | 0 | Order 2904 inaktiv |
| CL101 | **1** | Order 2905 aktiv |
| CL102 | 0 | Order 2906 inaktiv |

**Erkennungsformel:**
```
S5 = (CL111=1) ∧ (CL105=1) ∧ (CL100=0) ∧ (CL101=1) ∧ (CL102=0)
```

---

### 6.6 S6 – Single-Order Storage (Order 2906)

**Label-Signatur:**
| Label | Zustand | Beschreibung |
|-------|---------|--------------|
| CL110 | 0 | Retrieval inaktiv |
| CL111 | **1** | Storage aktiv |
| CL105 | **1** | List+Pen aktiv |
| CL106 | 0 | Scanner inaktiv |
| CL107 | 0 | PDT inaktiv |
| CL100 | 0 | Order 2904 inaktiv |
| CL101 | 0 | Order 2905 inaktiv |
| CL102 | **1** | Order 2906 aktiv |

**Erkennungsformel:**
```
S6 = (CL111=1) ∧ (CL105=1) ∧ (CL100=0) ∧ (CL101=0) ∧ (CL102=1)
```

---

### 6.7 S7 – Multi-Order Retrieval

**Label-Signatur:**
| Label | Zustand | Beschreibung |
|-------|---------|--------------|
| CL110 | **1** | Retrieval aktiv |
| CL111 | 0 | Storage inaktiv |
| CL105 | **1** | List+Pen aktiv |
| CL106 | 0 | Scanner inaktiv |
| CL107 | 0 | PDT inaktiv |
| CL100 | **1** | Order 2904 aktiv |
| CL101 | **1** | Order 2905 aktiv |
| CL102 | 0 | Order 2906 **inaktiv** |

**Erkennungsformel:**
```
S7 = (CL110=1) ∧ (CL105=1) ∧ (CL100=1) ∧ (CL101=1) ∧ (CL102=0)
```

**Besonderheit:** Beide Orders 2904+2905 gleichzeitig aktiv. Order 2906 ist NICHT Teil von Multi-Order!

---

### 6.8 S8 – Multi-Order Storage

**Label-Signatur:**
| Label | Zustand | Beschreibung |
|-------|---------|--------------|
| CL110 | 0 | Retrieval inaktiv |
| CL111 | **1** | Storage aktiv |
| CL105 | **1** | List+Pen aktiv |
| CL106 | 0 | Scanner inaktiv |
| CL107 | 0 | PDT inaktiv |
| CL100 | **1** | Order 2904 aktiv |
| CL101 | **1** | Order 2905 aktiv |
| CL102 | 0 | Order 2906 **inaktiv** |

**Erkennungsformel:**
```
S8 = (CL111=1) ∧ (CL105=1) ∧ (CL100=1) ∧ (CL101=1) ∧ (CL102=0)
```

**Besonderheit:** Identische Order-Kombination wie S7, aber Storage statt Retrieval.

---

## 7. Validierungsregeln

### 7.1 Exklusivitätsregeln

| Regel | Bedingung | Bedeutung |
|-------|-----------|-----------|
| **V-EX1** | CL110 + CL111 ≤ 1 | High-Level ist exklusiv |
| **V-EX2** | CL105 + CL106 + CL107 ≤ 1 | IT-System ist exklusiv |
| **V-EX3** | CL107=1 → Szenario=S2 | PDT-Exklusivität |
| **V-EX4** | CL106=1 → Szenario=S3 | Scanner-Exklusivität |

### 7.2 Multi-Order-Regeln

| Regel | Bedingung | Bedeutung |
|-------|-----------|-----------|
| **V-MO1** | Multi-Order → CL100=1 ∧ CL101=1 | Beide Orders aktiv |
| **V-MO2** | Multi-Order → CL102=0 | Order 2906 NICHT aktiv |
| **V-MO3** | CL100=1 ∧ CL101=1 → S7 ∨ S8 | Nur S7/S8 sind Multi-Order |

### 7.3 Single-Order-Regeln

| Regel | Bedingung | Bedeutung |
|-------|-----------|-----------|
| **V-SO1** | Single-Order → genau 1 Order aktiv | Nur eine von CL100/CL101/CL102 |
| **V-SO2** | S1-S6 → CL100+CL101+CL102 = 1 | Summe muss 1 sein |

---

## 8. Python-Implementierung (Vollständig)

```python
import pandas as pd
from typing import Dict, Tuple, List

# Label-Mappings
CC08_LABELS = {
    'CL110': 'CL110|Retrieval',
    'CL111': 'CL111|Storage',
    'CL112': 'CL112|Another High-Level Process',
    'CL113': 'CL113|High-Level Process Unknown'
}

CC07_LABELS = {
    'CL105': 'CL105|List and Pen',
    'CL106': 'CL106|List and Glove Scanner',
    'CL107': 'CL107|Portable Data Terminal',
    'CL108': 'CL108|No Information Technology',
    'CL109': 'CL109|Information Technology Unknown'
}

CC06_LABELS = {
    'CL100': 'CL100|2904',
    'CL101': 'CL101|2905',
    'CL102': 'CL102|2906',
    'CL103': 'CL103|No Order',
    'CL104': 'CL104|Order Unknown'
}

# Ground Truth Matrix
SCENARIO_SIGNATURES = {
    'S1': {'CL110': 1, 'CL111': 0, 'CL105': 1, 'CL106': 0, 'CL107': 0, 'CL100': 1, 'CL101': 0, 'CL102': 0},
    'S2': {'CL110': 1, 'CL111': 0, 'CL105': 0, 'CL106': 0, 'CL107': 1, 'CL100': 0, 'CL101': 1, 'CL102': 0},
    'S3': {'CL110': 1, 'CL111': 0, 'CL105': 0, 'CL106': 1, 'CL107': 0, 'CL100': 0, 'CL101': 0, 'CL102': 1},
    'S4': {'CL110': 0, 'CL111': 1, 'CL105': 1, 'CL106': 0, 'CL107': 0, 'CL100': 1, 'CL101': 0, 'CL102': 0},
    'S5': {'CL110': 0, 'CL111': 1, 'CL105': 1, 'CL106': 0, 'CL107': 0, 'CL100': 0, 'CL101': 1, 'CL102': 0},
    'S6': {'CL110': 0, 'CL111': 1, 'CL105': 1, 'CL106': 0, 'CL107': 0, 'CL100': 0, 'CL101': 0, 'CL102': 1},
    'S7': {'CL110': 1, 'CL111': 0, 'CL105': 1, 'CL106': 0, 'CL107': 0, 'CL100': 1, 'CL101': 1, 'CL102': 0},
    'S8': {'CL110': 0, 'CL111': 1, 'CL105': 1, 'CL106': 0, 'CL107': 0, 'CL100': 1, 'CL101': 1, 'CL102': 0},
}


def classify_frame(labels: Dict[str, int]) -> str:
    """
    Klassifiziert einen einzelnen Frame.
    
    Args:
        labels: Dict mit Label-Zuständen (0 oder 1)
    
    Returns:
        Szenario-ID ('S1'-'S8', 'SKIP', oder 'UNKNOWN')
    """
    # Filter: Übergangsphasen
    if labels.get('CL112', 0) == 1 or labels.get('CL113', 0) == 1:
        return 'SKIP'
    
    # Regel 1: IT-Eindeutigkeit
    if labels.get('CL107', 0) == 1:
        return 'S2'
    if labels.get('CL106', 0) == 1:
        return 'S3'
    
    # Regel 2: Multi-Order
    if labels.get('CL100', 0) == 1 and labels.get('CL101', 0) == 1 and labels.get('CL102', 0) == 0:
        if labels.get('CL110', 0) == 1:
            return 'S7'
        if labels.get('CL111', 0) == 1:
            return 'S8'
    
    # Regel 3: Single-Order Retrieval
    if labels.get('CL110', 0) == 1 and labels.get('CL105', 0) == 1:
        if labels.get('CL100', 0) == 1 and labels.get('CL101', 0) == 0 and labels.get('CL102', 0) == 0:
            return 'S1'
    
    # Regel 4: Single-Order Storage
    if labels.get('CL111', 0) == 1 and labels.get('CL105', 0) == 1:
        if labels.get('CL100', 0) == 1 and labels.get('CL101', 0) == 0 and labels.get('CL102', 0) == 0:
            return 'S4'
        if labels.get('CL100', 0) == 0 and labels.get('CL101', 0) == 1 and labels.get('CL102', 0) == 0:
            return 'S5'
        if labels.get('CL100', 0) == 0 and labels.get('CL101', 0) == 0 and labels.get('CL102', 0) == 1:
            return 'S6'
    
    return 'UNKNOWN'


def extract_labels_from_row(row: pd.Series) -> Dict[str, int]:
    """
    Extrahiert Label-Zustände aus einer DataFrame-Zeile.
    """
    labels = {}
    
    # CC08
    for label, col in CC08_LABELS.items():
        if col in row.index:
            labels[label] = int(row[col])
    
    # CC07
    for label, col in CC07_LABELS.items():
        if col in row.index:
            labels[label] = int(row[col])
    
    # CC06
    for label, col in CC06_LABELS.items():
        if col in row.index:
            labels[label] = int(row[col])
    
    return labels


def classify_block_by_dominance(
    cc06_df: pd.DataFrame,
    cc07_df: pd.DataFrame,
    cc08_df: pd.DataFrame,
    start_frame: int,
    end_frame: int
) -> Dict:
    """
    Klassifiziert einen Block basierend auf dominanten Labels.
    
    Returns:
        Dict mit Szenario, Konfidenz und Details
    """
    # Slices erstellen
    cc06_slice = cc06_df.iloc[start_frame:end_frame+1]
    cc07_slice = cc07_df.iloc[start_frame:end_frame+1]
    cc08_slice = cc08_df.iloc[start_frame:end_frame+1]
    
    total_frames = end_frame - start_frame + 1
    
    # Dominante Labels bestimmen
    dominant = {}
    
    # CC08 (>50% Dominanz)
    for label, col in CC08_LABELS.items():
        if col in cc08_slice.columns:
            count = cc08_slice[col].sum()
            dominant[label] = 1 if count > total_frames * 0.5 else 0
    
    # CC07 (>50% Dominanz)
    for label, col in CC07_LABELS.items():
        if col in cc07_slice.columns:
            count = cc07_slice[col].sum()
            dominant[label] = 1 if count > total_frames * 0.5 else 0
    
    # CC06 (Präsenz-basiert: >0 = vorhanden)
    for label, col in CC06_LABELS.items():
        if col in cc06_slice.columns:
            count = cc06_slice[col].sum()
            dominant[label] = 1 if count > 0 else 0
    
    # Klassifizieren
    scenario = classify_frame(dominant)
    
    return {
        'scenario': scenario,
        'start_frame': start_frame,
        'end_frame': end_frame,
        'total_frames': total_frames,
        'duration_sec': total_frames / 30.0,
        'dominant_labels': dominant
    }


def validate_scenario(scenario: str, labels: Dict[str, int]) -> Tuple[bool, List[str]]:
    """
    Validiert ein erkanntes Szenario gegen die Ground Truth.
    
    Returns:
        Tuple: (is_valid, list_of_violations)
    """
    if scenario in ['SKIP', 'UNKNOWN']:
        return True, []
    
    violations = []
    expected = SCENARIO_SIGNATURES.get(scenario, {})
    
    for label, expected_value in expected.items():
        actual_value = labels.get(label, 0)
        if actual_value != expected_value:
            violations.append(f"{label}: erwartet {expected_value}, gefunden {actual_value}")
    
    return len(violations) == 0, violations
```

---

## 9. Verwendungshinweise

**Diese Datei nutzen für:**
- Deterministische Szenario-Klassifikation
- Validierung von Erkennungsergebnissen
- Debugging von Fehlklassifikationen

**Verwandte Dateien:**
- `ground_truth_matrix.md` → Referenz-Tabelle
- `picking_strategies.md` → Single vs. Multi-Order Details
- `validation_logic_extended.md` → Erweiterte Validierungsregeln

---

## Metadaten

**Datei-Version:** 2.4  
**Erstellt:** 30.12.2025  
**Update:** 02.01.2026  
**Änderungen v2.4:**
- Vollständige Label-Zustandsmatrix (aktiv/inaktiv) hinzugefügt
- Szenario-Steckbriefe mit expliziten Label-Signaturen
- Erkennungsformeln in Boole'scher Notation
- Deterministische Klassifikationsfunktion
- Validierungsregeln präzisiert

**Anwendbar auf:** Alle 18 Subjekte (S01-S18)
