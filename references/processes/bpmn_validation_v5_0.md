---
version: 5.0
status: finalisiert
created: 2026-02-05
references:
  - core_validation_rules_v5_0.md
  - core_labels_207_v5_0.md
  - processes_process_hierarchy_v5_0.md
  - core_ground_truth_central_v5_0.md
---

# DaRa Dataset – BPMN Validation & Detailed Process Analysis

**Vollständige Validierungs- und Analyselogik für BPMN-konforme Prozessvalidierung mit detaillierten Prozessflows aus Abbildungen A2-A7**

**Version:** 5.0  
**Erstellt:** 05.02.2026  
**Quelle:** BPMN_PROZESSE_DARA.pdf (Figures A2-A7) + NotebookLM-Extraktionen  
**Skill-Version:** dara-dataset-expert v5.0  
**Status:** Finalisiert ✅

---

## ðŸ“‹ INHALTSVERZEICHNIS

### HAUPTTEILE
1. [Einleitung & Zweck](#1-einleitung--zweck)
2. [Validierungsregeln – Komplett](#2-validierungsregeln)
   - 2.1: Sequenz-Validierung (FSM) + Detaillierte Prozessflows
   - 2.2: Tool-Validierung
   - 2.3: Location-Validierung
   - 2.4: Multi-Order-Validierung
   - 2.5: CL134 (Waiting) Priorisierung
3. [BPMN-Generierung & Visualisierung](#3-bpmn-generierung)
4. [Abweichungs-Kategorien & Reporting](#4-abweichungs-kategorien)
5. [Verwendungsbeispiele](#5-verwendungsbeispiele)
6. [Erweiterungen & Automatisierung](#6-erweiterungen)
7. [Verwendungshinweise](#7-verwendungshinweise)

### NEU IN v5.0
- ✅ Detailed Process Flows (Section 2.1.3): Exakte Activity-Sequenzen aus Figures A2-A7
- ✅ Scenario-Routing Matrix (Section 2.1.4): S1-S8 Mapping mit Prozess-Pfaden
- ✅ Error-Handling Details (Section 2.1.5): CL135 Aktivierungsbedingungen pro Prozess
- ✅ Cross-Process Consistency (Section 2.1.6): Identische vs. unterschiedliche Aktivitäten

---

## 1. EINLEITUNG & ZWECK

### 1.1 Scope

Diese Datei definiert die **vollständige Validierungslogik** zur Prüfung von DaRa-Datensätzen gegen die idealisierten BPMN-Prozessmodelle (Figures 11, A2-A7). Sie ermöglicht:

- **Sequenzvalidierung:** Sind CC09-Prozessübergänge BPMN-konform?
- **Detaillierte Prozessflüsse:** Exakte Activity-Boxen, Gateways, Übergänge pro Prozess (neu in v5.0)
- **Szenario-Routing:** Welche Prozess-Flows gehören zu S1-S8? (neu in v5.0)
- **Error-Handling:** Wann wird CL135 aktiviert? Unter welchen Bedingungen? (neu in v5.0)
- **Tool-Validierung:** Sind Pflicht-Tools bei entsprechenden CC10-Labels aktiv?
- **Location-Validierung:** Entsprechen CC11-Transitions den erwarteten räumlichen Pfaden?
- **Multi-Order-Validierung:** Sind Order-Co-Activations biologisch plausibel?
- **CL134-Priorisierung:** Wird Waiting als Global Interrupt behandelt?
- **BPMN-Generierung:** Visualisierung tatsächlich durchgeführter Prozesse
- **Abweichungsreporting:** Strukturierte Fehlerberichte mit Severity-Klassifikation

### 1.2 Validierungs-Philosophie

**Hybrid-Ansatz:**
- **Frame-Level:** Tool-Validierung, Location-Transitions (präzise Fehlerlokalisation)
- **Chunk-Level:** Sequenz-Validierung (Prozessstabilität innerhalb Chunks)

**Severity-Klassifikation:**
- **CRITICAL:** Fundamentale BPMN-Logik verletzt (z.B. unmögliche Sequenz)
- **WARNING:** Ungewöhnlich, aber nicht ausgeschlossen (z.B. seltene Pfade)
- **INFO:** Abweichung ohne direkten Fehler (z.B. längere Wartezeiten)

### 1.3 Anwendungsbereich

- **Alle 18 Probanden** (S01-S18)
- **Alle 8 Szenarien** (S1-S8) + Other
- **Alle Sessions** (1-6)
- **Universell einsetzbar** ohne probandenspezifische Anpassungen

---

## 2. VALIDIERUNGSREGELN

### 2.1 SEQUENZ-VALIDIERUNG (FSM)

#### 2.1.1 Finite State Machine für CC09

Die BPMN-Logik definiert erlaubte Transitionen zwischen Mid-Level-Prozessen (CC09):

```python
VALID_CC09_TRANSITIONS = {
    # Preparing Order (CL114)
    CL114: [
        CL115,  # → Picking Travel Time (Retrieval-Pfad)
        CL117,  # → Unpacking (Storage-Pfad)
        CL121,  # → Finalizing Order (direkter Abschluss, selten)
    ],
    
    # Picking Travel Time (CL115)
    CL115: [
        CL115,  # → Loop (weitere Positionen)
        CL116,  # → Picking Pick Time (Hauptpfad)
    ],
    
    # Picking Pick Time (CL116)
    CL116: [
        CL116,  # → Loop (weitere Items am selben Regal)
        CL115,  # → Picking Travel Time (nächste Position)
        CL118,  # → Packing (optionaler Pfad)
        CL121,  # → Finalizing Order (alle Positionen komplett)
    ],
    
    # Unpacking (CL117)
    CL117: [
        CL117,  # → Loop (weitere Kartons)
        CL119,  # → Storing Travel Time (Hauptpfad)
    ],
    
    # Packing (CL118)
    CL118: [
        CL118,  # → Loop (weitere Kartons)
        CL115,  # → Picking Travel Time (zurück zu Picking, Multi-Order)
        CL121,  # → Finalizing Order (Abschluss)
    ],
    
    # Storing Travel Time (CL119)
    CL119: [
        CL119,  # → Loop (weitere Positionen)
        CL120,  # → Storing Store Time (Hauptpfad)
    ],
    
    # Storing Store Time (CL120)
    CL120: [
        CL120,  # → Loop (weitere Items am selben Regal)
        CL119,  # → Storing Travel Time (nächste Position)
        CL121,  # → Finalizing Order (alle Positionen komplett)
    ],
    
    # Finalizing Order (CL121)
    CL121: [
        CL114,  # → Preparing Order (neue Order, Multi-Order-Szenarien)
        None,   # → END (keine weiteren Orders)
    ],
    
    # Another Mid-Level Process (CL122)
    CL122: [
        CL122,  # → Loop (unbekannter Prozess)
        CL114,  # → Preparing Order (Rückkehr zu Standard)
        CL121,  # → Finalizing Order
    ],
    
    # Process Unknown (CL123)
    CL123: [
        CL123,  # → Loop (weiterhin unklar)
        CL114,  # → Preparing Order (Klarheit erreicht)
        CL121,  # → Finalizing Order
    ],
}
```

#### 2.1.2 Szenario-spezifische Sequenz-Erwartungen

**Retrieval-Szenarien (S1, S2, S3, S7):**
```python
RETRIEVAL_EXPECTED_SEQUENCE = [
    CL114,  # Preparing Order
    CL115,  # Picking Travel Time (mehrfach)
    CL116,  # Picking Pick Time (mehrfach)
    CL118,  # Packing (optional, hauptsächlich S1, S3, S7)
    CL121,  # Finalizing Order
]
```

**Storage-Szenarien (S4, S5, S6, S8):**
```python
STORAGE_EXPECTED_SEQUENCE = [
    CL114,  # Preparing Order
    CL117,  # Unpacking
    CL119,  # Storing Travel Time (mehrfach)
    CL120,  # Storing Store Time (mehrfach)
    CL121,  # Finalizing Order
]
```

#### 2.1.3 DETAILED PROCESS FLOWS (aus Figure A2-A7)

**NEW IN v5.0:** Exakte Activity-Sequenzen und Gateway-Bedingungen aus BPMN-Diagrammen

##### CL114 | Preparing Order (Figure A2)

**Exakte Activity-Sequenz:**
```
Start Preparing Order
  ↓
Collecting Order and Hardware
  ↓
[GATEWAY 1: "Does the subject already have a cart?"]
  ├─ YES: weiter zu Gateway 2
  └─ NO: Collecting Cart → weiter zu Gateway 2
  ↓
[GATEWAY 2: "Retrieval or Storage?"]
  ├─ Retrieval: Collecting Empty Cardboard Boxes
  └─ Storage: Collecting Packed Cardboard Boxes
  ↓
End Preparing Order
```

**CC10 Labels (erlaubt):**
- CL124: Collecting Order and Hardware
- CL125: Collecting Cart (optional)
- CL126: Collecting Empty Cardboard Boxes (Retrieval-Pfad)
- CL127: Collecting Packed Cardboard Boxes (Storage-Pfad)

**Szenario-Zuordnung:**
- S1, S2, S3, S7: Retrieval-Pfad (CL126)
- S4, S5, S6, S8: Storage-Pfad (CL127)

---

##### CL115/CL116 | Picking – Travel Time & Pick Time (Figure A3)

**Exakte Activity-Sequenz:**
```
Start Picking
  ↓
[GATEWAY 1: "Is the cart on the base?"]
  ├─ YES: weiter
  └─ NO: Transporting a Cart to the Base
  ↓
Moving to the Next Position
  ↓
[GATEWAY 2: "Information on the next position complete?"]
  ├─ YES: weiter
  └─ NO: Reporting and Clarifying the Incident → Loop to Moving to the Next Position
  ↓
[GATEWAY 3: "Items can be picked?" (Item is in stock, not damaged, ...)]
  ├─ YES: weiter zu Picking Pick Time
  └─ NO: Reporting and Clarifying the Incident → Loop to Moving to the Next Position
  ↓
[PICKING - PICK TIME PHASE]
Retrieving Items
  ↓
Moving to a Cart
  ↓
Placing Cardboard Box/Item in a Cart
  ↓
[GATEWAY 4: "Has the order been completed?"]
  ├─ YES: End Picking
  └─ NO: Loop back to Moving to the Next Position
```

**CC10 Labels (Travel Time - CL115):**
- CL128: Transporting a Cart to the Base
- CL137: Moving to the Next Position
- CL135: Reporting and Clarifying the Incident (Error-Handling)

**CC10 Labels (Pick Time - CL116):**
- CL139: Retrieving Items
- CL140: Moving to a Cart
- CL151: Placing Cardboard Box/Item in a Cart

**Error-Handling (CL135):**
- Auslöser 1: "Information on the next position complete?" = NO (Listenfehler)
- Auslöser 2: "Items can be picked?" = NO (Item fehlt oder beschädigt)
- Konsequenz: Übersprungene Aktivitäten: CL139, CL140, CL151
- Loop-Ziel: Zurück zu CL137 (Moving to the Next Position)

---

##### CL118 | Packing (Figure A4)

**Exakte Activity-Sequenz:**
```
Start Packing
  ↓
Transporting to the Packaging/Sorting Area
  ↓
Placing Cardboard Box/Item on a Table
  ↓
Removing Elastic Band
  ↓
Sorting
  ↓
Filling Cardboard Box with Filling Material
  ↓
Printing Shipping Label and Return Slip
  ↓
Preparing or Adding Return Label
  ↓
Attaching Shipping Label
  ↓
Sealing Cardboard Box
  ↓
Placing Cardboard Box/Item in a Cart
  ↓
[GATEWAY: "More unpacked boxes available?"]
  ├─ YES: Loop back to Transporting
  └─ NO: End Packing
```

**CC10 Labels:**
- CL129: Transporting to the Packaging/Sorting Area
- CL141: Placing Cardboard Box/Item on a Table
- CL149: Removing Elastic Band
- CL144: Sorting
- CL145: Filling Cardboard Box with Filling Material
- CL146: Printing Shipping Label and Return Slip
- CL147: Preparing or Adding Return Label
- CL148: Attaching Shipping Label
- CL150: Sealing Cardboard Box
- CL151: Placing Cardboard Box/Item in a Cart

**Hinweis:** Keine Error-Handling-Gateways (nicht wie in Picking oder Storing)

---

##### CL117 | Unpacking (Figure A5)

**Exakte Activity-Sequenz:**
```
Start Unpacking
  ↓
Transporting to the Packaging/Sorting Area
  ↓
Placing Cardboard Box/Item on a Table
  ↓
Opening Cardboard Box
  ↓
Disposing of Filling Material or Shipping Label
  ↓
Sorting
  ↓
Tying Elastic Band Around Cardboard
  ↓
Placing Cardboard Box/Item in a Cart
  ↓
[GATEWAY: "More unpacked boxes available?"]
  ├─ YES: Loop back to Transporting
  └─ NO: End Unpacking
```

**CC10 Labels:**
- CL129: Transporting to the Packaging/Sorting Area
- CL141: Placing Cardboard Box/Item on a Table
- CL142: Opening Cardboard Box
- CL143: Disposing of Filling Material or Shipping Label
- CL144: Sorting
- CL152: Tying Elastic Band Around Cardboard
- CL151: Placing Cardboard Box/Item in a Cart

**Reverse-Struktur zu Packing:**
- Packing: Removing Elastic Band (CL149) → Filling (CL145) → Sealing (CL150)
- Unpacking: Opening (CL142) → Disposing (CL143) → Tying Elastic Band (CL152)

---

##### CL119/CL120 | Storing – Travel Time & Store Time (Figure A6)

**Exakte Activity-Sequenz:**
```
Start Storing
  ↓
[GATEWAY 1: "Is the cart on the base?"]
  ├─ YES: weiter
  └─ NO: Transporting a Cart to the Base
  ↓
Moving to the Next Position
  ↓
[GATEWAY 2: "Information on the next position complete?"]
  ├─ YES: weiter
  └─ NO: Reporting and Clarifying the Incident → Loop back
  ↓
[STORING - STORE TIME PHASE]
Removing Cardboard Box/Item from the Cart
  ↓
Moving to a Cart [technisch: Bewegung vom Wagen zum Regal]
  ↓
Placing Items on a Rack
  ↓
[GATEWAY 3: "Items can be placed?"]
  ├─ YES: weiter
  └─ NO: Reporting and Clarifying the Incident → Loop back
  ↓
[GATEWAY 4: "Has the order been completed?"]
  ├─ YES: End Storing
  └─ NO: Loop back to Moving to the Next Position
```

**CC10 Labels (Travel Time - CL119):**
- CL128: Transporting a Cart to the Base
- CL137: Moving to the Next Position
- CL135: Reporting and Clarifying the Incident (Error-Handling)

**CC10 Labels (Store Time - CL120):**
- CL136: Removing Cardboard Box/Item from the Cart
- CL140: Moving to a Cart [generisches Label für Regal-Bewegung]
- CL138: Placing Items on a Rack

**Error-Handling (CL135) - UNTERSCHIED zu Picking:**
- Auslöser 1: "Information on the next position complete?" = NO (Fehler in Liste)
- Auslöser 2: "Items can be placed?" = NO (Regal voll/besetzt, nicht: Item fehlt)
- Konsequenz: Ähnlich Picking, aber semantisch unterschiedlicher Fehlergrund
- Loop-Ziel: Zurück zu Picking Travel Time oder Storing Travel Time

---

##### CL121 | Finalizing Order (Figure A7)

**Exakte Activity-Sequenz:**
```
Start Finalizing Order
  ↓
[GATEWAY: "Retrieval or Storage?"]
  ├─ Retrieval: Handing Over Packed Cardboard Boxes
  └─ Storage: Returning Empty Cardboard Boxes
  ↓
Returning Cart
  ↓
Returning Hardware
  ↓
End Finalizing Order
```

**CC10 Labels:**
- CL130: Handing Over Packed Cardboard Boxes (Retrieval-Pfad)
- CL131: Returning Empty Cardboard Boxes (Storage-Pfad)
- CL132: Returning Cart
- CL133: Returning Hardware

---

#### 2.1.4 SCENARIO-ROUTING MATRIX (S1-S8)

**NEW IN v5.0:** Exaktes Mapping der Szenarien zu Prozess-Flows

| Szenario | Bezeichnung | CC09 Sequenz | Figure-Paths | Besonderheit |
|----------|-------------|-------------|--------------|-------------|
| **S1** | Retrieval (1 Order, Intentional Error) | CL114 → CL115 → CL116 → CL118 → CL121 | A2(Retrieval) → A3(Error) → A4 → A7(Retrieval) | CL135 aktiviert in A3 (Picking Error) |
| **S2** | Retrieval (1 Order, Standard) | CL114 → CL115 → CL116 → CL121 | A2(Retrieval) → A3(Perfect) → A7(Retrieval) | Kein Packing, direkter Abschluss |
| **S3** | Retrieval (1 Order, Intentional Error) | CL114 → CL115 → CL116 → CL118 → CL121 | A2(Retrieval) → A3(Error) → A4 → A7(Retrieval) | Ähnlich S1, aber möglicherweise unterschiedlicher Error-Typ |
| **S4** | Storage (1 Order) | CL114 → CL117 → CL119 → CL120 → CL121 | A2(Storage) → A5 → A6 → A7(Storage) | Unpacking vor Storing |
| **S5** | Storage (1 Order, mit Error) | CL114 → CL117 → CL119 → CL120 → CL121 | A2(Storage) → A5 → A6(mit Error/CL135) → A7(Storage) | CL135 in Storing (A6) aktiviert |
| **S6** | Storage (1 Order) | CL114 → CL117 → CL119 → CL120 → CL121 | A2(Storage) → A5 → A6 → A7(Storage) | Ähnlich S4, evtl. unterschiedliche Komplexität |
| **S7** | Retrieval (2 Orders, Perfect) | [CL114 → CL115 → CL116 → CL118]×2 → CL121 | A2×2(Retrieval) → A3×2(Perfect) → A4×2 → A7×2(Retrieval) | Multi-Order: Doppelte Sequenz |
| **S8** | Storage (2 Orders, Perfect) | [CL114 → CL117 → CL119 → CL120]×2 → CL121 | A2×2(Storage) → A5×2 → A6×2 → A7×2(Storage) | Multi-Order: Doppelte Sequenz |

**Szenario-Entscheidungen (Figure A2):**

```
Figure A2 Gateway: "Retrieval or Storage?"
├─ RETRIEVAL-Pfad (Collecting Empty Cardboard Boxes):
│  └─ Szenarien: S1, S2, S3, S7
│  └─ Folge: Picking (A3) → ggf. Packing (A4) → Finalizing Retrieval (A7)
│
└─ STORAGE-Pfad (Collecting Packed Cardboard Boxes):
   └─ Szenarien: S4, S5, S6, S8
   └─ Folge: Unpacking (A5) → Storing (A6) → Finalizing Storage (A7)
```

---

#### 2.1.5 ERROR-HANDLING DETAILS (CL135)

**NEW IN v5.0:** Detaillierte Analyse von Fehlerbehandlung und Bedingungen

**CL135 | Reporting and Clarifying the Incident**

**Wo wird CL135 aktiviert?**

1. **Picking (Figure A3) – Szenario S1, S3:**
   - **Gateway:** "Information on the next position complete?" = NO
   - **Bedeutung:** Fehler in der Pick-Liste (fehlende Information)
   - **Gateway:** "Items can be picked?" = NO
   - **Bedeutung:** Item nicht verfügbar (fehlt, beschädigt, falsche Menge)
   - **Konsequenz:** 
     - Übersprungene Aktivitäten: CL139 (Retrieving), CL140 (Moving), CL151 (Placing)
     - Loop-Ziel: Zurück zu CL137 (Moving to the Next Position)
   - **Prozess-Spezifik:** Der Fehler hindert die **ENTNAHME** aus dem Regal

2. **Storing (Figure A6) – Szenario S5:**
   - **Gateway:** "Information on the next position complete?" = NO
   - **Bedeutung:** Fehler in der Einlagerungs-Liste
   - **Gateway:** "Items can be placed?" = NO
   - **Bedeutung:** Regalfach besetzt, voll oder beschädigt (nicht: Item-Problem)
   - **Konsequenz:**
     - Übersprungene Aktivitäten: CL138 (Placing Items on Rack)
     - Loop-Ziel: Zurück zu CL119 (Storing Travel Time) oder CL137
   - **Prozess-Spezifik:** Der Fehler hindert die **ABLAGE** ins Regal

3. **Nicht in Packing oder Unpacking:**
   - Figure A4 (Packing): Keine Error-Gateways, nur Loop für mehrere Kartons
   - Figure A5 (Unpacking): Keine Error-Gateways, nur Loop für mehrere Kartons

**Vergleich: Picking vs. Storing Error-Handling**

| Aspekt | Picking (A3) | Storing (A6) |
|--------|--------------|--------------|
| Gateway-Text | "Items can be picked?" | "Items can be placed?" |
| Fehlertyp | Missing Item / Damaged | Regal-Problem / Position-Problem |
| Fehler verhindert... | Retrieving (CL139) | Placing (CL138) |
| Loop-Ziel | Picking Travel Time (CL137) | Storing Travel Time (CL137) oder Travel Phase |
| Erscheint in | S1, S3 | S5 |

---

#### 2.1.6 CROSS-PROCESS CONSISTENCY

**NEW IN v5.0:** Analyse identischer vs. unterschiedlicher Aktivitäten

**Identische Activity-Boxen (gleicher Name, gleiche semantische Bedeutung):**

| Label | Aktivität | Picking (A3) | Storing (A6) | Bedeutung |
|-------|-----------|------|------|-----------|
| CL128 | Transporting a Cart to the Base | ✅ Ja | ✅ Ja | Transport Wagen zum Startpunkt (identisch) |
| CL137 | Moving to the Next Position | ✅ Ja | ✅ Ja | Bewegung zur nächsten Position (identisch) |
| CL135 | Reporting and Clarifying the Incident | ✅ Ja | ✅ Ja | Fehlerbehandlung (identisch) |
| CL151 | Placing Cardboard Box/Item in a Cart | ✅ (Picking) | ⚠️ (Storing bei Rückkehr) | Ablage im Wagen |
| CL144 | Sorting | ⚠️ Nur Vergleich | ⚠️ Nur Vergleich | Ware sortieren (beide Packing/Unpacking) |

**Gegenstück-Aktivitäten (logische Umkehrungen):**

| Packing (A4, CL118) | Unpacking (A5, CL117) | Relation |
|-----------------|-------------------|----------|
| Opening Cardboard Box (CL142) | Sealing Cardboard Box (CL150) | **Gegenstück (REVERSE)** |
| Removing Elastic Band (CL149) | Tying Elastic Band Around Cardboard (CL152) | **Gegenstück (REVERSE)** |
| Filling Cardboard Box (CL145) | Disposing of Filling Material (CL143) | **Gegenstück (REVERSE)** |
| Printing Shipping Label (CL146) | [Kein Gegenstück: Label wird gelöscht] | **Einseitig** |
| Attaching Shipping Label (CL148) | [Kein Gegenstück: Label wird entfernt in CL143] | **Einseitig** |

**Anomalien und Besonderheiten:**

1. **"Moving to a Cart" (CL140) – Semantische Ambiguität:**
   - In **Picking (A3):** Logisch = Bewegung VOM Regal ZUM Wagen (mit Ware in der Hand)
   - In **Storing (A6):** Label sagt "to Cart", aber physisch = VOM Wagen ZUM Regal
   - **Status:** ⚠️ Generisches Label, das flexibel interpretiert wird

2. **"Sorting" (CL144) – Kontextabhängig:**
   - In **Packing (A4):** Ware wird AUS dem Wagen IN den Versandkarton sortiert (Outbound)
   - In **Unpacking (A5):** Ware wird AUS dem Versandkarton entnommen und für Einlagerung sortiert (Inbound)
   - **Status:** ✅ Label ist korrekt, aber semantik ist kontextabhängig

3. **"Transporting to Packaging/Sorting Area" (CL129) – Unterschiedliche Quellen:**
   - In **Packing (A4):** Transport VON der Picking-Station zum Packtisch
   - In **Unpacking (A5):** Transport VON Retouren-Wareneingang zum Packtisch
   - **Status:** ✅ Label ist korrekt, Quellen unterscheiden sich

---

### 2.2 TOOL-VALIDIERUNG

#### 2.2.1 Pflicht-Tool-Matrix

Bestimmte CC10-Labels erfordern zwingend spezifische Tools in CC04 (Left Hand) oder CC05 (Right Hand):

```python
MANDATORY_TOOLS = {
    # Opening Cardboard Box
    CL142: {
        "Left": [CL061],   # Knife
        "Right": [CL096],  # Knife
        "Description": "Knife",
        "Process": "Opening Cardboard Box (CL142)",
        "BPMN_Context": "Unpacking (CL117)",
    },
    
    # Filling Cardboard Box with Filling Material
    CL145: {
        "Left": [CL059],   # Bubble Wrap
        "Right": [CL094],  # Bubble Wrap
        "Description": "Bubble Wrap",
        "Process": "Filling Cardboard Box (CL145)",
        "BPMN_Context": "Packing (CL118)",
    },
    
    # Removing Elastic Band
    CL149: {
        "Left": [CL063],   # Elastic Band
        "Right": [CL098],  # Elastic Band
        "Description": "Elastic Band",
        "Process": "Removing Elastic Band (CL149)",
        "BPMN_Context": "Packing (CL118)",
    },
    
    # Sealing Cardboard Box
    CL150: {
        "Left": [CL060],   # Tape Dispenser
        "Right": [CL095],  # Tape Dispenser
        "Description": "Tape Dispenser",
        "Process": "Sealing Cardboard Box (CL150)",
        "BPMN_Context": "Packing (CL118)",
    },
    
    # Printing Shipping Label and Return Slip
    CL146: {
        "Left": [CL058],   # Computer
        "Right": [CL093],  # Computer
        "Description": "Computer",
        "Process": "Printing Shipping Label (CL146)",
        "BPMN_Context": "Packing (CL118)",
    },
    
    # Attaching Shipping Label
    CL148: {
        "Left": [CL062],   # Shipping/Return Label
        "Right": [CL097],  # Shipping/Return Label
        "Description": "Shipping Label",
        "Process": "Attaching Shipping Label (CL148)",
        "BPMN_Context": "Packing (CL118)",
    },
    
    # Preparing or Adding Return Label
    CL147: {
        "Left": [CL062],   # Shipping/Return Label
        "Right": [CL097],  # Shipping/Return Label
        "Description": "Return Label",
        "Process": "Preparing Return Label (CL147)",
        "BPMN_Context": "Packing (CL118)",
    },
    
    # Tying Elastic Band Around Cardboard
    CL152: {
        "Left": [CL063],   # Elastic Band
        "Right": [CL098],  # Elastic Band
        "Description": "Elastic Band",
        "Process": "Tying Elastic Band (CL152)",
        "BPMN_Context": "Unpacking (CL117)",
    },
}
```

#### 2.2.2 Validierungslogik (Frame-Level)

```python
def validate_tool_requirements(df):
    """
    Prüft, ob Pflicht-Tools bei entsprechenden CC10-Labels aktiv sind.
    
    Frame-Level-Validierung: Jedes Frame mit tool-abhängigem CC10 wird geprüft.
    """
    violations = []
    
    for idx, row in df.iterrows():
        cc10 = row['CC10']
        
        # Prüfe, ob CC10 Tool-Anforderungen hat
        if cc10 in MANDATORY_TOOLS:
            required_tools = MANDATORY_TOOLS[cc10]
            
            # Sammle alle aktiven Tools aus CC04 (Left Hand)
            left_tools = [col for col in df.columns if col.startswith('CL0') and 30 <= int(col[2:5]) <= 64 and row[col] == 1]
            
            # Sammle alle aktiven Tools aus CC05 (Right Hand)
            right_tools = [col for col in df.columns if col.startswith('CL0') and 65 <= int(col[2:5]) <= 99 and row[col] == 1]
            
            # Prüfe, ob mindestens eines der erforderlichen Tools aktiv ist
            left_match = any(tool in left_tools for tool in required_tools["Left"])
            right_match = any(tool in right_tools for tool in required_tools["Right"])
            
            if not (left_match or right_match):
                violations.append({
                    "frame": row['frame'],
                    "type": "tool_violation",
                    "severity": "CRITICAL",
                    "cc10": cc10,
                    "required_tool": required_tools["Description"],
                    "required_labels_left": required_tools["Left"],
                    "required_labels_right": required_tools["Right"],
                    "detected_tools_left": left_tools,
                    "detected_tools_right": right_tools,
                    "description": f"Missing required tool '{required_tools['Description']}' for {required_tools['Process']}"
                })
    
    return violations
```

---

### 2.3 LOCATION-VALIDIERUNG

#### 2.3.1 Erwartete Location-Transitions

Bestimmte CC10-Prozesse erfordern spezifische räumliche Transitionen (CC11 Human Location):

```python
EXPECTED_LOCATION_TRANSITIONS = {
    # Collecting Order and Hardware
    CL124: {
        "Start": [CL155],  # Office
        "End": [CL155, CL156, CL157],  # Office oder Cart Area
        "Path": ["Office → Cart Area oder Office"],
        "Process": "Preparing Order (CL114)",
    },
    
    # Collecting Cart
    CL125: {
        "Start": [CL155, CL156],  # Office, Cart Area
        "End": [CL156],  # Cart Area
        "Path": ["Cart Area"],
        "Process": "Preparing Order (CL114)",
    },
    
    # Collecting Empty Cardboard Boxes
    CL126: {
        "Start": [CL155, CL156],  # Office, Cart Area
        "End": [CL157, CL158],  # Cardboard Box Area
        "Path": ["Office → Cardboard Area"],
        "Process": "Preparing Order (CL114 - Retrieval)",
    },
    
    # Transporting a Cart to the Base
    CL128: {
        "Start": [CL155, CL156, CL157],  # Office, Cart Area, Cardboard Area
        "End": [CL161, CL162, CL163],  # Aisles (picking/storing base)
        "Path": ["Office/Cart/Cardboard → Base (Aisle Start)"],
        "Process": "Picking (CL115) or Storing (CL119)",
    },
    
    # Moving to the Next Position (within Aisle)
    CL137: {
        "Start": [CL161, CL162, CL163, CL164, CL165, CL166, CL167],  # Aisles 1-7
        "End": [CL161, CL162, CL163, CL164, CL165, CL166, CL167],  # Aisles 1-7
        "Path": ["Within Aisle (shelves 1-7)"],
        "Process": "Picking (CL115) or Storing (CL119)",
    },
    
    # Retrieving Items (at Shelf)
    CL139: {
        "Start": [CL161, CL162, CL163, CL164, CL165, CL166, CL167],  # Aisles
        "End": [CL161, CL162, CL163, CL164, CL165, CL166, CL167],  # Aisles (hand-to-cart)
        "Path": ["At Shelf (Aisle)"],
        "Process": "Picking (CL116)",
    },
    
    # Placing Items on a Rack (at Shelf)
    CL138: {
        "Start": [CL161, CL162, CL163, CL164, CL165, CL166, CL167],  # Aisles
        "End": [CL161, CL162, CL163, CL164, CL165, CL166, CL167],  # Aisles
        "Path": ["At Shelf (Aisle)"],
        "Process": "Storing (CL120)",
    },
    
    # Placing Cardboard Box/Item on a Table (at Packing Table)
    CL141: {
        "Start": [CL161, CL162, CL163, CL164, CL165, CL166, CL167],  # Aisles (from picking)
        "End": [CL153],  # Packing Table
        "Path": ["Aisle → Packing Table"],
        "Process": "Packing (CL118)",
    },
    
    # Placing Cardboard Box/Item on a Table (at Unpacking Table)
    # (Note: CL141 ist multi-use; hier Unterscheid durch Location-Transition)
    CL141_UNPACK: {
        "Start": [CL154],  # Unpacking Table / Receiving
        "End": [CL154],  # Unpacking Table
        "Path": ["At Unpacking Table"],
        "Process": "Unpacking (CL117)",
    },
}
```

#### 2.3.2 Validierungslogik (Frame-Level)

```python
def validate_location_transitions(df):
    """
    Frame-Level-Validierung mit Transition-Detection:
    - Erkennt Location-Änderungen
    - Vergleicht gegen erwartete Pfade für aktives CC10
    """
    violations = []
    
    for i in range(1, len(df)):
        prev_location = df.iloc[i-1]['CC11']
        curr_location = df.iloc[i]['CC11']
        cc10 = df.iloc[i]['CC10']
        
        # Nur prüfen bei Location-Änderung
        if prev_location == curr_location:
            continue
        
        # Prüfe, ob CC10 Location-Erwartungen hat
        if cc10 in EXPECTED_LOCATION_TRANSITIONS:
            expected = EXPECTED_LOCATION_TRANSITIONS[cc10]
            
            # Prüfe Start-Location
            if prev_location not in expected["Start"]:
                violations.append({
                    "frame": df.iloc[i]['frame'],
                    "type": "location_violation",
                    "severity": "WARNING",
                    "cc10": cc10,
                    "prev_location": prev_location,
                    "curr_location": curr_location,
                    "expected_start": expected["Start"],
                    "expected_end": expected["End"],
                    "expected_path": expected["Path"],
                    "description": f"Invalid start location for {expected['Process']}: Expected {expected['Start']}, got {prev_location}"
                })
            
            # Prüfe End-Location
            if curr_location not in expected["End"]:
                violations.append({
                    "frame": df.iloc[i]['frame'],
                    "type": "location_violation",
                    "severity": "WARNING",
                    "cc10": cc10,
                    "prev_location": prev_location,
                    "curr_location": curr_location,
                    "expected_start": expected["Start"],
                    "expected_end": expected["End"],
                    "expected_path": expected["Path"],
                    "description": f"Invalid end location for {expected['Process']}: Expected {expected['End']}, got {curr_location}"
                })
    
    return violations
```

#### 2.3.3 Teleportation-Detection

```python
def detect_teleportations(df, max_distance=2):
    """
    Erkennt unrealistische Location-Sprünge (Teleportation).
    
    Hintergrund: Worker können nicht sofort von Office (CL155) zu Aisle 5 (CL176) springen.
    Erwartung: Locations sollten über Pfade (CL161-CL167) verbunden sein.
    """
    violations = []
    
    # Definition räumlicher Nachbarschaften
    ADJACENT_LOCATIONS = {
        CL155: [CL156, CL157],  # Office → Cart Area, Cardboard Area
        CL156: [CL155, CL157, CL161],  # Cart Area → Office, Cardboard, Aisle1
        CL157: [CL155, CL156, CL161],  # Cardboard → Office, Cart, Aisle1
        CL161: [CL156, CL157, CL162, CL153],  # Aisle1 → Cart, Cardboard, Aisle2, Packing
        CL162: [CL161, CL163, CL153],  # Aisle2 → Aisle1, Aisle3, Packing
        CL163: [CL162, CL164, CL153],  # Aisle3 → ...
        CL164: [CL163, CL165, CL153],
        CL165: [CL164, CL166, CL154],  # Aisles → Unpacking
        CL166: [CL165, CL167, CL154],
        CL167: [CL166, CL154],  # Last Aisle → Unpacking
        CL153: [CL161, CL162, CL163, CL164],  # Packing Table ↔ Aisles
        CL154: [CL165, CL166, CL167],  # Unpacking Table ↔ Aisles
    }
    
    for i in range(1, len(df)):
        prev_loc = df.iloc[i-1]['CC11']
        curr_loc = df.iloc[i]['CC11']
        
        if prev_loc == curr_loc:
            continue
        
        # Prüfe Nachbarschaft
        if prev_loc in ADJACENT_LOCATIONS:
            if curr_loc not in ADJACENT_LOCATIONS[prev_loc]:
                violations.append({
                    "frame": df.iloc[i]['frame'],
                    "type": "teleportation",
                    "severity": "CRITICAL",
                    "prev_location": prev_loc,
                    "curr_location": curr_loc,
                    "description": f"Unrealistic location jump: {prev_loc} → {curr_loc}"
                })
    
    return violations
```

---

### 2.4 MULTI-ORDER-VALIDIERUNG

#### 2.4.1 Multi-Order Co-Activation Rules

```python
def validate_multi_order_co_activation(df, scenario):
    """
    Prüft, ob Multiple Orders biologisch plausibel und korrekt aktiviert sind.
    
    Multi-Order-Szenarien: S7 (Retrieval, 2 Orders) und S8 (Storage, 2 Orders)
    """
    violations = []
    
    if scenario in ["S7", "S8"]:
        # Erwartung: Zwei vollständige Order-Sequenzen sollten sequenziell ablaufen
        # NICHT parallel oder überlappend
        
        # Pseudocode: Prüfe CC09-Chunks auf Order-Struktur
        chunks = df.groupby('chunk_id')
        order_count = 0
        
        for chunk_id, chunk_df in chunks:
            cc09_set = set(chunk_df['CC09'].unique())
            
            # Erkennung neuer Order: Übergang zu CL114 (Preparing Order) nach CL121
            if CL121 in cc09_set and CL114 in cc09_set:
                order_count += 1
        
        if scenario == "S7" and order_count != 2:
            violations.append({
                "type": "multi_order_violation",
                "severity": "CRITICAL",
                "expected_orders": 2,
                "detected_orders": order_count,
                "description": f"Scenario {scenario} expects 2 Retrieval Orders, detected {order_count}"
            })
        
        if scenario == "S8" and order_count != 2:
            violations.append({
                "type": "multi_order_violation",
                "severity": "CRITICAL",
                "expected_orders": 2,
                "detected_orders": order_count,
                "description": f"Scenario {scenario} expects 2 Storage Orders, detected {order_count}"
            })
    
    return violations
```

---

### 2.5 CL134 (WAITING) PRIORISIERUNG

#### 2.5.1 Global Interrupt Logic

CL134 (Waiting) wird als **Global Interrupt** behandelt:

```python
def validate_cl134_global_interrupt(df):
    """
    Prüft, ob CL134 (Waiting) mit höchster Priorität behandelt wird.
    
    Wenn CL134 aktiv ist, sollte kein anderes CC10-Label gleichzeitig aktiv sein.
    """
    violations = []
    
    for idx, row in df.iterrows():
        if row['CC10'] == CL134:
            # Prüfe, ob andere CC10-Labels gleichzeitig aktiv sind
            # (Dies sollte nicht vorkommen)
            if len(row[row.startswith('CL')].sum()) > 1:
                violations.append({
                    "frame": row['frame'],
                    "type": "cl134_not_prioritized",
                    "severity": "WARNING",
                    "cc10": "CL134",
                    "active_cc10": row[row.startswith('CL')][row[row.startswith('CL')] == 1].index.tolist(),
                    "description": "CL134 (Waiting) should be exclusive; other CC10-labels detected"
                })
    
    return violations
```

---

## 3. BPMN-GENERIERUNG

### 3.1 JSON-Schema für BPMN-Graphen

#### 3.1.1 Node-Typen

```json
{
  "nodeTypes": {
    "startEvent": "Rundes Start-Symbol",
    "endEvent": "Rundes End-Symbol",
    "task": "Rechteckige Aktivität (CC09 Mid-Level Process)",
    "exclusiveGateway": "Rautenförmiger XOR-Gateway (Entscheidungspunkt)",
    "parallelGateway": "Rautenförmiger AND-Gateway (Parallele Pfade)"
  }
}
```

#### 3.1.2 Vollständiges Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "DaRa BPMN Process Graph",
  "type": "object",
  "required": ["subject_id", "scenario", "bpmn_graph", "metadata"],
  "properties": {
    "subject_id": {
      "type": "string",
      "description": "Probanden-ID (S01-S18)",
      "pattern": "^S(0[1-9]|1[0-8])$"
    },
    "scenario": {
      "type": "string",
      "description": "Szenario-ID (S1-S8, Other)",
      "enum": ["S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "Other"]
    },
    "session": {
      "type": "integer",
      "description": "Session-Nummer (1-6)",
      "minimum": 1,
      "maximum": 6
    },
    "bpmn_graph": {
      "type": "object",
      "required": ["nodes", "edges"],
      "properties": {
        "nodes": {
          "type": "array",
          "items": {
            "type": "object",
            "required": ["id", "name", "type"],
            "properties": {
              "id": {
                "type": "string",
                "description": "Unique node identifier (e.g., 'start_1', 'task_CL114', 'gateway_1')"
              },
              "name": {
                "type": "string",
                "description": "Human-readable node name"
              },
              "type": {
                "type": "string",
                "enum": ["startEvent", "endEvent", "task", "exclusiveGateway", "parallelGateway"]
              },
              "cc09": {
                "type": "string",
                "description": "CC09 label if type is task (e.g., 'CL114')"
              },
              "frame_start": {
                "type": "integer",
                "description": "Start-Frame dieser Task"
              },
              "frame_end": {
                "type": "integer",
                "description": "End-Frame dieser Task"
              },
              "duration_frames": {
                "type": "integer",
                "description": "Dauer in Frames"
              },
              "duration_seconds": {
                "type": "number",
                "description": "Dauer in Sekunden (bei 100 Hz)"
              },
              "violations": {
                "type": "array",
                "description": "Liste von Abweichungen innerhalb dieser Task",
                "items": {
                  "type": "object"
                }
              }
            }
          }
        },
        "edges": {
          "type": "array",
          "items": {
            "type": "object",
            "required": ["source", "target"],
            "properties": {
              "source": {
                "type": "string",
                "description": "Source Node-ID"
              },
              "target": {
                "type": "string",
                "description": "Target Node-ID"
              },
              "label": {
                "type": "string",
                "description": "Gateway-Bedingung (z.B. 'Retrieval', 'YES', 'NO')"
              },
              "transition_type": {
                "type": "string",
                "enum": ["sequence", "loop", "conditional"],
                "description": "Art der Transition"
              }
            }
          }
        }
      }
    },
    "metadata": {
      "type": "object",
      "properties": {
        "total_frames": {
          "type": "integer"
        },
        "total_duration_seconds": {
          "type": "number"
        },
        "process_phases": {
          "type": "object",
          "description": "Aggregierte Statistiken pro CC09-Phase",
          "additionalProperties": {
            "type": "object",
            "properties": {
              "count": {"type": "integer"},
              "total_frames": {"type": "integer"},
              "total_duration_seconds": {"type": "number"}
            }
          }
        },
        "validation_summary": {
          "type": "object",
          "properties": {
            "total_violations": {"type": "integer"},
            "critical": {"type": "integer"},
            "warning": {"type": "integer"},
            "info": {"type": "integer"}
          }
        }
      }
    },
    "deviations": {
      "type": "array",
      "description": "Vollständige Liste aller Abweichungen vom idealen BPMN",
      "items": {
        "type": "object",
        "required": ["frame", "type", "severity", "description"],
        "properties": {
          "frame": {"type": "integer"},
          "chunk_id": {"type": "integer"},
          "type": {
            "type": "string",
            "enum": [
              "sequence_violation",
              "tool_violation",
              "location_violation",
              "multi_order_violation",
              "teleportation",
              "chunk_instability",
              "noisy_transition",
              "cl134_not_prioritized",
              "post_waiting_continuation",
              "multi_order_loop_missing",
              "multi_order_incomplete"
            ]
          },
          "severity": {
            "type": "string",
            "enum": ["CRITICAL", "WARNING", "INFO"]
          },
          "description": {"type": "string"},
          "prev_cc09": {"type": "string"},
          "curr_cc09": {"type": "string"},
          "expected": {"type": "array"},
          "cc10": {"type": "string"},
          "required_tool": {"type": "string"},
          "prev_location": {"type": "string"},
          "curr_location": {"type": "string"}
        }
      }
    }
  }
}
```

---

### 3.2 BPMN-Generierungsfunktion

```python
def generate_bpmn_from_data(df, subject_id, scenario, session):
    """
    Generiert BPMN-JSON-Struktur aus tatsächlichen Prozessdaten.
    
    Parameters:
    - df: DataFrame mit Columns ['frame', 'CC09', 'CC10', 'chunk_id', ...]
    - subject_id: Probanden-ID (z.B. 'S14')
    - scenario: Szenario-ID (z.B. 'S1')
    - session: Session-Nummer (1-6)
    
    Returns:
    - Vollständige BPMN-JSON-Struktur
    """
    
    # Initialisiere BPMN-Struktur
    bpmn = {
        "subject_id": subject_id,
        "scenario": scenario,
        "session": session,
        "bpmn_graph": {
            "nodes": [],
            "edges": []
        },
        "metadata": {},
        "deviations": []
    }
    
    # 1. Start-Node
    bpmn["bpmn_graph"]["nodes"].append({
        "id": "start_1",
        "name": "Start",
        "type": "startEvent"
    })
    
    # 2. Task-Nodes aus CC09-Sequenz
    cc09_chunks = df.groupby('chunk_id')['CC09'].apply(lambda x: x.mode()[0] if len(x.mode()) > 0 else x.iloc[0]).reset_index()
    
    for idx, row in cc09_chunks.iterrows():
        cc09 = row['CC09']
        chunk_id = row['chunk_id']
        chunk_df = df[df['chunk_id'] == chunk_id]
        
        node_id = f"task_{cc09}_{idx}"
        bpmn["bpmn_graph"]["nodes"].append({
            "id": node_id,
            "name": f"{cc09}",
            "type": "task",
            "cc09": cc09,
            "frame_start": chunk_df['frame'].min(),
            "frame_end": chunk_df['frame'].max(),
            "duration_frames": len(chunk_df),
            "duration_seconds": round(len(chunk_df) / 100.0, 2)
        })
    
    # 3. End-Node
    bpmn["bpmn_graph"]["nodes"].append({
        "id": "end_1",
        "name": "End",
        "type": "endEvent"
    })
    
    # 4. Edges (Transitions)
    prev_node = "start_1"
    for idx in range(len(cc09_chunks)):
        curr_node = f"task_{cc09_chunks.iloc[idx]['CC09']}_{idx}"
        bpmn["bpmn_graph"]["edges"].append({
            "source": prev_node,
            "target": curr_node,
            "transition_type": "sequence"
        })
        prev_node = curr_node
    
    # Verbinde letzten Task mit End
    bpmn["bpmn_graph"]["edges"].append({
        "source": prev_node,
        "target": "end_1",
        "transition_type": "sequence"
    })
    
    # 5. Metadata
    bpmn["metadata"] = {
        "total_frames": len(df),
        "total_duration_seconds": round(len(df) / 100.0, 2),
        "process_phases": calculate_phase_statistics(df),
        "validation_summary": {
            "total_violations": len(bpmn["deviations"]),
            "critical": len([v for v in bpmn["deviations"] if v["severity"] == "CRITICAL"]),
            "warning": len([v for v in bpmn["deviations"] if v["severity"] == "WARNING"]),
            "info": len([v for v in bpmn["deviations"] if v["severity"] == "INFO"])
        }
    }
    
    return bpmn

def get_label_name(label_code):
    """Gibt den Klarnamen für ein Label zurück."""
    LABEL_NAMES = {
        "CL114": "Preparing Order",
        "CL115": "Picking - Travel Time",
        "CL116": "Picking - Pick Time",
        "CL117": "Unpacking",
        "CL118": "Packing",
        "CL119": "Storing - Travel Time",
        "CL120": "Storing - Store Time",
        "CL121": "Finalizing Order",
    }
    return LABEL_NAMES.get(label_code, "Unknown")

def calculate_phase_statistics(df):
    """Berechnet aggregierte Statistiken pro CC09-Phase."""
    stats = {}
    for cc09 in df['CC09'].unique():
        phase_df = df[df['CC09'] == cc09]
        stats[cc09] = {
            "count": len(phase_df),
            "total_frames": len(phase_df),
            "total_duration_seconds": round(len(phase_df) / 100.0, 2)
        }
    return stats
```

---

### 3.3 Mermaid-Syntax-Export

```python
def generate_mermaid_from_bpmn(bpmn_json):
    """
    Konvertiert BPMN-JSON zu Mermaid-Flowchart-Syntax.
    
    Output kann direkt mit Mermaid Chart Tool gerendert werden.
    """
    mermaid_lines = ["graph TD"]
    
    # Nodes
    for node in bpmn_json["bpmn_graph"]["nodes"]:
        node_id = node["id"]
        node_name = node["name"]
        node_type = node["type"]
        
        if node_type == "startEvent":
            mermaid_lines.append(f"    {node_id}[ðŸŸ¢ {node_name}]")
        elif node_type == "endEvent":
            mermaid_lines.append(f"    {node_id}[ðŸ”´ {node_name}]")
        elif node_type == "task":
            duration = node.get("duration_seconds", "?")
            mermaid_lines.append(f"    {node_id}['{node_name}<br/>({duration}s)']")
        elif node_type == "exclusiveGateway":
            mermaid_lines.append(f"    {node_id}{{'{node_name}'}}")
    
    # Edges
    for edge in bpmn_json["bpmn_graph"]["edges"]:
        source = edge["source"]
        target = edge["target"]
        label = edge.get("label", "")
        
        if label:
            mermaid_lines.append(f"    {source} -->|{label}| {target}")
        else:
            mermaid_lines.append(f"    {source} --> {target}")
    
    return "\n".join(mermaid_lines)
```

---

### 3.4 IST vs. SOLL Vergleich

```python
def compare_bpmn_ist_soll(ist_bpmn, scenario):
    """
    Vergleicht tatsächlich durchgeführten Prozess (IST) mit idealem BPMN (SOLL).
    
    Returns:
    - Diff-Struktur mit fehlenden/zusätzlichen Nodes und Sequenzabweichungen
    """
    # SOLL-Sequenzen aus Section 2.1.2
    SOLL_SEQUENCES = {
        "S1": ["CL114", "CL115", "CL116", "CL118", "CL121"],
        "S2": ["CL114", "CL115", "CL116", "CL121"],
        "S3": ["CL114", "CL115", "CL116", "CL118", "CL121"],
        "S4": ["CL114", "CL117", "CL119", "CL120", "CL121"],
        "S5": ["CL114", "CL117", "CL119", "CL120", "CL121"],
        "S6": ["CL114", "CL117", "CL119", "CL120", "CL121"],
        "S7": ["CL114", "CL115", "CL116", "CL118", "CL121", "CL114", "CL115", "CL116", "CL121"],
        "S8": ["CL114", "CL117", "CL119", "CL120", "CL121", "CL114", "CL117", "CL119", "CL120", "CL121"],
    }
    
    soll_sequence = SOLL_SEQUENCES.get(scenario, [])
    
    # Extrahiere IST-Sequenz
    ist_sequence = [node["cc09"] for node in ist_bpmn["bpmn_graph"]["nodes"] if node["type"] == "task"]
    
    # Diff berechnen
    missing_nodes = [cc09 for cc09 in soll_sequence if cc09 not in ist_sequence]
    extra_nodes = [cc09 for cc09 in ist_sequence if cc09 not in soll_sequence]
    
    # Sequenzabweichungen
    sequence_deviations = 0
    for i in range(min(len(ist_sequence), len(soll_sequence))):
        if ist_sequence[i] != soll_sequence[i]:
            sequence_deviations += 1
    
    diff = {
        "scenario": scenario,
        "soll_sequence": soll_sequence,
        "ist_sequence": ist_sequence,
        "missing_nodes": missing_nodes,
        "extra_nodes": extra_nodes,
        "sequence_deviations": sequence_deviations,
        "conformity_score": round((1 - sequence_deviations / max(len(ist_sequence), len(soll_sequence))) * 100, 2)
    }
    
    return diff
```

---

## 4. ABWEICHUNGS-KATEGORIEN

### 4.1 Severity-Klassifikation

- **CRITICAL:** Fundamentale BPMN-Logik verletzt
- **WARNING:** Ungewöhnlich, aber nicht ausgeschlossen
- **INFO:** Abweichung ohne direkten Fehler

### 4.2 Violation-Typ-Katalog

11 Violation-Typen sind definiert (siehe JSON-Schema Section 3.1.2):
1. sequence_violation
2. tool_violation
3. location_violation
4. multi_order_violation
5. teleportation
6. chunk_instability
7. noisy_transition
8. cl134_not_prioritized
9. post_waiting_continuation
10. multi_order_loop_missing
11. multi_order_incomplete

---

## 5. VERWENDUNGSBEISPIELE

### 5.1 Single-Subject-Validierung

```python
# Lade Daten für Subject S14, Scenario S1, Session 3
df = load_proband_data("S14", "S1", session=3)

# Führe alle Validierungen durch
violations = []
violations.extend(validate_cc09_sequence(df, chunk_level=True))
violations.extend(validate_tool_requirements(df))
violations.extend(validate_location_transitions(df))
violations.extend(detect_teleportations(df))
violations.extend(validate_multi_order_co_activation(df, scenario="S1"))
violations.extend(validate_cl134_global_interrupt(df))

# Generiere BPMN-Graph
bpmn = generate_bpmn_from_data(df, "S14", "S1", 3)
bpmn["deviations"] = violations

# Exportiere als Mermaid
mermaid_code = generate_mermaid_from_bpmn(bpmn)
print(mermaid_code)

# Exportiere als JSON
import json
with open("bpmn_S14_S1_session3.json", "w") as f:
    json.dump(bpmn, f, indent=2)
```

---

### 5.2 Scenario-Specific-Validierung

```python
# Validiere alle Subjects in Scenario S7 (Multi-Order Retrieval)
for subject_id in ["S01", "S02", ..., "S18"]:
    for session in range(1, 7):
        df = load_proband_data(subject_id, "S7", session=session)
        
        # S7-spezifische Validierung
        violations = validate_multi_order_co_activation(df, scenario="S7")
        
        if violations:
            print(f"{subject_id} Session {session}: Multi-Order Issues Detected")
```

---

## 6. ERWEITERUNGEN

### 6.1 Probabilistic Sequence Validation

```python
def validate_sequence_probabilistic(df, confidence=0.95):
    """
    Probabilistische Validierung basierend auf Häufigkeit beobachteter Übergänge.
    
    Nutzt Markov-Chain-Analyse über alle Probanden.
    """
    # Build transition matrix
    transition_matrix = build_transition_matrix(df)
    
    # Prüfe, ob Übergänge unter Confidence-Threshold fallen
    violations = []
    for i in range(len(df) - 1):
        from_cc09 = df.iloc[i]['CC09']
        to_cc09 = df.iloc[i+1]['CC09']
        
        if transition_matrix[from_cc09][to_cc09] < (1 - confidence):
            violations.append({
                "frame": df.iloc[i]['frame'],
                "type": "sequence_violation",
                "severity": "WARNING",
                "prev_cc09": from_cc09,
                "curr_cc09": to_cc09,
                "probability": transition_matrix[from_cc09][to_cc09],
                "confidence_threshold": confidence
            })
    
    return violations
```

---

### 6.2 BPMN-Diff-Visualisierung

```python
def visualize_bpmn_diff(ist_bpmn, soll_bpmn):
    """
    Visualisiert Unterschiede zwischen IST und SOLL mittels Farbcodierung.
    
    - Grün: Matches SOLL
    - Rot: Extra Nodes (nicht in SOLL)
    - Orange: Missing Nodes (erwartet, aber nicht in IST)
    """
    mermaid_lines = ["graph TD"]
    
    soll_nodes = {node["cc09"]: node for node in soll_bpmn["bpmn_graph"]["nodes"] if node["type"] == "task"}
    ist_nodes = {node["cc09"]: node for node in ist_bpmn["bpmn_graph"]["nodes"] if node["type"] == "task"}
    
    # Draw IST nodes with color coding
    for cc09, node in ist_nodes.items():
        node_id = node["id"]
        node_name = node["name"]
        
        if cc09 in soll_nodes:
            # Match: Green
            mermaid_lines.append(f"    {node_id}['{node_name}']")
            mermaid_lines.append(f"    style {node_id} fill:#90EE90")
        else:
            # Extra: Red
            mermaid_lines.append(f"    {node_id}['{node_name}<br/>EXTRA']")
            mermaid_lines.append(f"    style {node_id} fill:#FF6B6B")
    
    # Highlight missing nodes
    for cc09 in soll_nodes:
        if cc09 not in ist_nodes:
            node_id = f"missing_{cc09}"
            mermaid_lines.append(f"    {node_id}[{cc09}<br/>MISSING]")
            mermaid_lines.append(f"    style {node_id} fill:#FFA500,stroke:#FF6347,stroke-dasharray: 5 5")
    
    # Edges (aus IST-BPMN)
    for edge in ist_bpmn["bpmn_graph"]["edges"]:
        source = edge["source"]
        target = edge["target"]
        mermaid_lines.append(f"    {source} --> {target}")
    
    return "\n".join(mermaid_lines)
```

---

### 6.3 Automatische Fehlerursachen-Hypothesen

```python
def generate_error_hypothesis(violation):
    """
    Generiert automatische Hypothesen für Abweichungsursachen.
    
    Nutzt regelbasierte Heuristiken + LLM-Unterstützung.
    """
    hypotheses = []
    
    if violation["type"] == "sequence_violation":
        prev = violation["prev_cc09"]
        curr = violation["curr_cc09"]
        
        # Heuristik 1: Retrieval → Storage Sprung
        if prev in ["CL115", "CL116"] and curr in ["CL119", "CL120"]:
            hypotheses.append({
                "hypothesis": "Proband hat versehentlich zu Storage-Prozess gewechselt",
                "likelihood": "MEDIUM",
                "evidence": "Ungültige Transition von Retrieval zu Storage"
            })
            hypotheses.append({
                "hypothesis": "Annotation-Fehler: Frame sollte anderes CC09 haben",
                "likelihood": "HIGH",
                "evidence": "Abrupter Prozesswechsel ohne logischen Grund"
            })
        
        # Heuristik 2: Fehlende Zwischenschritte
        if prev == "CL115" and curr == "CL121":
            hypotheses.append({
                "hypothesis": "Picking wurde abgebrochen (z.B. Item nicht verfügbar)",
                "likelihood": "HIGH",
                "evidence": "Direct Finalize ohne Pick Time"
            })
    
    elif violation["type"] == "tool_violation":
        hypotheses.append({
            "hypothesis": "Tool wurde nicht annotiert (Annotationsfehler)",
            "likelihood": "HIGH",
            "evidence": "Prozess erfordert Tool, aber keines aktiv"
        })
        hypotheses.append({
            "hypothesis": "Proband hat Tool nicht verwendet (Prozessabweichung)",
            "likelihood": "MEDIUM",
            "evidence": "Reale Abweichung von Standard-Prozedur"
        })
    
    return hypotheses
```

---

## 7. VERWENDUNGSHINWEISE

**Diese Datei nutzen für:**
- Vollständige BPMN-Validierung von Probandendaten
- Generierung von IST-BPMN-Graphen
- Abweichungsanalyse und Fehlerreporting
- Vergleich zwischen idealem und tatsächlichem Prozess
- Detaillierte Prozessflow-Analyse (Figures A2-A7)
- Szenario-spezifische Validierung (S1-S8)
- Error-Handling-Logik und CL135-Bedingungen

**Nicht in dieser Datei:**
- Rohdaten-Processing (siehe auxiliary_data_structure_v5_0.md)
- Label-Definitionen (siehe core_labels_207_v5_0.md)
- Szenario-Definitionen (siehe core_ground_truth_central_v5_0.md)
- REFA-Zeitarten (siehe processes_refa_analytics_v5_0.md)

**Querverweise (v5.0):**
- core_ground_truth_central_v5_0.md: Szenario-Definitionen
- processes_process_hierarchy_v5_0.md: Prozess-Dokumentation
- auxiliary_warehouse_physical_v5_0.md: Lagerlayout-Kontext
- core_validation_rules_v5_0.md: Validierungs-Matrix

---

**Version:** 5.0  
**Erstellt:** 05.02.2026  
**Status:** finalisiert ✅  
**Autor:** Phase 2+3 Analyse, Umsetzung & NotebookLM Integration  
**BPMN-Quelle:** Figures A2-A7 aus BPMN_PROZESSE_DARA.pdf  
**Nächste Phase:** Phase 4 (Konsolidierungsanalyse)
