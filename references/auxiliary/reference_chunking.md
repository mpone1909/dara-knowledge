---
version: 6.1.0
---

# DaRa Dataset — Chunking-Logik

**Quelle:** DaRa Dataset Description (Stand 20.10.2025)
**Skill-Version:** 6.1.0
**Erstellt:** 05.12.2025
**Update:** 26.02.2026 (v6.0: Encoding, Frame-Schätzungen korrigiert, Cross-Refs aktualisiert)

---

## 0. ÜBERBLICK UND ZWECK

Das Chunking-System segmentiert den kontinuierlichen Frame-Strom (30 fps) in **stabilitäts-definierte Einheiten (Chunks)**. Jeder Chunk repräsentiert einen konsistenten Labelzustand über alle 12 Kategorien.

**Warum Chunking?**
- Reduktion hochfrequenter Frame-Daten auf interpretierbare Segmente
- Basis für Szenario-, Prozess- und Verhaltensanalyse
- Ermöglicht effiziente Verarbeitung von Sequenzmodellen
- Validierung von Ground Truth (v3.0) auf aggregierter Ebene

---

## 1. FUNDAMENTALE DEFINITION

### 1.1 Was ist ein Chunk?

Ein **Chunk** ist die kleinste stabile Einheit der Annotation:

- **Stabiler Labelzustand:** Alle 12 Klassenkategorien (CC01-CC12) bleiben unverändert
- **Determinierte Grenzen:** Chunks werden EXKLUSIV durch Trigger T1-T13 definiert
- **Vollständige Abdeckung:** Jeder Chunk enthält Information aus allen 12 Kategorien
- **Keine Lücken/Überlaps:** Jeder Frame gehört zu genau einem Chunk

**Formal:**
```
Chunk = {Frame i, Frame i+1, ..., Frame i+n}
        WOBEI für alle Frames in {i..i+n} gilt:
        Label_State(Frame j) == Label_State(Frame j+1)
        UND Chunk endet, wenn ein Trigger (T1-T13) auftritt
```

### 1.2 Kern-Properties

| Eigenschaft | Beschreibung |
|------------|-------------|
| **Atomar** | Kleinste semantisch kohärente Einheit |
| **Stabil** | Keine inneren Label-Änderungen |
| **Vollständig** | Alle 12 Kategorien CC01-CC12 enthalten |
| **Determiniert** | Nur durch T1-T13 definiert |
| **Subjekt-spezifisch** | Jeder der 3 Akteure pro Session hat eigenen Chunk-Strom |
| **Frame-konsistent** | Lückenlos, keine Überlappung |

### 1.3 Beziehung zu Frames und Szenarien

```
Frame-Ebene (30 fps, variabel pro Proband: z.B. S10=199.427, S11=167.627, S12=217.583)
    → aggregiert durch Trigger
Chunk-Ebene (stabile Zustände, typisch mehrere tausend pro Proband)
    → klassifiziert durch Ground Truth v3.0
Szenario-Ebene (S1-S8 + Other)
    → organisiert in
Prozess-Ebene (High/Mid/Low-Level)
```

---

## 2. TRIGGER-SYSTEM

### 2.1 Trigger-Architektur: 4 Kategorien + 1 Extensions

Ein **Trigger** ist ein Zustandswechsel, der eine **Chunk-Grenze** auslöst.
Es existieren 13 definierte Trigger, organisiert in 4 Kategorien:

#### A. MOTOR-TRIGGER (T1-T5)
Körperbewegung und Haltung

| ID | Kategorie | Labels | Typ | Bedingung |
|----|-----------|--------|-----|-----------|
| **T1** | CC01 Main Activity | 15 | Single | Label-Wechsel (z.B. Walking→Standing) |
| **T2** | CC02 Legs | 8 | Single | Label-Wechsel (z.B. Gait→Standing Still) |
| **T3** | CC03 Torso | 6 | Multi (Max 2) | Änderung Beugung ODER Rotation hinzu/weg |
| **T4** | CC04 Left Hand | 35 | Required Multi (4) | Änderung Position ODER Movement ODER Object ODER Tool |
| **T5** | CC05 Right Hand | 35 | Required Multi (4) | Analog zu T4 |

**Auslösebedingung für T1-T5:**
```
IF ein Label in {CC01, CC02, CC03, CC04, CC05} ändert:
    Chunk-Grenze
```

#### B. CONTEXT-TRIGGER (T6-T7)
Auftrags- und IT-Kontext

| ID | Kategorie | Labels | Typ | Bedingung |
|----|-----------|--------|-----|-----------|
| **T6** | CC06 Order | 5 | Multi (Max 2) | Order-Wechsel, Addition oder Entfernung |
| **T7** | CC07 IT-System | 5 | Single | IT-Wechsel (z.B. List+Pen→PDT) |

**Auslösebedingung für T6-T7:**
```
IF ein Label in {CC06, CC07} ändert:
    Chunk-Grenze
```

**Besonderheit T6:** Multi-Order Aktivierung
- Addition: CL100=1, CL101=0 → CL100=1, CL101=1 (T6!)
- Entfernung: CL100=1, CL101=1 → CL100=1, CL101=0 (T6!)

#### C. PROCESS-TRIGGER (T8: High/Mid/Low)
Prozessebenen-Wechsel

| ID | Kategorie | Labels | Typ | Bedingung |
|----|-----------|--------|-----|-----------|
| **T8a** | CC08 High-Level | 4 | Single | High-Level Wechsel (Retrieval→Storage→Other) |
| **T8b** | CC09 Mid-Level | 10 | Single | Mid-Level Wechsel (Travel Time→Pick Time→...) |
| **T8c** | CC10 Low-Level | 31 | Single | Low-Level Wechsel (jeden der 31 Prozesse) |

**Auslösebedingung für T8:**
```
IF JEDER Label in {CC08, CC09, CC10} ändert (egal welcher!):
    Chunk-Grenze (EINE Grenze, nicht 3)
```

**Wichtig:** T8c Low-Level ist der **häufigste Trigger** (ca. 40-50% aller Chunk-Grenzen)

#### D. SPATIAL-TRIGGER (T9-T10)
Ortsveränderung

| ID | Kategorie | Labels | Typ | Bedingung |
|----|-----------|--------|-----|-----------|
| **T9** | CC11 Location Human | 26 | Hierarchisch (Max 3) | Hierarchische Kombination ändert sich |
| **T10** | CC12 Location Cart | 27 | Hierarchisch (Max 4) | Hierarchische Kombination ändert sich |

**Hierarchische Struktur CC11/CC12:**
```
Main Area (z.B. "Storage Aisle")
  └── Aisle (z.B. "Aisle 3")
      └── Position (z.B. "Front/Back")

Änderung auf JEDER Ebene → T9/T10
```

**Auslösebedingung für T9-T10:**
```
IF die hierarchische Kombination in {CC11, CC12} ändert:
    Chunk-Grenze
```

#### E. CLASSIFICATION-TRIGGER (T11-T13)
Ground Truth v3.0 Klassifikations-Marker

| ID | Label | Status | Bedingung |
|----|-------|--------|-----------|
| **T11** | CL134 Waiting | Global Interrupt | CL134: 0→1 (Worker wartet) |
| **T12** | CL112/CL113 Unknown Process | Unknown | (CL112 OR CL113)=1 AND (CL110 OR CL111)=0 |
| **T13** | CL103+CL108 No Data | No Data | CL103=1 AND CL108=1 (kombiniert) |

**Auslösebedingung für T11-T13:**
```
IF CL134 state ändert (z.B. 0→1):
    Chunk-Grenze + szenario="Other_Waiting"

IF (CL112 OR CL113) aktiviert ohne Retrieval/Storage:
    Chunk-Grenze + szenario="Other_Process"

IF (CL103 AND CL108) kombiniert:
    Chunk-Grenze + szenario="Other_NoData"
```

**Wichtig:** T11-T13 sind **immer redundant** mit T1-T10 (T11⊃T1, T12⊃T8, T13⊃T6+T7), werden aber explizit dokumentiert zur Kennzeichnung von Ground Truth v3.0 Sonderfällen (Waiting, Unknown Process, No Data).

### 2.2 Formale Trigger-Definition

**Universale Regel für Chunk-Grenzenerkennung:**

```python
FOR EACH Frame i (1 to N-1):
    
    previous_state = {
        cc01[i-1], cc02[i-1], ..., cc12[i-1]  # Label-Snapshot
    }
    
    current_state = {
        cc01[i], cc02[i], ..., cc12[i]  # Label-Snapshot
    }
    
    IF previous_state != current_state:
        # Mindestens ein Label hat sich geändert
        
        # Prüfe welche Trigger erfüllt sind
        triggers_activated = []
        
        IF cc01[i-1] != cc01[i]: triggers_activated.append(T1)
        IF cc02[i-1] != cc02[i]: triggers_activated.append(T2)
        IF cc03[i-1] != cc03[i]: triggers_activated.append(T3)
        IF cc04[i-1] != cc04[i]: triggers_activated.append(T4)
        IF cc05[i-1] != cc05[i]: triggers_activated.append(T5)
        IF cc06[i-1] != cc06[i]: triggers_activated.append(T6)
        IF cc07[i-1] != cc07[i]: triggers_activated.append(T7)
        IF cc08[i-1] != cc08[i] OR cc09[i-1] != cc09[i] OR cc10[i-1] != cc10[i]:
            triggers_activated.append(T8)
        IF cc11[i-1] != cc11[i]: triggers_activated.append(T9)
        IF cc12[i-1] != cc12[i]: triggers_activated.append(T10)
        
        # T11-T13 (Classification-Trigger)
        IF cl134[i-1]==0 AND cl134[i]==1: triggers_activated.append(T11)
        IF (cl112[i] OR cl113[i]) AND NOT (cl110[i] OR cl111[i]): 
            triggers_activated.append(T12)
        IF (cl103[i]==1 AND cl108[i]==1): triggers_activated.append(T13)
        
        IF triggers_activated is not empty:
            # CHUNK-GRENZE vor Frame i
            chunk[i].start = TRUE
            chunk[i-1].end = TRUE
            chunk[i-1].trigger_list = triggers_activated
            
    ELSE:
        # Kein Zustandswechsel → selber Chunk
        chunk[i].within_chunk = TRUE
```

### 2.3 Simultane Trigger und Priorität

**Fall: Mehrere Trigger gleichzeitig**

```
Frame i-1: CC01=Walking, CC06=Order2904
Frame i:   CC01=Standing, CC06=Order2905

Auslöser: T1 (Main Activity) UND T6 (Order)
Resultat: EINE Chunk-Grenze (nicht 2!)

chunk[i].trigger_list = [T1, T6]
```

**Trigger-Priorität (informativ, nicht implementierungskritisch):**
```
Höchste Priorität: T8 (Prozess ist Kern-Diskriminator)
Hohe Priorität:    T4, T5 (Hand-Interaktion oft mit Prozess gekoppelt)
Mittlere Priorität: T1, T6, T7 (Motor und Kontext)
Niedrig:            T2, T3, T9, T10 (körperliche Ergänzung)
```

**Interpretation:** T8 triggert häufig automatisch andere, aber alle Trigger sind GLEICHBERECHTIGT.

---

## 3. CHUNK-VALIDIERUNG

### 3.1 Interne Konsistenz (V1-V3)

**V1: Single-Label Exklusivität**
```
REGEL: In Single-Label Kategorien {CC01, CC02, CC07, CC08, CC09, CC10}
       muss EXAKT ein Label aktiv sein pro Frame.

PRÜFUNG:
FOR EACH chunk:
    FOR EACH frame in chunk:
        FOR cc in {CC01, CC02, CC07, CC08, CC09, CC10}:
            IF count(active_labels[cc]) != 1:
                chunk.validity = INVALID
                chunk.error = f"Multi-label in Single-Label {cc}"
```

**V2: Multi-Label Gültigkeit**
```
REGEL: Multi-Label Kategorien müssen gültige Kombinationen erfüllen:

  - CC03 (Torso): Max 2 Labels (Beugung + [optionale Rotation])
  - CC04/CC05 (Hände): EXAKT 4 Komponenten (Position + Movement + Object + Tool)
  - CC06 (Order): Max 2 (single oder 2904+2905 combo)
  - CC11/CC12 (Locations): Hierarchisch korrekt

PRÜFUNG:
FOR EACH chunk:
    IF NOT validate_hand_4components(chunk.cc04):
        chunk.validity = INVALID
        chunk.error = "Hand-Komponenten unvollständig"
    # etc für CC05, CC06, CC11, CC12
```

**V3: Prozess-Hierarchie Konsistenz**
```
REGEL: High-Level, Mid-Level, Low-Level müssen kohärent sein

Beispiel:
  IF CC08="Retrieval" (CL110):
      THEN CC09 MUSS EINER SEIN VON {CL114, CL115, CL116, CL118, CL121}
      ELSE: INVALID

  IF CC09="Picking - Pick Time" (CL116):
      THEN CC10 MUSS Pick-Time-relevant sein
      (Gemäß V-B3 in phase4_bpmn_validation.md: CL139, CL140, CL151, CL134)
      ELSE: WARNING

PRÜFUNG:
FOR EACH chunk:
    valid_mid_level = get_valid_mid_level(chunk.cc08)
    IF chunk.cc09 NOT IN valid_mid_level:
        chunk.validity = INVALID
```

### 3.2 Externe Konsistenz (C1-C3)

**C1: Keine Duplikate**
```
REGEL: Aufeinanderfolgende Chunks mit identischem Label-Zustand
       zeigen an, dass Trigger NICHT korrekt erkannt wurde.

PRÜFUNG:
FOR i in range(len(chunks)-1):
    state_i = chunks[i].label_snapshot
    state_i1 = chunks[i+1].label_snapshot
    
    IF state_i == state_i1:
        error("Duplicate chunks detected (Trigger nicht erfasst)")
```

**C2: Frame-Kontinuität**
```
REGEL: Kein Frame darf lückenlos oder überlappend sein.

Chunk i:   Frames [500, 501, 502]
Chunk i+1: Frames [503, 504, ...]  — MUSS mit 503 starten!

PRÜFUNG:
FOR i in range(len(chunks)-1):
    IF chunks[i].last_frame + 1 != chunks[i+1].first_frame:
        error("Frame gap or overlap detected")
```

**C3: Trigger-Sequenz Validität**
```
REGEL: Trigger-Folge muss logisch sein.

Beispiel FEHLER:
  Chunk i:   trigger=[T1]  (Main Activity ändert)
  Chunk i+1: trigger=[T1]  (Main Activity ändert wieder)
  Aber Frame state zeigt, CC01 ist identisch!
  → FEHLER: Trigger wurde mehrfach erkannt ohne tatsächliche Änderung

PRÜFUNG:
FOR i in range(len(chunks)-1):
    IF chunks[i].trigger_list:
        for trigger in chunks[i].trigger_list:
            category = trigger.category
            IF chunks[i].label[category] == chunks[i+1].label[category]:
                error(f"Trigger {trigger} erkannt aber Label identisch")
```

### 3.3 Anomalie-Konsistenz (A1-A2)

**A1: Anomalien ohne Chunk-Grenzen dokumentieren**
```
FALL: Ein Frame violiert Ground Truth (v3.0) Szenario-Logik,
      aber T1-T13 werden NICHT ausgelöst.

REGEL:
  chunk.anomalous_frames.append(i)
  chunk.anomaly_type = "Retrieval_Mismatch"
  chunk.status = "ANOMALOUS"
```

**A2: Chunk-Anomalie-Status Klassifikation**
```
FOR EACH chunk:
    normal_frame_count = 0
    anomaly_frame_count = 0
    
    FOR EACH frame in chunk:
        scenario = ground_truth_v3.classify(frame)
        IF scenario is valid (S1-S8, Other_*):
            normal_frame_count += 1
        ELSE:
            anomaly_frame_count += 1
    
    IF anomaly_frame_count == 0:
        chunk.status = "NORMAL"
    ELIF anomaly_frame_count < 0.1 * total_frames:
        chunk.status = "NORMAL_WITH_ARTIFACTS"  # <10% anomalies OK
    ELSE:
        chunk.status = "ANOMALOUS"
```

### 3.4 Validierungs-Metriken

| Metrik | Definition | Zielwert |
|--------|-----------|----------|
| **Valid Chunks %** | Bestehen V1-V3 + C1-C3 | >95% |
| **Pure Chunks %** | Nur ein Szenario | 70-80% |
| **Boundary Chunks %** | Genau 2 Szenarien (Übergänge) | 15-20% |
| **Anomalous Chunks %** | Violieren Ground Truth | <5% |
| **Trigger Coverage %** | % Frames an Trigger-Position | 90-95% |
| **Avg Chunk Duration** | Sekunden | 1-3 (typisch) |

---

## 4. CHUNK-SZENARIO INTEGRATION

### 4.1 Fundamentale Beziehung

**Zwei unabhängige Ebenen:**
```
EBENE 1: Chunk (Label-basiert, T1-T13)
         → Bestimmt durch Zustandsstabilität

EBENE 2: Szenario (Klassifikation, Ground Truth v3.0)
         → Bestimmt durch 5-Schritt Logic (siehe phase1_scenario_recognition.md)
```

**Beide sind DETERMINISTISCH, aber UNABHÄNGIG:**
- Eine Chunk-Grenze garantiert NICHT einen Szenario-Wechsel
- Ein Szenario-Wechsel erzeugt typischerweise (aber nicht immer) eine Chunk-Grenze

### 4.2 Drei Synchronisationsmuster

#### PATTERN A: SYNCHRONE GRENZEN (Typisch ~70%)

**Definition:** Chunk-Grenze und Szenario-Grenze fallen zusammen

```
Frame i-1: Labels stabil     + Szenario = S1
Frame i:   Labels ändern     + Szenario = S4
           → Trigger T8 (CL110→CL111)  
           → Szenario-Wechsel S1→S4
           → SYNCHRONE GRENZE
```

**Auslöser für Synchronie:**
- High-Level Prozess wechselt (T8a: CL110→CL111)
- Order wechselt grundlegend (T6: z.B. CL100→CL101)
- IT-System wechselt (T7: z.B. CL105→CL107)

#### PATTERN B: ASYNCHRONE CHUNK-GRENZEN (Häufig ~20%)

**Definition:** Chunk-Grenze, aber KEIN Szenario-Wechsel

```
Frame i-1: CC01=Walking         + Szenario = S1
Frame i:   CC01=Standing        + Szenario = S1
           → Trigger T1 (Main Activity)  
           → Kein Szenario-Wechsel (bleibt S1)
           → ASYNCHRONE CHUNK-GRENZE
```

**Das ist NORMAL und ERWARTET!**
- Motor-Änderungen (T1-T5) triggern Chunks ohne Szenario-Effekt
- Spatial-Änderungen (T9-T10) triggern Chunks ohne Szenario-Effekt

#### PATTERN C: ASYNCHRONE SZENARIO-KLASSIFIKATION (Selten ~10%)

**Definition:** Szenario-Klassifikation ändert, aber KEINE Chunk-Grenze

```
Frame i-1: Labels stabil     + Ground Truth = S1 (valid)
Frame i:   Labels stabil     + Ground Truth = Retrieval_Mismatch (anomaly!)
           → KEIN Trigger erfüllt
           → Szenario ändert (aber anomalisch)
           → ANOMALOUS (innerhalb desselben Chunks!)
```

**Wann tritt das auf?** Annotationsfehler oder ambige Grenzfälle.

### 4.3 Konkrete Transitions und Chunk-Erwartungen

**Transition S1 → S2 (beide Retrieval, unterschiedliche IT)**
```
Frame i-1: CL110=1, CL105=1, CL100=1 → S1
Frame i:   CL110=1, CL107=1, CL101=1 → S2

Label-Änderungen:
  CL105 (List+Pen) → CL107 (PDT)  [T7]
  CL100 (Order2904) → CL101 (Order2905)  [T6]

Trigger: T6 + T7 (simultane Trigger)
→ 1 Chunk-Grenze (nicht 2)
Szenario-Wechsel: S1→S2 (synchron)
Status: ✅ SYNCHRON
```

**Transition S1 → S7 (Single-Order → Multi-Order)**
```
Frame i-1: CL110=1, CL105=1, CL100=1 (Order2904 only) → S1
Frame i:   CL110=1, CL105=1, CL100=1, CL101=1 (both) → S7

Label-Änderungen:
  CL101 wird hinzugefügt (0→1)  [T6]

Trigger: T6 (Order Addition)
→ 1 Chunk-Grenze
Szenario-Wechsel: S1→S7 (synchron)
Status: ✅ SYNCHRON
```

**Transition S4 → S1 (Storage → Retrieval)**
```
Frame i-1: CL111=1, CL105=1, CL100=1, CC09=CL119 → S4
Frame i:   CL110=1, CL105=1, CL100=1, CC09=CL115 → S1

Label-Änderungen:
  CL111 → CL110 (Storage → Retrieval)  [T8a]
  CC09: CL119 → CL115  [T8b]

Trigger: T8 (High-Level + Mid-Level gleichzeitig)
→ 1 Chunk-Grenze
Szenario-Wechsel: S4→S1 (synchron)
Status: ✅ SYNCHRON
```

---

## 4.5 BRIDGE ZU GROUND TRUTH CENTRAL v3.0

### 4.5.1 Warum diese Bridge entscheidend ist

Die Bridge zeigt die explizite Verbindung zwischen Chunking-Trigger und
Ground Truth Klassifikation. Szenario-Erkennung siehe phase1_scenario_recognition.md.

### 4.5.2 Die 3 Klassifikations-Trigger und ihre GTV3.0 Entsprechungen

#### T11: CL134 = Waiting (Global Interrupt)

```
Chunking: CL134 state 0→1 → neue Chunk-Grenze
GTV3.0:   Schritt 1: IF cl134[i] == 1 → scenario = "Other_Waiting"

SYNCHRONISIERUNG:
Frame 549: CL134=0, Szenario = S1
Frame 550: CL134=1 → TRIGGER T11 + Ground Truth: "Other_Waiting"
→ SYNCHRONE GRENZEN ✅
```

#### T12: (CL112 OR CL113) OHNE (CL110 OR CL111)

```
Chunking: CL112=1 OR CL113=1, OHNE CL110/CL111 → neue Chunk-Grenze
GTV3.0:   scenario = "Other_Process"

SYNCHRONISIERUNG:
Frame 300: CL110=1 → S1
Frame 301: CL110=0, CL112=1 → TRIGGER T12 + "Other_Process"
→ SYNCHRONE GRENZEN ✅
```

#### T13: CL103 = No Order AND CL108 = No IT

```
Chunking: CL103=1 AND CL108=1 → neue Chunk-Grenze
GTV3.0:   scenario = "Other_NoData"

SYNCHRONISIERUNG:
Frame 200: CL100=1, CL105=1 → S1
Frame 201: CL103=1, CL108=1 → TRIGGER T13 + "Other_NoData"
→ SYNCHRONE GRENZEN ✅
```

### 4.5.3 Validierungs-Checkliste: T11-T13 ↔ GTV3.0 Alignment

```python
IF chunk.trigger_list contains (T11 OR T12 OR T13):
    trigger_frame = chunk.end
    next_frame = trigger_frame + 1
    
    IF trigger == T11:
        ✅ MUSS: scenario[next_frame] == "Other_Waiting"
        ✅ MUSS: CL134[next_frame] == 1
        
    ELIF trigger == T12:
        ✅ MUSS: scenario[next_frame] == "Other_Process"
        ✅ MUSS: (CL112[next_frame] OR CL113[next_frame])
        ✅ MUSS: NOT (CL110 OR CL111)
        
    ELIF trigger == T13:
        ✅ MUSS: scenario[next_frame] == "Other_NoData"
        ✅ MUSS: CL103[next_frame] == 1 AND CL108[next_frame] == 1
    
    IF ANY check fails:
        ⚠ ERROR: T11-T13 Trigger ↔ GTV3.0 Mismatch!
```

---

## 4.6 MULTI-ORDER HANDLING: S7 UND S8

### 4.6.1 Überblick: Single-Order vs Multi-Order

#### Single-Order Szenarien (S1-S6)
```
Alle Frames einer Phase haben nur eine Order aktiv.
Chunk-Grenzen entstehen durch T1-T10, aber NICHT wegen Order-Wechsel.
```

#### Multi-Order Szenarien (S7 & S8)
```
Zeitstrahl: 0s    10s   20s   30s   40s   50s   60s
Order:      2904  2904  2905  2905  2904  2904  2904
                       → ORDER ADDITION!
           Szenario: S1    S7         S1    S1    S1

Frame 20→21: ORDER ADDITION (CL100=1, CL101=1)
             → TRIGGER T6! Neue Chunk-Grenze
             → Ground Truth S1→S7 (Szenario-Wechsel)
             → Pattern A: SYNCHRONE GRENZEN ✅

Frame 30→31: ORDER REMOVAL (CL101: 1→0)
             → TRIGGER T6! Neue Chunk-Grenze
             → Ground Truth S7→S1
             → Pattern A: SYNCHRONE GRENZEN ✅
```

### 4.6.2 S7: Multi-Order Retrieval

**Definition:**
```
High-Level: CL110 = Retrieval
Orders:     CL100=1 (Order 2904) AND CL101=1 (Order 2905)
IT-System:  CL105 oder CL106 oder CL107 (variabel)
Mid-Level:  CL115, CL116, CL118, CL121
```

**Erlaubte Order-Kombinationen:**
```
✅ ERLAUBT:   CL100=1 + CL101=1    (2904 + 2905) → S7
✗ NICHT ERLAUBT: CL100=1 + CL102=1 → Multi_Retrieval_Anomaly
✗ NICHT ERLAUBT: CL101=1 + CL102=1 → Multi_Retrieval_Anomaly
```

**Validierungsregeln für S7:**
```
V1: CL110=1 (exakt Retrieval)
V2: CL100 AND CL101 (genau diese 2 Orders)
V3: CC09 ∈ {CL115, CL116, CL118, CL121}
S7-spezifisch: IT variabel (CL105 oder CL106 oder CL107)
```

### 4.6.3 S8: Multi-Order Storage

**Definition:**
```
High-Level: CL111 = Storage
Orders:     CL100=1 (Order 2904) AND CL101=1 (Order 2905)
IT-System:  CL105 = List+Pen (KONSTANT für Storage!)
Mid-Level:  CL117, CL119, CL120, CL121
```

**Unterschied zu S7:**
```
              S7 (Retrieval)     S8 (Storage)
IT-System     Variabel           Konstant (CL105 = List+Pen)
Komplexität   Höher              Niedriger
Navigation    Mehrere Regale     Ein Packing-Bereich
```

### 4.6.4 Edge Cases & Anomalien

**Edge Case 1: Sehr kurze Multi-Order Phase**
```
Frame 20: CL100=1, CL101=0 → S1
Frame 21: CL100=1, CL101=1 → S7 (T6)
Frame 22: CL100=1, CL101=0 → S1 (T6)

Technisch OK, aber S7 dauert nur 1 Frame.
Empfehlung: Video prüfen — Annotationsfehler wahrscheinlich.
```

**Edge Case 2: Unerwünschte Multi-Order**
```
Frame 20: CL100=1, CL102=0 → S1
Frame 21: CL100=1, CL102=1 → ANOMALIE!

NICHT ERLAUBT: 2904+2906 ist keine dokumentierte Kombination.
Ground Truth: "Multi_Retrieval_Anomaly"
```

**Edge Case 3: Order-Wechsel statt Addition**
```
Frame 20: CL100=1, CL101=0 → S1
Frame 21: CL100=0, CL101=1 → S2 (nicht S7!)

Das ist Order-Wechsel (2904→2905), nicht Multi-Order.
Trigger: T6
Szenario: S1→S2 (Single-Order Wechsel)
```

### 4.6.5 S7/S8 Validierungs-Checkliste

```python
def validate_s7_s8_chunk(chunk):
    """Validiere S7 oder S8 Chunks"""
    
    # V1: Single-Label Exklusivität
    assert chunk.cc01.count() == 1, "Main Activity muss exakt 1 sein"
    assert chunk.cc08.count() == 1, "High-Level muss exakt 1 sein"
    assert chunk.cc09.count() == 1, "Mid-Level muss exakt 1 sein"
    assert chunk.cc10.count() == 1, "Low-Level muss exakt 1 sein"
    
    # V2: Multi-Label Order Gültigkeit
    if chunk.scenario in ["S7", "S8"]:
        assert chunk.cl100 == 1 and chunk.cl101 == 1, "Multi: beide Orders aktiv"
        assert chunk.cl102 == 0, "CL102 muss 0 sein (nicht erlaubte Kombo)"
    
    # V3: Prozess-Hierarchie
    if chunk.cl110 == 1:  # Retrieval
        assert chunk.cc09 in [CL114, CL115, CL116, CL118, CL121]
    if chunk.cl111 == 1:  # Storage
        assert chunk.cc09 in [CL114, CL117, CL119, CL120, CL121]
    
    # S7-spezifisch
    if chunk.scenario == "S7":
        assert chunk.cl110 == 1, "S7 muss Retrieval sein"
    
    # S8-spezifisch
    if chunk.scenario == "S8":
        assert chunk.cl111 == 1, "S8 muss Storage sein"
        assert chunk.cl105 == 1, "S8 IT MUSS List+Pen sein (CL105)"
    
    return True
```

---

## 5. PRAKTISCHE BEISPIELE

### 5.1 Frame-by-Frame Chunk-Konstruktion

**Raw Frame-Daten (Beispiel):**

```
Frame | CC01   | CC02  | CC04_Pos | CC08 | CC09 | CC10  | CC06 | Szenario
------|--------|-------|----------|------|------|-------|------|----------
500   | Walk   | Gait  | Upwards  | Retr | Pick | Retri | 2904 | S1
501   | Walk   | Gait  | Upwards  | Retr | Pick | Retri | 2904 | S1
502   | Walk   | Gait  | Downward | Retr | Pick | Retri | 2904 | S1  → T4
503   | Walk   | Gait  | Centered | Retr | Pick | Move  | 2904 | S1  → T4+T8c
504   | Stand  | Still | Centered | Retr | Pick | Move  | 2904 | S1  → T1+T2
505   | Stand  | Still | Centered | Retr | Pick | Move  | 2904 | S1
```

**Chunk-Konstruktion:**

```
CHUNK 1:  Frames 500-501 (stabil)
  Szenario: S1

CHUNK 2:  Frame 502 (T4: Hand-Position ändert)
  Trigger: T4 (Upwards→Downward)
  Szenario: S1
  
CHUNK 3:  Frame 503 (T4+T8c: Hand UND Low-Level ändern)
  Trigger: T4 + T8c
  Szenario: S1
  
CHUNK 4:  Frames 504-505 (T1+T2: Main Activity + Legs)
  Trigger: T1 (Walking→Standing), T2 (Gait→Still)
  Szenario: S1
  Pattern: ASYNCHRONE CHUNK-GRENZE (Motor-Changes ohne Szenario-Effekt)
```

---

## 6. HIERARCHIE UND BEZIEHUNGEN

### 6.1 Chunk → Prozess → Szenario Hierarchie

```
EBENE 0: Frame-Level (30 fps, variabel pro Proband)
    Rohe Annotationsdaten, hochfrequent

EBENE 1: Chunk-Level (T1-T13 segmentiert, typisch mehrere tausend)
    Stabile Zustände, determiniert durch Trigger
    
EBENE 2: Prozess-Level (CC08/CC09/CC10, mehrere hundert Prozess-Blöcke)
    High-Level (Retrieval/Storage)
        → Mid-Level (Travel/Pick/Store/...)
            → Low-Level (atomic actions)
    
EBENE 3: Szenario-Level (S1-S8 + Other)
    Ground Truth v3.0 Klassifikation pro Frame
    Aggregiert zu Chunk-Szenario Zuordnung
```

### 6.2 Cross-References

- **Label-Definitionen (CL001-CL207):** → reference_labels.md
- **Szenario-Erkennung (Ground Truth v3.0):** → phase1_scenario_recognition.md
- **Validierungsregeln (Master-Slave):** → reference_validation_rules.md
- **Process-Validierung & Konformität:** → phase4_bpmn_validation.md
- **CC09→CC10 Mappings (V-B3):** → phase4_bpmn_validation.md + reference_bpmn_flows.md
- **Aktivierungsregeln (Min/Max):** → reference_activation_rules.md

---

## APPENDIX: Schnell-Referenz — Chunk-Szenario Transitions

**Wann erzeugt Szenario-Wechsel IMMER Chunk-Grenze?**

| Transition | High-Level Wechsel? | Triggertyp | Chunk-Grenze? | Grund |
|-----------|---------------------|-----------|---------------|-------|
| S1 → S2 | Nein (beide Retr) | T6 + T7 | ✅ JA | Order + IT wechsel |
| S1 → S7 | Nein (beide Retr) | T6 | ✅ JA | Order Addition |
| S1 → S4 | **Ja** (Retr→Stor) | T8 | ✅ JA | High-Level Wechsel |
| S4 → S5 | Nein (beide Stor) | T6 | ✅ JA | Order wechsel |
| S7 → S1 | Nein | T6 | ✅ JA | Order Removal |
| S4 → Other_Waiting | Ja (→CL134) | T11 | ✅ JA | Global Interrupt |
| S8 → S4 | Nein (beide Stor) | T6 | ✅ JA | Order Removal |

**Wann Chunk-Grenze OHNE Szenario-Wechsel?**

| Beispiel | Change | Trigger | Chunk-Grenze? | Szenario-Effekt |
|----------|--------|---------|---------------|-----------------|
| S1 stabil | CC01: Walk→Stand | T1 | ✅ JA | S1→S1 (kein Effekt) |
| S1 stabil | CC04 Hand-Pos | T4 | ✅ JA | S1→S1 (kein Effekt) |
| S1 stabil | CC11 Location | T9 | ✅ JA | S1→S1 (kein Effekt) |
| S1 stabil | Alle stabil | keine | ✗ NEIN | S1→S1 (selber Chunk) |

---

**Skill-Version:** 6.1.0
**Erstellt:** 05.12.2025
**Update:** 26.02.2026 (v6.0 Bereinigung)
**Quelle:** DaRa Dataset Description, Teil 3 — Chunking

<!-- VERIFICATION_TOKEN: DARA-CHUNK-6N3D-v630 -->
