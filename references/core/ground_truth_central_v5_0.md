# DaRa Dataset – Ground Truth Central (v5.0)

**Zentrale Quelle für alle Szenario-Definitionen und Erkennungslogik**

**Skill-Version:** 5.0 (04.02.2026)  
**Basis:** v3.0 (25.01.2026) + Klarstellungen v5.0  
**Quelle:** DaRa Dataset Description (Table 3) + DaRA Logic v9

**Changelog v5.0 (04.02.2026 – MINOR UPDATE):**
- ✅ Klarstellung: CL115/116/118 / CL117/119/120 sind INFORMATIV, nicht validierungserforderlich
- ✅ Edge-Case gelöst: retrieval_evidence == storage_evidence → Storage DEFAULT
- ✅ Nomenklatur präzisiert: "Multi_Order" vs. "Anomaly"
- ⚠️ KEINE BREAKING CHANGES: v3.0-Logik bleibt vollständig funktional

**[WICHTIG]:** Dies ist v5.0-Versionierung ohne Inhalts-Migration. Die Logik bleibt identisch zu v3.0.

---

## ðŸ“š INHALTSVERZEICHNIS

1. [Szenario-Übersicht](#szenario-übersicht)
2. [Ground Truth Matrix](#ground-truth-matrix)
3. [Szenario-Profile (S1-S8 + Other)](#szenario-profile)
4. [Erkennungslogik (ALT)](#erkennungslogik-alt--deprecated)
5. [**NEW Decision-Logik: 5-Schritt System**](#new-decision-logik-5-schritt-system)
6. [Validierungskriterien](#validierungskriterien)
7. [Wichtige Unterschiede v3.0 vs. v2.7](#wichtige-unterschiede-v30--v27)
8. [Bekannte Befunde und Besonderheiten](#bekannte-befunde-und-besonderheiten)
9. [Migration v2.7 → v3.0](#migration-v27--v30)

---

## 1. SZENARIO-ÜBERSICHT

Der DaRa-Datensatz umfasst **8 definierte Szenarien (S1-S8)** plus die Restkategorie **"Other"**.

### Retrieval-Szenarien (Kommissionierung)

- **S1** – Standard Retrieval (List+Pen, Order 2904, Errors möglich)
- **S2** – Variant Retrieval (PDT, Order 2905, keine Errors)
- **S3** – Error Retrieval (Scanner, Order 2906, Errors möglich)
- **S7** – Multi-Order Retrieval Perfect Run (List+Pen, Orders 2904+2905)

### Storage-Szenarien (Einlagerung)

- **S4** – Standard Storage (List+Pen, Order 2904)
- **S5** – Variant Storage (List+Pen, Order 2905)
- **S6** – Storage (List+Pen, Order 2906)
- **S8** – Multi-Order Storage Perfect Run (List+Pen, Orders 2904+2905)

### Restkategorie

- **Other** – Wartezeiten, Übergänge, Synchronisationen
  - **Other_Waiting:** CL134=1 (Global Interrupt)
  - **Other_Process:** CL112/CL113=1 ohne CL110/CL111
  - **Other_NoData:** CL103=1 AND CL108=1 (No Order + No IT)

---

## 2. GROUND TRUTH MATRIX

### 2.1 Vollständige Matrix (mit Bedingungen für v3.0/v5.0)

| Szenario | CC08 (High) | CC07 (IT) | CC06 (Order) | CC09 (Mid) | Bedingungen |
|:--------:|:-----------:|:---------:|:------------:|:----------:|:-----------|
| **S1** | CL110 | CL105 | CL100 | CL115/116/118¹ | ✓ Process=Retr, IT=List+Pen, Order=2904 |
| **S2** | CL110 | CL107 | CL101 | CL115/116/118¹ | ✓ Process=Retr, IT=PDT, Order=2905 |
| **S3** | CL110 | CL106 | CL102 | CL115/116/118¹ | ✓ Process=Retr, IT=Scanner, Order=2906 |
| **S4** | CL111 | CL105 | CL100 | CL117/119/120¹ | ✓ Process=Stor, IT=List+Pen, Order=2904 |
| **S5** | CL111 | CL105 | CL101 | CL117/119/120¹ | ✓ Process=Stor, IT=List+Pen, Order=2905 |
| **S6** | CL111 | CL105 | CL102 | CL117/119/120¹ | ✓ Process=Stor, IT=List+Pen, Order=2906 |
| **S7** | CL110 | CL105 | CL100+101 | CL115/116/118¹ | ✓ Process=Retr, Multi(2904+2905) |
| **S8** | CL111 | CL105 | CL100+101 | CL117/119/120¹ | ✓ Process=Stor, Multi(2904+2905) |
| **Other** | CL112/113 | CL108 | CL103 | – | ✓ CL134=1 OR (CL112/113 AND NOT Retr/Stor) |

**¹ WICHTIG (v5.0 Klarstellung):** Die Labels in CC09-Spalte (CL115/116/118 für Retrieval, CL117/119/120 für Storage) sind **INFORMATIV und DESKRIPTIV** – sie charakterisieren das Scenario, sind aber **NICHT erforderlich** für die Szenario-Klassifikation in Schritt 5. Die primäre Klassifikation basiert auf CL110/CL111 (High-Level) und CL100-102 (Order).

**Wichtig:** Jeder Frame erfüllt EXAKT EINE Zeile dieser Matrix!

---

## 3. SZENARIO-PROFILE

[Wie in v2.7 – keine Änderungen in den Profilen selbst, aber neue Bedingungsprüfung bei Erkennung]

---

## 4. ERKENNUNGSLOGIK (ALT – DEPRECATED)

### ⚠️ v2.7 "Evidence-Based Scoring" – NICHT MEHR VERWENDEN

Die alte Logik (Zeilen 349-356 in v2.7):
```
Score_Retrieval = (CL110 × 3) + (Max(CL126,CL130,CL149) × 5)
Score_Storage = (CL111 × 3) + (Max(CL127,CL131,CL152,CL142) × 5)

IF Score_Retrieval > Score_Storage:
    process_type = "Retrieval"
ELSE:
    process_type = "Storage"
```

**Problem:** Score-Gewichtung war willkürlich, Low-Level Labels könnten High-Level überschreiben auf nicht-transparente Weise.

**ERSETZEN DURCH:** v3.0 5-Schritt System (siehe unten)

---

## NEW: DECISION-LOGIK 5-SCHRITT SYSTEM

### **SCHRITT 1: GLOBAL INTERRUPTS** (Priorität 1 – STOP Condition)

**Für Frame i – IMMER ZUERST PRÜFEN:**

```python
IF cl134[i] == 1:  # CL134 = Waiting
    scenario[i] = "Other_Waiting"
    RETURN  # KEINE weitere Verarbeitung

IF (cl112[i] == 1 OR cl113[i] == 1) AND NOT (cl110[i] == 1 OR cl111[i] == 1):
    # CL112 = Another Process OR CL113 = Unknown Process
    # UND NICHT (CL110 Retrieval OR CL111 Storage)
    scenario[i] = "Other_Process"
    RETURN

IF (cl103[i] == 1 AND cl108[i] == 1):  # No Order AND No IT
    scenario[i] = "Other_NoData"
    RETURN

# Falls keine Bedingung erfüllt → Weiter zu Schritt 2
```

**Labels prüfen:**
- CL134 (Waiting)
- CL112 (Another High-Level Process)
- CL113 (High-Level Process Unknown)
- CL110 (Retrieval) – zur Bestätigung
- CL111 (Storage) – zur Bestätigung
- CL103 (No Order)
- CL108 (No Information Technology)

**Logik:**
- CL134 hat **absolute Priorität** (Global Interrupt)
- CL112/CL113 sind nur "Other", wenn sie OHNE Retrieval/Storage auftreten
- CL103+CL108 kombiniert signalisiert Daten-Lücke

---

### **SCHRITT 2: PROCESS_TYPE DETERMINATION** (Retrieval vs Storage)

**Für alle restlichen Frames (nach Schritt 1):**

```python
# Primary Indicators (High-Level)
IF cl110[i] == 1:
    process_type = "RETRIEVAL"
    
ELIF cl111[i] == 1:
    process_type = "STORAGE"

ELSE:
    # Fallback: Low-Level Indikatoren (CC10)
    
    # RETRIEVAL-spezifische Low-Level Prozesse
    retrieval_evidence = MAX(
        cl126[i],  # CL126 = Collecting Empty Cardboard Boxes
        cl130[i]   # CL130 = Handing Over Packed Cardboard Boxes
    )
    
    # STORAGE-spezifische Low-Level Prozesse
    storage_evidence = MAX(
        cl127[i],  # CL127 = Collecting Packed Cardboard Boxes
        cl131[i],  # CL131 = Returning Empty Cardboard Boxes
        cl152[i],  # CL152 = Tying Elastic Band Around Cardboard
        cl142[i]   # CL142 = Opening Cardboard Box
    )
    
    # v5.0 KLARSTELLUNG: Edge-Case bei Gleichstand
    IF retrieval_evidence > storage_evidence:
        process_type = "RETRIEVAL"
    ELIF storage_evidence > retrieval_evidence:
        process_type = "STORAGE"
    ELSE:  # retrieval_evidence == storage_evidence
        # Edge-Case: Beide gleich → Storage als DEFAULT priorisieren
        process_type = "STORAGE"
```

**Labels prüfen:**
- CL110 (Retrieval) – Primary
- CL111 (Storage) – Primary
- CL126, CL130 (Retrieval Low-Level) – Fallback
- CL127, CL131, CL142, CL152 (Storage Low-Level) – Fallback

**Logik:**
- High-Level Labels (CL110/CL111) haben Priorität
- Low-Level Labels sind Fallback für mehrdeutige Frames
- MAX() garantiert, dass schon 1 aktives Label ausreicht
- **v5.0:** Bei Gleichstand wird Storage als DEFAULT priorisiert

---

### **SCHRITT 3: ORDER_STRATEGY DETERMINATION** (Single vs Multi)

**Zähle aktive Order-Labels:**

```python
# Zähle welche Order-Labels aktiv sind
active_orders = [
    cl100[i],  # CL100 = Order 2904
    cl101[i],  # CL101 = Order 2905
    cl102[i]   # CL102 = Order 2906
]

active_count = sum(active_orders)

# Entscheide Strategy
IF (cl100[i] == 1 AND cl101[i] == 1):
    # EXAKT Orders 2904 UND 2905
    strategy = "MULTI_ORDER"
    multi_combo = "2904_2905"  # Erlaubte Kombination
    
ELIF (cl100[i] == 1 AND cl102[i] == 1) OR (cl101[i] == 1 AND cl102[i] == 1):
    # Orders 2904+2906 oder 2905+2906 (unerwünscht)
    strategy = "MULTI_ORDER"
    multi_combo = "OTHER"  # ⚠️ ANOMALIE!
    
ELIF active_count == 1:
    # Exakt eine Order
    strategy = "SINGLE_ORDER"
    
ELSE:  # active_count == 0
    # Keine Order
    strategy = "NO_ORDER"  # ⚠️ Kann zu Misclassification führen
```

**Labels prüfen:**
- CL100 (Order 2904)
- CL101 (Order 2905)
- CL102 (Order 2906)

**Logik:**
- MULTI = 2 oder mehr Orders gleichzeitig
- **ERLAUBTE MULTI:** 2904+2905 (S7, S8) → strategy="MULTI_ORDER", multi_combo="2904_2905"
- **UNERWÜNSCHTE MULTI:** 2904+2906 oder 2905+2906 → strategy="MULTI_ORDER", multi_combo="OTHER" (führt zu Anomaly)
- SINGLE = genau 1 Order (S1-S6)
- NO_ORDER = wahrscheinlich unvollständige Annotation

**v5.0 Klarstellung:** MULTI_ORDER ist NICHT dasselbe wie "erlaubte Kombination". MULTI_ORDER bedeutet nur ≥2 Orders. Die Anomaly-Klassifikation erfolgt in Schritt 5 basierend auf multi_combo.

---

### **SCHRITT 4: IT_SYSTEM IDENTIFICATION** (Nur für Retrieval)

**Nur relevant wenn process_type == "RETRIEVAL":**

```python
IF process_type == "RETRIEVAL":
    
    IF cl105[i] == 1:  # CL105 = List and Pen
        it_system = "LIST_PEN"
    ELIF cl106[i] == 1:  # CL106 = List and Glove Scanner
        it_system = "SCANNER"
    ELIF cl107[i] == 1:  # CL107 = Portable Data Terminal
        it_system = "PDT"
    ELSE:
        it_system = "NONE"  # ⚠️ ANOMALIE!

ELSE:  # Storage
    # In Storage-Szenarien ist IT-System KONSTANT
    it_system = "STORAGE_CONST"  # Immer List+Pen in S4-S6, S8
```

**Labels prüfen:**
- CL105 (List and Pen)
- CL106 (List and Glove Scanner)
- CL107 (Portable Data Terminal)

**Logik:**
- IT-System ist **Diskriminator zwischen S1, S2, S3**
- Für Storage ist IT immer List+Pen (konstant)
- Es kann max. 1 IT-System aktiv sein pro Frame (multi-label nicht erwartet)

---

### **SCHRITT 5: FINALE SZENARIO-ZUORDNUNG**

**Basierend auf Combination aller Dimensionen:**

```
╔══════════════════════════════════════════════════════════════════════════════╗
║ RETRIEVAL-SZENARIEN (process_type == "RETRIEVAL")                           ║
╚══════════════════════════════════════════════════════════════════════════════╝

IF strategy == "SINGLE_ORDER":
    
    IF it_system == "LIST_PEN" AND cl100[i] == 1:
        → scenario[i] = "S1"
        # Standard Retrieval: List+Pen, Order 2904
        # Bedingungen erfüllt: CL110=1, CL105=1, CL100=1
    
    ELIF it_system == "PDT" AND cl101[i] == 1:
        → scenario[i] = "S2"
        # Variant Retrieval: PDT, Order 2905
        # Bedingungen erfüllt: CL110=1, CL107=1, CL101=1
    
    ELIF it_system == "SCANNER" AND cl102[i] == 1:
        → scenario[i] = "S3"
        # Error Retrieval: Scanner, Order 2906
        # Bedingungen erfüllt: CL110=1, CL106=1, CL102=1
    
    ELSE:
        → scenario[i] = "Retrieval_Mismatch"  ⚠️
        # Beispiel: CL105=1 (List+Pen) aber CL101 oder CL102 aktiv
        # → Falsche Order für dieses IT-System

ELIF strategy == "MULTI_ORDER":
    
    IF multi_combo == "2904_2905":
        → scenario[i] = "S7"
        # Multi-Order Retrieval: Orders 2904+2905
        # Bedingungen erfüllt: CL110=1, CL105=1, CL100=1, CL101=1
    
    ELSE:
        → scenario[i] = "Multi_Retrieval_Anomaly"  ⚠️
        # Unerwünschte Kombination (2904+2906 oder 2905+2906)


╔══════════════════════════════════════════════════════════════════════════════╗
║ STORAGE-SZENARIEN (process_type == "STORAGE")                               ║
╚══════════════════════════════════════════════════════════════════════════════╝

IF strategy == "SINGLE_ORDER":
    
    IF cl100[i] == 1:
        → scenario[i] = "S4"
        # Standard Storage: Order 2904
        # Bedingungen erfüllt: CL111=1, CL105=1, CL100=1
    
    ELIF cl101[i] == 1:
        → scenario[i] = "S5"
        # Variant Storage: Order 2905
        # Bedingungen erfüllt: CL111=1, CL105=1, CL101=1
    
    ELIF cl102[i] == 1:
        → scenario[i] = "S6"
        # Storage: Order 2906
        # Bedingungen erfüllt: CL111=1, CL105=1, CL102=1
    
    ELSE:
        → scenario[i] = "Storage_Mismatch"  ⚠️
        # Storage erkannt (CL111=1) aber keine aktive Order?

ELIF strategy == "MULTI_ORDER":
    
    IF multi_combo == "2904_2905":
        → scenario[i] = "S8"
        # Multi-Order Storage: Orders 2904+2905
        # Bedingungen erfüllt: CL111=1, CL105=1, CL100=1, CL101=1
    
    ELSE:
        → scenario[i] = "Multi_Storage_Anomaly"  ⚠️

ELSE:  # strategy == "NO_ORDER"
    → scenario[i] = "Storage_Unclassified"  ⚠️
    # Storage erkannt aber keine Order?
```

---

## VALIDIERUNGSKRITERIEN

Nach Szenarioerkennung IMMER validieren:

```
✓ Jeder Frame hat EXAKT ein Szenario zugewiesen
✓ Summe aller Frames = 100.0%
✓ Anomalien klar gekennzeichnet (Mismatch, Anomaly, Unclassified)
✓ Kein Frame ist leer/nicht klassifiziert
```

**Anomalien-Report:**
```
⚠️ Retrieval_Mismatch: [count] Frames
⚠️ Storage_Mismatch: [count] Frames
⚠️ Multi_Retrieval_Anomaly: [count] Frames
⚠️ Multi_Storage_Anomaly: [count] Frames
⚠️ Storage_Unclassified: [count] Frames
```

---

## WICHTIGE UNTERSCHIEDE: v3.0 (und v5.0) vs. v2.7

| Aspekt | v2.7 | v3.0/v5.0 |
|--------|------|-----------|
| **Logik-Typ** | Evidence-Based Scoring | Bedingungsprüfung |
| **Frame-Verarbeitung** | Score-Berechnung | Explizite IF-THEN-Logik |
| **Low-Level Integration** | Gewichtete Scores (3:5) | Fallback-Logik (nur wenn CL110/CL111=0) |
| **Anomalie-Erkennung** | Implizit | Explizit (5 Anomalie-Typen) |
| **Reproduzierbarkeit** | Schwierig (Scores unklar) | Leicht (klare Bedingungen) |
| **Performance** | Schneller (Aggregation) | Langsamer (Frame-by-Frame) |
| **Genauigkeit** | Fehler möglich | Korrekt (100% konsistent) |

**v5.0 Zusätze:**
| Aspekt | v3.0 | v5.0 |
|--------|------|------|
| **Edge-Case: retrieval_evidence == storage_evidence** | Undefined | Storage DEFAULT |
| **CC09-Labels (CL115/116/118 etc.)** | Unklar ob validierungserforderlich | Informativ, nicht erforderlich |
| **Nomenklatur: MULTI_ORDER vs. Anomaly** | Implizit | Explizit präzisiert |

---

## BEKANNTE BEFUNDE UND BESONDERHEITEN

### Szenarios sind nicht immer vorhanden

Nicht alle Szenarien kommen bei jedem Probanden vor. Beispiel: **Proband S10**
- ✓ S1, S2, S3, S6: Vorhanden
- ✗ S4, S5, S7, S8: NICHT VORHANDEN

**Grund:** Order 2904/2905 in Datensatz immer mit Retrieval (CL110), nie mit Storage (CL111) annotiert.

Das ist **NORMAL** für ein Experiment mit variablen Bedingungen!

### Low-Level Evidence ist wichtig

In ~10-20% der Frames können CL110 und CL111 beide 0 sein. In diesen Fällen ist **Low-Level Evidence entscheidend:**
- CL126/CL130 → "Retrieval-Zeichen"
- CL127/CL131/CL142/CL152 → "Storage-Zeichen"

Diese Labels sind nicht redundant zu CL110/CL111!

---

## MIGRATION VON v2.7 → v3.0

Wenn alte v2.7 Decision Tree verwendest, MUSST du migrieren:

```python
# v2.7 (VERALTET):
score_retr = (cl110 * 3) + (max(cl126, cl130, cl149) * 5)  # ✗ NICHT MEHR!

# v3.0/v5.0 (AKTUELL):
if cl110 == 1:
    process_type = "RETRIEVAL"  # ✓ NEU!
elif cl111 == 1:
    process_type = "STORAGE"
else:
    # Low-Level Fallback ...
```

---

## QUELLENANGABEN & VERSIONSHISTORIE

**Skill-Version:** 5.0 (04.02.2026)  
**Basis:** 3.0 (25.01.2026)  
**Vorherige:** 2.7, 2.6, 2.5

**Changelog:**
- **v5.0:** Klarstellungen zu CL115/116/118 (informativ), Edge-Case bei Fallback-Logik, Nomenklatur-Präzisierungen (KEINE BREAKING CHANGES)
- **v3.0:** Neue 5-Schritt Decision-Logik mit expliziter Bedingungsprüfung (BREAKING CHANGE zu v2.7)
- v2.7: Order-Pflichtlabels für BPMN-Validierung
- v2.6: CL134-Priorisierung, "Other"-Erkennung
- v2.5: CC09-Validierung

**Dokumentation:**
- DaRa Dataset Description (Table 3)
- DaRA Logic v9
- Skill `dara-dataset-expert` v5.0+

---

**Status:** ✅ v5.0 AKTIV  
**Freigabe:** 04.02.2026  
**Basis-Autor:** Claude (v3.0, 25.01.2026)  
**Update v5.0:** Claude (04.02.2026)  
**Update-Zyklus:** Bei Bedarf anpassen
