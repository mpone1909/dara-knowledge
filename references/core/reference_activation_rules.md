# DaRa Dataset — Aktivierungsregeln & Kardinalität

**Quelle:** DaRa Dataset Description + labels_207 (autoritativ)
**Skill-Version:** 6.0
**Erstellt:** 26.02.2026
**Hinweis:** Alle Label-Beschreibungen verifiziert gegen reference_labels.md

---

## 1. SCHNELLÜBERSICHT: Min/Max-Matrix

| Kategorie | Min | Max | Typ | Beschreibung | Kardinalität-Regel |
|-----------|-----|-----|-----|--------------|-------------------|
| **CC01** | 1 | 1 | Single | Main Activity | Genau 1 Label (Exklusiv) |
| **CC02** | 1 | 1 | Single | Legs | Genau 1 Label (Exklusiv) |
| **CC03** | 1 | 2 | Multi | Torso | 1 Beugungs-Label + optional CL027 (Rotation) |
| **CC04** | 4 | 4 | Multi (4 Gruppen) | Left Hand | Genau 4 Labels (Position + Movement + Object + Tool) |
| **CC05** | 4 | 4 | Multi (4 Gruppen) | Right Hand | Genau 4 Labels (Position + Movement + Object + Tool) |
| **CC06** | 1–2 | 1–2 | Variabel | Order | Abhängig von Szenario (S1-S6: 1, S7-S8: 2) |
| **CC07** | 1 | 1 | Single | Information Technology | Genau 1 Label (Exklusiv) |
| **CC08** | 1 | 1 | Single | High-Level Process | Genau 1 Label (Master → CC09) |
| **CC09** | 1 | 1 | Single | Mid-Level Process | Genau 1 Label (Master → CC10) |
| **CC10** | 1 | 1 | Single | Low-Level Process | Genau 1 Label (abhängig von CC09) |
| **CC11** | 1 | 3 | Hierarchisch | Location Human | 1 Bereich oder 3 (Aisle + Nummer + Position) |
| **CC12** | 1 | 4 | Hierarchisch | Location Cart | Wie CC11 + optional CL181 (Transition) |

### Nach Aktivierungstyp

| Typ | Kategorien | Min | Max |
|----|-----------|-----|-----|
| **Single-Label (Exklusiv)** | CC01, CC02, CC07, CC08, CC09, CC10 | 1 | 1 |
| **Multi-Label (Optional)** | CC03, CC06 | 1–2 | 1–2 |
| **Multi-Label (Zwingend)** | CC04, CC05 | 4 | 4 |
| **Hierarchisch** | CC11 | 1 | 3 |
| **Hierarchisch + Transition** | CC12 | 1 | 4 |

---

## 2. SINGLE-LABEL-KATEGORIEN

Diese Kategorien dürfen **nur ein Label pro Frame** haben.

### CC01 — Main Activity (15 Labels: CL001–CL015)

- CL001: Synchronization
- CL002: Confirming with Pen
- CL003: Confirming with Screen
- CL004: Confirming with Button
- CL005: Scanning
- CL006: Pulling Cart
- CL007: Pushing Cart
- CL008: Handling Upwards
- CL009: Handling Centered
- CL010: Handling Downwards
- CL011: Walking
- CL012: Standing
- CL013: Sitting
- CL014: Another Main Activity
- CL015: Main Activity Unknown

**Rolle:** Master für motorische Kategorien (CC02–CC05).

**Prioritätsregel bei Mehrdeutigkeit:**
```
Sync > Confirming > Scanning > Cart (Pushing/Pulling) > Handling > Walking/Standing
```

**Validierung:**
```python
if len(active_labels_cc01) != 1:
    raise ValidationError("CC01 muss genau 1 Label haben")
```

### CC02 — Legs (8 Labels: CL016–CL023)

- CL016: Gait Cycle
- CL017: Step
- CL018: Standing Still
- CL019: Sitting
- CL020: Squat
- CL021: Lunges
- CL022: Another Leg Activity
- CL023: Leg Activity Unknown

**Rolle:** Slave von CC01. Detaillierung der Beinbewegung.

### CC07 — Information Technology (5 Labels: CL105–CL109)

- CL105: List and Pen
- CL106: List and Glove Scanner
- CL107: Portable Data Terminal (PDT)
- CL108: No Information Technology
- CL109: Information Technology Unknown

**Rolle:** Szenario-Diskriminator für S1–S3.

### CC08 — High-Level Process (4 Labels: CL110–CL113)

- CL110: Retrieval (Kommissionierung)
- CL111: Storage (Einlagerung)
- CL112: Another High-Level Process
- CL113: High-Level Process Unknown

**Rolle:** Master für CC09.

### CC09 — Mid-Level Process (10 Labels: CL114–CL123)

**Retrieval-Prozesse (wenn CC08 = CL110):**
- CL114: Preparing Order (shared mit Storage)
- CL115: Picking — Travel Time
- CL116: Picking — Pick Time
- CL118: Packing
- CL121: Finalizing Order (shared mit Storage)

**Storage-Prozesse (wenn CC08 = CL111):**
- CL114: Preparing Order (shared mit Retrieval)
- CL117: Unpacking
- CL119: Storing — Travel Time
- CL120: Storing — Store Time
- CL121: Finalizing Order (shared mit Retrieval)

**Sonstige:** CL122 Another Mid-Level, CL123 Mid-Level Unknown

**Rolle:** Master für CC10. Hauptdiskriminator für REFA-Zeitarten.

### CC10 — Low-Level Process (31 Labels: CL124–CL154)

- CL124: Collecting Order and Hardware
- CL125: Collecting Cart
- CL126: Collecting Empty Cardboard Boxes
- CL127: Collecting Packed Cardboard Boxes
- CL128: Transporting a Cart to the Base
- CL129: Transporting to the Packaging/Sorting Area
- CL130: Handing Over Packed Cardboard Boxes
- CL131: Returning Empty Cardboard Boxes
- CL132: Returning Cart
- CL133: Returning Hardware
- CL134: Waiting (Global Interrupt — siehe phase1, CL134 = t_w/t_s in REFA)
- CL135: Reporting and Clarifying the Incident
- CL136: Removing Cardboard Box/Item from the Cart
- CL137: Moving to the Next Position
- CL138: Placing Items on a Rack
- CL139: Retrieving Items
- CL140: Moving to a Cart
- CL141: Placing Cardboard Box/Item on a Table
- CL142: Opening Cardboard Box
- CL143: Disposing of Filling Material or Shipping Label
- CL144: Sorting
- CL145: Filling Cardboard Box with Filling Material
- CL146: Printing Shipping Label and Return Slip
- CL147: Preparing or Adding Return Label
- CL148: Attaching Shipping Label
- CL149: Removing Elastic Band
- CL150: Sealing Cardboard Box
- CL151: Placing Cardboard Box/Item in a Cart
- CL152: Tying Elastic Band Around Cardboard
- CL153: Another Low-Level Process
- CL154: Low-Level Process Unknown

**Rolle:** Atomare Prozessschritte. CC09→CC10 Mapping siehe phase4_bpmn_validation.md (V-B3).

**⚠️ Wichtig — Nicht-Exklusivität:** Low-Level-Prozesse (CC10) sind **nicht exklusiv** an einzelne Mid-Level-Prozesse (CC09) gebunden. Derselbe Low-Level-Prozess kann in verschiedenen Mid-Level-Kontexten auftreten. Beispiel: CL137 (Moving to Next Position) tritt sowohl in CL115 (Pick Travel) als auch in CL119 (Store Travel) auf. Das CC09→CC10-Mapping in phase4_bpmn_validation.md (V-B3) definiert erlaubte Kombinationen, aber keine Exklusivzuordnung.

---

## 3. MULTI-LABEL-KATEGORIEN MIT FESTER STRUKTUR

### CC03 — Torso (6 Labels: CL024–CL029)

**Struktur:**
- **Beugungs-Labels (genau 1 erforderlich):**
  - CL024: No Bending (< 10°)
  - CL025: Slightly Bending (10°–30°)
  - CL026: Strongly Bending (> 30°)
- **Rotations-Label (optional, nur MIT Beugung):**
  - CL027: Torso Rotation
- **Sonstige:**
  - CL028: Another Torso Activity
  - CL029: Torso Activity Unknown

**Validierung:**
```python
def validate_cc03(active_labels):
    assert 1 <= len(active_labels) <= 2, \
        f"CC03 muss 1–2 Labels haben, hat {len(active_labels)}"
    
    if 'CL027' in active_labels:
        bending = {'CL024', 'CL025', 'CL026'} & set(active_labels)
        assert len(bending) >= 1, \
            "CL027 (Rotation) MUSS mit Biegung kombiniert sein"
    
    return True
```

**Erlaubte Kombinationen:**
```
✅ [CL024]               Keine Beugung, keine Rotation
✅ [CL025]               Leichte Beugung
✅ [CL026]               Starke Beugung
✅ [CL025, CL027]        Leichte Beugung + Rotation
✅ [CL026, CL027]        Starke Beugung + Rotation
```

**Verboten:**
```
✗ [CL027]               Rotation ohne Biegung
✗ [CL024, CL026]        Zwei Beugungsgrade (exklusiv)
```

### CC04 — Left Hand (35 Labels: CL030–CL064)

**Immer genau 4 Labels aktiv, je 1 pro Untergruppe:**

**1. Position (genau 1 aus CL030–CL033):**
- CL030: Upwards
- CL031: Centered
- CL032: Downwards
- CL033: Position Unknown

**2. Movement (genau 1 aus CL034–CL039):**
- CL034: Reaching, Grasping, Moving, Positioning, Releasing
- CL035: Manipulating
- CL036: Holding
- CL037: No Movement
- CL038: Another Movement
- CL039: Movement Unknown

**3. Object (genau 1 aus CL040–CL051):**
- CL040: No Object
- CL041: Large Item
- CL042: Medium Item
- CL043: Small Item
- CL044: Tool
- CL045: Cart
- CL046: Load Carrier
- CL047: Cardboard Box
- CL048: On Body
- CL049: Another Logistic Object
- CL050: No Logistic Object
- CL051: Object Unknown

**4. Tool (genau 1 aus CL052–CL064):**
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

**Validierung:**
```python
def validate_cc04(active_labels):
    assert len(active_labels) == 4, \
        f"CC04 muss genau 4 Labels haben, hat {len(active_labels)}"
    
    position = [l for l in active_labels if l in range(CL030, CL034)]
    movement = [l for l in active_labels if l in range(CL034, CL040)]
    object_  = [l for l in active_labels if l in range(CL040, CL052)]
    tool     = [l for l in active_labels if l in range(CL052, CL065)]
    
    assert len(position) == 1, f"Position: benötigt 1, hat {len(position)}"
    assert len(movement) == 1, f"Movement: benötigt 1, hat {len(movement)}"
    assert len(object_)  == 1, f"Object: benötigt 1, hat {len(object_)}"
    assert len(tool)     == 1, f"Tool: benötigt 1, hat {len(tool)}"
    
    return True
```

**Erlaubte Kombinationen:**
```
✅ [CL031, CL034, CL043, CL056]  Centered + Grasping + Small Item + Pen
✅ [CL031, CL037, CL040, CL064]  Centered + No Movement + No Object + Another Tool
   (Trotz Inaktivität müssen alle 4 Gruppen belegt sein!)
```

**Verboten:**
```
✗ [CL031, CL034, CL035, CL043, CL056]  5 Labels statt 4
✗ [CL031, CL034, CL043]                  3 Labels — Tool-Gruppe fehlt
✗ [CL030, CL031, CL034, CL043, CL056]  2 Position-Labels (exklusiv)
```

### CC05 — Right Hand (35 Labels: CL065–CL099)

Struktur identisch zu CC04, aber mit Label-Range CL065–CL099:
- Position: CL065–CL068
- Movement: CL069–CL074
- Object: CL075–CL086
- Tool: CL087–CL099

Validierung identisch zu CC04.

---

## 4. SZENARIO-ABHÄNGIGES ORDER-LABEL (CC06)

**Labels:** CL100–CL104

- CL100: Order 2904
- CL101: Order 2905
- CL102: Order 2906
- CL103: No Order
- CL104: Order Unknown

**Validierung (szenario-abhängig):**
```python
def validate_cc06(active_orders, scenario):
    # S1–S3: Single-Order, jede der 3 Orders möglich
    if scenario in ['S1', 'S2', 'S3']:
        assert len(active_orders) == 1
        assert active_orders[0] in ['CL100', 'CL101', 'CL102']
    
    # S4–S6: Feste Order-Zuordnung
    elif scenario == 'S4':
        assert active_orders == ['CL100']  # Order 2904
    elif scenario == 'S5':
        assert active_orders == ['CL101']  # Order 2905
    elif scenario == 'S6':
        assert active_orders == ['CL102']  # Order 2906
    
    # S7–S8: Multi-Order (genau CL100 + CL101)
    elif scenario in ['S7', 'S8']:
        assert len(active_orders) == 2
        assert set(active_orders) == {'CL100', 'CL101'}
    
    # Other: Sonderlabels
    elif scenario in ['Other_Waiting', 'Other_Process', 'Other_NoData']:
        assert active_orders[0] in ['CL103', 'CL104']
    
    return True
```

**Szenario-Mapping:**

| Szenario | Min | Max | Gültige Labels | Regel |
|----------|-----|-----|--------|-------|
| S1 | 1 | 1 | CL100, CL101, CL102 | Retrieval + IT-Diskriminator |
| S2 | 1 | 1 | CL100, CL101, CL102 | Retrieval + IT-Diskriminator |
| S3 | 1 | 1 | CL100, CL101, CL102 | Retrieval + IT-Diskriminator |
| S4 | 1 | 1 | CL100 | Storage + Order 2904 |
| S5 | 1 | 1 | CL101 | Storage + Order 2905 |
| S6 | 1 | 1 | CL102 | Storage + Order 2906 |
| S7 | 2 | 2 | CL100 + CL101 | Multi-Order Retrieval |
| S8 | 2 | 2 | CL100 + CL101 | Multi-Order Storage |
| Other | 1 | 1 | CL103, CL104 | Sonderlabel (exklusiv) |

---

## 5. HIERARCHISCHE LOCATION-KATEGORIEN

### CC11 — Location Human (26 Labels: CL155–CL180)

**Level 1 — Hauptbereiche (genau 1, wenn nicht in Regalgang):**
- CL155: Office
- CL156: Cart Area
- CL157: Cardboard Box Area
- CL158: Base
- CL159: Packing/Sorting Area
- CL160: Issuing/Receiving Area
- CL161: Path (allgemein)
- CL162: Cross Aisle Path
- CL163: Aisle Path (Regalgang)

**Level 1a — Path Sub-Areas (Kinder von CL161):**
- CL164: Path (Office)
- CL165: Path (Cardboard Box Area)
- CL166: Path (Cart Area)
- CL167: Path (Issuing Area)

**Level 1b — Cross Aisle Sub-Areas (Kinder von CL162):**
- CL168: 1-2 (zwischen Aisle 1 und 2)
- CL169: 2-3
- CL170: 3-4
- CL171: 4-5

**Level 2 — Aisle Number (nur wenn CL163 aktiv, genau 1):**
- CL172: Aisle 1
- CL173: Aisle 2
- CL174: Aisle 3
- CL175: Aisle 4
- CL176: Aisle 5

**Level 3 — Position (nur wenn CL163 aktiv, genau 1):**
- CL177: Front Position
- CL178: Back Position

**Sonstige:**
- CL179: Another Location
- CL180: Location Unknown

**Validierung:**
```python
def validate_cc11(location_labels):
    assert 1 <= len(location_labels) <= 3, \
        f"CC11: {len(location_labels)} Labels (benötigt 1–3)"
    
    if 'CL163' in location_labels:  # Aisle Path
        assert len(location_labels) == 3, \
            "CC11: In Regalgang MUSS 3 Labels haben (CL163 + Aisle + Position)"
        
        aisle_nums = {'CL172', 'CL173', 'CL174', 'CL175', 'CL176'}
        positions  = {'CL177', 'CL178'}
        
        assert len(aisle_nums & set(location_labels)) == 1, "Genau 1 Gassennummer"
        assert len(positions & set(location_labels)) == 1, "Genau 1 Position"
    else:
        assert len(location_labels) == 1, \
            "CC11: Außerhalb Regalgang genau 1 Bereichs-Label"
    
    return True
```

**Erlaubte Kombinationen:**
```
✅ [CL155]                    Office
✅ [CL158]                    Base
✅ [CL163, CL174, CL177]     Aisle Path + Aisle 3 + Front
✅ [CL163, CL172, CL178]     Aisle Path + Aisle 1 + Back
```

**Verboten:**
```
✗ [CL155, CL156]             Zwei Hauptbereiche gleichzeitig
✗ [CL163, CL174]             Regalgang unvollständig (Position fehlt)
✗ [CL155, CL163, CL174, CL177]  Mixed: Bereich + Regalgang
```

### CC12 — Location Cart (27 Labels: CL181–CL207)

**WICHTIG:** CC12 hat EIGENE Labels (CL181–CL207), parallel zu CC11 (CL155–CL180).

**CL181 — Transition between Areas (nur CC12, kein Pendant in CC11):**
Erfasst den Zeitraum, in dem der Wagen eine Bereichsgrenze überquert.
CL181 tritt IMMER gemeinsam mit einem Orts-Label auf (nie allein).

**Level 1 — Hauptbereiche:**
- CL182: Office
- CL183: Cart Area
- CL184: Cardboard Box Area
- CL185: Base
- CL186: Packing/Sorting Area
- CL187: Issuing/Receiving Area
- CL188: Path
- CL189: Cross Aisle Path
- CL190: Aisle Path

**Path Sub-Areas (Kinder von CL188):**
- CL191: Path (Office)
- CL192: Path (Cardboard Box Area)
- CL193: Path (Cart Area)
- CL194: Path (Issuing Area)

**Cross Aisle Sub-Areas (Kinder von CL189):**
- CL195: 1-2
- CL196: 2-3
- CL197: 3-4
- CL198: 4-5

**Aisle Number (nur wenn CL190 aktiv):**
- CL199: Aisle 1
- CL200: Aisle 2
- CL201: Aisle 3
- CL202: Aisle 4
- CL203: Aisle 5

**Position (nur wenn CL190 aktiv):**
- CL204: Front Position
- CL205: Back Position

**Sonstige:**
- CL206: Another Location — Cart
- CL207: Cart Location Unknown

**Validierung:**
```python
def validate_cc12(location_labels):
    assert 1 <= len(location_labels) <= 4, \
        f"CC12: {len(location_labels)} Labels (benötigt 1–4)"
    
    is_transitioning = 'CL181' in location_labels
    base_labels = [l for l in location_labels if l != 'CL181']
    
    assert len(base_labels) >= 1, "CC12: Mindestens 1 Orts-Label neben CL181"
    
    if 'CL190' in base_labels:  # Aisle Path (Cart)
        assert len(base_labels) == 3, \
            "CC12: In Regalgang MUSS 3 Orts-Labels haben (CL190 + Aisle + Position)"
        
        aisle_nums = {'CL199', 'CL200', 'CL201', 'CL202', 'CL203'}
        positions  = {'CL204', 'CL205'}
        
        assert len(aisle_nums & set(base_labels)) == 1, "Genau 1 Gassennummer"
        assert len(positions & set(base_labels)) == 1, "Genau 1 Position"
    else:
        assert len(base_labels) == 1, \
            "CC12: Außerhalb Regalgang genau 1 Bereichs-Label"
    
    return True
```

**Erlaubte Kombinationen:**
```
✅ [CL185]                          Wagen an Base
✅ [CL190, CL201, CL204]           Wagen in Aisle 3, Front
✅ [CL181, CL186]                   Wagen überquert Grenze bei Packing Area
✅ [CL181, CL190, CL200, CL205]    Wagen überquert Grenze in Aisle 2, Back
```

**Verboten:**
```
✗ [CL181]                          Transition allein (Orts-Label fehlt)
✗ [CL190, CL201]                   Regalgang unvollständig (Position fehlt)
✗ [CL182, CL183]                   Zwei Hauptbereiche gleichzeitig
```

---

## 6. WIDERSPRUCHSMATRIX

| Kategorie | Verbotene Kombination | Grund |
|-----------|----------------------|-------|
| **CC01** | CL011 (Walking) + CL012 (Standing) | Single-Label: exklusiv |
| **CC02** | CL016 (Gait Cycle) + CL018 (Standing Still) | Single-Label: exklusiv |
| **CC03** | CL024 (No Bending) + CL026 (Strongly Bending) | Beugungsgrade exklusiv |
| **CC03** | CL027 (Rotation) allein ohne Biegung | Rotation erfordert Biegung |
| **CC04** | 2× Labels aus Position-Gruppe (CL030 + CL031) | Genau 1 pro Subgruppe |
| **CC04** | CL034 (Grasping) + CL036 (Holding) | Movement exklusiv |
| **CC04** | Nur 3 Labels (Tool-Gruppe fehlt) | Alle 4 Gruppen zwingend |
| **CC05** | Analog zu CC04 | Identische Logik |
| **CC06** | CL100 + CL103 (Order + No Order) | Specific + Sonderlabel exklusiv |
| **CC06** | CL103 + CL104 (No Order + Unknown) | Sonderlabels untereinander exklusiv |
| **CC06** | S4 + CL101 | S4 erfordert zwingend CL100 |
| **CC07** | CL105 + CL106 | Nur 1 IT-System gleichzeitig |
| **CC11** | CL155 + CL156 | Zwei Hauptbereiche exklusiv |
| **CC11** | CL163 + CL172 ohne CL177/CL178 | Regalgang-Struktur unvollständig |
| **CC12** | Nur CL181 ohne Bereichs-Label | Transition braucht Ortsangabe |
| **CC12** | CL182 + CL183 | Zwei Hauptbereiche exklusiv |

---

## 7. ABHÄNGIGKEITSREGELN ZWISCHEN KATEGORIEN

### Master-Slave: CC08 → CC09 → CC10

```
CC08 = CL110 (Retrieval)
  → Gültige CC09: CL114, CL115, CL116, CL118, CL121
  → CC10 abhängig von CC09 (siehe V-B3 in phase4_bpmn_validation.md)

CC08 = CL111 (Storage)
  → Gültige CC09: CL114, CL117, CL119, CL120, CL121
  → CC10 abhängig von CC09

CL114 (Preparing) und CL121 (Finalizing) sind für BEIDE Pfade gültig.
```

### Master-Slave: CC01 → CC02–CC05

CC01 definiert die Hauptaktivität. CC02–CC05 bieten motorische Details.
Typische (aber nicht deterministische) Korrelationen:

```
CC01 = CL011 (Walking) → CC02 typisch CL016 (Gait Cycle) oder CL017 (Step)
CC01 = CL012 (Standing) → CC02 typisch CL018 (Standing Still)
CC01 = CL013 (Sitting) → CC02 typisch CL019 (Sitting)
```

### Szenario-Diskriminatoren: CC06 ↔ CC07 ↔ CC08

Bei S1–S3 (Retrieval) unterscheidet das IT-System (CC07) die Szenarien:
- S1: CL110 + CL105 (List and Pen)
- S2: CL110 + CL107 (PDT)
- S3: CL110 + CL106 (List and Glove Scanner)

Bei S4–S6 (Storage) unterscheidet die Order (CC06):
- S4: CL111 + CL100 (Order 2904) + CL105 (List+Pen)
- S5: CL111 + CL101 (Order 2905) + CL105 (List+Pen)
- S6: CL111 + CL102 (Order 2906) + CL105 (List+Pen)

Für vollständige 5-Schritt-Logik siehe phase1_scenario_recognition.md.

---

## 8. SZENARIO-SPEZIFISCHE AKTIVIERUNG (Beispiel S4)

```
Frame in Szenario S4 (Storage, Order 2904):
  CC01: Genau 1 (Main Activity)
  CC02: Genau 1 (Leg Movement)
  CC03: 1–2 (Torso, optional Rotation)
  CC04/CC05: Je 4 (Hände)
  CC06: CL100 (Order 2904 — zwingend!)
  CC07: CL105 (List+Pen — Storage nutzt immer CL105)
  CC08: CL111 (Storage)
  CC09: CL114, CL117, CL119, CL120, oder CL121
  CC10: Storage-spezifisches Label (gemäß V-B3)
  CC11: 1–3 (Location Human)
  CC12: 1–4 (Location Cart)
```

---

**Skill-Version:** 6.0
**Erstellt:** 26.02.2026
**Quellen:** reference_labels.md (autoritativ), DaRa Dataset Description

<!-- VERIFICATION_TOKEN: DARA-ACTRL-3H9E-v630 -->
