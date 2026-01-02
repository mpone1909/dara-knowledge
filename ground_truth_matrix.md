# DaRa Dataset – Ground Truth Matrix (Table 3)

Diese Datei enthält die **vollständige Ground-Truth-Referenz** für die Szenarioerkennung, basierend auf Table 3 des DaRa-Papers.

**Quelle:** DaRa Dataset Description (Stand 20.10.2025), Table 3 – Scenario Overview  
**Skill-Version:** 2.4 (02.01.2026)

---

## 1. Die 5 Dimensionen der Szenario-Definition

Jedes der 8 Szenarien (S1-S8) ist durch **genau 5 Merkmale** eindeutig definiert:

| Dimension | Kategorie | Labels | Beschreibung |
|-----------|-----------|--------|--------------|
| **1. High-Level Process** | CC08 | CL110, CL111 | Retrieval oder Storage |
| **2. Picking Strategy** | - | Single/Multi | Serielle oder parallele Auftragsbearbeitung |
| **3. Information Technology** | CC07 | CL105, CL106, CL107 | Genutztes IT-System |
| **4. Customer Order** | CC06 | CL100, CL101, CL102, CL103 | Auftragsnummer |
| **5. Errors in Picking List** | - | Yes/No | Enthält Auftrag Fehler? |

---

## 2. Ground-Truth-Matrix (Vollständig)

### 2.1 Tabellarische Übersicht

| Szenario | High-Level (CC08) | Picking Strategy | IT (CC07) | Order (CC06) | Errors |
|:--------:|:-----------------:|:----------------:|:---------:|:------------:|:------:|
| **S1** | Retrieval (CL110) | Single-Order | List+Pen (CL105) | 2904 (CL100) | **Yes** |
| **S2** | Retrieval (CL110) | Single-Order | **PDT (CL107)** | 2905 (CL101) | No |
| **S3** | Retrieval (CL110) | Single-Order | **List+Scanner (CL106)** | 2906 (CL102) | **Yes** |
| **S4** | Storage (CL111) | Single-Order | List+Pen (CL105) | 2904 (CL100) | No |
| **S5** | Storage (CL111) | Single-Order | List+Pen (CL105) | 2905 (CL101) | No |
| **S6** | Storage (CL111) | Single-Order | List+Pen (CL105) | 2906 (CL102) | No |
| **S7** | Retrieval (CL110) | **Multi-Order** | List+Pen (CL105) | 2904 + 2905 (CL100+CL101) | No |
| **S8** | Storage (CL111) | **Multi-Order** | List+Pen (CL105) | 2904 + 2905 (CL100+CL101) | No |

### 2.2 Label-basierte Darstellung

```
╔═══════════════════════════════════════════════════════════════════════════════════════════╗
║                            GROUND TRUTH MATRIX (TABLE 3)                                   ║
╠═══════════════════════════════════════════════════════════════════════════════════════════╣
║ Szenario │ CC08 (HL)  │ Strategy │ CC07 (IT)   │ CC06 (Order)      │ Errors │
╠══════════╪════════════╪══════════╪═════════════╪═══════════════════╪════════╣
║    S1    │ CL110      │ Single   │ CL105       │ CL100 (2904)      │  Yes   ║
║    S2    │ CL110      │ Single   │ CL107 ★     │ CL101 (2905)      │  No    ║
║    S3    │ CL110      │ Single   │ CL106 ★     │ CL102 (2906)      │  Yes   ║
║    S4    │ CL111      │ Single   │ CL105       │ CL100 (2904)      │  No    ║
║    S5    │ CL111      │ Single   │ CL105       │ CL101 (2905)      │  No    ║
║    S6    │ CL111      │ Single   │ CL105       │ CL102 (2906)      │  No    ║
║    S7    │ CL110      │ Multi ★  │ CL105       │ CL100+CL101       │  No    ║
║    S8    │ CL111      │ Multi ★  │ CL105       │ CL100+CL101       │  No    ║
╚═══════════════════════════════════════════════════════════════════════════════════════════╝
★ = Eindeutiger Identifikator für dieses Szenario
```

---

## 3. Eindeutige Identifikatoren

Zwei Szenarien haben **100% eindeutige** Erkennungsmerkmale durch IT:

| Szenario | Merkmal | Label | Erkennungsregel |
|----------|---------|-------|-----------------|
| **S2** | PDT | CL107 | `if CC07 == CL107 → S2` |
| **S3** | Glove Scanner | CL106 | `if CC07 == CL106 → S3` |

Zwei Szenarien sind durch **Multi-Order-Strategie** eindeutig:

| Szenario | Merkmal | Erkennungsregel |
|----------|---------|-----------------|
| **S7** | Multi-Order + Retrieval | `if order_count == 2 AND CC08 == CL110 → S7` |
| **S8** | Multi-Order + Storage | `if order_count == 2 AND CC08 == CL111 → S8` |

**Hinweis:** S7 und S8 haben beide **exakt 2 Orders** (2904 + 2905), nicht 3!

---

## 4. Detaillierte Szenario-Profile

### S1: Standard Retrieval (Error Run)

| Dimension | Wert | Label |
|-----------|------|-------|
| High-Level Process | Retrieval | CL110 |
| Picking Strategy | Single-Order | - |
| Information Technology | List + Pen | CL105 |
| Customer Order | 2904 | CL100 |
| Errors | **Yes** | CL135 möglich |

**Charakteristik:** Kommissionierung mit Papierliste, absichtliche Fehler im Auftrag.

---

### S2: Variant Retrieval (PDT)

| Dimension | Wert | Label |
|-----------|------|-------|
| High-Level Process | Retrieval | CL110 |
| Picking Strategy | Single-Order | - |
| Information Technology | **Portable Data Terminal** | **CL107** |
| Customer Order | 2905 | CL101 |
| Errors | No | - |

**Charakteristik:** Einziges Szenario mit PDT. 100% eindeutig identifizierbar.

---

### S3: Error Retrieval (Scanner)

| Dimension | Wert | Label |
|-----------|------|-------|
| High-Level Process | Retrieval | CL110 |
| Picking Strategy | Single-Order | - |
| Information Technology | **List + Glove Scanner** | **CL106** |
| Customer Order | 2906 | CL102 |
| Errors | **Yes** | CL135 möglich |

**Charakteristik:** Einziges Szenario mit Handschuh-Scanner. 100% eindeutig.

---

### S4: Standard Storage

| Dimension | Wert | Label |
|-----------|------|-------|
| High-Level Process | Storage | CL111 |
| Picking Strategy | Single-Order | - |
| Information Technology | List + Pen | CL105 |
| Customer Order | 2904 | CL100 |
| Errors | No | - |

**Charakteristik:** Einlagerung mit Order 2904.

---

### S5: Variant Storage

| Dimension | Wert | Label |
|-----------|------|-------|
| High-Level Process | Storage | CL111 |
| Picking Strategy | Single-Order | - |
| Information Technology | List + Pen | CL105 |
| Customer Order | 2905 | CL101 |
| Errors | No | - |

**Charakteristik:** Einlagerung mit Order 2905. Unterschied zu S4 durch Order.

---

### S6: Storage (Order 2906)

| Dimension | Wert | Label |
|-----------|------|-------|
| High-Level Process | Storage | CL111 |
| Picking Strategy | Single-Order | - |
| Information Technology | List + Pen | CL105 |
| Customer Order | 2906 | CL102 |
| Errors | No | - |

**Charakteristik:** Einlagerung mit Order 2906. Simuliert Wareneingang.

---

### S7: Multi-Order Retrieval

| Dimension | Wert | Label |
|-----------|------|-------|
| High-Level Process | Retrieval | CL110 |
| Picking Strategy | **Multi-Order** | - |
| Information Technology | List + Pen | CL105 |
| Customer Order | **2904 + 2905** | CL100 + CL101 |
| Errors | No | - |

**Charakteristik:** Zwei Orders parallel (2904 + 2905). Order-Wechsel innerhalb des Blocks ist normal.

---

### S8: Multi-Order Storage

| Dimension | Wert | Label |
|-----------|------|-------|
| High-Level Process | Storage | CL111 |
| Picking Strategy | **Multi-Order** | - |
| Information Technology | List + Pen | CL105 |
| Customer Order | **2904 + 2905** | CL100 + CL101 |
| Errors | No | - |

**Charakteristik:** Zwei Orders parallel (2904 + 2905). Gleiche Order-Kombination wie S7.

---

## 5. Decision Tree für Szenarioerkennung

```
Block analysieren:
│
├─ CC08 = CL110 (Retrieval)?
│   │
│   ├─ Multi-Order (2 Orders: CL100+CL101)?
│   │   └─ JA → S7 ✓
│   │
│   ├─ CC07 = CL107 (PDT)?
│   │   └─ JA → S2 ✓
│   │
│   ├─ CC07 = CL106 (Scanner)?
│   │   └─ JA → S3 ✓
│   │
│   └─ SONST (Single-Order, Pen) → S1 ✓
│
├─ CC08 = CL111 (Storage)?
│   │
│   ├─ Multi-Order (2 Orders: CL100+CL101)?
│   │   └─ JA → S8 ✓
│   │
│   ├─ Order = CL100 (2904)?
│   │   └─ JA → S4 ✓
│   │
│   ├─ Order = CL101 (2905)?
│   │   └─ JA → S5 ✓
│   │
│   ├─ Order = CL102 (2906)?
│   │   └─ JA → S6 ✓
│   │
│   └─ SONST → S4 (Default) ✓
│
└─ SONST → "Unknown" oder Übergangsphase (CL112/CL113)
```

---

## 6. Bekannte Probleme

### 6.1 S4/S5/S6-Unterscheidung bei Storage

**Problem:** S4, S5 und S6 sind alle Storage (CL111) mit Single-Order. Der Unterschied liegt NUR im Order:
- S4 = Order 2904 (CL100)
- S5 = Order 2905 (CL101)
- S6 = Order 2906 (CL102)

**Lösung:** Order-Wechsel innerhalb eines Storage-Blocks als Szenario-Grenze erkennen.

### 6.2 CL112/CL113 sind KEINE Szenarien

- CL112 (Another High-Level Process) → Übergangsphase
- CL113 (High-Level Process Unknown) → Wartezeit/Initialisierung

Diese Labels bei der Szenario-Zählung ignorieren!

### 6.3 Multi-Order hat exakt 2 Orders

S7 und S8 haben **beide die gleichen 2 Orders**: 2904 + 2905 (CL100 + CL101).
- Order 2906 (CL102) ist NICHT Teil von Multi-Order-Szenarien.

### 6.4 Multi-Label-Annotation bei CC06

**Kritisch:** Bei Multi-Order-Szenarien können **zwei Orders gleichzeitig aktiv** sein (CL100=1 UND CL101=1). Dies erfordert Set-basierte Analyse.

---

## 7. Verwendungshinweise

**Diese Datei nutzen für:**
- Szenario-Identifikation und -Validierung
- Ground-Truth-Referenz für alle 8 Szenarien
- Decision-Tree-Implementierung

**Verwandte Dateien:**
- `scenarios.md` → Detaillierte Szenario-Beschreibungen
- `picking_strategies.md` → Single vs. Multi-Order Details
- `scenario_boundary_detection.md` → Allgemeiner Algorithmus
- `validation_logic_extended.md` → Szenario-Validierungsregeln
- `label_activity_matrix.md` → Aktive/Inaktive Labels pro Kategorie (NEU in v2.4)

---

## Metadaten

**Datei-Version:** 2.4  
**Erstellt:** 30.12.2025  
**Aktualisiert:** 02.01.2026  
**Quelle:** DaRa Dataset Description, Table 3
