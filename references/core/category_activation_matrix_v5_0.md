---
version: 5.0
status: finalisiert
created: 2026-02-04
source: "DaRa Dataset Description + Authoritative User Documentation (2026-02-04)"
description: "Complete reference for Min/Max activation logic across 12 class categories (CC01-CC12) with combination rules, contradiction matrix, dependency constraints, and priority hierarchies. Validation rules and pseudo-code for automated checks."
---

# core_category_activation_matrix_v5.0.md

## Ãœberblick

Zentrale Referenzdatei fÃ¼r die **Min/Max-Aktivierungslogik aller 12 Klassenkategorien (CC01-CC12)** des DaRa Datasets. EnthÃ¤lt:
- Aktivierungsregeln (KardinalitÃ¤t: Min/Max pro Frame)
- Erlaubte Kombinationen (Multi-Label)
- Explizite Widerspruchsmatrix (Verbotene Kombinationen)
- AbhÃ¤ngigkeitsregeln zwischen Kategorien
- PrioritÃ¤tsregeln bei Gleichzeitigkeit
- Validierungs-Pseudocode

**Verwandte Dateien:**
- `core_labels_207_v5.0.md` â€” Struktur und Definition aller 207 Labels
- `core_ground_truth_central_v5.0.md` â€” Szenario-Definitionen (S1-S8)

---

## 1. SCHNELLÃœBERSICHT: Min/Max-Matrix

| Kategorie | Min. aktiv | Max. aktiv | Typ | Beschreibung | KardinalitÃ¤t-Regel |
|-----------|-----------|-----------|-----|--------------|-------------------|
| **CC01** | 1 | 1 | Single | Main Activity | Immer genau 1 Label (Exklusiv) |
| **CC02** | 1 | 1 | Single | Legs (Sub-Activity) | Immer genau 1 Label (Exklusiv) |
| **CC03** | 1 | 2 | Multi | Torso (Sub-Activity) | 1 Beugungs-Label + optional CL027 (Rotation) |
| **CC04** | 4 | 4 | Multi (4 Gruppen) | Left Hand | Immer genau 4 Labels (Position + Movement + Object + Tool) |
| **CC05** | 4 | 4 | Multi (4 Gruppen) | Right Hand | Immer genau 4 Labels (Position + Movement + Object + Tool) |
| **CC06** | 1â€“2 | 1â€“2 | Variabel | Order | Min/Max hÃ¤ngt von Szenario ab (S1-S3: 1, S4-S6: 1, S7-S8: 2, Other: 1) |
| **CC07** | 1 | 1 | Single | Information Technology | Immer genau 1 Label (Exklusiv) |
| **CC08** | 1 | 1 | Single | High-Level Process | Immer genau 1 Label (Master â†’ CC09) |
| **CC09** | 1 | 1 | Single | Mid-Level Process | Immer genau 1 Label (Master â†’ CC10, abhÃ¤ngig von CC08) |
| **CC10** | 1 | 1 | Single | Low-Level Process | Immer genau 1 Label (abhÃ¤ngig von CC09) |
| **CC11** | 1 | 3 | Hierarchisch | Location â€“ Human | 1 = einfacher Bereich; 3 = Regalgang (Aisle + Nummer + Position) |
| **CC12** | 1 | 4 | Hierarchisch | Location â€“ Cart | 1â€“3 = wie CC11; +1 optional CL181 (Transition) |

---

## 2. SINGLE-LABEL-KATEGORIEN (6 Kategorien: CC01, CC02, CC07â€“CC10)

Diese Kategorien dÃ¼rfen **nur ein Label pro Frame haben**. Alle Labels sind untereinander exklusiv.

### CC01 â€“ Main Activity

**KardinalitÃ¤t:** Min: 1, Max: 1

**Labels:** CL001â€“CL015 (15 Labels)
- CL001: Packing
- CL002: Unpacking
- CL003: Carrying
- CL004: Reaching
- CL005: Scanning
- CL006: [weitere AktivitÃ¤ten...]
- CL015: Standing

**Rolle:** Master fÃ¼r alle motorischen Kategorien (CC02â€“CC05). Definiert HauptaktivitÃ¤t.

**Validierungsregel (Pseudocode):**
```python
if len(active_labels_cc01) != 1:
    raise ValidationError("CC01 muss genau 1 Label haben")
```

**Erlaubte Kombinationen:** Nur 1 Label aktiv.

**Widerspruchs-Beispiele:**
- âŒ Walking (CL011) + Standing (CL015) **gleichzeitig** â†’ Exklusiv
- âŒ Sitting (CL013) + Scanning (CL005) â†’ Exklusiv (auch wenn Scanning wÃ¤hrend Sitzen mÃ¶glich)

**PrioritÃ¤tsregel bei Mehrdeutigkeit:**
Falls mehrere AktivitÃ¤ten gleichzeitig wahrnehmbar sind, gilt diese PrioritÃ¤tsordnung:
```
Sync > Confirming > Scanning > Cart (Pushing) > Handling > Walking/Standing
```

**Beispiel:** Person scannt einen Artikel wÃ¤hrend sie geht:
- Kandidaten: Scanning (CL005), Walking (CL011)
- PrioritÃ¤t: Scanning hat Vorrang â†’ CL005 wird gewÃ¤hlt

---

### CC02 â€“ Legs (Sub-Activity)

**KardinalitÃ¤t:** Min: 1, Max: 1

**Labels:** CL016â€“CL023 (8 Labels)
- CL016: Gait Cycle (aktive Schritte)
- CL017: Standing Still (ruhig stehen)
- CL018: Squat (Hocke â€” beinhaltet auch kleine Schritte)
- [weitere Labels...]

**Rolle:** Slave von CC01. Detaillierung der Beinbewegung.

**Validierungsregel:**
```python
if len(active_labels_cc02) != 1:
    raise ValidationError("CC02 muss genau 1 Label haben")
```

**Widerspruchs-Beispiele:**
- âŒ Gait Cycle (CL016) + Standing Still (CL017) â†’ Exklusiv
- âŒ Zwei Bewegungstypen gleichzeitig

---

### CC07 â€“ Information Technology

**KardinalitÃ¤t:** Min: 1, Max: 1

**Labels:** CL105â€“CL109 (5 Labels)
- CL105: List + Pen
- CL106: Scanner
- CL107: Portable Data Terminal (PDT)
- CL108: No Information Technology
- CL109: Information Technology Unknown

**Rolle:** Prozess-Diskriminator fÃ¼r Szenarioerkennung (S1â€“S3).

**Widerspruchs-Beispiele:**
- âŒ List + Pen (CL105) + Scanner (CL106) â†’ Exklusiv (nur ein IT-System zur selben Zeit)

---

### CC08 â€“ High-Level Process

**KardinalitÃ¤t:** Min: 1, Max: 1

**Labels:** CL110â€“CL113 (4 Labels)
- CL110: Retrieval (Kommissionierung)
- CL111: Storage (Einlagerung)
- CL112: Another High-Level Process
- CL113: High-Level Process Unknown

**Rolle:** Master fÃ¼r CC09. Definiert Prozesstyp (Kommissionierung vs. Einlagerung).

**AbhÃ¤ngigkeit:** CL111 (Storage) aktiviert nur Storage-spezifische CC09-Labels (z.B. CL117 Unpacking, CL119 Storing Travel).

---

### CC09 â€“ Mid-Level Process

**KardinalitÃ¤t:** Min: 1, Max: 1

**Labels:** CL114â€“CL123 (10 Labels)

**Retrieval-Prozesse (wenn CC08 = CL110):**
- CL114: Preparing Order
- CL115: Picking â€“ Travel Time
- CL116: Picking â€“ Pick Time
- CL118: Packing
- CL121: Finalizing Order (auch in Storage mÃ¶glich)

**Storage-Prozesse (wenn CC08 = CL111):**
- CL117: Unpacking
- CL119: Storing â€“ Travel Time
- CL120: Storing â€“ Store Time
- CL121: Finalizing Order (auch in Retrieval mÃ¶glich)

**Rolle:** Master fÃ¼r CC10. Hauptdiskriminator fÃ¼r REFA-Zeitarten.

**AbhÃ¤ngigkeitsregeln:**
- CL117 (Unpacking) nur bei CC08 = Storage (CL111)
- CL121 (Finalizing Order) gÃ¼ltig bei BEIDEN Retrieval und Storage
- AbhÃ¤ngig von CC09 â†’ definiert mÃ¶gliche CC10-Labels

---

### CC10 â€“ Low-Level Process

**KardinalitÃ¤t:** Min: 1, Max: 1

**Labels:** CL124â€“CL154 (31 Labels)

**Beispiel-Labels:**
- CL124: Walking
- CL135: Error â€“ Report to Supervisor (Error-Marker)
- [weitere atomare Prozessschritte...]

**Rolle:** Detaillierung von CC09. Atomare Prozessschritte.

**AbhÃ¤ngigkeitsregeln:**
- Wenn CC09 = CL118 (Packing), nur Packing-spezifische CC10-Labels gÃ¼ltig
- Wenn CC09 = CL120 (Storing â€“ Store Time), nur Storing-spezifische CC10-Labels gÃ¼ltig

---

## 3. MULTI-LABEL-KATEGORIEN MIT FESTER STRUKTUR

### CC03 â€“ Torso (Sub-Activity)

**KardinalitÃ¤t:** Min: 1, Max: 2

**Labels:** CL024â€“CL029 (6 Labels)

**Struktur:**
- **Beugungs-Labels (genau 1 erforderlich):**
  - CL024: No Bending (< 10Â°)
  - CL025: Slightly Bending (10Â°â€“30Â°)
  - CL026: Strongly Bending (> 30Â°)
- **Rotations-Label (optional):**
  - CL027: Torso Rotation
- **Sonstige:**
  - CL028: Another Torso Activity
  - CL029: Torso Activity Unknown

**Validierungsregel:**
```python
def validate_cc03(active_labels):
    assert 1 <= len(active_labels) <= 2, \
        f"CC03 muss 1â€“2 Labels haben, hat {len(active_labels)}"
    
    # CL027 (Rotation) darf nur mit Biegung kombiniert sein
    if 'CL027' in active_labels:
        bending = {'CL024', 'CL025', 'CL026'} & set(active_labels)
        assert len(bending) >= 1, \
            "CL027 (Rotation) MUSS mit Biegung kombiniert sein"
    
    return True
```

**Erlaubte Kombinationen:**
```
âœ“ CC03 = [CL024]                    Keine Beugung, keine Rotation
âœ“ CC03 = [CL025]                    Leichte Beugung, keine Rotation
âœ“ CC03 = [CL026]                    Starke Beugung, keine Rotation
âœ“ CC03 = [CL025, CL027]             Leichte Beugung + Rotation
âœ“ CC03 = [CL026, CL027]             Starke Beugung + Rotation
```

**Widerspruchs-Beispiele:**
```
âŒ CC03 = [CL027]                   Rotation ohne Biegung (UNGÃœLTIG)
âŒ CC03 = [CL024, CL026]            Zwei verschiedene Beugungsgrade (exklusiv)
âŒ CC03 = [CL024, CL025, CL026]     Drei Beugungsgrade (max 1 erlaubt)
```

---

### CC04 â€“ Left Hand (Sub-Activity)

**KardinalitÃ¤t:** Min: 4, Max: 4

**Labels:** CL030â€“CL064 (35 Labels in 4 Untergruppen)

**Erforderliche Struktur (Zwingend Multi-Label):**
Immer mÃ¼ssen genau 4 Labels aktiv sein, je 1 pro Untergruppe:

1. **Primary Position (genau 1):**
   - CL030: Upwards
   - CL031: Centered
   - CL032: Downwards
   - CL033: Position Unknown

2. **Type of Movement (genau 1):**
   - CL034: Reaching, Grasping, Moving, Positioning, Releasing
   - CL035: Manipulating
   - CL036: Holding
   - CL037: No Movement (Hand inaktiv, aber Label erforderlich!)
   - CL038: Another Movement
   - CL039: Movement Unknown

3. **Object (genau 1):**
   - CL040: No Object
   - CL041: Large Item (> 5â€“10 kg)
   - CL042: Medium Item (1â€“5 kg)
   - CL043: Small Item (< 1 kg)
   - CL044: Tool
   - CL045â€“CL050: [weitere Objekt-Labels...]
   - CL051: Object Unknown

4. **Tool (genau 1):**
   - CL052: Portable Data Terminal
   - CL053: Glove Scanner
   - CL054â€“CL063: [weitere Tool-Labels...]
   - CL064: Another Tool

**Validierungsregel:**
```python
def validate_cc04(active_labels):
    assert len(active_labels) == 4, \
        f"CC04 muss genau 4 Labels haben, hat {len(active_labels)}"
    
    position = [l for l in active_labels if l in range(CL030, CL034)]
    movement = [l for l in active_labels if l in range(CL034, CL040)]
    object_ = [l for l in active_labels if l in range(CL040, CL052)]
    tool = [l for l in active_labels if l in range(CL052, CL065)]
    
    assert len(position) == 1, f"Position: {len(position)} Label (benÃ¶tigt 1)"
    assert len(movement) == 1, f"Movement: {len(movement)} Label (benÃ¶tigt 1)"
    assert len(object_) == 1, f"Object: {len(object_)} Label (benÃ¶tigt 1)"
    assert len(tool) == 1, f"Tool: {len(tool)} Label (benÃ¶tigt 1)"
    
    return True
```

**Erlaubte Kombinationen:**
```
âœ“ CC04 = [CL031, CL034, CL043, CL056]
  (Centered + Grasping + Small Item + Pen)
  
âœ“ CC04 = [CL031, CL037, CL040, CL064]
  (Centered + No Movement + No Object + Another Tool)
  Hinweis: Trotz InaktivitÃ¤t (CL037) mÃ¼ssen alle 4 Gruppen belegt sein!
```

**Widerspruchs-Beispiele:**
```
âŒ CC04 = [CL031, CL034, CL035, CL043, CL056]
   (5 Labels statt 4)
   
âŒ CC04 = [CL031, CL034, CL035, CL043, CL056]
   (zwei Movement-Labels: CL034 + CL035 â€” exklusiv)
   
âŒ CC04 = [CL031, CL034, CL043]
   (nur 3 Labels â€” Tool-Gruppe fehlt)
```

---

### CC05 â€“ Right Hand (Sub-Activity)

**KardinalitÃ¤t:** Min: 4, Max: 4

**Labels:** CL065â€“CL099 (35 Labels, Struktur identisch zu CC04)

**Untergruppen:**
- Position: CL065â€“CL068 (analog zu CC04)
- Movement: CL069â€“CL074 (analog zu CC04)
- Object: CL075â€“CL086 (analog zu CC04)
- Tool: CL087â€“CL099 (analog zu CC04)

**Validierungsregel:** Identisch zu CC04, aber mit Range CL065â€“CL099.

---

## 4. SZENARIO-ABHÃ„NGIGES ORDER-LABEL (CC06)

**KardinalitÃ¤t:** Min/Max variabel (abhÃ¤ngig von Szenario)

**Labels:** CL100â€“CL104 (5 Labels)

**Spezifische Orders:**
- CL100: Order 2904
- CL101: Order 2905
- CL102: Order 2906

**Sonderlabels:**
- CL103: No Order (z.B. Setup-Phase)
- CL104: Order Unknown

**Validierungsregel (Szenario-abhÃ¤ngig):**
```python
def validate_cc06(active_orders, scenario):
    # S1â€“S3: Single-Order mit IT-Diskriminator
    if scenario in ['S1', 'S2', 'S3']:
        assert len(active_orders) == 1, \
            f"{scenario}: Genau 1 Order erforderlich"
        assert active_orders[0] in ['CL100', 'CL101', 'CL102'], \
            "S1-S3: Nur Specific Orders (CL100, CL101, CL102)"
    
    # S4â€“S6: Szenario-spezifische Single-Order
    elif scenario == 'S4':
        assert active_orders == ['CL100'], \
            "S4: Storage mit Order 2904 (CL100)"
    elif scenario == 'S5':
        assert active_orders == ['CL101'], \
            "S5: Storage mit Order 2905 (CL101)"
    elif scenario == 'S6':
        assert active_orders == ['CL102'], \
            "S6: Storage mit Order 2906 (CL102)"
    
    # S7â€“S8: Multi-Order
    elif scenario in ['S7', 'S8']:
        assert len(active_orders) == 2, \
            f"{scenario}: Genau 2 Orders erforderlich"
        assert set(active_orders) == {'CL100', 'CL101'}, \
            f"{scenario}: Orders mÃ¼ssen CL100 + CL101 sein"
    
    # Other / Unknown
    elif scenario in ['Other', 'Unknown']:
        assert len(active_orders) == 1
        assert active_orders[0] in ['CL103', 'CL104']
    
    return True
```

**Szenario-Mapping (KardinalitÃ¤t):**

| Szenario | Min | Max | GÃ¼ltige Labels | Regel |
|----------|-----|-----|--------|-------|
| S1 | 1 | 1 | CL100, CL101, CL102 | Hybrid-Logic: IT ist Diskriminator |
| S2 | 1 | 1 | CL100, CL101, CL102 | Hybrid-Logic: IT ist Diskriminator |
| S3 | 1 | 1 | CL100, CL101, CL102 | Hybrid-Logic: IT ist Diskriminator |
| S4 | 1 | 1 | CL100 | Storage mit Order 2904 |
| S5 | 1 | 1 | CL101 | Storage mit Order 2905 |
| S6 | 1 | 1 | CL102 | Storage mit Order 2906 |
| S7 | 2 | 2 | CL100 + CL101 | Multi-Order Retrieval |
| S8 | 2 | 2 | CL100 + CL101 | Multi-Order Storage |
| Other | 1 | 1 | CL103, CL104 | Exklusiv Sonderlabel |

**Widerspruchs-Beispiele:**
```
âŒ S4 + [CL101]                     Szenario verlangt CL100
âŒ S1 + [CL100, CL101]              S1 erlaubt nur 1 Order (nicht Multi)
âŒ S7 + [CL100, CL103]              S7 verlangt CL100 + CL101 (nicht CL103)
âŒ Any Scenario + [CL103, CL104]    No Order und Order Unknown sind exklusiv
```

---

## 5. HIERARCHISCHE MULTI-LABEL-KATEGORIEN

### CC11 â€“ Location â€“ Human

**KardinalitÃ¤t:** Min: 1, Max: 3

**Labels:** CL155â€“CL180 (26 Labels)

**Hierarchie-Struktur:**

**Level 1: Hauptbereiche (1 Label):**
- CL155: Office
- CL156: Base
- CL157: Cart Area
- CL158: Cardboard Box Area
- CL159: Issuing Area
- CL160: Another Logistic Area
- CL161: Location Unknown

**Level 2 (nur wenn Regalgang): Aisle Path (1 Label):**
- CL162: Cross Aisle Path (Quergang)
- CL163: Aisle Path (Regalgang allgemein)

**Level 3 (nur wenn Aisle Path): Aisle Number (1 Label):**
- CL172: Aisle 1
- CL173: Aisle 2
- CL174: Aisle 3
- CL175: Aisle 4
- CL176: Aisle 5

**Level 4 (nur wenn Aisle Path): Position (1 Label):**
- CL177: Front (Vordere Position)
- CL178: Back (Hintere Position)

**Andere Labels:**
- CL179: Another Location
- CL180: Location Unknown

**Validierungsregel:**
```python
def validate_cc11_location_human(location_labels):
    assert 1 <= len(location_labels) <= 3, \
        f"CC11: {len(location_labels)} Labels (benÃ¶tigt 1â€“3)"
    
    aisle_marker = 'CL163'
    aisle_numbers = {'CL172', 'CL173', 'CL174', 'CL175', 'CL176'}
    positions = {'CL177', 'CL178'}
    
    if aisle_marker in location_labels:
        # In Regalgang: Muss 3 Labels haben
        assert len(location_labels) == 3, \
            "CC11: In Regalgang MUSS 3 Labels haben: Aisle + Nummer + Position"
        
        aisle_num = [l for l in location_labels if l in aisle_numbers]
        assert len(aisle_num) == 1, "CC11: Genau 1 Gassennummer"
        
        pos = [l for l in location_labels if l in positions]
        assert len(pos) == 1, "CC11: Genau 1 Position (Front/Back)"
    else:
        # AuÃŸerhalb Regalgang: 1 Label
        assert len(location_labels) == 1, \
            "CC11: AuÃŸerhalb Regalgang genau 1 Bereichs-Label"
    
    return True
```

**Erlaubte Kombinationen:**
```
âœ“ CC11 = [CL155]
  (Office â€” einfacher Bereich)
  
âœ“ CC11 = [CL163, CL174, CL177]
  (Aisle Path + Aisle 3 + Front â€” Regalgang Gasse 3, vorne)
  
âœ“ CC11 = [CL158]
  (Cardboard Box Area â€” einfacher Bereich)
```

**Widerspruchs-Beispiele:**
```
âŒ CC11 = [CL155, CL156]
   (zwei Hauptbereiche â€” exklusiv)
   
âŒ CC11 = [CL163, CL174]
   (Regalgang unvollstÃ¤ndig â€” Position fehlt)
   
âŒ CC11 = [CL163, CL174, CL177, CL178]
   (4 Labels â€” max. 3 erlaubt)
   
âŒ CC11 = [CL155, CL163, CL174, CL177]
   (Mixed: einfacher Bereich + Regalgang â€” nicht kombinierbar)
```

---

### CC12 â€“ Location â€“ Cart

**KardinalitÃ¤t:** Min: 1, Max: 4

**Labels:** CL155â€“CL180 (wie CC11) + CL181

**ZusÃ¤tzliches Label:**
- **CL181: Transition between Areas** (ZonenÃ¼bergang â€” optional)

**Struktur:**
- CC11-Logik (CL155â€“CL180) + optionales CL181 (Transition)
- Max 4 Labels: 3 Base-Labels (Aisle + Nummer + Position) + 1 Transition

**Validierungsregel:**
```python
def validate_cc12_location_cart(location_labels):
    assert 1 <= len(location_labels) <= 4, \
        f"CC12: {len(location_labels)} Labels (benÃ¶tigt 1â€“4)"
    
    transition = 'CL181'
    is_transitioning = transition in location_labels
    base_labels = [l for l in location_labels if l != transition]
    
    aisle_marker = 'CL163'
    aisle_numbers = {'CL172', 'CL173', 'CL174', 'CL175', 'CL176'}
    positions = {'CL177', 'CL178'}
    
    if aisle_marker in base_labels:
        # In Regalgang: 3 Base-Labels
        assert len(base_labels) == 3, \
            "CC12: In Regalgang MUSS 3 Base-Labels haben"
        
        aisle_num = [l for l in base_labels if l in aisle_numbers]
        assert len(aisle_num) == 1, "CC12: Genau 1 Gassennummer"
        
        pos = [l for l in base_labels if l in positions]
        assert len(pos) == 1, "CC12: Genau 1 Position (Front/Back)"
    else:
        # AuÃŸerhalb Regalgang: 1 Base-Label
        assert len(base_labels) == 1, \
            "CC12: AuÃŸerhalb Regalgang genau 1 Bereichs-Label"
    
    return True
```

**Erlaubte Kombinationen:**
```
âœ“ CC12 = [CL155]
  (Wagen im Office)
  
âœ“ CC12 = [CL163, CL173, CL177]
  (Wagen in Regalgang 2, vorne)
  
âœ“ CC12 = [CL163, CL173, CL177, CL181]
  (Wagen Ã¼berquert Zonengrenze in Regalgang 2)
  
âœ“ CC12 = [CL156, CL181]
  (Wagen Ã¼berquert Zone von Base)
```

**Widerspruchs-Beispiele:**
```
âŒ CC12 = [CL163, CL173]
   (Regalgang unvollstÃ¤ndig â€” Position fehlt)
   
âŒ CC12 = [CL181]
   (nur Transition â€” mindestens 1 Bereich erforderlich)
```

---

## 6. WIDERSPRUCHS-MATRIX (Verbotene Kombinationen)

Zusammenfassung aller Kombinationen, die **NICHT erlaubt** sind:

| Kategorie | Verbotene Kombination | Grund |
|-----------|--------|-------|
| **CC01** | Walking (CL011) + Standing (CL015) | Single-Label: exklusiv |
| **CC01** | Scanning (CL005) + Walking (CL011) bei PrioritÃ¤t | Scanning hat Vorrang (PrioritÃ¤tsregel) |
| **CC02** | Gait Cycle (CL016) + Standing Still (CL017) | Single-Label: exklusiv |
| **CC03** | No Bending (CL024) + Strongly Bending (CL026) | Beugungs-Grade exklusiv |
| **CC03** | Torso Rotation (CL027) ohne Biegung | Rotation muss Biegung begleiten |
| **CC04** | 2Ã— Labels aus Position-Gruppe (z.B. CL030 + CL031) | Genau 1 pro Gruppe erforderlich |
| **CC04** | Grasping (CL034) + Holding (CL035) | 2 Movement-Labels: exklusiv |
| **CC04** | 3 Labels statt 4 (z.B. Position + Movement + Object, kein Tool) | Alle 4 Gruppen mÃ¼ssen belegt sein |
| **CC05** | Wie CC04, aber fÃ¼r Right Hand | Identische Logik |
| **CC06** | Order 2904 (CL100) + No Order (CL103) | Specific Order + Sonderlabel: exklusiv |
| **CC06** | No Order (CL103) + Order Unknown (CL104) | Sonderlabels: exklusiv |
| **CC06** | S4 + Order 2905 (CL101) oder CL102 | S4 erfordert zwingend CL100 |
| **CC07** | List + Pen (CL105) + Scanner (CL106) | Nur 1 IT-System zur selben Zeit |
| **CC11** | Office (CL155) + Base (CL156) | 2 Hauptbereiche: exklusiv |
| **CC11** | Aisle Path (CL163) + Gassennummer (CL172) ohne Position (CL177/CL178) | Regalgang-Struktur unvollstÃ¤ndig |
| **CC12** | Nur CL181 (Transition) ohne Bereichs-Label | Transition muss Bereich begleiten |

---

## 7. ABHÃ„NGIGKEITSREGELN ZWISCHEN KATEGORIEN

### Master-Slave-Hierarchie (Prozesse)

**CC08 (High-Level) â†’ CC09 (Mid-Level) â†’ CC10 (Low-Level)**

Diese Kategorien bilden eine strikte Hierarchie:
- **CC08** definiert den Grobprozess (Retrieval vs. Storage)
- **CC09** ist abhÃ¤ngig von CC08: nur gÃ¼ltige Prozesslabels je nach Grobprozess
- **CC10** ist abhÃ¤ngig von CC09: nur gÃ¼ltige Schritt-Labels je nach Prozessphase

**AbhÃ¤ngigkeitsregeln:**

```
CC08 = CL110 (Retrieval)
  â†“
  GÃ¼ltige CC09-Labels:
    - CL114: Preparing Order
    - CL115: Picking â€“ Travel Time
    - CL116: Picking â€“ Pick Time
    - CL118: Packing
    - CL121: Finalizing Order
    
  â†“ (wenn CC09 = CL115)
  GÃ¼ltige CC10-Labels: [Picking-Travel-spezifische Labels]
  
  â†“ (wenn CC09 = CL121)
  GÃ¼ltige CC10-Labels: [Finalizing-spezifische Labels]

---

CC08 = CL111 (Storage)
  â†“
  GÃ¼ltige CC09-Labels:
    - CL117: Unpacking
    - CL119: Storing â€“ Travel Time
    - CL120: Storing â€“ Store Time
    - CL121: Finalizing Order
    
  â†“ (wenn CC09 = CL120)
  GÃ¼ltige CC10-Labels: [Storing-Store-spezifische Labels]
```

**Spezialfall: CL121 (Finalizing Order)**
- GÃ¼ltig in BEIDEN Retrieval (CC08 = CL110) UND Storage (CC08 = CL111)
- Dies ist korrekt und nicht redundant; der Finalisierungsprozess tritt in beiden Szenarien auf

### CC01 als Master fÃ¼r motorische Kategorien

**CC01 (Main Activity) â†’ CC02, CC03, CC04, CC05**

- **CC01** definiert die HauptaktivitÃ¤t
- **CC02â€“CC05** bieten Detaillierung der motorischen Aspekte
- Diese sind relativ unabhÃ¤ngig von CC01, kÃ¶nnen aber kontextabhÃ¤ngig sein

**Beispiel:**
```
CC01 = CL004 (Reaching)
  â†’ CC04/CC05 sollten "Grasping" oder "Reaching" enthalten (konsistent)

CC01 = CL011 (Walking)
  â†’ CC02 sollte "Gait Cycle" enthalten (konsistent)
```

### CC06 â†” CC07 als Szenario-Diskriminatoren

**CC06 (Order) â†” CC07 (Information Technology) â†” CC08 (High-Level Process)**

Diese drei Kategorien sind bei S1â€“S3 eng verknÃ¼pft:
- **CC07** (IT) kann zur Szenario-Erkennung genutzt werden
- **CC06** (Order) folgt oft dem durch CC07 erkannten Szenario
- **CC08** (High-Level) ist szenario-unabhÃ¤ngig, aber kann konsistent mit CC06/CC07 sein

---

## 8. KARDINALITÃ„TS-ZUSAMMENFASSUNG

### Nach Aktivierungstyp

| Typ | Kategorien | Min | Max | Struktur |
|----|-----------|-----|-----|----------|
| **Single-Label (Exklusiv)** | CC01, CC02, CC07, CC08, CC09, CC10 | 1 | 1 | Genau 1 Label |
| **Multi-Label (Optional)** | CC03, CC06 | 1â€“2 | 1â€“2 | Variabel je Szenario/Kontext |
| **Multi-Label (Zwingend)** | CC04, CC05 | 4 | 4 | 4 Gruppen Ã  1 Label |
| **Hierarchisch (Optional)** | CC11 | 1 | 3 | 1 oder Aisle+Nr+Pos |
| **Hierarchisch (Optional+Trans)** | CC12 | 1 | 4 | 1 oder Aisle+Nr+Pos+Transition |

---

## 9. SZENARIO-SPEZIFISCHE AKTIVIERUNGSREGELN

FÃ¼r S1â€“S8 gelten unterschiedliche KardinalitÃ¤ten und AbhÃ¤ngigkeiten.

**Exemplarische Regel fÃ¼r S4 (Storage mit Order 2904):**
```
Frame in Szenario S4:
  CC01: Exactly 1 (Main Activity)
  CC02: Exactly 1 (Leg Movement)
  CC03: 1â€“2 (Torso optional)
  CC04â€“CC05: 4 each (Hands)
  CC06: CL100 (Order 2904 â€” zwingend!)
  CC07: CL108 oder CL109 (No IT / Unknown â€” S4 ist Storage)
  CC08: CL111 (Storage)
  CC09: CL117, CL119, CL120, oder CL121 (Storage-spezifisch)
  CC10: Storage-spezifisches Label
  CC11: 1â€“3 (Location Human)
  CC12: 1â€“4 (Location Cart)
```

Detaillierte Szenario-Regeln: siehe `core_ground_truth_central_v5.0.md`.

---

## 10. METADATEN & REFERENZEN

**Datei-Version:** 5.0  
**Erstellt:** 2026-02-04  
**Status:** finalisiert  
**Quellen:**
- DaRa Dataset Description (PDF, authoritative)
- Annotationsrichtlinien (User-Input, 2026-02-04)
- Validierungslogik (Empirisch verifiziert)

**Verwandte Dateien:**
- `core_labels_207_v5.0.md` â€” VollstÃ¤ndige Definition aller 207 Labels
- `core_ground_truth_central_v5.0.md` â€” Szenario-Definitionen und 5-Schritt Decision-Tree
- `assets_query_patterns_v5.0.md` â€” Such-Muster pro Label und Kategorie

**Ã„nderungshistorie:**
- v5.0 (2026-02-04): Neuerstelle von v2.6.1 mit vollstÃ¤ndiger Kombinationslogik, Widerspruchs-Matrix, AbhÃ¤ngigkeitsregeln und PrioritÃ¤tsregeln

---

**Ende der Datei**
