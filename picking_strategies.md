# DaRa Dataset – Picking Strategies (Single vs. Multi-Order)

Diese Datei beschreibt die **Picking-Strategien** im DaRa-Datensatz – ein kritisches Unterscheidungsmerkmal für die Szenarien S1-S6 (Single-Order) vs. S7-S8 (Multi-Order).

**Quelle:** DaRa Dataset Description (Stand 20.10.2025), Table 3 – Picking Strategies  
**Skill-Version:** 2.4 (02.01.2026)

---

## 1. Übersicht: Die zwei Strategien

| Strategie | Szenarien | Beschreibung |
|-----------|-----------|--------------|
| **Single-Order-Picking** | S1, S2, S3, S4, S5, S6 | Ein Auftrag wird vollständig abgearbeitet, bevor der nächste beginnt |
| **Multi-Order-Picking** | S7, S8 | Mehrere Aufträge werden parallel/verschränkt abgearbeitet |

---

## 2. Single-Order-Picking (Serielle Bearbeitung)

### Definition

Bei Single-Order-Picking wird **ein Kundenauftrag vollständig abgeschlossen**, bevor der nächste Auftrag begonnen wird.

### Charakteristika

- **Ein aktiver Auftrag** pro Zeitpunkt
- **Order-Wechsel = Szenario-Grenze** (neues Szenario beginnt)
- In CC06: Nur **ein Label aktiv** (CL100 ODER CL101 ODER CL102)

### Erkennung in CSV-Daten

```python
def is_single_order(frame_data):
    """Prüft ob Frame Single-Order ist"""
    active_orders = []
    for label in ['CL100', 'CL101', 'CL102']:
        if frame_data[label] == 1:
            active_orders.append(label)
    
    return len(active_orders) <= 1
```

### Szenario-Zuordnung

| Szenario | Order | High-Level |
|----------|-------|------------|
| S1 | 2904 (CL100) | Retrieval |
| S2 | 2905 (CL101) | Retrieval |
| S3 | 2906 (CL102) | Retrieval |
| S4 | 2904 (CL100) | Storage |
| S5 | 2905 (CL101) | Storage |
| S6 | 2906 (CL102) | Storage |

---

## 3. Multi-Order-Picking (Parallele Bearbeitung)

### Definition

Bei Multi-Order-Picking werden **mehrere Kundenaufträge gleichzeitig oder verschränkt** bearbeitet. Der Arbeiter wechselt zwischen Aufträgen, ohne einen vollständig abzuschließen.

### Charakteristika

- **Mehrere Aufträge aktiv** im selben High-Level-Block
- **Order-Wechsel ≠ Szenario-Grenze** (Wechsel sind normaler Teil des Prozesses)
- In CC06: **Mehrere Labels können aktiv sein** (z.B. CL100=1 UND CL101=1)

### Erkennung in CSV-Daten

```python
def is_multi_order_block(block_data):
    """
    Prüft ob ein Block Multi-Order ist.
    
    Multi-Order = genau 2 Orders (2904 + 2905) im Block.
    """
    unique_orders = set()
    
    for frame in block_data:
        for label in ['CL100', 'CL101', 'CL102']:
            if frame[label] == 1:
                unique_orders.add(label)
    
    # Multi-Order: Genau CL100 + CL101 (Orders 2904 + 2905)
    return unique_orders == {'CL100', 'CL101'}
```

### Kritische Erkenntnis: Multi-Label-Annotation

**Im DaRa-Datensatz können bei Multi-Order-Szenarien mehrere Order-Labels GLEICHZEITIG aktiv sein!**

Beispiel aus Analyse:
```
Frame 153.747: CL100=1, CL101=1, CL102=0  → Orders 2904 + 2905 gleichzeitig
```

**Konsequenz:** Algorithmen müssen `frozenset()` statt einzelnes Label verwenden!

### Szenario-Zuordnung (KORRIGIERT)

| Szenario | Orders | High-Level | Order-Set |
|----------|--------|------------|-----------|
| **S7** | 2904 + 2905 | Retrieval (CL110) | {CL100, CL101} |
| **S8** | 2904 + 2905 | Storage (CL111) | {CL100, CL101} |

**WICHTIG:** 
- S7 und S8 haben **dieselben 2 Orders**: 2904 + 2905 (CL100 + CL101)
- Order 2906 (CL102) ist **NICHT** Teil von Multi-Order-Szenarien!
- Multi-Order bedeutet **exakt 2 Orders**, nicht 3

---

## 4. Unterscheidungslogik

### Order-Wechsel als Grenze vs. Prozess

```
Single-Order (S1-S6):
├─ Order wechselt von CL100 → CL101
│   └─ = SZENARIO-GRENZE (neues Szenario beginnt)
│
Multi-Order (S7-S8):
├─ Order wechselt von CL100 → CL101
│   └─ = NORMALER PROZESS (gleicher Multi-Order-Block)
│
├─ High-Level wechselt (CL110 → CL111)
│   └─ = SZENARIO-GRENZE (S7 → S8)
```

### Decision Tree (KORRIGIERT)

```
Block mit CC08 = CL110 oder CL111:
│
├─ Wie viele verschiedene Orders im Block?
│   │
│   ├─ 1 Order → Single-Order-Szenario
│   │   ├─ CC08 = CL110 (Retrieval):
│   │   │   ├─ CC07 = CL107 (PDT) → S2
│   │   │   ├─ CC07 = CL106 (Scanner) → S3
│   │   │   └─ CC07 = CL105 (Pen) + CL100 → S1
│   │   │
│   │   └─ CC08 = CL111 (Storage):
│   │       ├─ CL100 (2904) → S4
│   │       ├─ CL101 (2905) → S5
│   │       └─ CL102 (2906) → S6
│   │
│   └─ 2 Orders (genau {CL100, CL101}) → Multi-Order-Szenario
│       ├─ CC08 = CL110 → S7
│       └─ CC08 = CL111 → S8
│
└─ Andere Kombinationen → Prüfen/Anomalie
```

**HINWEIS:** Es gibt keine "3 Orders → Multi-Order" Regel. Multi-Order hat immer genau 2 Orders.

---

## 5. Validierungsregeln

### V-PS1: Single-Order-Konsistenz

```python
IF scenario IN ['S1', 'S2', 'S3', 'S4', 'S5', 'S6'] THEN
    len(block.orders) == 1 OR block.orders == {'CL103'}
```

### V-PS2: Multi-Order-Konsistenz

```python
IF scenario IN ['S7', 'S8'] THEN
    block.orders == {'CL100', 'CL101'}  # Genau diese 2
```

### V-PS3: S7 Order-Set

```python
IF scenario == 'S7' THEN
    block.orders == {'CL100', 'CL101'}
    block.high_level == 'CL110'  # Retrieval
```

### V-PS4: S8 Order-Set (KORRIGIERT)

```python
IF scenario == 'S8' THEN
    block.orders == {'CL100', 'CL101'}  # NICHT {CL100, CL102}!
    block.high_level == 'CL111'  # Storage
```

**WICHTIG:** S8 hat dieselben Orders wie S7 (2904 + 2905), unterscheidet sich nur durch High-Level (Storage statt Retrieval).

---

## 6. Implementierungshinweise

### Korrekte Order-Extraktion (Set-basiert)

```python
def extract_orders_from_block(block_frames, cc06_columns):
    """
    Extrahiert alle aktiven Orders aus einem Block.
    Verwendet frozenset für Multi-Label-Kompatibilität.
    """
    all_orders = set()
    
    for frame_idx, frame in block_frames.iterrows():
        frame_orders = frozenset(
            col for col in cc06_columns 
            if frame[col] == 1 and col.startswith('CL10')
        )
        all_orders.update(frame_orders)
    
    return all_orders
```

### Multi-Order-Erkennung

```python
def classify_picking_strategy(block_orders):
    """
    Klassifiziert die Picking-Strategie eines Blocks.
    
    Returns:
        'single' | 'multi' | 'unknown'
    """
    # Filtere "No Order" und "Unknown"
    active_orders = block_orders - {'CL103', 'CL104'}
    
    if len(active_orders) == 0:
        return 'unknown'
    elif len(active_orders) == 1:
        return 'single'
    elif active_orders == {'CL100', 'CL101'}:
        return 'multi'  # Genau 2904 + 2905
    else:
        return 'unknown'  # Unerwartete Kombination
```

### Falsch vs. Richtig

```python
# ❌ FALSCH: Nur erstes Label extrahieren
order = next(col for col in cc06_cols if frame[col] == 1)

# ✅ RICHTIG: Alle aktiven Labels als Set
orders = frozenset(col for col in cc06_cols if frame[col] == 1)

# ❌ FALSCH: Annahme dass 3 Orders = Multi-Order
if len(orders) >= 2:  # Zu ungenau!

# ✅ RICHTIG: Exakte Prüfung auf {CL100, CL101}
if orders == {'CL100', 'CL101'}:  # Multi-Order
```

---

## 7. Verwendungshinweise

**Diese Datei nutzen für:**

- Unterscheidung Single-Order vs. Multi-Order
- Implementierung der Order-Logik
- Validierung von S7/S8

**Verwandte Dateien:**

- `ground_truth_matrix.md` → Vollständige Szenario-Matrix
- `scenario_boundary_detection.md` → Grenz-Erkennung
- `validation_logic_extended.md` → Szenario-Validierung
- `label_activity_matrix.md` → Aktive/Inaktive Labels (NEU in v2.4)

---

## Metadaten

**Datei-Version:** 2.4  
**Erstellt:** 30.12.2025  
**Update:** 02.01.2026  
**Änderungen v2.4:**
- Label-Aktivitätsmatrix integriert
- Multi-Order-Erkennung durch Co-Aktivierung dokumentiert

**Änderungen v2.3:**
- S8 Order-Set korrigiert: {CL100, CL101} statt {CL100, CL102}
- Decision Tree korrigiert: Keine "3 Orders" Regel
- V-PS4 korrigiert
- Multi-Order-Erkennung präzisiert

**Quelle:** DaRa Dataset Description, Table 3
