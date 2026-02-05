---
version: 5.0
status: finalisiert
created: 2026-02-04
source: "DaRa Dataset Description + Documentation (authoritative PDF)"
description: "Complete inventory of all 207 labels (CL001-CL207) with definitions, examples, and annotation context. Structured by 12 class categories (CC01-CC12). Validation rules and hard constraints documented in validation_rules_v5.0.md."
---

# core_labels_207_v5.0.md â€” Complete Label Inventory

**DaRa Dataset Expert Skill â€” Phase 2+3 Output**  
**Scope:** 207 Labels across 12 Categories  
**Format:** Label-Definition Hub (Validation Logic in validation_rules_v5.0.md)

---

## 1. SYSTEMATISCHE KLASSIFIZIERUNG

| ID | Kategorie-Name | Anzahl Labels | Type | Scope |
|:---|:---|:---:|:---|:---|
| **CC01** | Main Activity | 15 | Single-Select | All scenarios |
| **CC02** | Sub-Activity - Legs | 8 | Single-Select | All scenarios |
| **CC03** | Sub-Activity - Torso | 6 | Optional Multi (1-2) | All scenarios |
| **CC04** | Sub-Activity - Left Hand | 35 | Required Multi (4) | All scenarios |
| **CC05** | Sub-Activity - Right Hand | 35 | Required Multi (4) | All scenarios |
| **CC06** | Order | 5 | Optional Multi (1-2) | All scenarios |
| **CC07** | Information Technology | 5 | Single-Select | Scenario-dependent |
| **CC08** | High-Level Process | 4 | Single-Select | All scenarios |
| **CC09** | Mid-Level Process | 10 | Single-Select | Scenario-dependent |
| **CC10** | Low-Level Process | 31 | Single-Select | Hard-constrained |
| **CC11** | Location - Human | 26 | Hierarchical Multi (1-3) | All scenarios |
| **CC12** | Location - Cart | 27 | Hierarchical Multi (1-4) | All scenarios |
| **TOTAL** | | **207** | | |

---

## 2. ÃœBERBLICK: KATEGORISIERUNG

### Type Definitionen (Details: see validation_rules_v5.0.md)

- **Single-Select (Exclusive):** Exactly 1 label must be active per frame
- **Optional Multi:** 1-2 labels can be active (user choice)
- **Required Multi (Faceted):** Multiple specific labels MUST be active (all groups required)
- **Hierarchical Multi:** 1-3 labels representing hierarchy levels (parent-child drill-down)
- **Scenario-dependent:** Active labels vary by Scenario S1-S8

---

[CC01-CC12 LABELS FOLGEN HIER â€” SEE PART 2]

---

## USAGE GUIDELINES

### For Annotators

1. **Cardinality:** See category_activation_matrix_v5.0.md for Min/Max rules per scenario
2. **Type Details:** See validation_rules_v5.0.md for Single/Multi/Required/Hierarchical rules
3. **Constraints:** See validation_rules_v5.0.md for hard-constraints (especially CC09â†’CC10, CC06â†”CC07)
4. **Query Patterns:** See assets_query_patterns_v5.0.md for search terms and examples
5. **Scenario Binding:** See validation_rules_v5.0.md for scenario-specific label activation

### Cross-References
- **Validation Logic:** validation_rules_v5.0.md (Master for rules, constraints, matrices)
- **Cardinality Min/Max:** core_category_activation_matrix_v5.0.md
- **Scenario Recognition:** core_ground_truth_central_v5.0.md (5-Schritt Decision-Tree)
- **Query Patterns:** assets_query_patterns_v5.0.md (Such-Muster pro Label)

---

**Version:** 5.0 | **Status:** finalisiert | **Umfang:** 207 Labels | **Datum:** 2026-02-04
4 Cross-Aisle Transitions
- Usage Rule: Can only be selected if CL162 is active

**Related Labels:** CL162 (Parent), CL168-CL169, CL171

---

#### CL171 | 4-5

**Description:**  
Cross-aisle transition from Aisle 4 to Aisle 5.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL162)
- Parent: CL162 (Cross Aisle Path)
- Position in Group: 4 of 4 Cross-Aisle Transitions
- Usage Rule: Can only be selected if CL162 is active

**Related Labels:** CL162 (Parent), CL168-CL170

---

### Level 2c: Aisle Specification (if CL163 selected)

#### CL172 | Aisle 1

**Description:**  
Warehouse Aisle 1. One of 5 main picking/storage aisles.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL163 - Aisle Path)
- Parent: CL163 (Aisle Path)
- Position in Group: 1 of 5 Aisles
- Requires: Must also select Position (CL177-CL178: Front or Back)
- Usage Rule: Can only be selected if CL163 is active

**Related Labels:** CL163 (Parent), CL173-CL176 (other aisles), CL177-CL178 (Position)

---

#### CL173 | Aisle 2

**Description:**  
Warehouse Aisle 2. One of 5 main picking/storage aisles.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL163)
- Parent: CL163 (Aisle Path)
- Position in Group: 2 of 5 Aisles
- Requires: Must also select Position (CL177-CL178)
- Usage Rule: Can only be selected if CL163 is active

**Related Labels:** CL163 (Parent), CL172, CL174-CL176, CL177-CL178

---

#### CL174 | Aisle 3

**Description:**  
Warehouse Aisle 3. One of 5 main picking/storage aisles.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL163)
- Parent: CL163 (Aisle Path)
- Position in Group: 3 of 5 Aisles
- Requires: Must also select Position (CL177-CL178)
- Usage Rule: Can only be selected if CL163 is active

**Related Labels:** CL163 (Parent), CL172-CL173, CL175-CL176, CL177-CL178

---

#### CL175 | Aisle 4

**Description:**  
Warehouse Aisle 4. One of 5 main picking/storage aisles.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL163)
- Parent: CL163 (Aisle Path)
- Position in Group: 4 of 5 Aisles
- Requires: Must also select Position (CL177-CL178)
- Usage Rule: Can only be selected if CL163 is active

**Related Labels:** CL163 (Parent), CL172-CL174, CL176, CL177-CL178

---

#### CL176 | Aisle 5

**Description:**  
Warehouse Aisle 5. One of 5 main picking/storage aisles.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL163)
- Parent: CL163 (Aisle Path)
- Position in Group: 5 of 5 Aisles
- Requires: Must also select Position (CL177-CL178)
- Usage Rule: Can only be selected if CL163 is active

**Related Labels:** CL163 (Parent), CL172-CL175, CL177-CL178

---

### Level 3: Position Specification (if CL163 + Aisle selected)

#### CL177 | Front Position

**Description:**  
Front section of aisle. Forward-facing area near aisle entrance.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: Aisle CL172-CL176)
- Parent: One of CL172-CL176 (Aisle selection)
- Position in Group: 1 of 2 Positions (within aisle)
- Usage Rule: Can only be selected if CL163 AND one aisle (CL172-CL176) are active

**Related Labels:** CL163 (Aisle Path), CL172-CL176 (Aisle number), CL178 (Back Position)

---

#### CL178 | Back Position

**Description:**  
Back section of aisle. Rear-facing area, deeper into aisle.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: Aisle CL172-CL176)
- Parent: One of CL172-CL176 (Aisle selection)
- Position in Group: 2 of 2 Positions (within aisle)
- Usage Rule: Can only be selected if CL163 AND one aisle (CL172-CL176) are active

**Related Labels:** CL163 (Aisle Path), CL172-CL176 (Aisle number), CL177 (Front Position)

---

### Final Level: Unknown

#### CL179 | Another Location - Human

**Description:**  
Any other human location not explicitly listed.

**Annotation Context:**
- Type: Hierarchical (special case - can stand alone)
- Position in Category: 25 of 26 Human Locations
- Scenario: All (S1-S8)

**Related Labels:** CL180 (Location Unknown)

---

#### CL180 | Human Location Unknown

**Description:**  
Human location cannot be determined or identified.

**Examples:**  
Video obscured, unclear location, unidentifiable position.

**Annotation Context:**
- Type: Hierarchical (special case - can stand alone)
- Position in Category: 26 of 26 Human Locations
- Scenario: All (S1-S8)

**Related Labels:** CL179 (Another Location)

---

## 14. CC12 â€” LOCATION - CART (27 Labels)

**Type:** Hierarchical Multi-Select (1-4 labels)  
**Structure:** Level 1 (Main Area) â†’ Level 2 (Sub-Area) â†’ Level 3 (Position) â†’ Level 4 (Beacon)  
**Scope:** All scenarios (S1-S8)  
**Special:** CL181 (Beacon Transition Multi-Frame) has special combinatorics with beacon locations  
**Note:** Beacon-based location system. Parallel to CC11 (Human Location). See validation_rules_v5.0.md for drill-down and beacon transition logic.

---

### Level 1: Cart Main Area (9 Labels, mirroring CC11)

#### CL182 | Office

**Description:**  
Cart location in/near office area (beacon-based). Picking/storage office zone for cart.

**Annotation Context:**
- Type: Hierarchical Level 1 (Main Area)
- Parent: None (top level)
- Beacon: Office beacon location
- Scenario: All (S1-S8)

**Related Labels:** CL155 (Human CC11: Office), CL183-CL190 (other cart locations)

---

#### CL183 | Cart Area

**Description:**  
Cart location in cart storage area (beacon-based). Cart equipment zone.

**Annotation Context:**
- Type: Hierarchical Level 1 (Main Area)
- Parent: None (top level)
- Beacon: Cart Area beacon location
- Scenario: All (S1-S8)

**Related Labels:** CL156 (Human CC11: Cart Area), CL182, CL184-CL190

---

#### CL184 | Cardboard Box Area

**Description:**  
Cart location in box storage area (beacon-based). Packaging material zone for cart.

**Annotation Context:**
- Type: Hierarchical Level 1 (Main Area)
- Parent: None (top level)
- Beacon: Box Area beacon location
- Scenario: All (S1-S8)

**Related Labels:** CL157 (Human CC11: Box Area), CL182-CL183, CL185-CL190

---

#### CL185 | Issuing/Receiving Area

**Description:**  
Cart location at issuing/receiving dock (beacon-based). Handover zone for cart.

**Annotation Context:**
- Type: Hierarchical Level 1 (Main Area)
- Parent: None (top level)
- Beacon: Issuing/Receiving beacon location
- Scenario: All (S1-S8)

**Related Labels:** CL158 (Human CC11: Issuing/Receiving), CL182-CL184, CL186-CL190

---

#### CL186 | Packaging/Sorting Area

**Description:**  
Cart location at packing/sorting station (beacon-based). Processing zone for cart.

**Annotation Context:**
- Type: Hierarchical Level 1 (Main Area)
- Parent: None (top level)
- Beacon: Packaging/Sorting beacon location
- Scenario: All (S1-S8)

**Related Labels:** CL159 (Human CC11: Packaging Area), CL182-CL185, CL187-CL190

---

#### CL187 | Administrative Area

**Description:**  
Cart location in administrative area (beacon-based). Support zone for cart.

**Annotation Context:**
- Type: Hierarchical Level 1 (Main Area)
- Parent: None (top level)
- Beacon: Administrative beacon location
- Scenario: All (S1-S8)

**Related Labels:** CL160 (Human CC11: Administrative Area), CL182-CL186, CL188-CL190

---

#### CL188 | Path (Cart Location)

**Description:**  
Cart location on path connecting areas (beacon-based). Requires drill-down to specify path type. **Mirrors CL161 (Path) structure.**

**Annotation Context:**
- Type: Hierarchical Level 1 (Main Area) â€” requires Level 2 specification
- Parent: None (top level)
- Children: **REQUIRED** â€” must select one of path types (Office, Cross-Aisle, Aisle paths)
- Beacon: Path beacon location(s)
- Scenario: All (S1-S8)
- Drill-Down Rule: If CL188 â†’ must choose path type

**Related Labels:** CL161 (Human Path), CL189-CL190, CL191-CL207 (Path sub-types for cart)

---

#### CL189 | Cross Aisle Path (Cart)

**Description:**  
Cart location on cross-aisle transition (beacon-based). **Mirrors CL162 (Cross Aisle Path) structure.** Requires further drill-down to specify which aisle transition.

**Annotation Context:**
- Type: Hierarchical Level 1 (Main Area) â€” requires Level 2 specification
- Parent: None (top level)
- Children: **REQUIRED** â€” must select which aisle transition (similar to CL168-CL171)
- Beacon: Cross-aisle beacon location(s)
- Scenario: All (S1-S8)
- Drill-Down Rule: If CL189 â†’ must choose aisle transition

**Related Labels:** CL162 (Human Cross-Aisle Path), CL188, CL190, CL191-CL207 (specifics)

---

#### CL190 | Aisle Path (Cart)

**Description:**  
Cart location in aisle system (beacon-based). **Mirrors CL163 (Aisle Path) structure.** Requires drill-down to specify aisle AND position.

**Annotation Context:**
- Type: Hierarchical Level 1 (Main Area) â€” requires Level 2 AND Level 3 specification
- Parent: None (top level)
- Children: **REQUIRED** â€” must select aisle number AND position (Front/Back)
- Beacon: Aisle beacon location(s)
- Scenario: All (S1-S8)
- Drill-Down Rule: If CL190 â†’ must choose Aisle AND Position

**Related Labels:** CL163 (Human Aisle Path), CL188-CL189, CL191-CL207 (specifics)

---

### Special: Beacon Transition Multi-Frame Label

#### CL181 | Beacon Transition (Multi-Frame)

**Description:**  
Multi-frame label indicating cart wheel crossing beacon boundary. Cart is transitioning between beacon zones. **Special Combinatorics:** CL181 MUST be paired with exactly ONE beacon location (CL182-CL190 OR sub-types). This label spans multiple frames (typically 0.1-0.5 seconds) while wheels cross beacon line.

**Example Sequence:**
```
Frame 1: [Cart Location: Office + Path] (wheels not yet crossing)
Frame 2: [CL181 + Office] (wheels crossing, beacon still in office)
Frame 3: [CL181 + Packaging Area] (wheels crossing, beacon crossed to packaging)
Frame 4: [Cart Location: Packaging Area + Path] (wheels fully crossed, in new zone)
```

**Examples:**  
Cart wheels crossing aisle boundary, wheels transitioning between beacon zones, cart changing beacon location.

**Annotation Context:**
- Type: Multi-Frame Beacon Transition (1 frame duration: 0.1-0.5 sec)
- Special Pairing Rule: MUST combine with exactly ONE location label (CL182-CL190)
- Multi-Frame Duration: Spans frames where wheels are in transition
- Beacon Rule: CL181 + [ANY single beacon location] = valid combination
- Scenario: All (S1-S8)
- Combinatorics: CL181 can pair with CL182, CL183, CL184, ..., CL190 OR their sub-types

**Related Labels:** All CC12 beacon locations (CL182-CL190), can combine with hierarchical sub-types

---

### Level 2+3: Path Sub-Types (Cart versions of CC11 paths)

#### CL191 | Path (Office) - Cart

**Description:**  
Cart path to/from office beacon zone. Mirror of CL164 for cart.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL188 - Path)
- Parent: CL188 (Path for cart)
- Scenario: All (S1-S8)

**Related Labels:** CL164 (Human: Path Office), CL188, CL192-CL194

---

#### CL192 | Path (Cross Aisle) - Cart

**Description:**  
Cart path on cross-aisle transition beacon. Mirror of CL165.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL188)
- Parent: CL188 (Path for cart)
- Children: **OPTIONAL** â€” can specify which aisle transition (CL195-CL198)
- Scenario: All (S1-S8)

**Related Labels:** CL165 (Human: Path Cross-Aisle), CL191, CL193-CL194

---

#### CL193 | Path (Aisle) - Cart

**Description:**  
Cart path within aisle system beacon. Mirror of CL166.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL188)
- Parent: CL188 (Path for cart)
- Children: **OPTIONAL** â€” can specify aisle number (CL199-CL203) and position (CL204-CL205)
- Scenario: All (S1-S8)

**Related Labels:** CL166 (Human: Path Aisle), CL191-CL192, CL194

---

#### CL194 | Path (Another) - Cart

**Description:**  
Any other cart path type.

**Annotation Context:**
- Type: Hierarchical Level 2 (Parent: CL188)
- Parent: CL188 (Path for cart)
- Scenario: All (S1-S8)

**Related Labels:** CL167 (Human: Path Another), CL191-CL193

---

### Cross-Aisle Transitions for Cart (CL189 children)

#### CL195 | 1-2 (Cart)

**Description:**  
Cart beacon transition between Aisle 1 and 2.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: CL189 or CL192)
- Parent: CL189 (Cross-Aisle Path for cart)
- Scenario: All (S1-S8)

**Related Labels:** CL168 (Human: 1-2), CL189, CL196-CL198

---

#### CL196 | 2-3 (Cart)

**Description:**  
Cart beacon transition between Aisle 2 and 3.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: CL189)
- Parent: CL189 (Cross-Aisle Path for cart)
- Scenario: All (S1-S8)

**Related Labels:** CL169 (Human: 2-3), CL195, CL197-CL198

---

#### CL197 | 3-4 (Cart)

**Description:**  
Cart beacon transition between Aisle 3 and 4.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: CL189)
- Parent: CL189 (Cross-Aisle Path for cart)
- Scenario: All (S1-S8)

**Related Labels:** CL170 (Human: 3-4), CL195-CL196, CL198

---

#### CL198 | 4-5 (Cart)

**Description:**  
Cart beacon transition between Aisle 4 and 5.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: CL189)
- Parent: CL189 (Cross-Aisle Path for cart)
- Scenario: All (S1-S8)

**Related Labels:** CL171 (Human: 4-5), CL195-CL197

---

### Aisle Numbers for Cart (CL190 children - Level 2)

#### CL199 | Aisle 1 (Cart)

**Description:**  
Cart beacon location in Aisle 1.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: CL190)
- Parent: CL190 (Aisle Path for cart)
- Requires: Must also select Position (CL204-CL205)
- Scenario: All (S1-S8)

**Related Labels:** CL172 (Human: Aisle 1), CL190, CL200-CL203, CL204-CL205

---

#### CL200 | Aisle 2 (Cart)

**Description:**  
Cart beacon location in Aisle 2.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: CL190)
- Parent: CL190 (Aisle Path for cart)
- Requires: Must also select Position (CL204-CL205)
- Scenario: All (S1-S8)

**Related Labels:** CL173 (Human: Aisle 2), CL199, CL201-CL203, CL204-CL205

---

#### CL201 | Aisle 3 (Cart)

**Description:**  
Cart beacon location in Aisle 3.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: CL190)
- Parent: CL190 (Aisle Path for cart)
- Requires: Must also select Position (CL204-CL205)
- Scenario: All (S1-S8)

**Related Labels:** CL174 (Human: Aisle 3), CL199-CL200, CL202-CL203, CL204-CL205

---

#### CL202 | Aisle 4 (Cart)

**Description:**  
Cart beacon location in Aisle 4.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: CL190)
- Parent: CL190 (Aisle Path for cart)
- Requires: Must also select Position (CL204-CL205)
- Scenario: All (S1-S8)

**Related Labels:** CL175 (Human: Aisle 4), CL199-CL201, CL203, CL204-CL205

---

#### CL203 | Aisle 5 (Cart)

**Description:**  
Cart beacon location in Aisle 5.

**Annotation Context:**
- Type: Hierarchical Level 3 (Parent: CL190)
- Parent: CL190 (Aisle Path for cart)
- Requires: Must also select Position (CL204-CL205)
- Scenario: All (S1-S8)

**Related Labels:** CL176 (Human: Aisle 5), CL199-CL202, CL204-CL205

---

### Positions for Cart (CL190 children - Level 3)

#### CL204 | Front Position (Cart)

**Description:**  
Cart beacon location at front of aisle (forward section).

**Annotation Context:**
- Type: Hierarchical Level 4 (Parent: Aisle CL199-CL203)
- Parent: One of CL199-CL203 (Aisle number)
- Usage Rule: Can only be selected if CL190 AND one aisle (CL199-CL203) are active
- Scenario: All (S1-S8)

**Related Labels:** CL177 (Human: Front Position), CL190, CL199-CL203, CL205

---

#### CL205 | Back Position (Cart)

**Description:**  
Cart beacon location at back of aisle (rear section).

**Annotation Context:**
- Type: Hierarchical Level 4 (Parent: Aisle CL199-CL203)
- Parent: One of CL199-CL203 (Aisle number)
- Usage Rule: Can only be selected if CL190 AND one aisle (CL199-CL203) are active
- Scenario: All (S1-S8)

**Related Labels:** CL178 (Human: Back Position), CL190, CL199-CL203, CL204

---

### Final Labels

#### CL206 | Another Location - Cart

**Description:**  
Any other cart location not explicitly listed.

**Annotation Context:**
- Type: Hierarchical (special case)
- Position in Category: 26 of 27 Cart Locations
- Scenario: All (S1-S8)

**Related Labels:** CL205 (Back), CL207 (Unknown)

---

#### CL207 | Cart Location Unknown

**Description:**  
Cart location cannot be determined or identified. Beacon signal unclear or unidentifiable location.

**Examples:**  
Video obscured, unclear beacon reading, unidentifiable cart position.

**Annotation Context:**
- Type: Hierarchical (special case - can stand alone)
- Position in Category: 27 of 27 Cart Locations
- Scenario: All (S1-S8)

**Related Labels:** CL206 (Another Location), CL180 (Human Location Unknown)

---

## USAGE GUIDELINES

### For Annotators

1. **Cardinality:** See category_activation_matrix_v5.0.md for Min/Max rules per scenario
2. **Type Details:** See validation_rules_v5.0.md for Single/Multi/Required/Hierarchical rules
3. **Constraints:** See validation_rules_v5.0.md for hard-constraints (especially CC09â†’CC10, CC06â†”CC07)
4. **Query Patterns:** See assets_query_patterns_v5.0.md for search terms and examples
5. **Scenario Binding:** See validation_rules_v5.0.md for scenario-specific label activation

### Cross-References
- **Validation Logic:** validation_rules_v5.0.md (Master for rules, constraints, matrices)
- **Cardinality Min/Max:** core_category_activation_matrix_v5.0.md
- **Scenario Recognition:** core_ground_truth_central_v5.0.md (5-Schritt Decision-Tree)
- **Scenario Context:** ground_truth_central_v5.0.md (Szenario-Erkennungslogik)
- **Query Patterns:** assets_query_patterns_v5.0.md (Such-Muster pro Label)
- **Chunking Trigger:** auxiliary_chunking_v5.0.md (T1-T13 Aktivierungsregeln)

---

## DATEIEND

**Version:** 5.0  
**Status:** finalisiert  
**Umfang:** 207 Labels (CL001-CL207) across 12 Categories (CC01-CC12)  
**Referenzen:** Alle mit _v5.0 Suffix  
**Erstellungsdatum:** 2026-02-04

