# DaRa Dataset – Validation Rules (v2.6)

**Zentrale Sammlung aller Validierungsregeln**

**Skill-Version:** 2.6 (07.01.2026)

---

## 📚 INHALTSVERZEICHNIS

1. [Basis-Validierung](#basis-validierung)
2. [Szenario-Validierung](#szenario-validierung)
3. [CC09-Konsistenz](#cc09-konsistenz)
4. [Hybrid-Logic-Validierung](#hybrid-logic-validierung)

---

## 1. BASIS-VALIDIERUNG

### 1.1 Master-Slave-Abhängigkeiten

**CC01 (Main Activity) → Master für alle anderen**

```python
# Regel V-B1: Wenn Main Activity = "Standing Still", dann Legs MUSS "Standing Still" sein
if CC01 == 'CL001':  # Standing Still
    assert CC02 == 'CL016'  # Standing Still (Legs)
```

**CC08 (High-Level) → Master für CC09**

```python
# Regel V-B2: CC09 MUSS zu CC08 passen
if CC08 == 'CL110':  # Retrieval
    assert CC09 in ['CL114', 'CL115', 'CL116', 'CL118', 'CL121']

if CC08 == 'CL111':  # Storage
    assert CC09 in ['CL117', 'CL119', 'CL120', 'CL121']
```

**CC09 (Mid-Level) → Master für CC10**

```python
# Regel V-B3: CC10 MUSS zu CC09 passen
if CC09 == 'CL115':  # Picking Travel
    assert CC10 in ['CL136', 'CL137', ...]  # Travel-related

if CC09 == 'CL116':  # Picking Pick
    assert CC10 in ['CL139', 'CL140', ...]  # Pick-related
```

---

### 1.2 Single-Label-Prinzip

**Diese Kategorien dürfen nur EIN aktives Label haben:**

```python
SINGLE_LABEL_CATEGORIES = ['CC01', 'CC02', 'CC03', 'CC07', 'CC08']

for category in SINGLE_LABEL_CATEGORIES:
    active_labels = get_active_labels(frame, category)
    assert len(active_labels) == 1, f"Single-Label-Violation in {category}"
```

**Multi-Label erlaubt:**
- CC04 (Left Hand)
- CC05 (Right Hand)
- CC06 (Order) ← Wichtig für S7/S8!
- CC09 (Mid-Level Process)
- CC10 (Low-Level Process)
- CC11 (Location Human)
- CC12 (Location Cart)

---

## 2. SZENARIO-VALIDIERUNG

### 2.1 IT-Konsistenz (V-S1, V-S7, V-S8)

```python
EXPECTED_IT = {
    'S1': 'CL105',  # List + Pen
    'S2': 'CL107',  # PDT
    'S3': 'CL106',  # Scanner
    'S4': 'CL105',  # List + Pen
    'S5': 'CL105',  # List + Pen
    'S6': 'CL105',  # List + Pen
    'S7': 'CL105',  # List + Pen
    'S8': 'CL105',  # List + Pen
}

def validate_it_consistency(scenario, dominant_it):
    expected = EXPECTED_IT[scenario]
    return dominant_it == expected

# V-S7: PDT ist S2-exklusiv
if dominant_it == 'CL107':
    assert scenario == 'S2', "PDT nur in S2 erlaubt"

# V-S8: Scanner ist S3-exklusiv
if dominant_it == 'CL106':
    assert scenario == 'S3', "Scanner nur in S3 erlaubt"
```

---

### 2.2 Order-Konsistenz (V-S2, V-S4, V-S5)

**Single-Order Szenarien:**

```python
# S1-S3: Order IRRELEVANT (Hybrid-Logic)
# Keine Validierung erforderlich

# S4-S6: Order RELEVANT (Hybrid-Logic)
EXPECTED_ORDERS_STORAGE = {
    'S4': 'CL100',  # Order 2904
    'S5': 'CL101',  # Order 2905
    'S6': 'CL102',  # Order 2906
}

if scenario in ['S4', 'S5', 'S6']:
    expected_order = EXPECTED_ORDERS_STORAGE[scenario]
    assert single_order == expected_order, \
        f"{scenario} erwartet Order {expected_order}, hat {single_order}"
```

**Multi-Order Szenarien:**

```python
# V-S4: S7 Order-Set
if scenario == 'S7':
    assert orders == {'CL100', 'CL101'}, \
        "S7 hat genau 2 Orders: 2904 + 2905"
    assert process_type == 'Retrieval'

# V-S5: S8 Order-Set
if scenario == 'S8':
    assert orders == {'CL100', 'CL101'}, \
        "S8 hat genau 2 Orders: 2904 + 2905 (wie S7!)"
    assert process_type == 'Storage'
```

---

### 2.3 Picking-Strategy-Konsistenz (V-S3)

```python
EXPECTED_STRATEGY = {
    'S1': 'Single', 'S2': 'Single', 'S3': 'Single',
    'S4': 'Single', 'S5': 'Single', 'S6': 'Single',
    'S7': 'Multi',  'S8': 'Multi'
}

def validate_picking_strategy(scenario, order_count):
    if scenario in ['S1', 'S2', 'S3', 'S4', 'S5', 'S6']:
        assert order_count == 1, \
            f"{scenario} ist Single-Order, hat aber {order_count} Orders"
    
    if scenario in ['S7', 'S8']:
        assert order_count == 2, \
            f"{scenario} ist Multi-Order, braucht 2 Orders, hat {order_count}"
```

---

### 2.4 High-Level-Konsistenz (V-S6)

```python
HL_GROUND_TRUTH = {
    'S1': 'CL110', 'S2': 'CL110', 'S3': 'CL110', 'S7': 'CL110',  # Retrieval
    'S4': 'CL111', 'S5': 'CL111', 'S6': 'CL111', 'S8': 'CL111'   # Storage
}

def validate_hl_consistency(scenario, high_level):
    expected = HL_GROUND_TRUTH[scenario]
    # HINWEIS: Bei v2.6 wird Score-System genutzt, nicht direkt CC08
    # Daher: Diese Validierung prüft das Score-Ergebnis, nicht CC08 direkt
    return high_level == expected
```

---

### 2.5 Error-Flag-Konsistenz (V-S10)

```python
ERROR_GROUND_TRUTH = {
    'S1': True,   # Errors erwartet
    'S2': False,  # Keine Errors
    'S3': True,   # Errors erwartet
    'S4': False, 'S5': False, 'S6': False,  # Keine Errors
    'S7': False, 'S8': False   # Perfect Runs
}

def validate_error_flag(scenario, has_cl135):
    expected_errors = ERROR_GROUND_TRUTH[scenario]
    
    if expected_errors and not has_cl135:
        return 'WARNING'  # Fehler-Szenario ohne CL135 (ungewöhnlich)
    elif not expected_errors and has_cl135:
        return 'ERROR'  # Non-Error-Szenario mit CL135 (Fehler!)
    
    return 'OK'
```

---

## 3. CC09-KONSISTENZ (v2.5)

### 3.1 Prozess-Exklusivität

**Retrieval-Prozesse:**
```python
RETRIEVAL_CC09 = ['CL115', 'CL116', 'CL118']  # Picking Travel, Pick, Packing
```

**Storage-Prozesse:**
```python
STORAGE_CC09 = ['CL117', 'CL119', 'CL120']  # Unpacking, Storing Travel, Store
```

**Validierung:**

```python
def validate_cc09_consistency(scenario, cc09_active):
    retrieval_scenarios = ['S1', 'S2', 'S3', 'S7']
    storage_scenarios = ['S4', 'S5', 'S6', 'S8']
    
    if scenario in retrieval_scenarios:
        # MUSS mindestens ein Retrieval-Prozess haben
        has_retrieval = any(label in cc09_active for label in RETRIEVAL_CC09)
        assert has_retrieval, \
            f"{scenario} (Retrieval) hat keine Picking/Packing-Prozesse"
        
        # DARF KEINE Storage-Prozesse haben
        has_storage = any(label in cc09_active for label in STORAGE_CC09)
        assert not has_storage, \
            f"{scenario} (Retrieval) hat Storage-Prozesse (Inkonsistenz!)"
    
    if scenario in storage_scenarios:
        # MUSS mindestens ein Storage-Prozess haben
        has_storage = any(label in cc09_active for label in STORAGE_CC09)
        assert has_storage, \
            f"{scenario} (Storage) hat keine Unpacking/Storing-Prozesse"
        
        # DARF KEINE Retrieval-Prozesse haben
        has_retrieval = any(label in cc09_active for label in RETRIEVAL_CC09)
        assert not has_retrieval, \
            f"{scenario} (Storage) hat Retrieval-Prozesse (Inkonsistenz!)"
```

---

## 4. HYBRID-LOGIC-VALIDIERUNG (v2.6)

### 4.1 Retrieval-Szenarien (S1-S3)

```python
def validate_hybrid_retrieval(scenario, cc07, single_order):
    """
    Bei Retrieval ist IT-System Diskriminator, Order IRRELEVANT
    """
    retrieval_scenarios = ['S1', 'S2', 'S3']
    
    if scenario not in retrieval_scenarios:
        return  # Nicht anwendbar
    
    # Order darf beliebig sein (CL100, CL101 oder CL102)
    assert single_order in ['CL100', 'CL101', 'CL102'], \
        f"{scenario}: Order muss eine von [CL100, CL101, CL102] sein, ist {single_order}"
    
    # IT-System MUSS zum Szenario passen
    EXPECTED_IT_RETRIEVAL = {
        'S1': 'CL105',  # Pen
        'S2': 'CL107',  # PDT
        'S3': 'CL106',  # Scanner
    }
    
    expected_it = EXPECTED_IT_RETRIEVAL[scenario]
    assert cc07 == expected_it, \
        f"{scenario} erwartet IT {expected_it}, hat {cc07}"
```

---

### 4.2 Storage-Szenarien (S4-S6)

```python
def validate_hybrid_storage(scenario, cc07, single_order):
    """
    Bei Storage ist Order-ID Diskriminator, IT konstant (CL105)
    """
    storage_scenarios = ['S4', 'S5', 'S6']
    
    if scenario not in storage_scenarios:
        return  # Nicht anwendbar
    
    # IT-System MUSS CL105 sein (konstant)
    assert cc07 == 'CL105', \
        f"{scenario} (Storage) muss IT CL105 (Pen) nutzen, hat {cc07}"
    
    # Order MUSS zum Szenario passen
    EXPECTED_ORDER_STORAGE = {
        'S4': 'CL100',  # Order 2904
        'S5': 'CL101',  # Order 2905
        'S6': 'CL102',  # Order 2906
    }
    
    expected_order = EXPECTED_ORDER_STORAGE[scenario]
    assert single_order == expected_order, \
        f"{scenario} erwartet Order {expected_order}, hat {single_order}"
```

---

### 4.3 Multi-Order-Szenarien (S7, S8)

```python
def validate_multi_order(scenario, orders):
    """
    S7 und S8 haben beide {CL100, CL101}
    """
    if scenario not in ['S7', 'S8']:
        return  # Nicht anwendbar
    
    # Exakt 2 Orders: CL100 + CL101
    assert len(orders) == 2, \
        f"{scenario} muss 2 Orders haben, hat {len(orders)}"
    
    assert orders == {'CL100', 'CL101'}, \
        f"{scenario} muss Orders {{CL100, CL101}} haben, hat {orders}"
```

---

## 5. SCORE-SYSTEM-VALIDIERUNG (v2.6)

```python
def validate_score_system(frame, detected_process):
    """
    Prüft ob Score-System korrekt angewendet wurde
    """
    # Berechne Scores
    cl110 = frame.get('CL110', 0)
    cl111 = frame.get('CL111', 0)
    
    retrieval_markers = [frame.get(label, 0) for label in ['CL126', 'CL130', 'CL149']]
    storage_markers = [frame.get(label, 0) for label in ['CL127', 'CL131', 'CL152', 'CL142']]
    
    score_retrieval = (cl110 * 3) + (max(retrieval_markers) * 5)
    score_storage = (cl111 * 3) + (max(storage_markers) * 5)
    
    # Validiere Entscheidung
    if score_retrieval > score_storage:
        expected_process = 'Retrieval'
    else:
        expected_process = 'Storage'
    
    assert detected_process == expected_process, \
        f"Score-System sagt {expected_process}, erkannt wurde {detected_process}"
```

---

## 6. "OTHER"-VALIDIERUNG (v2.6)

```python
def validate_other(frame, detected_scenario):
    """
    Prüft ob "Other" korrekt erkannt wurde
    """
    # CL134 (Waiting) = Hard Cut
    if frame.get('CL134', 0) == 1:
        assert detected_scenario == 'Other', \
            "CL134 (Waiting) muss 'Other' erzwingen"
    
    # CL112/CL113
    cc08 = get_single_label(frame, 'CC08')
    if cc08 in ['CL112', 'CL113']:
        assert detected_scenario == 'Other', \
            f"CC08={cc08} muss 'Other' erzwingen"
    
    # CL103+CL108
    if frame.get('CL103', 0) == 1 and frame.get('CL108', 0) == 1:
        assert detected_scenario == 'Other', \
            "CL103+CL108 (No Order + No IT) muss 'Other' erzwingen"
```

---

## Metadaten

**Datei-Version:** 1.0  
**Erstellt:** 07.01.2026  
**Status:** Freigegeben ✅  
**Ersetzt:** `validation_logic.md`, `validation_logic_extended.md`