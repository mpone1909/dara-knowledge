# DaRa Dataset – Kategorien-Aktivierungsmatrix (v2.6.1)

**Zentrale Referenzdatei für Min/Max-Aktivitätslogik aller 12 Klassenkategorien**

**Skill-Version:** 2.6.1 (14.01.2026)  
**Quelle:** DaRa Dataset Description + Annotationsrichtlinien (Benutzer-Input 14.01.2026)

---

## 📋 Schnellübersicht: Min/Max-Matrix

| Kategorie | Min. aktiv | Max. aktiv | Typ | Beschreibung | Validierungsregel |
|-----------|-----------|-----------|-----|--------------|-------------------|
| **CC01** | 1 | 1 | Single | Main Activity | Immer genau 1 Label (Master) |
| **CC02** | 1 | 1 | Single | Legs (Sub-Activity) | Immer genau 1 Label (Slave ← CC01) |
| **CC03** | 1 | 2 | Multi | Torso (Sub-Activity) | 1 Biegung-Label + optional CL027 (Rotation) |
| **CC04** | 4 | 4 | Multi (4 Gruppen) | Left Hand | Immer genau 4 Labels (Position + Movement + Object + Tool) |
| **CC05** | 4 | 4 | Multi (4 Gruppen) | Right Hand | Immer genau 4 Labels (Position + Movement + Object + Tool) |
| **CC06** | 1–2 | 1–2 | Variabel | Order | S1–S3/S4–S6: 1 Label; S7–S8: 2 Labels; Other: CL103/CL104 exklusiv |
| **CC07** | 1 | 1 | Single | Information Technology | Immer genau 1 Label (IT-Diskriminator) |
| **CC08** | 1 | 1 | Single | High-Level Process | Immer genau 1 Label (Master → CC09) |
| **CC09** | 1 | 1 | Single | Mid-Level Process | Immer genau 1 Label (Master → CC10) |
| **CC10** | 1 | 1 | Single | Low-Level Process | Immer genau 1 Label |
| **CC11** | 1 | 3 | Multi (Hierarchisch) | Location – Human | 1 = einfacher Bereich; 3 = Regalgang (Aisle + Nummer + Position) |
| **CC12** | 1 | 4 | Multi (Hierarchisch) | Location – Cart | 1–3 = wie CC11; +1 optional CL181 (Transition) |

**Legende:**
- **Single:** Genau 1 Label pro Frame (exklusiv)
- **Multi:** Mehrere Labels möglich (kombinierbar)
- **Variabel:** Min/Max hängt von Szenario ab
- **Hierarchisch:** Kombination von Hauptbereich + Detailebenen

---

## 1. SINGLE-LABEL-KATEGORIEN (6 Stück)

Diese Kategorien **dürfen nur ein Label pro Frame haben**:

### CC01 – Main Activity

**Min: 1, Max: 1**

```python
if len(active_labels_cc01) != 1:
    raise ValidationError("CC01 muss genau 1 Label haben")
```

**Labels:** CL001–CL015 (15 Labels)

**Rolle:** Master für alle motorischen Kategorien (CC02–CC05)

---

### CC02 – Legs (Sub-Activity)

**Min: 1, Max: 1**

```python
if len(active_labels_cc02) != 1:
    raise ValidationError("CC02 muss genau 1 Label haben")
```

**Labels:** CL016–CL023 (8 Labels)

**Rolle:** Slave ← CC01. Detaillierung der Beinbewegung.

---

### CC07 – Information Technology

**Min: 1, Max: 1**

```python
if len(active_labels_cc07) != 1:
    raise ValidationError("CC07 muss genau 1 Label haben")
```

**Labels:** CL105–CL109 (5 Labels)
- CL105: List + Pen
- CL106: Scanner
- CL107: Portable Data Terminal (PDT)
- CL108: No Information Technology
- CL109: Information Technology Unknown

**Rolle:** Prozess-Diskriminator für Szenarioerkennung (S1–S3)

---

### CC08 – High-Level Process

**Min: 1, Max: 1**

```python
if len(active_labels_cc08) != 1:
    raise ValidationError("CC08 muss genau 1 Label haben")
```

**Labels:** CL110–CL113 (4 Labels)
- CL110: Retrieval (Kommissionierung)
- CL111: Storage (Einlagerung)
- CL112: Another High-Level Process
- CL113: High-Level Process Unknown

**Rolle:** Master für CC09. Definiert Prozesstyp.

---

### CC09 – Mid-Level Process

**Min: 1, Max: 1**

```python
if len(active_labels_cc09) != 1:
    raise ValidationError("CC09 muss genau 1 Label haben")
```

**Labels:** CL114–CL123 (10 Labels)

**Retrieval-Prozesse:**
- CL114: Preparing Order
- CL115: Picking – Travel Time
- CL116: Picking – Pick Time
- CL118: Packing
- CL121: Finalizing Order

**Storage-Prozesse:**
- CL117: Unpacking
- CL119: Storing – Travel Time
- CL120: Storing – Store Time
- CL121: Finalizing Order

**Rolle:** Master für CC10. Hauptdiskriminator für REFA-Zeitarten.

---

### CC10 – Low-Level Process

**Min: 1, Max: 1**

```python
if len(active_labels_cc10) != 1:
    raise ValidationError("CC10 muss genau 1 Label haben")
```

**Labels:** CL124–CL154 (31 Labels)

**Spezial:** CL135 (Error – Report to Supervisor) ist Error-Marker

**Rolle:** Detaillierung von CC09. Atomare Prozessschritte.

---

## 2. MULTI-LABEL-KATEGORIEN MIT FESTER STRUKTUR

### CC03 – Torso (Sub-Activity)

**Min: 1, Max: 2**

```python
def validate_cc03(active_labels):
    assert 1 <= len(active_labels) <= 2, \
        f"CC03 muss 1–2 Labels haben, hat {len(active_labels)}"
    
    # CL027 (Rotation) darf nur mit Biegung kombiniert sein
    if 'CL027' in active_labels:
        bending = {'CL024', 'CL025', 'CL026'} & set(active_labels)
        assert len(bending) >= 1, \
            "CL027 (Rotation) MUSS mit Biegung (CL024–026) kombiniert sein"
    
    return True
```

**Labels:** CL024–CL029 (6 Labels)

**Biegung (Single-Label):**
- CL024: No Bending (< 10°)
- CL025: Slightly Bending (10°–30°)
- CL026: Strongly Bending (> 30°)

**Rotation (Optional-Add-On):**
- CL027: Torso Rotation (nur mit Biegung kombinierbar!)

**Sonstige:**
- CL028: Another Torso Activity
- CL029: Torso Activity Unknown

**Gültige Kombinationen:**
```
CC03 = [CL024]           ✓ Keine Beugung, keine Rotation
CC03 = [CL025]           ✓ Leichte Beugung, keine Rotation
CC03 = [CL026]           ✓ Starke Beugung, keine Rotation
CC03 = [CL025, CL027]    ✓ Leichte Beugung + Rotation
CC03 = [CL026, CL027]    ✓ Starke Beugung + Rotation
CC03 = [CL027]           ✗ UNGÜLTIG: Rotation ohne Biegung!
```

**Rolle:** Primäre Quelle für Haltungs-Erholungszeit ($t_{er}$)

---

### CC04 – Left Hand (Sub-Activity)

**Min: 4, Max: 4**

```python
def validate_cc04(active_labels):
    assert len(active_labels) == 4, \
        f"CC04 muss genau 4 Labels haben, hat {len(active_labels)}"
    
    # Validiere 4 Untergruppen
    position = [l for l in active_labels if l in range(CL030, CL034)]
    movement = [l for l in active_labels if l in range(CL034, CL040)]
    object_ = [l for l in active_labels if l in range(CL040, CL052)]
    tool = [l for l in active_labels if l in range(CL052, CL065)]
    
    assert len(position) == 1, f"Position: {len(position)} Label (benötigt 1)"
    assert len(movement) == 1, f"Movement: {len(movement)} Label (benötigt 1)"
    assert len(object_) == 1, f"Object: {len(object_)} Label (benötigt 1)"
    assert len(tool) == 1, f"Tool: {len(tool)} Label (benötigt 1)"
    
    return True
```

**Labels:** CL030–CL064 (35 Labels, in 4 Untergruppen)

**Untergruppe 1: Primary Position (4 Labels)**
- CL030: Upwards
- CL031: Centered
- CL032: Downwards
- CL033: Position Unknown

**Untergruppe 2: Type of Movement (6 Labels)**
- CL034: Reaching, Grasping, Moving, Positioning, Releasing
- CL035: Manipulating
- CL036: Holding
- CL037: **No Movement** ← Hand inaktiv, aber andere Labels erforderlich!
- CL038: Another Movement
- CL039: Movement Unknown

**Untergruppe 3: Object (12 Labels)**
- CL040: No Object
- CL041: Large Item (> 5–10 kg)
- CL042: Medium Item (1–5 kg)
- CL043: Small Item (< 1 kg)
- CL044: Tool
- CL045: Cart
- CL046: Load Carrier
- CL047: Cardboard Box
- CL048: On Body
- CL049: Another Logistic Object
- CL050: No Logistic Object
- CL051: Object Unknown

**Untergruppe 4: Tool (13 Labels)**
- CL052: Portable Data Terminal
- CL053: Glove Scanner
- CL054: Plastic Bag
- CL055: Picking List
- CL056: Pen
- CL057: Button
- CL058: Computer
- CL059: Bubble Wrap
- CL060: Tape Dispenser
- CL061: Knife
- CL062: Shipping/Return Label
- CL063: Elastic Band
- CL064: Another Tool

**Beispiel – Aktive Hand (Greifen):**
```
CC04 = [CL031 (Centered), CL034 (Grasping), CL043 (Small Item), CL056 (Pen)]
Count: 4 ✓
```

**Beispiel – Inaktive Hand (No Movement):**
```
CC04 = [CL031 (Centered), CL037 (No Movement), CL040 (No Object), CL064 (Another Tool)]
Count: 4 ✓  ← Trotz Inaktivität alle 4 Gruppen belegt!
```

**Rolle:** Detaillierung der Mensch-Objekt-Interaktion. Lastklasse für Erholungszeit.

---

### CC05 – Right Hand (Sub-Activity)

**Min: 4, Max: 4**

**Struktur:** Identisch zu CC04, aber Labels CL065–CL099

(Siehe CC04 für Logik)

**Rolle:** Detaillierung der rechten Hand.

---

## 3. SZENARIO-ABHÄNGIGE MULTI-LABEL-KATEGORIEN

### CC06 – Order

**Min/Max je nach Szenario:**

```python
def validate_cc06_order(scenario, active_orders):
    # S1–S3: Single-Order Retrieval
    if scenario in ['S1', 'S2', 'S3']:
        assert len(active_orders) == 1, \
            f"{scenario}: 1 Order erforderlich (Single-Order)"
        assert active_orders[0] in ['CL100', 'CL101', 'CL102']
    
    # S4–S6: Single-Order Storage
    elif scenario == 'S4':
        assert active_orders == ['CL100'], "S4: Order muss CL100 (2904) sein"
    elif scenario == 'S5':
        assert active_orders == ['CL101'], "S5: Order muss CL101 (2905) sein"
    elif scenario == 'S6':
        assert active_orders == ['CL102'], "S6: Order muss CL102 (2906) sein"
    
    # S7–S8: Multi-Order
    elif scenario in ['S7', 'S8']:
        assert len(active_orders) == 2, \
            f"{scenario}: Genau 2 Orders erforderlich (Multi-Order)"
        assert set(active_orders) == {'CL100', 'CL101'}, \
            f"{scenario}: Orders müssen CL100 + CL101 (2904+2905) sein"
    
    # Other / Unknown
    elif scenario in ['Other', 'Unknown']:
        assert len(active_orders) == 1
        assert active_orders[0] in ['CL103', 'CL104']
    
    return True
```

**Labels:** CL100–CL104 (5 Labels)

**Spezifische Orders:**
- CL100: Order 2904
- CL101: Order 2905
- CL102: Order 2906

**Sonderlabels:**
- CL103: No Order (z.B. Setup-Phase)
- CL104: Order Unknown

**Szenarien-Mapping:**

| Szenario | Min | Max | Labels | Regel |
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

**Rolle:** Verknüpfung mit Geschäftsfall. Szenario-Diskriminator (S4–S6).

---

## 4. HIERARCHISCHE MULTI-LABEL-KATEGORIEN

### CC11 – Location – Human

**Min: 1, Max: 3**

```python
def validate_cc11_location_human(location_labels):
    assert 1 <= len(location_labels) <= 3, \
        f"CC11: {len(location_labels)} Labels (benötigt 1–3)"
    
    # Regalgang-Check
    aisle_marker = 'CL163'  # Aisle Path
    aisle_numbers = {'CL172', 'CL173', 'CL174', 'CL175', 'CL176'}  # Gasse 1–5
    positions = {'CL177', 'CL178'}  # Front/Back
    
    if aisle_marker in location_labels:
        # In Regalgang: Muss 3 Labels haben
        assert len(location_labels) == 3, \
            "CC11: In Regalgang MUSS 3 Labels haben: Aisle + Nummer + Position"
        
        # Genau 1 Gassennummer
        aisle_num = [l for l in location_labels if l in aisle_numbers]
        assert len(aisle_num) == 1, "CC11: Genau 1 Gassennummer erforderlich"
        
        # Genau 1 Position
        pos = [l for l in location_labels if l in positions]
        assert len(pos) == 1, "CC11: Genau 1 Position (Front/Back) erforderlich"
    else:
        # Außerhalb Regalgang: 1 Label
        assert len(location_labels) == 1, \
            "CC11: Außerhalb Regalgang genau 1 Bereichs-Label"
    
    return True
```

**Labels:** CL155–CL180 (26 Labels)

**Hauptbereiche (Einfache Bereiche = 1 Label):**
- CL155: Office
- CL156: Base
- CL157: Cart Area
- CL158: Cardboard Box Area
- CL159: Issuing Area
- CL160: Another Logistic Area
- CL161: Location Unknown

**Regalgang-Struktur (3 Labels wenn aktiv):**

1. **Aisle Path (1 Label):**
   - CL163: Aisle Path (Regalgang allgemein)

2. **Cross Aisle Path (1 Label):**
   - CL162: Cross Aisle Path (Quergang)
   - Oder: **Aisle Path + eine Nummer** (siehe 3.)

3. **Aisle Numbers (Gasse 1–5, 1 Label):**
   - CL172: Aisle 1
   - CL173: Aisle 2
   - CL174: Aisle 3
   - CL175: Aisle 4
   - CL176: Aisle 5

4. **Position im Regalgang (1 Label):**
   - CL177: Front (Vordere Position)
   - CL178: Back (Hintere Position)

**Andere Labels:**
- CL179: Another Location
- CL180: Location Unknown

**Beispiele:**

```
Szenario 1: Person im Büro
  CC11 = [CL155]
  Count: 1 ✓

Szenario 2: Person in Regalgang 3, vorne
  CC11 = [CL163, CL174, CL177]
  Count: 3 ✓
  - CL163: Aisle Path
  - CL174: Gasse 3
  - CL177: Front

Szenario 3: Person in Verpackungsbereich
  CC11 = [CL158]
  Count: 1 ✓

Szenario 4 (UNGÜLTIG): Person mit Aisle aber ohne Position
  CC11 = [CL163, CL174]
  Count: 2 ✗ FEHLER
```

**Rolle:** Räumliche Lokalisation für Wegzeit-Validierung.

---

### CC12 – Location – Cart

**Min: 1, Max: 4**

```python
def validate_cc12_location_cart(location_labels):
    assert 1 <= len(location_labels) <= 4, \
        f"CC12: {len(location_labels)} Labels (benötigt 1–4)"
    
    # Transition optional
    transition = 'CL181'  # Transition between Areas
    is_transitioning = transition in location_labels
    base_labels = [l for l in location_labels if l != transition]
    
    # Analog zu CC11 für Base-Labels
    aisle_marker = 'CL163'
    aisle_numbers = {'CL172', 'CL173', 'CL174', 'CL175', 'CL176'}
    positions = {'CL177', 'CL178'}
    
    if aisle_marker in base_labels:
        # In Regalgang: 3 Base-Labels + optional 1 Transition = max 4
        assert len(base_labels) == 3, \
            "CC12: In Regalgang MUSS 3 Base-Labels haben"
        
        aisle_num = [l for l in base_labels if l in aisle_numbers]
        assert len(aisle_num) == 1, "CC12: Genau 1 Gassennummer"
        
        pos = [l for l in base_labels if l in positions]
        assert len(pos) == 1, "CC12: Genau 1 Position (Front/Back)"
    else:
        # Außerhalb Regalgang: 1 Base-Label + optional 1 Transition = max 2
        assert len(base_labels) == 1, \
            "CC12: Außerhalb Regalgang genau 1 Bereichs-Label"
    
    return True
```

**Labels:** CL155–CL180 (wie CC11) + CL181

**Zusätzliches Label:**
- **CL181: Transition between Areas** (Zonenübergang – optional)

**Struktur:**
- CC11-Labels (CL155–CL180) + optionales CL181 (Transition)

**Max 4 Labels:**
- Einfacher Bereich + Transition = 2 Labels
- Regalgang (Aisle + Nummer + Position) + Transition = 4 Labels

**Beispiele:**

```
Szenario 1: Wagen im Büro
  CC12 = [CL155]
  Count: 1 ✓

Szenario 2: Wagen in Regalgang 2
  CC12 = [CL163, CL173, CL177]
  Count: 3 ✓
  - CL163: Aisle Path
  - CL173: Gasse 2
  - CL177: Front

Szenario 3: Wagen überquert Zonengrenze
  CC12 = [CL163, CL173, CL177, CL181]
  Count: 4 ✓
  - CL163: Aisle Path
  - CL173: Gasse 2
  - CL177: Front
  - CL181: Transition between Areas

Szenario 4: Wagen in Base mit Transition
  CC12 = [CL156, CL181]
  Count: 2 ✓
  - CL156: Base
  - CL181: Transition
```

**Rolle:** Räumliche Lokalisation des Wagens inkl. Zonenübergänge.

---

## 5. ZUSAMMENFASSUNG: AKTIVIERUNGSPRINZIPIEN

### Prinzip 1: Single-Label-Kategorien (6)

**CC01, CC02, CC07, CC08, CC09, CC10**

→ Immer genau 1 Label pro Frame

---

### Prinzip 2: Torso-Multi-Label (CC03)

**Min 1, Max 2**

→ 1 Biegung-Label (CL024–CL026) + optional Rotation (CL027)
→ Rotation MUSS mit Biegung kombiniert sein

---

### Prinzip 3: Hand-Gruppen-Multi-Label (CC04, CC05)

**Min 4, Max 4**

→ Immer genau 4 Labels: Position + Movement + Object + Tool
→ Auch wenn Hand inaktiv (CL037), müssen alle 4 Gruppen belegt sein

---

### Prinzip 4: Szenario-abhängiges Order-Label (CC06)

**Min/Max variabel**

→ S1–S3: 1 Label (beliebige Order)
→ S4–S6: 1 Label (szenario-spezifische Order)
→ S7–S8: 2 Labels (immer CL100 + CL101)
→ Other: 1 Sonderlabel (CL103 oder CL104)

---

### Prinzip 5: Hierarchische Location-Labels (CC11, CC12)

**CC11: Min 1, Max 3**
**CC12: Min 1, Max 4**

→ Einfache Bereiche: 1 Label
→ Regalgang: 3 Base-Labels (Aisle + Nummer + Position)
→ CC12 zusätzlich: +1 Transition optional

---

## Metadaten

**Datei-Version:** 1.0  
**Erstellt:** 14.01.2026  
**Quellen:**
- DaRa Dataset Description (Stand 20.10.2025)
- Annotationsrichtlinien (Benutzer-Input 14.01.2026)
- Validierungslogik (validation_rules.md v1.1)

**Verwandte Dateien:**
- `labels_207.md` – Struktur und Label-Definitionen
- `validation_rules.md` – Validierungslogik und Pseudocode
- `ground_truth_central.md` – Szenario-Definitionen
