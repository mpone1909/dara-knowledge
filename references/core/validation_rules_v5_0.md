---
version: 5.0
status: finalisiert
created: 2026-02-05
source: "frame_validation_rules.md v4.5.1 (27.01.2026) + DaRa-Dokumentation (NotebookLM-validiert)"
dependencies: ["core_labels_207_v5_0.md", "core_category_activation_matrix_v5_0.md", "core_ground_truth_central_v5_0.md"]
---

# core_validation_rules_v5_0.md â€” Frame-Level Validierungsregeln

**Zentrale Sammlung aller Frame-Level Validierungsregeln fÃ¼r den DaRa-Datensatz**

**Skill-Version:** 5.0 (05.02.2026)  
**Fokus:** Frame-Level Validierung (Label-Kombinationen, Master-Slave-AbhÃ¤ngigkeiten, Fehlerbehandlung)  
**Szenario-Level Validierung:** Siehe `core_ground_truth_central_v5_0.md` (5-Schritt-Logik)

---

## ðŸ“š INHALTSVERZEICHNIS

1. [Master-Slave-AbhÃ¤ngigkeiten](#1-master-slave-abhÃ¤ngigkeiten)
2. [Label-Kombinationsregeln](#2-label-kombinationsregeln)
3. [Spezielle Validierungen](#3-spezielle-validierungen)
4. [Anwendungshinweise](#4-anwendungshinweise)
5. [Ã„nderungshistorie](#5-Ã¤nderungshistorie)
6. [BPMN-Prozess-Mappings (Anhang)](#anhang-bpmn-prozess-mappings)

---

## 1. MASTER-SLAVE-ABHÃ„NGIGKEITEN

Master-Slave-AbhÃ¤ngigkeiten definieren, dass eine Ã¼bergeordnete Kategorie die AuswahlmÃ¶glichkeiten fÃ¼r nachgelagerte Kategorien einschrÃ¤nkt oder erzwingt.

### 1.1 CC01 (Main Activity) â†’ Master fÃ¼r CC02â€“CC05

**CC01 bestimmt den globalen Zustand des Probanden und seine Bewegungskomponenten.**

**Regel V-B1: Hierarchische Master-Slave-AbhÃ¤ngigkeit**

```python
# CC01 ist Master; CC02-CC05 sind Slaves
# Die Sub-AktivitÃ¤ten (CC02-CC05) mÃ¼ssen semantisch zu CC01 passen

# Beispiel: Wenn CC01 = Walking (CL011)
if CC01 == 'CL011':  # Walking
    # Dann MUSS CC02 = Gait Cycle (CL016) sein
    assert CC02 == 'CL016'  # Walking erfordert Beinbewegung
    
    # Walking ist NICHT kompatibel mit:
    # - CC02 = Standing Still (CL018) âŒ
    # - CC02 = Squat (CL017) âŒ

# Beispiel: Wenn CC01 = Standing Still (CL001)
if CC01 == 'CL001':
    # Dann MUSS CC02 = Standing Still (CL016) sein
    assert CC02 == 'CL016'
```

**CC01 PrioritÃ¤ts-Hierarchie bei Konflikten:**

Bei theoretischen Mehrdeutigkeiten oder simultanen AktivitÃ¤ten gilt folgende explizite PrioritÃ¤tsordnung (hÃ¶chste â†’ niedrigste):

```python
CC01_PRIORITY_HIERARCHY = [
    ('CL001', 'Synchronization', 1),           # HÃ¶chste PrioritÃ¤t
    ('CL002', 'Confirming with Pen', 2),
    ('CL003', 'Confirming with Screen', 3),
    ('CL004', 'Confirming with Button', 4),
    ('CL005', 'Scanning', 5),
    ('CL006', 'Pulling Cart', 6),
    ('CL007', 'Pushing Cart', 7),
    ('CL008', 'Handling Upwards', 8),
    ('CL009', 'Handling Centered', 9),
    ('CL010', 'Handling Downwards', 10),
    ('CL011', 'Walking', 11),
    ('CL012', 'Standing', 12),
    ('CL013', 'Sitting', 13),
    ('CL014', 'Another Main Activity', 14),
    ('CL015', 'Main Activity Unknown', 15),   # Niedrigste PrioritÃ¤t
]

def resolve_cc01_conflict(active_labels_cc01):
    """
    Wenn mehrere CC01-Labels gleichzeitig aktiv wÃ¤ren (sollte nicht vorkommen),
    wÃ¤hle das Label mit der hÃ¶chsten PrioritÃ¤t.
    """
    for label, name, priority in CC01_PRIORITY_HIERARCHY:
        if label in active_labels_cc01:
            return label  # Gibt das erste (hÃ¶chste PrioritÃ¤t) zurÃ¼ck
```

**Praktische Beispiele:**

| Situation | CC01 priorisiert | BegrÃ¼ndung |
|-----------|------------------|-----------|
| Gehen + Wagen schieben | CL007 (Pushing Cart) | Pushing hat hÃ¶here PrioritÃ¤t als Walking |
| Gehen + Scannen | CL005 (Scanning) | Scanning hat hÃ¶here PrioritÃ¤t als Walking |
| Stehen + BestÃ¤tigung am PDT | CL003 (Confirming) | Confirming hat hÃ¶here PrioritÃ¤t als Standing |
| Greifen wÃ¤hrend Gehen | CL008/CL009/CL010 (Handling) | Handling hat hÃ¶here PrioritÃ¤t als Walking |

**Technische Umsetzung:**

Die DaRa-Annotationstool (SARA) implementiert diese AbhÃ¤ngigkeiten als **Dependencies**:
- Bestimmte Labels in CC01 erzwingen oder verbieten bestimmte Labels in CC02â€“CC05
- Beispiel: Walking (CL011) in CC01 erzwingt Gait Cycle (CL016) in CC02 und schlieÃŸt Standing Still (CL018) aus
- QualitÃ¤tssicherung: Annotatoren von CC02â€“CC05 fungieren gleichzeitig als Revisoren fÃ¼r CC01

---

### 1.2 CC08 (High-Level Process) â†’ Master fÃ¼r CC09 (Mid-Level Process)

**CC08 definiert den Grobprozess (Retrieval vs. Storage) und bestimmt, welche Mid-Level-Prozesse (CC09) erlaubt sind.**

**Regel V-B2: Prozess-Hierarchie High-Level â†’ Mid-Level**

```python
def validate_cc09_from_cc08(cc08_active, cc09_active):
    """
    CC08 bestimmt die erlaubten CC09-Labels
    """
    
    # Retrieval-Prozess (Kommissionierung)
    RETRIEVAL_CC09 = ['CL114', 'CL115', 'CL116', 'CL118', 'CL121']
    
    # Storage-Prozess (Einlagerung)
    STORAGE_CC09 = ['CL114', 'CL117', 'CL119', 'CL120', 'CL121']
    
    if cc08_active == 'CL110':  # Retrieval
        assert cc09_active in RETRIEVAL_CC09, \
            f"Retrieval: CC09={cc09_active} erlaubt, muss in {RETRIEVAL_CC09} sein"
    
    elif cc08_active == 'CL111':  # Storage
        assert cc09_active in STORAGE_CC09, \
            f"Storage: CC09={cc09_active} erlaubt, muss in {STORAGE_CC09} sein"
    
    elif cc08_active == 'CL112':  # Another Process
        # Keine EinschrÃ¤nkung fÃ¼r "Another"
        return True
    
    elif cc08_active == 'CL113':  # Process Unknown
        # Keine EinschrÃ¤nkung fÃ¼r "Unknown"
        return True
```

**Label-Definitionen:**

| CC08 Label | Beschreibung | Erlaubte CC09-Labels |
|------------|-------------|----------------------|
| **CL110** | Retrieval (Kommissionierung) | CL114, CL115, CL116, CL118, CL121 |
| **CL111** | Storage (Einlagerung) | CL114, CL117, CL119, CL120, CL121 |
| **CL112** | Another Process | Beliebig oder CL122/CL123 |
| **CL113** | Process Unknown | CL122, CL123 |

**Gemeinsame Labels (beide Prozesse):**
- **CL114** (Preparing Order): Start im BÃ¼ro, Vorbereitung (beide Prozesse)
- **CL121** (Finalizing Order): Abschluss und Hardware-RÃ¼ckgabe (beide Prozesse)

---

### 1.3 CC09 (Mid-Level Process) â†’ Master fÃ¼r CC10 (Low-Level Process)

**CC09 definiert den Mittelstufen-Prozess (z.B. Picking - Travel Time vs. Picking - Pick Time) und bestimmt, welche Low-Level-Prozesse (CC10) innerhalb dieses Schritts erlaubt sind.**

**Regel V-B3: Prozess-Hierarchie Mid-Level â†’ Low-Level (BPMN-basiert)**

```python
def validate_cc10_from_cc09(cc09_active, cc10_active):
    """
    CC09 (Mid-Level) bestimmt die erlaubten CC10-Labels (Low-Level)
    basierend auf BPMN-Prozessmodellen
    """
    
    # Mapping basierend auf BPMN-Diagrammen (siehe Anhang: BPMN-Mappings)
    CC09_TO_CC10_MAPPING = {
        'CL114': ['CL135', 'CL134'],  # Preparing: Reporting, Waiting
        'CL115': ['CL137', 'CL128', 'CL135', 'CL134'],  # Picking Travel
        'CL116': ['CL139', 'CL151', 'CL134'],  # Picking Pick
        'CL117': ['CL135', 'CL134'],  # Unpacking: Reporting, Waiting
        'CL118': ['CL144', 'CL145', 'CL150', 'CL134'],  # Packing
        'CL119': ['CL137', 'CL128', 'CL135', 'CL134'],  # Storing Travel
        'CL120': ['CL154', 'CL134'],  # Storing Store
        'CL121': ['CL135', 'CL134'],  # Finalizing: Reporting, Waiting
        'CL122': ['CL134'],  # Other Process: nur Waiting
        'CL123': ['CL134'],  # Process Unknown: nur Waiting
    }
    
    if cc09_active in CC09_TO_CC10_MAPPING:
        allowed_cc10 = CC09_TO_CC10_MAPPING[cc09_active]
        assert cc10_active in allowed_cc10, \
            f"CC09={cc09_active}: CC10={cc10_active} nicht erlaubt. Erlaubt: {allowed_cc10}"
    else:
        return True  # Unbekanntes CC09, keine Validierung
```

**BPMN-Mapping Ãœbersicht:**

Siehe **Anhang: BPMN-Prozess-Mappings** fÃ¼r detaillierte Tabellen mit:
- Jeder CC09-Phase und ihren erlaubten CC10-Labels
- Bedingungen und ÃœbergÃ¤nge
- Fehlbehandlung (CL135-Reporting)

**Wichtig:** CL135 (Reporting and Clarifying the Incident) ist ein **aktiver Low-Level-Prozessschritt**, der in Travel-Phasen (CL115, CL119) auftreten kann, wenn Fehler geklÃ¤rt werden mÃ¼ssen. Dies ist **nicht** eine Fehlerklassifikation, sondern ein normaler Prozessprozessschritt.

---

## 2. LABEL-KOMBINATIONSREGELN

### 2.1 Single-Label-Prinzip

**Diese Kategorien dÃ¼rfen pro Frame nur GENAU EIN aktives Label haben:**

```python
SINGLE_LABEL_CATEGORIES = ['CC01', 'CC02', 'CC07', 'CC08', 'CC09', 'CC10']

for category in SINGLE_LABEL_CATEGORIES:
    active_labels = get_active_labels(frame, category)
    assert len(active_labels) == 1, \
        f"Single-Label-Violation in {category}: {len(active_labels)} Labels aktiv"
```

**Multi-Label erlaubt (mit spezifischen Regeln):**
- **CC03 (Torso)** â€“ Max 2 Labels: 1 Beugung + optional Rotation (CL027)
- **CC04 (Left Hand)** â€“ Exakt 4 Labels: Position + Movement + Object + Tool (Pflicht)
- **CC05 (Right Hand)** â€“ Exakt 4 Labels: Position + Movement + Object + Tool (Pflicht)
- **CC06 (Order)** â€“ 1-2 Labels: Single-Order normal, Multi-Order nur S7/S8
- **CC11 (Location Human)** â€“ Max 3 Labels: hierarchische Struktur
- **CC12 (Location Cart)** â€“ Max 4 Labels: hierarchische Struktur + Transition

---

### 2.2 Multi-Label Kombinationsregeln

#### CC03 (Torso) â€“ Additiv Kombinierbar

**Regel V-B4: Torso-Beugung und Rotation**

```python
def validate_cc03_torso(active_labels_cc03):
    """
    CC03 (Torso) hat Max 2 Labels:
    - Exakt 1 Beugungslabel (CL024-CL026, CL028-CL029)
    - Optional + 1 Rotationslabel (CL027)
    """
    
    BENDING_LABELS = ['CL024', 'CL025', 'CL026', 'CL028', 'CL029']
    ROTATION_LABEL = 'CL027'
    
    # ZÃ¤hle Beugungslabels
    bending_active = [l for l in active_labels_cc03 if l in BENDING_LABELS]
    has_rotation = ROTATION_LABEL in active_labels_cc03
    
    # Regel 1: Exakt 1 Beugunglabel (Pflicht)
    assert len(bending_active) == 1, \
        f"CC03 benÃ¶tigt exakt 1 Beugungslabel, hat {len(bending_active)}"
    
    # Regel 2: Max 1 Rotationslabel (optional)
    if has_rotation:
        assert len(active_labels_cc03) == 2, \
            "Wenn Rotation aktiv, max 2 Labels gesamt"
    else:
        assert len(active_labels_cc03) == 1, \
            "Ohne Rotation, exakt 1 Label (Beugung)"
```

**Erlaubte Kombinationen:**

| Beugung | Rotation | Erlaubt? | Beispiel |
|---------|----------|----------|----------|
| CL024 (No Bending) | â€” | âœ… | Aufrechte Haltung |
| CL024 (No Bending) | CL027 (Rotation) | âœ… | Aufrecht + Drehung |
| CL025 (Slightly Bending) | â€” | âœ… | Leichte Beugung |
| CL025 (Slightly Bending) | CL027 (Rotation) | âœ… | Beugung + Drehung |
| CL025 (Slightly) | CL026 (Strongly) | âŒ | Zwei Beugungslabels gleichzeitig |

---

#### CC04/CC05 (Hands) â€“ Hierarchische Pflicht (Exakt 4 Dimensionen)

**Regel V-B5: Hand-Labels benÃ¶tigen immer exakt 4 Untergruppen**

```python
def validate_hand_labels(hand_labels, hand_side):
    """
    CC04 (Left Hand) und CC05 (Right Hand) sind hierarchisch strukturiert.
    FÃ¼r jedes Zeitfenster mÃ¼ssen exakt 4 Untergruppen definiert sein:
    1. Primary Position (Wo befindet sich die Hand?)
    2. Type of Movement (Was tut die Hand?)
    3. Object (Welches Objekt wird gehandhabt?)
    4. Tool (Welches Werkzeug wird genutzt?)
    
    Min: 4 Labels, Max: 4 Labels (Zwingend)
    """
    
    HAND_STRUCTURE = {
        'Primary Position': {
            'left': ['CL030', 'CL031', 'CL032'],  # Upwards, Centered, Downwards
            'right': ['CL065', 'CL066', 'CL067'],
        },
        'Type of Movement': {
            'left': ['CL033', 'CL034', 'CL035', 'CL036', 'CL037', 'CL038', 'CL039'],
            'right': ['CL068', 'CL069', 'CL070', 'CL071', 'CL072', 'CL073', 'CL074'],
        },
        'Object': {
            'left': ['CL040', 'CL041', 'CL042', 'CL043', 'CL044', 'CL045', 'CL046', 'CL047', 'CL048', 'CL049', 'CL050', 'CL051', 'CL052', 'CL053', 'CL054', 'CL055', 'CL056', 'CL057'],
            'right': ['CL075', 'CL076', 'CL077', 'CL078', 'CL079', 'CL080', 'CL081', 'CL082', 'CL083', 'CL084', 'CL085', 'CL086', 'CL087', 'CL088', 'CL089', 'CL090', 'CL091', 'CL092'],
        },
        'Tool': {
            'left': ['CL058', 'CL059', 'CL060', 'CL061', 'CL062', 'CL063', 'CL064'],
            'right': ['CL093', 'CL094', 'CL095', 'CL096', 'CL097', 'CL098', 'CL099'],
        },
    }
    
    # PrÃ¼fe jede Untergruppe
    for dimension, label_ranges in HAND_STRUCTURE.items():
        hand_labels_in_dimension = [l for l in hand_labels if l in label_ranges[hand_side]]
        assert len(hand_labels_in_dimension) == 1, \
            f"{hand_side} Hand: {dimension} muss exakt 1 Label haben, hat {len(hand_labels_in_dimension)}"
    
    # Gesamtzahl
    assert len(hand_labels) == 4, \
        f"{hand_side} Hand: exakt 4 Labels erforderlich (Position+Movement+Object+Tool), hat {len(hand_labels)}"
```

**Beispiele:**

| Kombination | GÃ¼ltig? | Grund |
|------------|---------|-------|
| CL030 (Up) + CL033 (Reaching) + CL040 (Items) + CL058 (PDT) | âœ… | 4 Dimensionen |
| CL030 + CL033 + CL040 | âŒ | Fehlt Tool (nur 3) |
| CL030 + CL031 + CL033 + CL040 + CL058 | âŒ | 2 Position-Labels (5 insgesamt) |
| CL030 + CL034 (Grasping) + CL040 + CL058 | âœ… | 4 Dimensionen |

---

#### CC06 (Order) â€“ Multi-Order nur in S7/S8

**Regel V-B6: Order-Labels szenario-abhÃ¤ngig**

```python
def validate_cc06_orders(scenario, active_orders):
    """
    CC06 (Order) hat szenario-spezifische Regeln:
    - Single-Order-Szenarien (S1-S6): Exakt 1 Order
    - Multi-Order-Szenarien (S7-S8): Exakt 2 Orders (2904 + 2905)
    """
    
    if scenario in ['S1', 'S2', 'S3', 'S4', 'S5', 'S6']:
        # Single-Order
        assert len(active_orders) == 1, \
            f"{scenario} (Single-Order): exakt 1 Order, hat {len(active_orders)}"
    
    elif scenario in ['S7', 'S8']:
        # Multi-Order: Exakt CL100 (2904) + CL101 (2905)
        assert active_orders == {'CL100', 'CL101'}, \
            f"{scenario} (Multi-Order): benÃ¶tigt CL100+CL101, hat {active_orders}"
    
    # Exklusiv-Regeln
    # CL103 (No Order) und CL104 (Unknown) sind exklusiv mit anderen Orders
    assert not ('CL103' in active_orders and any(o != 'CL103' for o in active_orders)), \
        "CL103 (No Order) kann nicht mit anderen Orders kombiniert werden"
    assert not ('CL104' in active_orders and any(o != 'CL104' for o in active_orders)), \
        "CL104 (Unknown) kann nicht mit anderen Orders kombiniert werden"
```

---

#### CC11 (Location Human) â€“ Hierarchische Struktur (Max 3)

**Regel V-B7: Location Human hierarchisch**

```python
def validate_cc11_location_human(active_labels_cc11):
    """
    CC11 (Location - Human) hat max 3 Labels in hierarchischer Struktur:
    Level 1: Main Area (zwingend)
    Level 2: Sub-Area / Specific Location (bedingt)
    Level 3: Position (nur bei Aisle Path)
    """
    
    LOCATION_HIERARCHY = {
        'Level 1 - Main Area': ['CL155', 'CL156', 'CL157', 'CL158', 'CL159', 'CL160', 'CL161', 'CL162', 'CL163'],
        'Level 2 - Sub-Area': ['CL164', 'CL165', 'CL166', 'CL167', 'CL168', 'CL169', 'CL170', 'CL171', 'CL172', 'CL173', 'CL174', 'CL175', 'CL176'],
        'Level 3 - Position': ['CL177', 'CL178'],  # Front, Back
    }
    
    # ZÃ¤hle Labels pro Level
    level1_count = len([l for l in active_labels_cc11 if l in LOCATION_HIERARCHY['Level 1 - Main Area']])
    level2_count = len([l for l in active_labels_cc11 if l in LOCATION_HIERARCHY['Level 2 - Sub-Area']])
    level3_count = len([l for l in active_labels_cc11 if l in LOCATION_HIERARCHY['Level 3 - Position']])
    
    # Regel: Max 1 Label pro Level
    assert level1_count <= 1, f"Max 1 Main Area Label, hat {level1_count}"
    assert level2_count <= 1, f"Max 1 Sub-Area Label, hat {level2_count}"
    assert level3_count <= 1, f"Max 1 Position Label, hat {level3_count}"
    
    # Gesamt: Max 3 Labels
    assert len(active_labels_cc11) <= 3, f"CC11: Max 3 Labels, hat {len(active_labels_cc11)}"
```

**Beispiele:**

| Kombination | GÃ¼ltig? | Beschreibung |
|------------|---------|-------------|
| CL163 + CL172 + CL177 | âœ… | Aisle Path + Aisle 1 + Front |
| CL155 | âœ… | Office alleine (simple) |
| CL163 + CL172 | âœ… | Aisle Path + Aisle 1 (ohne Position) |
| CL155 + CL156 | âŒ | 2 Main Areas gleichzeitig |
| CL163 + CL172 + CL173 + CL177 | âŒ | 4 Labels (zu viele) |

---

#### CC12 (Location Cart) â€“ Mit Transition (Max 4)

**Regel V-B8: Location Cart hierarchisch + Transition**

```python
def validate_cc12_location_cart(active_labels_cc12):
    """
    CC12 (Location - Cart) ist wie CC11 strukturiert, aber mit zusÃ¤tzlichem
    Transition-Label (CL181) fÃ¼r Zonenwechsel:
    
    Max 3 normale Labels (wie CC11) + optional 1 Transition = Max 4 gesamt
    """
    
    TRANSITION_LABEL = 'CL181'
    
    # Entferne Transition temporÃ¤r
    has_transition = TRANSITION_LABEL in active_labels_cc12
    normal_labels = [l for l in active_labels_cc12 if l != TRANSITION_LABEL]
    
    # Normale Labels: max 3 (wie CC11)
    assert len(normal_labels) <= 3, \
        f"CC12 normal labels: max 3, hat {len(normal_labels)}"
    
    # Mit Transition: max 4
    if has_transition:
        assert len(active_labels_cc12) <= 4, \
            f"CC12 mit Transition: max 4, hat {len(active_labels_cc12)}"
    else:
        assert len(active_labels_cc12) <= 3, \
            f"CC12 ohne Transition: max 3, hat {len(active_labels_cc12)}"
```

**CL181 (Transition between Areas) â€” Spezialfall:**

Das Transition-Label markiert den Zeitraum, in dem der Wagen eine Zone-Grenzlinie Ã¼berquert (von ersten Rad bis letztes Rad). Dies dient der Fehleranalyse von Sensor-Rauschen und Indoor-Lokalisierung.

**Beispiele:**

| Kombination | GÃ¼ltig? | Beschreibung |
|------------|---------|-------------|
| CL190 (Aisle) + CL201 (Aisle 3) + CL204 (Front) + CL181 (Transition) | âœ… | 4 Labels mit Transition |
| CL190 + CL201 + CL204 | âœ… | 3 Labels ohne Transition |
| CL181 + CL155 (Path) | âœ… | Transition wÃ¤hrend Ãœbergang zur anderen Zone |

---

## 3. SPEZIELLE VALIDIERUNGEN

### 3.1 CC09-Konsistenz (Prozess-ExklusivitÃ¤t)

**Regel V-P1: CC09-Labels sind prozess-spezifisch**

```python
def validate_cc09_consistency(scenario, cc09_active):
    """
    Bestimmte CC09-Labels sind nur in bestimmten Prozessen erlaubt.
    Dies ist eine Konsistenz-PrÃ¼fung zusÃ¤tzlich zu V-B2.
    """
    
    # Retrieval-spezifische CC09-Labels
    RETRIEVAL_CC09 = ['CL114', 'CL115', 'CL116', 'CL118', 'CL121']
    
    # Storage-spezifische CC09-Labels
    STORAGE_CC09 = ['CL114', 'CL117', 'CL119', 'CL120', 'CL121']
    
    # Szenarien S1-S3, S7: Retrieval
    if scenario in ['S1', 'S2', 'S3', 'S7']:
        assert cc09_active in RETRIEVAL_CC09, \
            f"{scenario} (Retrieval): CC09={cc09_active} nicht erlaubt. Muss in {RETRIEVAL_CC09} sein"
    
    # Szenarien S4-S6, S8: Storage
    elif scenario in ['S4', 'S5', 'S6', 'S8']:
        assert cc09_active in STORAGE_CC09, \
            f"{scenario} (Storage): CC09={cc09_active} nicht erlaubt. Muss in {STORAGE_CC09} sein"
    
    # Szenario Other: Beliebig oder spezielle Labels
    else:
        pass  # Keine EinschrÃ¤nkung fÃ¼r "Other"
```

**Wichtig:** CL114 (Preparing) und CL121 (Finalizing) sind **gemeinsam** in beiden Prozessen, da beide Retrieval und Storage mit Preparation/Finalization beginnen/enden.

---

### 3.2 Error-Flag Konsistenz (CL135 â€” Reporting and Clarifying Incident)

**Regel V-E1': CL135-Aktivierung szenario-spezifisch**

**WICHTIG:** CL135 ist **NICHT** ein â€žError-Flag", sondern ein **aktiver Low-Level-Prozessschritt** (CC10), der verwendet wird, wenn ein Fehler geklÃ¤rt werden muss.

```python
def validate_cl135_activation(scenario, has_cl135_in_travel_phase):
    """
    CL135 (Reporting and Clarifying the Incident) ist ein CC10-Label,
    das in Travel-Phasen (CL115, CL119) verwendet wird, wenn Fehler
    geklÃ¤rt werden mÃ¼ssen (Weg BÃ¼ro â†’ KlÃ¤rung â†’ RÃ¼ckweg).
    
    Aktivierungs-Regeln nach Szenario-Fehler-Status:
    """
    
    # S1-S3: Retrieval mit INTENTIONAL ERRORS (geplante Fehler)
    if scenario in ['S1', 'S2', 'S3']:
        # Fehler sind absichtlich eingebaut (falsche LagerplÃ¤tze, fehlende Materialien)
        # Probanden mÃ¼ssen diese klÃ¤ren â†’ CL135 wird erwartet
        if has_planned_error_in_scenario:
            assert has_cl135_in_travel_phase, \
                f"{scenario}: Geplanter Fehler vorhanden, aber CL135 nicht aktiviert in Travel-Phase"
    
    # S7-S8: Perfect Run (fehlerfrei)
    elif scenario in ['S7', 'S8']:
        # Keine geplanten Fehler, Perfect Run
        # CL135 sollte NOT vorkommen (auÃŸer ungeplante Proband-Fehler)
        if has_cl135_in_travel_phase:
            # Warnung: Ungeplanter Fehler in Perfect Run erkannt
            return 'WARNING_UNEXPECTED_ERROR_IN_PERFECT_RUN'
    
    # S4-S6: Storage (Fehler-Status in Quellen nicht explizit erwÃ¤hnt)
    elif scenario in ['S4', 'S5', 'S6']:
        # Konservativ: CL135 mÃ¶glich, aber nicht erzwungen
        return 'NEUTRAL'
    
    # Other: Organisatorische Zeit (zwischen Szenarien)
    elif scenario == 'Other':
        # Other ist Wartezeit, Sensoren-Anlegen, Pausen
        # CL135 ist aktiver Prozessschritt, sollte NICHT in Other vorkommen
        assert not has_cl135_in_travel_phase, \
            "CL135 ist aktiver Prozess, nicht Wartezeit. Sollte nicht in 'Other' auftreten"
```

**Wichtig:** 

1. **S1-S3 haben intentional errors:**
   - S1: Falsche LagerplÃ¤tze
   - S2: (Additional error zu bestÃ¤tigen)
   - S3: Fehlende Materialien, Mengenabweichungen

2. **S7-S8 sind Perfect Runs:**
   - Keine geplanten Fehler
   - CL135 sollte idealerweise nicht auftreten

3. **CL135 ist CC10-Prozessschritt:**
   - Nicht "Error-Flag" oder Kategorisierung
   - Umfasst: Weg zum BÃ¼ro + KlÃ¤rungszeit + RÃ¼ckweg
   - Tritt auf wÃ¤hrend Travel-Phasen (CL115, CL119) auf

---

## 4. ANWENDUNGSHINWEISE

### Validierungs-Reihenfolge

```python
def validate_frame(frame, scenario):
    """
    VollstÃ¤ndige Frame-Level-Validierung in korrekter Reihenfolge
    """
    # 1. Master-Slave Dependencies
    validate_cc01_master(frame)  # V-B1
    validate_cc08_cc09_hierarchy(frame)  # V-B2
    validate_cc09_cc10_hierarchy(frame)  # V-B3
    
    # 2. Single-Label Prinzip
    validate_single_label_categories(frame)  # CC01, CC02, CC07, CC08, CC09, CC10
    
    # 3. Multi-Label Kombinationsregeln
    validate_cc03_torso(frame)  # V-B4
    validate_cc04_cc05_hands(frame)  # V-B5
    validate_cc06_orders(frame, scenario)  # V-B6
    validate_cc11_location_human(frame)  # V-B7
    validate_cc12_location_cart(frame)  # V-B8
    
    # 4. Prozess-Spezifika
    validate_cc09_consistency(scenario, frame)  # V-P1
    
    # 5. Error-Handling
    validate_cl135_activation(scenario, frame)  # V-E1'
```

### Beziehung zu Szenario-Validierung

| Datei | Fokus | Zweck |
|-------|-------|-------|
| **core_validation_rules_v5_0.md** (diese Datei) | Frame-Level | Sind die Label-Kombinationen innerhalb eines Frames konsistent? |
| **core_ground_truth_central_v5_0.md** | Szenario-Level | Welches Szenario hat der Frame und passt der Gesamtfluss zur Ground Truth? |
| **core_category_activation_matrix_v5_0.md** | Cardinality | Wie viele Labels pro Kategorie pro Szenario? |

**Workflow:**
1. **Frame-Validierung** (core_validation_rules_v5_0.md) â†’ Ist der Frame selbst konsistent?
2. **Szenario-Zuordnung** (core_ground_truth_central_v5_0.md) â†’ Welches Szenario hat der Frame?
3. **Szenario-Validierung** (core_ground_truth_central_v5_0.md) â†’ Passt das Szenario zur Ground Truth?

---

## 5. Ã„NDERUNGSHISTORIE

### v5.0 (05.02.2026)

**Neuerstellen auf Basis DaRa-Quellen + frame_validation_rules.md v4.5.1**

**Ã„nderungen gegenÃ¼ber v4.5.1:**
- âœ… V-B1 bis V-B3 Ã¼bernommen (alle Master-Slave-AbhÃ¤ngigkeiten validiert)
- âœ… V-B4 bis V-B8 Ã¼bernommen (Multi-Label-Regeln validiert)
- âœ… V-P1 Ã¼bernommen (Prozess-ExklusivitÃ¤t validiert)
- âŒ V-E1 komplett Ã¼berarbeitet:
  - **FEHLER BEHOBEN:** S1-S3 haben intentional errors, sind NICHT fehlerfrei
  - **KLÃ„RUNG:** CL135 ist "Reporting and Clarifying Incident", NICHT "Error-Flag"
  - **KLÃ„RUNG:** "Other" ist organisatorische Zeit, NICHT Error-Szenario
  - Neue Regel V-E1' mit szenario-spezifischen Aktivierungen
- âœ… BPMN-Prozess-Mappings als Anhang hinzugefÃ¼gt (V-B3 Details)
- âœ… Alle Referenzen auf _v5_0-Versionen aktualisiert
- âœ… Epistemische Validierung durch NotebookLM + DaRa-Quellen durchgefÃ¼hrt

### v4.5.1 (27.01.2026, deprecated)
- Original frame_validation_rules.md
- **Hinweis:** EnthÃ¤lt Fehler in V-E1 (siehe Ã„nderungshistorie v5.0)

---

## ANHANG: BPMN-Prozess-Mappings

### CC09 â†’ CC10 Mapping (BPMN-basiert)

Die folgenden Tabellen zeigen das explizite Mapping zwischen Mid-Level (CC09) und Low-Level (CC10) Prozessen basierend auf den BPMN-Diagrammen der DaRa-Dokumentation.

#### Retrieval-Prozess (S1-S3, S7)

##### CL114 | Preparing Order

| CC09 Phase | Erlaubte CC10-Labels | Beschreibung |
|-----------|----------------------|-------------|
| **CL114** | CL135 (Reporting) | KlÃ¤rung, falls Fehler beim Vorbereiten |
| | CL134 (Waiting) | Warten auf Hardware/Wagen-VerfÃ¼gbarkeit |

**Prozessfluss:** BÃ¼ro â†’ Wagen holen â†’ Material sammeln (ggfs. KlÃ¤rung bei Problemen)

---

##### CL115 | Picking - Travel Time

| CC09 Phase | Erlaubte CC10-Labels | Beschreibung |
|-----------|----------------------|-------------|
| **CL115** | CL137 (Moving to Next Position) | Fortbewegung zwischen Positionen/Regalgang |
| | CL128 (Transporting Cart to Base) | Wagen zur Basis transportieren |
| | CL135 (Reporting and Clarifying) | KlÃ¤rung bei Fehler (falsche LagerplÃ¤tze, fehlende Artikel) |
| | CL134 (Waiting) | Warten (z.B. auf Regal-Zugang) |

**Prozessfluss:** Bewegung zwischen KommissionierplÃ¤tzen, ggfs. Fehlerbehebung

---

##### CL116 | Picking - Pick Time

| CC09 Phase | Erlaubte CC10-Labels | Beschreibung |
|-----------|----------------------|-------------|
| **CL116** | CL139 (Retrieving Items) | Entnahme von Artikel aus dem Regal |
| | CL151 (Placing Cardboard Box/Item in Cart) | Ablage in Wagen |
| | CL134 (Waiting) | Warten auf Regal-Freiheit |

**Prozessfluss:** Artikel greifen â†’ in Wagen ablegen

---

##### CL118 | Packing

| CC09 Phase | Erlaubte CC10-Labels | Beschreibung |
|-----------|----------------------|-------------|
| **CL118** | CL144 (Opening Cardboard Box) | Box Ã¶ffnen |
| | CL145 (Filling Cardboard Box with Filling Material) | FÃ¼llmaterial einfÃ¼gen |
| | CL150 (Sealing Cardboard Box) | Box versiegeln/kleben |
| | CL134 (Waiting) | Warten auf Material/Box |

**Prozessfluss:** Pack-AktivitÃ¤ten am Packtisch (nur bei Retrieval, da Pick & Pack)

---

##### CL121 | Finalizing Order

| CC09 Phase | Erlaubte CC10-Labels | Beschreibung |
|-----------|----------------------|-------------|
| **CL121** | CL135 (Reporting) | KlÃ¤rung bei Problemen beim Abschluss |
| | CL134 (Waiting) | Warten auf Versand-Freigabe |

**Prozessfluss:** Abgabe Pakete, RÃ¼ckgabe Hardware

---

#### Storage-Prozess (S4-S6, S8)

##### CL114 | Preparing Order

*Identisch zu Retrieval (siehe oben)*

---

##### CL117 | Unpacking

| CC09 Phase | Erlaubte CC10-Labels | Beschreibung |
|-----------|----------------------|-------------|
| **CL117** | CL135 (Reporting) | KlÃ¤rung bei Abweichungen |
| | CL134 (Waiting) | Warten auf Material/Box |

**Prozessfluss:** Artikel auspacken, sortieren, kennzeichnen

---

##### CL119 | Storing - Travel Time

| CC09 Phase | Erlaubte CC10-Labels | Beschreibung |
|-----------|----------------------|-------------|
| **CL119** | CL137 (Moving to Next Position) | Fortbewegung zum Lagerplatz |
| | CL128 (Transporting Cart to Base) | Wagen zur Basis transportieren |
| | CL135 (Reporting and Clarifying) | KlÃ¤rung bei Fehler (falsche Positionen) |
| | CL134 (Waiting) | Warten auf Regal-Zugang |

**Prozessfluss:** Bewegung zum Einlagerungsplatz, ggfs. Fehlerbehebung

---

##### CL120 | Storing - Store Time

| CC09 Phase | Erlaubte CC10-Labels | Beschreibung |
|-----------|----------------------|-------------|
| **CL120** | CL154 (Placing Item in Rack) | Artikel ins Regal einlagern |
| | CL134 (Waiting) | Warten auf Regal-Freiheit |

**Prozessfluss:** Artikel platzieren/einlagern

---

##### CL121 | Finalizing Order

*Identisch zu Retrieval (siehe oben)*

---

#### Other Processes

##### CL122 | Another Process

| CC09 Phase | Erlaubte CC10-Labels |
|-----------|----------------------|
| **CL122** | CL134 (Waiting) |

---

##### CL123 | Process Unknown

| CC09 Phase | Erlaubte CC10-Labels |
|-----------|----------------------|
| **CL123** | CL134 (Waiting) |

---

### Hinweise zur BPMN-Struktur

**Diese BPMN-Mappings basieren auf:**
- Anhang A.2 der DaRa-Datensatzbeschreibung (BPMN-Diagramme)
- Annotationsrichtlinien fÃ¼r Prozess-Kategorien
- Praktische Prozessbeobachtungen aus Pilotierung

**Verwendung:**
- FÃ¼r V-B3 Validierung: PrÃ¼fe, ob CC10 in erlaubten Labels fÃ¼r aktuelles CC09 liegt
- FÃ¼r BPMN-Visualisierung: Siehe `processes_bpmn_visualization_v5_0.md` (falls verfÃ¼gbar)

---

## REFERENZEN

**Verwandte Dateien (v5.0):**
- `core_labels_207_v5_0.md` â€” VollstÃ¤ndige Label-Definitionen (CL001-CL207)
- `core_category_activation_matrix_v5_0.md` â€” Min/Max-Aktivierungsmatrix pro Szenario
- `core_ground_truth_central_v5_0.md` â€” 5-Schritt-Logik fÃ¼r Szenario-Erkennung
- `processes_bpmn_validation_v5_0.md` â€” BPMN-Validierung und Sequenz-Logik

**Externe Quellen:**
- DaRa Dataset Description (Authoritative PDF)
- Annotationsrichtlinien (NotebookLM-validiert)
- BPMN-Diagramme (Anhang A.2)

---

**Datei-Version:** 5.0  
**Status:** finalisiert âœ…  
**Validierung:** Quellen-Klarstellung durch NotebookLM abgeschlossen  
**Autor:** Phase 2+3 Analyse & Umsetzung (05.02.2026)  
**NÃ¤chste Phase:** Phase 4 (Konsolidierungsanalyse)
