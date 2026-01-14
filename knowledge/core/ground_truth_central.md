# DaRa Dataset – Ground Truth Central (v2.6)

**Zentrale Quelle für alle Szenario-Definitionen und Erkennungslogik**

**Skill-Version:** 2.6 (07.01.2026)  
**Quelle:** DaRa Dataset Description (Table 3) + DaRA Logic v8

---

## 📚 INHALTSVERZEICHNIS

1. [Szenario-Übersicht](#szenario-übersicht)
2. [Ground Truth Matrix](#ground-truth-matrix)
3. [Szenario-Profile (S1-S8 + Other)](#szenario-profile)
4. [Erkennungslogik](#erkennungslogik)
5. [Decision Tree](#decision-tree)

---

## 1. SZENARIO-ÜBERSICHT

Der DaRa-Datensatz umfasst **8 definierte Szenarien (S1-S8)** plus die Restkategorie **"Other"**.

### Retrieval-Szenarien (Kommissionierung)

- **S1** – Standard Retrieval (Pen, Order 2904*, Errors möglich)
- **S2** – Variant Retrieval (PDT, Order 2905*, keine Errors)
- **S3** – Error Retrieval (Scanner, Order 2906*, Errors möglich)
- **S7** – Multi-Order Retrieval Perfect Run (Pen, Orders 2904+2905)

*Hybrid-Logic: Order ist sekundär, IT-System ist primärer Diskriminator für S1-S3

### Storage-Szenarien (Einlagerung)

- **S4** – Standard Storage (Pen, Order 2904)
- **S5** – Variant Storage (Pen, Order 2905)
- **S6** – Storage (Pen, Order 2906)
- **S8** – Multi-Order Storage Perfect Run (Pen, Orders 2904+2905)

### Restkategorie

- **Other** – Wartezeiten, Übergänge, Synchronisationen

---

## 2. GROUND TRUTH MATRIX

### 2.1 Vollständige Matrix (6 Dimensionen + "Other")

| Szenario | CC08 (High) | CC09 (Mid-Level) | Strategy | CC07 (IT) | CC06 (Order) | Errors |
|:--------:|:-----------:|:----------------:|:--------:|:---------:|:------------:|:------:|
| **S1** | CL110 | Picking+Packing | Single | CL105 | CL100* | Yes |
| **S2** | CL110 | Picking+Packing | Single | CL107 | CL101* | No |
| **S3** | CL110 | Picking+Packing | Single | CL106 | CL102* | Yes |
| **S4** | CL111 | Unpacking+Storing | Single | CL105 | **CL100** | No |
| **S5** | CL111 | Unpacking+Storing | Single | CL105 | **CL101** | No |
| **S6** | CL111 | Unpacking+Storing | Single | CL105 | **CL102** | No |
| **S7** | CL110 | Picking+Packing | **Multi** | CL105 | **CL100+CL101** | No |
| **S8** | CL111 | Unpacking+Storing | **Multi** | CL105 | **CL100+CL101** | No |
| **Other** | **CL112/113** | - | - | CL108 | CL103 | - |

**\*** Beliebig = CL100, CL101 oder CL102 (Hybrid-Logic: IT-System ist Diskriminator)

**Legende:**
- **Fettdruck** = Eindeutige Diskriminatoren
- CC09 (Neu in v2.5): Primäre Dimension zur Prozess-Unterscheidung
- "Other": Restkategorie – **MUSS erkannt werden!**

**Hybrid-Logic (v3.0):**
- *S1-S3 (Retrieval):* Order-Zuordnung ist sekundär (CL100/CL101/CL102), IT-System ist primärer Diskriminator
- *S4-S6 (Storage):* Order-Zuordnung ist primär, IT-System ist konstant (CL105)
- Dokumentation siehe: articles_inventory.md (Order 2904 = CL100, Order 2905 = CL101, Order 2906 = CL102)

---

### 2.2 "Other"-Erkennung (Erweitert v2.6)

**"Other"-Trigger (Priorität 1):**

1. **CL134 (Waiting)** – Global Interrupt, Hard Cut (höchste Priorität!)
2. **CL112 (Another High-Level Process)** – Anderer Prozess als Retrieval/Storage
3. **CL113 (High-Level Process Unknown)** – Prozess unklar
4. **CL103+CL108 (No Order + No IT)** – Kein aktiver Prozess

**Erkennungsregel:**
```python
if (CL134==1) OR (CC08 in [CL112, CL113]) OR (CL103==1 AND CL108==1):
    return "Other"
```

**Wichtig:** CL134 überschreibt ALLE anderen Labels!

---

## 3. SZENARIO-PROFILE

### S1: Standard Retrieval (Error Run)

| Dimension | Wert | Label | Hybrid-Logic |
|-----------|------|-------|--------------|
| High-Level Process | Retrieval | CL110 | |
| Mid-Level Process | Picking + Packing | CL115/116/118 | |
| Picking Strategy | Single-Order | - | |
| Information Technology | List + Pen | CL105 | **Diskriminator** |
| Customer Order | **Beliebig (2904, 2905 oder 2906)** | **CL100, CL101 oder CL102** | **Irrelevant** |
| Errors | **Yes** | CL135 möglich | |

**Charakteristik:** Kommissionierung mit Papierliste, absichtliche Fehler im Auftrag.

**Hybrid-Logic:** IT-System (CL105) identifiziert S1, Order-ID ist **irrelevant**.

**CC09-Validierung:** MUSS CL115/116 haben, DARF NICHT CL117/119/120 haben

---

### S2: Variant Retrieval (PDT)

| Dimension | Wert | Label | Hybrid-Logic |
|-----------|------|-------|--------------|
| High-Level Process | Retrieval | CL110 | |
| Mid-Level Process | Picking + Packing | CL115/116/118 | |
| Picking Strategy | Single-Order | - | |
| Information Technology | **Portable Data Terminal** | **CL107** | **Diskriminator (100% eindeutig)** |
| Customer Order | **Beliebig (2904, 2905 oder 2906)** | **CL100, CL101 oder CL102** | **Irrelevant** |
| Errors | No | - | |

**Charakteristik:** Einziges Szenario mit PDT. 100% eindeutig identifizierbar.

**Hybrid-Logic:** IT-System (CL107) identifiziert S2, Order-ID ist **irrelevant**.

**CC09-Validierung:** MUSS CL115/116 haben, DARF NICHT CL117/119/120 haben

---

### S3: Error Retrieval (Scanner)

| Dimension | Wert | Label | Hybrid-Logic |
|-----------|------|-------|--------------|
| High-Level Process | Retrieval | CL110 | |
| Mid-Level Process | Picking + Packing | CL115/116/118 | |
| Picking Strategy | Single-Order | - | |
| Information Technology | **List + Glove Scanner** | **CL106** | **Diskriminator (100% eindeutig)** |
| Customer Order | **Beliebig (2904, 2905 oder 2906)** | **CL100, CL101 oder CL102** | **Irrelevant** |
| Errors | **Yes** | CL135 möglich | |

**Charakteristik:** Einziges Szenario mit Handschuh-Scanner. 100% eindeutig.

**Hybrid-Logic:** IT-System (CL106) identifiziert S3, Order-ID ist **irrelevant**.

**CC09-Validierung:** MUSS CL115/116 haben, DARF NICHT CL117/119/120 haben

---

### S4: Standard Storage

| Dimension | Wert | Label | Hybrid-Logic |
|-----------|------|-------|--------------|
| High-Level Process | Storage | CL111 | |
| Mid-Level Process | Unpacking + Storing | CL117/119/120 | |
| Picking Strategy | Single-Order | - | |
| Information Technology | List + Pen | CL105 | Konstant |
| Customer Order | **2904** | **CL100** | **Diskriminator** |
| Errors | No | - | |

**Charakteristik:** Einlagerung mit Order 2904.

**Hybrid-Logic:** IT-System konstant (CL105), Order-ID (CL100) identifiziert S4.

**CC09-Validierung:** MUSS CL119/120 haben, DARF NICHT CL115/116/118 haben

---

### S5: Variant Storage

| Dimension | Wert | Label | Hybrid-Logic |
|-----------|------|-------|--------------|
| High-Level Process | Storage | CL111 | |
| Mid-Level Process | Unpacking + Storing | CL117/119/120 | |
| Picking Strategy | Single-Order | - | |
| Information Technology | List + Pen | CL105 | Konstant |
| Customer Order | **2905** | **CL101** | **Diskriminator** |
| Errors | No | - | |

**Charakteristik:** Einlagerung mit Order 2905. Unterschied zu S4 nur durch Order.

**Hybrid-Logic:** IT-System konstant (CL105), Order-ID (CL101) identifiziert S5.

**CC09-Validierung:** MUSS CL119/120 haben, DARF NICHT CL115/116/118 haben

---

### S6: Storage (Order 2906)

| Dimension | Wert | Label | Hybrid-Logic |
|-----------|------|-------|--------------|
| High-Level Process | Storage | CL111 | |
| Mid-Level Process | Unpacking + Storing | CL117/119/120 | |
| Picking Strategy | Single-Order | - | |
| Information Technology | List + Pen | CL105 | Konstant |
| Customer Order | **2906** | **CL102** | **Diskriminator** |
| Errors | No | - | |

**Charakteristik:** Einlagerung mit Order 2906. Simuliert Wareneingang.

**Hybrid-Logic:** IT-System konstant (CL105), Order-ID (CL102) identifiziert S6.

**CC09-Validierung:** MUSS CL119/120 haben, DARF NICHT CL115/116/118 haben

---

### S7: Multi-Order Retrieval

| Dimension | Wert | Label | Hybrid-Logic |
|-----------|------|-------|--------------|
| High-Level Process | Retrieval | CL110 | |
| Mid-Level Process | Picking + Packing | CL115/116/118 | |
| Picking Strategy | **Multi-Order** | - | **Diskriminator** |
| Information Technology | List + Pen | CL105 | |
| Customer Order | **2904 + 2905** | **CL100 + CL101** | Beide gleichzeitig |
| Errors | No | - | |

**Charakteristik:** Zwei Orders parallel (2904 + 2905). Order-Wechsel innerhalb des Blocks ist normal.

**Hybrid-Logic:** Multi-Order (CL100+CL101) + Retrieval identifiziert S7.

**CC09-Validierung:** MUSS CL115/116 haben, DARF NICHT CL117/119/120 haben

---

### S8: Multi-Order Storage

| Dimension | Wert | Label | Hybrid-Logic |
|-----------|------|-------|--------------|
| High-Level Process | Storage | CL111 | |
| Mid-Level Process | Unpacking + Storing | CL117/119/120 | |
| Picking Strategy | **Multi-Order** | - | **Diskriminator** |
| Information Technology | List + Pen | CL105 | |
| Customer Order | **2904 + 2905** | **CL100 + CL101** | Beide gleichzeitig |
| Errors | No | - | |

**Charakteristik:** Zwei Orders parallel (2904 + 2905). Gleiche Order-Kombination wie S7.

**Hybrid-Logic:** Multi-Order (CL100+CL101) + Storage identifiziert S8.

**CC09-Validierung:** MUSS CL119/120 haben, DARF NICHT CL115/116/118 haben

---

### "Other": Restkategorie

| Dimension | Wert | Label |
|-----------|------|-------|
| High-Level Process | **Another / Unknown** | **CL112 / CL113** |
| **Idle-Cut** | **Waiting** | **CL134** |
| Information Technology | No IT | CL108 |
| Customer Order | No Order | CL103 |

**Charakteristik:** Vorbereitungs-, Warte-, Synchronisationszeiten außerhalb der Szenarien.

**Wichtig:** "Other" ist **KEIN 9. Szenario**, sondern eine Restkategorie, die **aktiv erkannt werden MUSS**, um False-Positives zu verhindern!

---

## 4. ERKENNUNGSLOGIK

### 4.1 Hybrid-Identification-Logic (v2.6)

**Asymmetrische Erkennungslogik für Single-Order Szenarien:**

#### Retrieval (S1-S3): IT-System = Diskriminator

```
Order-ID ist IRRELEVANT
→ S2: Wenn CL107 (PDT) aktiv
→ S3: Wenn CL106 (Scanner) aktiv
→ S1: Wenn CL105 (Pen) aktiv
```

**Begründung:** IT-System variiert zwischen S1-S3, ist stabiler Marker.

#### Storage (S4-S6): Order-ID = Diskriminator

```
IT-System konstant (immer CL105)
→ S4: Wenn CL100 (Order 2904) aktiv
→ S5: Wenn CL101 (Order 2905) aktiv
→ S6: Wenn CL102 (Order 2906) aktiv
```

**Begründung:** Order-ID variiert zwischen S4-S6, IT ist konstant.

---

### 4.2 Evidence-Based Scoring System (v2.6)

**Formel:**
```python
Score_Retrieval = (CL110 × 3) + (Max(CL126, CL130, CL149) × 5)
Score_Storage = (CL111 × 3) + (Max(CL127, CL131, CL152, CL142) × 5)

# Entscheidung
if Score_Retrieval > Score_Storage:
    process_type = "Retrieval"
else:
    process_type = "Storage"
```

**Gewichtung 3:5:** Low-Level-Beweise (CC10) überschreiben High-Level-Labels (CC08).

**CC10-Marker:**

| Marker | Label | Funktion |
|--------|-------|----------|
| CL126 | Collecting Empty Cardboard Boxes | Retrieval-Beweis |
| CL130 | Handing Over Packed Cardboard Boxes | Retrieval-Beweis |
| CL149 | Removing Elastic Band | Retrieval-Beweis |
| CL127 | Collecting Packed Cardboard Boxes | Storage-Beweis |
| CL131 | Returning Empty Cardboard Boxes | Storage-Beweis |
| CL152 | Tying Elastic Band Around Cardboard | Storage-Beweis |
| CL142 | Opening Cardboard Box | Storage-Beweis |

---

## 5. DECISION TREE

```
Frame analysieren:
│
├─ [1] GLOBAL INTERRUPTS (🔴 PRIORITÄT 1)
│   │
│   ├─ CL134 = 1 (Waiting)?  ← HÖCHSTE PRIORITÄT!
│   │   └─ JA → "Other" ✓ (HARD CUT, STOP)
│   │
│   ├─ CC08 in [CL112, CL113]?
│   │   └─ JA → "Other" ✓ (STOP)
│   │
│   ├─ (CL103 = 1 UND CL108 = 1)?
│   │   └─ JA → "Other" ✓ (STOP)
│   │
│   └─ NEIN → Weiter zu Schritt 2
│
├─ [2] EVIDENCE-BASED SCORING
│   │
│   ├─ Score_Retrieval = (CL110 × 3) + (Max(CL126,CL130,CL149) × 5)
│   ├─ Score_Storage = (CL111 × 3) + (Max(CL127,CL131,CL152,CL142) × 5)
│   │
│   └─ IF Score_Retrieval > Score_Storage:
│       └─ process_type = "Retrieval"
│       └─ ELSE: process_type = "Storage"
│
├─ [3] CC09 VALIDIERUNG
│   │
│   ├─ IF Retrieval: MUSS CL115/116/118, NICHT CL117/119/120
│   └─ IF Storage: MUSS CL117/119/120, NICHT CL115/116/118
│
├─ [4] PICKING STRATEGY
│   │
│   ├─ Orders = {CL100, CL101}? → Multi-Order
│   └─ Sonst → Single-Order
│
└─ [5] HYBRID-IDENTIFICATION-LOGIC
    │
    ├─ MULTI-ORDER:
    │   ├─ Retrieval → S7 ✓
    │   └─ Storage → S8 ✓
    │
    ├─ SINGLE RETRIEVAL (S1-S3):
    │   │   [IT-System = Diskriminator, Order IRRELEVANT]
    │   ├─ CL107 → S2 ✓
    │   ├─ CL106 → S3 ✓
    │   └─ CL105 → S1 ✓
    │
    └─ SINGLE STORAGE (S4-S6):
        │   [Order-ID = Diskriminator, IT konstant CL105]
        ├─ CL100 → S4 ✓
        ├─ CL101 → S5 ✓
        └─ CL102 → S6 ✓
```

---

## 6. VERWANDTE DOKUMENTE

**Vollständiger Algorithmus (Pseudocode):**
→ `recognition_algorithm_v2.6_FINAL.md`

**Validierungsregeln:**
→ `validation_rules.md`

**Label-Definitionen:**
→ `labels_207.md`

---

## Metadaten

**Datei-Version:** 1.0  
**Erstellt:** 07.01.2026  
**Quelle:** DaRa Dataset Description (Table 3) + DaRA Logic v8  
**Status:** Freigegeben ✅  
**Ersetzt:** `ground_truth_matrix.md`, `scenarios.md`, `picking_strategies.md`