# DaRa Dataset – Erweiterte Validierungslogik (Szenario-Ebene)

Diese Datei ergänzt die Basis-Validierung (`validation_logic.md`) um **szenariospezifische Validierungsregeln** (V-S1 bis V-S12).

**Quelle:** Entwickelt basierend auf Ground Truth Matrix (Table 3)  
**Skill-Version:** 2.4 (02.01.2026)

---

## 1. IT-Konsistenz (Kategorie V-IT)

### V-S1: IT-Konsistenz pro Szenario

Jedes Szenario hat ein **erwartetes IT-System**:

| Szenario | Erwartetes IT | Label |
|----------|---------------|-------|
| S1 | List + Pen | CL105 |
| **S2** | **Portable Data Terminal** | **CL107** |
| **S3** | **List + Glove Scanner** | **CL106** |
| S4, S5, S6, S7, S8 | List + Pen | CL105 |

**Regel:**
```python
EXPECTED_IT = {
    'S1': 'CL105', 'S2': 'CL107', 'S3': 'CL106',
    'S4': 'CL105', 'S5': 'CL105', 'S6': 'CL105',
    'S7': 'CL105', 'S8': 'CL105'
}

def validate_it_consistency(scenario, dominant_it):
    expected = EXPECTED_IT[scenario]
    return dominant_it == expected
```

### V-S7: PDT ist S2-exklusiv

```python
IF dominant_it == 'CL107' THEN scenario MUST BE 'S2'
```

**Keine Ausnahmen!** PDT kommt nur in S2 vor.

### V-S8: Scanner ist S3-exklusiv

```python
IF dominant_it == 'CL106' THEN scenario MUST BE 'S3'
```

**Keine Ausnahmen!** Glove Scanner kommt nur in S3 vor.

---

## 2. Order-Konsistenz (Kategorie V-ORD)

### V-S2: Order-Konsistenz pro Szenario

| Szenario | Erwartete Order(s) | Labels |
|----------|-------------------|--------|
| S1 | 2904 | CL100 |
| S2 | 2905 | CL101 |
| S3 | 2906 | CL102 |
| S4 | 2904 | CL100 |
| S5 | 2905 | CL101 |
| S6 | 2906 | CL102 |
| S7 | 2904 + 2905 | CL100 + CL101 |
| S8 | 2904 + 2905 | CL100 + CL101 |

### V-S9: Order 2906 Zuordnung

```python
IF 'CL102' IN block.orders AND block.high_level == 'CL110':
    scenario SHOULD BE 'S3'  # Retrieval mit 2906

IF 'CL102' IN block.orders AND block.high_level == 'CL111':
    scenario SHOULD BE 'S6'  # Storage mit 2906
```

**Hinweis:** Order 2906 (CL102) kommt in S3 (Retrieval) und S6 (Storage) vor.

---

## 3. Picking-Strategy-Konsistenz (Kategorie V-PS)

### V-S3: Picking-Strategy-Konsistenz

| Szenario | Strategie | Order-Count |
|----------|-----------|-------------|
| S1-S6 | Single-Order | 1 |
| S7-S8 | Multi-Order | 2 (genau) |

**Regel:**
```python
IF scenario IN ['S1', 'S2', 'S3', 'S4', 'S5', 'S6']:
    ASSERT len(block.orders) == 1 OR block.orders == {'CL103'}

IF scenario IN ['S7', 'S8']:
    ASSERT block.orders == {'CL100', 'CL101'}  # Genau diese 2
```

### V-S4: S7 Order-Set

```python
IF scenario == 'S7':
    ASSERT block.orders == {'CL100', 'CL101'}
    ASSERT block.high_level == 'CL110'  # Retrieval
```

S7 hat **genau 2 Orders**: 2904 + 2905.

### V-S5: S8 Order-Set (KORRIGIERT in v2.3)

```python
IF scenario == 'S8':
    ASSERT block.orders == {'CL100', 'CL101'}  # NICHT {CL100, CL102}!
    ASSERT block.high_level == 'CL111'  # Storage
```

**WICHTIG:** S8 hat **dieselben 2 Orders** wie S7: 2904 + 2905 (CL100 + CL101).

---

## 4. High-Level und Error-Flag Konsistenz (Kategorie V-HL)

### V-S6: High-Level Process Konsistenz

| Szenario | Erwarteter High-Level | Label |
|----------|----------------------|-------|
| S1, S2, S3, S7 | Retrieval | CL110 |
| S4, S5, S6, S8 | Storage | CL111 |

**Regel:**
```python
HL_GROUND_TRUTH = {
    'S1': 'CL110', 'S2': 'CL110', 'S3': 'CL110',
    'S4': 'CL111', 'S5': 'CL111', 'S6': 'CL111',
    'S7': 'CL110', 'S8': 'CL111'
}

def validate_hl_consistency(scenario, high_level):
    expected = HL_GROUND_TRUTH[scenario]
    return high_level == expected
```

### V-S10: Error-Flag Konsistenz

**Beschreibung:** S1 und S3 haben intentionale Fehler (erkennbar via CL135), andere Szenarien nicht.

| Szenario | Fehler erwartet? | Erkennungsmerkmal |
|----------|------------------|-------------------|
| **S1** | **Ja** | CL135 (Incident Reporting) kann auftreten |
| S2 | Nein | Kein CL135 |
| **S3** | **Ja** | CL135 (Incident Reporting) kann auftreten |
| S4-S8 | Nein | Kein CL135 (Perfect Runs) |

**Regel:**
```python
ERROR_GROUND_TRUTH = {
    'S1': True, 'S2': False, 'S3': True,
    'S4': False, 'S5': False, 'S6': False,
    'S7': False, 'S8': False
}

def validate_error_flag(scenario, has_cl135):
    expected_errors = ERROR_GROUND_TRUTH[scenario]
    
    if expected_errors and not has_cl135:
        return 'WARNING'  # Fehler-Szenario ohne CL135
    elif not expected_errors and has_cl135:
        return 'ERROR'  # Non-Error-Szenario mit CL135
    
    return 'OK'
```

**Hinweis:** CL135 = "Reporting and Clarifying the Incident" (CC10 Low-Level Process)

---

## 5. Strukturelle Konsistenz (Kategorie V-STR)

### V-S11: Szenario-Anzahl pro Subjekt (GEÄNDERT in v2.3)

**WICHTIG: Keine feste Szenario-Anzahl erwarten!**

```python
# ❌ FALSCH (v2.0):
expected_scenario_count = 7  # Hardcoded!

# ✅ RICHTIG (v2.3):
# Keine Annahme über Szenario-Anzahl
# Jedes Subjekt kann 1-8 Szenarien haben
# Validierung erfolgt pro erkanntem Szenario, nicht auf Gesamtanzahl
```

**Begründung:**
- Nicht alle Subjekte haben alle 8 Szenarien aufgezeichnet
- Szenarien können fehlen, fragmentiert oder mehrfach vorkommen
- Die Erkennung muss subjektunabhängig funktionieren

### V-S12: CL112/CL113-Filterung

```python
CL112 (Another High-Level Process) = TRANSITION (kein Szenario)
CL113 (High-Level Process Unknown) = TRANSITION (kein Szenario)

IF block.high_level IN ['CL112', 'CL113']:
    scenario = None  # Nicht als Szenario zählen
```

---

## 6. Zusammenfassung aller Regeln

| Regel-ID | Name | Beschreibung | Kritisch |
|----------|------|--------------|----------|
| V-S1 | IT-Konsistenz | IT passt zum Szenario | ✓ |
| V-S2 | Order-Konsistenz | Order passt zum Szenario | ✓ |
| V-S3 | Picking-Strategy | Single vs. Multi-Order korrekt | ✓ |
| **V-S4** | **S7 Order-Set** | **S7 hat {CL100, CL101}** | **✓** |
| **V-S5** | **S8 Order-Set** | **S8 hat {CL100, CL101}** | **✓** |
| V-S6 | HL-Konsistenz | High-Level passt zum Szenario | ✓ |
| V-S7 | PDT-Exklusivität | PDT nur in S2 | ✓ |
| V-S8 | Scanner-Exklusivität | Scanner nur in S3 | ✓ |
| V-S9 | Order-2906-Zuordnung | CL102 in S3 oder S6 | ⚠ |
| V-S10 | Error-Flag | S1/S3 können CL135 haben | ⚠ |
| V-S11 | Szenario-Anzahl | **KEINE feste Anzahl** | ❌ |
| V-S12 | CL112/CL113-Filterung | Übergangsphasen ignorieren | ✓ |

**Gesamt: 12 Szenario-Validierungsregeln**

---

## 7. Validierungs-Implementierung

```python
def validate_scenario(scenario, block_analysis):
    """
    Validiert ein erkanntes Szenario gegen alle Regeln.
    
    Args:
        scenario: 'S1' bis 'S8'
        block_analysis: dict mit high_level, it_mode, orders
    
    Returns:
        tuple: (is_valid, list_of_violations)
    """
    violations = []
    
    hl = block_analysis['high_level']
    it_mode = block_analysis['it_mode']
    orders = block_analysis['orders']
    
    # V-S1: IT-Konsistenz
    expected_it = {
        'S2': 'CL107',
        'S3': 'CL106'
    }.get(scenario, 'CL105')
    
    if it_mode != expected_it:
        violations.append(f"V-S1: Erwarte {expected_it}, gefunden {it_mode}")
    
    # V-S6: HL-Konsistenz
    expected_hl = {
        'S1': 'CL110', 'S2': 'CL110', 'S3': 'CL110',
        'S4': 'CL111', 'S5': 'CL111', 'S6': 'CL111',
        'S7': 'CL110', 'S8': 'CL111'
    }.get(scenario)
    
    if hl != expected_hl:
        violations.append(f"V-S6: Erwarte {expected_hl}, gefunden {hl}")
    
    # V-S7: PDT-Exklusivität
    if it_mode == 'CL107' and scenario != 'S2':
        violations.append(f"V-S7: PDT nur in S2 erlaubt, gefunden in {scenario}")
    
    # V-S8: Scanner-Exklusivität
    if it_mode == 'CL106' and scenario != 'S3':
        violations.append(f"V-S8: Scanner nur in S3 erlaubt, gefunden in {scenario}")
    
    # V-S3: Picking-Strategy
    if scenario in ['S1', 'S2', 'S3', 'S4', 'S5', 'S6']:
        active_orders = orders - {'CL103', 'CL104'}
        if len(active_orders) > 1:
            violations.append(f"V-S3: Single-Order erwartet, aber {len(active_orders)} Orders")
    
    if scenario in ['S7', 'S8']:
        if orders != {'CL100', 'CL101'}:
            violations.append(f"V-S3: Multi-Order erwartet {{CL100,CL101}}, gefunden {orders}")
    
    # V-S4: S7 Order-Set
    if scenario == 'S7':
        if orders != {'CL100', 'CL101'}:
            violations.append(f"V-S4: S7 erwartet {{CL100, CL101}}, gefunden {orders}")
    
    # V-S5: S8 Order-Set (KORRIGIERT)
    if scenario == 'S8':
        if orders != {'CL100', 'CL101'}:
            violations.append(f"V-S5: S8 erwartet {{CL100, CL101}}, gefunden {orders}")
    
    return len(violations) == 0, violations


def validate_all_scenarios(recognized_scenarios):
    """
    Validiert alle erkannten Szenarien.
    
    KEINE Prüfung auf feste Szenario-Anzahl!
    
    Args:
        recognized_scenarios: list aus recognize_scenarios()
    
    Returns:
        dict: Validierungsergebnisse
    """
    results = {
        'total': len(recognized_scenarios),
        'valid': 0,
        'invalid': 0,
        'details': []
    }
    
    for s in recognized_scenarios:
        is_valid, violations = validate_scenario(s['scenario'], s)
        
        results['details'].append({
            'scenario': s['scenario'],
            'valid': is_valid,
            'violations': violations
        })
        
        if is_valid:
            results['valid'] += 1
        else:
            results['invalid'] += 1
    
    return results
```

---

## 8. Verwendungshinweise

**Diese Datei nutzen für:**

- Validierung erkannter Szenarien
- Debugging von Erkennungsfehlern
- Qualitätssicherung der Algorithmen

**Verwandte Dateien:**

- `validation_logic.md` → Basis-Validierung (Motorik, Prozesse)
- `ground_truth_matrix.md` → Referenz für erwartete Werte
- `scenario_boundary_detection.md` → Erkennungsalgorithmus
- `label_activity_matrix.md` → Aktive/Inaktive Labels (NEU in v2.4)

---

## Metadaten

**Datei-Version:** 2.4  
**Erstellt:** 30.12.2025  
**Update:** 02.01.2026  
**Änderungen v2.4:**
- Label-Aktivitätsmatrix integriert
- Inaktive Labels dokumentiert (CL104, CL109, CL113)

**Änderungen v2.3:**
- V-S5 korrigiert: S8 Order-Set = {CL100, CL101}
- V-S11 geändert: Keine feste Szenario-Anzahl mehr
- Validierungsfunktionen aktualisiert

**Erweitert:** Basis-Validierung um 12 Szenario-Regeln
