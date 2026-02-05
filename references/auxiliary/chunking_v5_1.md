# DaRa Dataset – Chunking-Logik

**Quelle:** DaRa Dataset Description (Stand 20.10.2025)  
**Skill-Version:** 5.0  
**Erstellt:** 05.12.2025  
**Update:** 29.01.2026  

> Für vollständige Changelog siehe: [CHANGELOG_chunking.md](../../CHANGELOG_chunking.md)

---

## 0. ÜBERBLICK UND ZWECK

Das Chunking-System segmentiert den kontinuierlichen Frame-Strom (30 fps) in **stabilitäts-definierte Einheiten (Chunks)**. Jeder Chunk repräsentiert einen konsistenten Labelzustand über alle 12 Kategorien.

**Warum Chunking?**
- Reduktion hochfrequenter Frame-Daten (≈18,000 frames/Proband) auf interpretierbare Segmente
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
Frame-Ebene (30 fps, ≈18,000 frames)
    – " aggregiert durch Trigger
Chunk-Ebene (stabile Zustände, ≈2,000-3,000 chunks)
    – " klassifiziert durch Ground Truth v3.0
Szenario-Ebene (S1-S8 + Other, ≈100-200 chunks)
    – " organisiert in
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
| **T1** | CC01 Main Activity | 15 | Single | Label-Wechsel (z.B. Walking -> Standing) |
| **T2** | CC02 Legs | 8 | Single | Label-Wechsel (z.B. Gait -> Standing Still) |
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
| **T7** | CC07 IT-System | 5 | Single | IT-Wechsel (z.B. List+Pen -> PDT) |

**Auslösebedingung für T6-T7:**
```
IF ein Label in {CC06, CC07} ändert:
    Chunk-Grenze
```

**Besonderheit T6:** Multi-Order Aktivierung
- Addition: CL100=1, CL101=0 -> CL100=1, CL101=1 (T6!)
- Entfernung: CL100=1, CL101=1 -> CL100=1, CL101=0 (T6!)

#### C. PROCESS-TRIGGER (T8: High/Mid/Low)
Prozessebenen-Wechsel

| ID | Kategorie | Labels | Typ | Bedingung |
|----|-----------|--------|-----|-----------|
| **T8a** | CC08 High-Level | 4 | Single | High-Level Wechsel (Retrieval -> Storage -> Other) |
| **T8b** | CC09 Mid-Level | 10 | Single | Mid-Level Wechsel (Travel Time -> Pick Time -> ...) |
| **T8c** | CC10 Low-Level | 31 | Single | Low-Level Wechsel (jeden der 31 Prozesse) |

**Auslösebedingung für T8:**
```
IF JEDER Label in {CC08, CC09, CC10} ändert (egal welcher!):
    Chunk-Grenze (EINE Grenze, nicht 3)
```

**Wichtig:** T8c Low-Level ist der **häufigste Trigger** (≈60% aller Chunk-Grenzen)

#### D. SPATIAL-TRIGGER (T9-T10)
Ortsveränderung

| ID | Kategorie | Labels | Typ | Bedingung |
|----|-----------|--------|-----|-----------|
| **T9** | CC11 Location Human | 26 | Hierarchisch (Max 3) | Hierarchische Kombination ändert sich |
| **T10** | CC12 Location Cart | 27 | Hierarchisch (Max 4) | Hierarchische Kombination ändert sich |

**Hierarchische Struktur CC11/CC12:**
```
Main Area (z.B. "Storage Aisle")
  -> Aisle (z.B. "Aisle 3")
      -> Position (z.B. "Shelf Level 2")

Änderung auf JEDER Ebene -> T9/T10
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
| **T11** | CL134 Waiting | Global Interrupt | CL134: 0->1 (Worker wartet) |
| **T12** | CL112/CL113 Unknown Process | Unknown | (CL112 OR CL113)=1 AND (CL110 OR CL111)=0 |
| **T13** | CL103+CL108 No Data | No Data | CL103=1 AND CL108=1 (kombiniert) |

**Auslösebedingung für T11-T13:**
```
IF CL134 state ändert (z.B. 0->1):
    Chunk-Grenze + szenario="Other_Waiting"

IF (CL112 OR CL113) aktiviert ohne Retrieval/Storage:
    Chunk-Grenze + szenario="Other_Process"

IF (CL103 AND CL108) kombiniert:
    Chunk-Grenze + szenario="Other_NoData"
```

**Wichtig:** T11-T13 sind **immer redundant** mit T1-T10 (T11 -> T1, T12 -> T8, T13 -> T6+T7), werden aber explizit dokumentiert zur Kennzeichnung von Ground Truth v3.0 Sonderfällen (Waiting, Unknown Process, No Data).

### 2.2 Formale Trigger-Definition

**Universale Regel für Chunk-Grenzenerkennung:**

```python
FOR EACH Frame i (1 to N-1):
    
    previous_state = {
        cc01[i-1], cc02[i-1], ..., cc12[i-1]  # Label-Snapshot
    }
    
    current_state = {
        cc01[i], cc02[i], ..., cc12[i]  # Label-Snapshot
    }
    
    IF previous_state != current_state:
        # Mindestens ein Label hat sich geändert
        
        # Prüfe welche Trigger erfüllt sind
        triggers_activated = []
        
        IF cc01[i-1] != cc01[i]: triggers_activated.append(T1)
        IF cc02[i-1] != cc02[i]: triggers_activated.append(T2)
        IF cc03[i-1] != cc03[i]: triggers_activated.append(T3)
        # ... etc für T4-T10
        
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
        # Kein Zustandswechsel – ' selber Chunk
        chunk[i].within_chunk = TRUE
```

### 2.3 Simultane Trigger und Priorität

**Fall: Mehrere Trigger gleichzeitig**

```
Frame i-1: CC01=Walking, CC06=Order2904
Frame i:   CC01=Standing, CC06=Order2905

Auslöser: T1 (Main Activity) UND T6 (Order)
Resultat: EINE Chunk-Grenze (nicht 2!)

chunk[i].trigger_list = [T1, T6]
```

**Trigger-Priorität (informativ, nicht implementierungskritisch):**
```
Höchste Priorität: T8 (Prozess ist Kern-Diskriminator)
Hohe Priorität:   T4, T5 (Hand-Interaktion oft mit Prozess gekoppelt)
Mittlere Priorität: T1, T6, T7 (Motor und Kontext)
Niedrig:           T2, T3, T9, T10 (körperliche Ergänzung)
```

**Interpretation:** T8 triggert häufig automatisch andere, aber all triggers sind GLEICHBERECHTIGT.

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
      THEN CC10 MUSS Retrieval-relevant sein (z.B. CL139 Retrieving Items)
      ELSE: WARNING (aber nicht zwingend invalid)

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
    state_i+1 = chunks[i+1].label_snapshot
    
    IF state_i == state_i+1:
        error("Duplicate chunks detected (Trigger nicht erfasst)")
```

**C2: Frame-Kontinuität**
```
REGEL: Kein Frame darf lückenlos oder überlappend sein.

Chunk i:   Frames [500, 501, 502]
Chunk i+1: Frames [503, 504, ...]  –   MUSS mit 503 starten!

PRÜFUNG:
FOR i in range(len(chunks)-1):
    IF chunks[i].last_frame + 1 != chunks[i+1].first_frame:
        error("Frame gap or overlap detected")
```

**C3: Trigger-Sequenz Validität**
```
REGEL: Trigger-Folge muss logisch sein.

Beispiel FEHLER:
  Chunk i:   trigger=[T1]  (Main Activity ändert)
  Chunk i+1: trigger=[T1]  (Main Activity ändert wieder)
  Aber Frame state zeigt, CC01 ist identisch!
  – ' FEHLER: Trigger wurde mehrfach erkannt ohne tatsächliche Änderung

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

Beispiel:
  Frame i-1: CL110=1, CL105=1, CL100=1 – ' S1 (valid)
  Frame i:   CL110=1, CL105=1, CL102=1 – ' Retrieval_Mismatch (anomaly!)
             (Aber CL110 und CL105 bleiben 1!)
             (Nur CL102 ändert, aber wenn nicht Single-Label...)

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
        IF scenario is "S1" or "S2" or ... or "S8" or "Other_*":
            normal_frame_count += 1
        ELSE IF scenario is "Retrieval_Mismatch" or "*_Anomaly":
            anomaly_frame_count += 1
    
    IF anomaly_frame_count == 0:
        chunk.status = "NORMAL"
    ELIF anomaly_frame_count < 0.1 * total_frames:
        chunk.status = "NORMAL_WITH_ARTIFACTS"  # <10% anomalies OK
    ELSE:
        chunk.status = "ANOMALOUS"
```

### 3.4 Validierungs-Metriken

**Pro Datensatz:**

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
         – ' Bestimmt durch Zustandsstabilität

EBENE 2: Szenario (Klassifikation, Ground Truth v3.0)
         – ' Bestimmt durch 5-Schritt Logic (CL110, CL107, CL106, CL100, CL101, CL102)
```

**Beide sind DETERMINISTISCH, aber UNABHÄNGIG:**
- Eine Chunk-Grenze garantiert NICHT einen Szenario-Wechsel
- Ein Szenario-Wechsel erzeugt typischerweise (aber nicht immer) eine Chunk-Grenze

### 4.2 Drei Synchronisationsmuster

#### PATTERN A: SYNCHRONE GRENZEN (Typisch ~70%)

**Definition:** Chunk-Grenze und Szenario-Grenze fallen zusammen

```
Frame i-1: Labels stabil     + Szenario = S1
Frame i:   Labels ändern     + Szenario = S4
           –> Trigger T8 (CL110 -> CL111)  
           –> Szenario-Wechsel S1 -> S4
           –> SYNCHRONE GRENZE
```

**Auslöser für Synchronie:**
- High-Level Prozess wechselt (T8a: CL110 -> CL111)
- Order wechselt grundlegend (T6: z.B. CL100 -> CL101)
- IT-System wechselt (T7: z.B. CL105 -> CL107)

**Validierungsregel:**
```
IF Szenario ändert (z.B. S1->S4):
    DANN muss Chunk-Grenze (T1-T13) an derselben Position sein
    ELSE: report_async_boundary()
```

#### PATTERN B: ASYNCHRONE CHUNK-GRENZEN (Häufig ~20%)

**Definition:** Chunk-Grenze, aber KEIN Szenario-Wechsel

```
Frame i-1: CC01=Walking         + Szenario = S1
Frame i:   CC01=Standing        + Szenario = S1
           –> Trigger T1 (Main Activity)  
           –> Kein Szenario-Wechsel (bleibt S1)
           –> ASYNCHRONE CHUNK-GRENZE
```

**Das ist NORMAL und ERWARTET!**
- Motor-Änderungen (T1-T5) triggern Chunks ohne Szenario-Effekt
- Spatial-Änderungen (T9-T10) triggern Chunks ohne Szenario-Effekt
- Beispiel: Worker läuft in selbekm Szenario von einem Ort zum anderen

**Validierungsregel:**
```
IF Chunk-Grenze OHNE Szenario-Wechsel:
    Prüfe, dass Trigger in {T1, T2, T3, T4, T5, T9, T10}
    Wenn JA: Normal ✔
    Wenn NEIN (z.B. T6 aber selbe Order): Report ⚠️
```

#### PATTERN C: ASYNCHRONE SZENARIO-KLASSIFIKATION (Selten ~10%)

**Definition:** Szenario-Klassifikation ändert, aber KEINE Chunk-Grenze

```
Frame i-1: Labels stabil     + Ground Truth = S1 (valid)
```Frame i:   Labels stabil     + Ground Truth = Retrieval_Mismatch (anomaly!)
           — KEIN Trigger erfüllt (CL110, CL105, CL100 alle stabil)
           — Szenario ändert (aber anomalisch)
           — ANOMALOUS (in selekm Chunk!)
```

**Wann tritt das auf?**
```
Beispiel 1:
  Frame i-1: CL110=1 (Retrieval), CL105=1 (List+Pen), CL100=1 (Order2904) — S1 ✓
  Frame i:   CL110=1 (Retrieval), CL105=1 (List+Pen), CL102=1 (Order2906) — Mismatch ⚠️ 
  
  Warum kein Trigger T6?
  - Wenn CL100 und CL102 sind BEIDE Single-Label (exklusiv), ändert sich einer — T6!
  - ABER wenn falsch annotiert: Beide gleichzeitig 1 — kein Zustandswechsel auf Frame-Ebene
  
Beispiel 2:
  Frame i-1: CL100=1, CL101=0, all else stable — S1
  Frame i:   CL100=1, CL101=1, all else stable — S7
  
  Erwartung: T6 (Order Addition) — neue Chunk
  Realität: Immer richtig erkannt
```

**Validierungsregel:**
```
FOR EACH chunk:
    anomaly_frames = []
    FOR EACH frame in chunk:
        if ground_truth_classify(frame) in [*Mismatch, *Anomaly, Unclassified]:
            anomaly_frames.append(frame)
    
    IF anomaly_frames and (length(anomaly_frames) < length(chunk)):
        chunk.mark_as("PARTIAL_ANOMALY")
        chunk.anomalous_frames = anomaly_frames
        report_anomaly(chunk)  # Für Datenqualitäts-Check
```

### 4.3 Konkrete Transitions und Chunk-Erwartungen

**Transition S1 — S2 (beide Retrieval, unterschiedliche IT)**
```
Frame i-1: CL110=1, CL105=1, CL100=1 — S1
Frame i:   CL110=1, CL107=1, CL101=1 — S2

Label-Änderungen:
  CL105 (List+Pen) — CL107 (PDT)  [T7]
  CL100 (Order2904) — CL101 (Order2905)  [T6]
  CL110 bleibt CL110 (no T8)

Trigger: T6 + T7 (simultane Trigger)
— 1 Chunk-Grenze (nicht 2)
Szenario-Wechsel: S1—S2 (synchron mit Chunk-Grenze)
Status: ✓ SYNCHRON
```

**Transition S1 — S7 (Single-Order — Multi-Order)**
```
Frame i-1: CL110=1, CL105=1, CL100=1 (Order2904 only) — S1
Frame i:   CL110=1, CL105=1, CL100=1, CL101=1 (both) — S7

Label-Änderungen:
  CL101 wird hinzugefügt (0—1)  [T6]
  Alle anderen stabil

Trigger: T6 (Order Addition)
— 1 Chunk-Grenze
Szenario-Wechsel: S1—S7 (synchron)
Status: ✓ SYNCHRON
```

**Transition S4 — S1 (Storage — Retrieval)**
```
Frame i-1: CL111=1, CL105=1, CL100=1, CC09=CL119 (Storing Travel) — S4
Frame i:   CL110=1, CL105=1, CL100=1, CC09=CL115 (Picking Travel) — S1

Label-Änderungen:
  CL111 — CL110 (Storage — Retrieval)  [T8a High-Level]
  CC09: CL119 — CL115 (auch Mid-Level)  [T8b Mid-Level]
  CL100, CL105 stabil

Trigger: T8 (High-Level + Mid-Level gleichzeitig)
— 1 Chunk-Grenze
Szenario-Wechsel: S4—S1 (synchron mit High-Level Wechsel)
Status: ✓ SYNCHRON
```

---

## 4.5 BRIDGE ZU GROUND TRUTH CENTRAL v3.0 [NEU v5.1!]

### 4.5.1 Warum diese Bridge entscheidend ist

**Das Problem:** 
- Chunking v5.1 definiert Chunks und T11-T13 Trigger
- Ground Truth v3.0 klassifiziert Szenarien (S1-S8 + Other)
- **Aber:** Wie hängen sie zusammen? Das ist nicht klar genug!

**Die Lösung:**
Diese Bridge zeigt die explizite Verbindung zwischen Chunking-Trigger und Ground Truth Klassifikation.

### 4.5.2 Die 3 Klassifikations-Trigger und ihre GTV3.0 Entsprechungen

#### T11: CL134 = Waiting (Global Interrupt)

**Chunking v5.1:**
```
T11-Auslösung: CL134 state 0—1 (Worker wartet)
Resultat: — neue Chunk-Grenze
```

**Ground Truth v3.0 (5-Schritt Logic):**
```
Schritt 1: Global Interrupts
  IF cl134[i] == 1:
      scenario[i] = "Other_Waiting"
      RETURN (keine weitere Verarbeitung)
```

**SYNCHRONISIERUNG:**
```
Frame 549: CL134=0, Szenario = S1 (Retrieval)
Frame 550: CL134=1 (Waiting)
           — TRIGGER T11! Neue Chunk-Grenze
           — Ground Truth: "Other_Waiting"
           — SYNCHRONE GRENZEN (Pattern A) ✓

Frames 550+: Alle mit CL134=1 klassifiziert als "Other_Waiting"
            bis CL134 wieder 0 wird
```

**Validierungs-Checkliste:**
```
Wenn T11 auslöst (CL134 state 0—1):
  ✓ Chunk-Grenze erkannt? (Chunking v5.1)
  ✓ Szenario = "Other_Waiting"? (Ground Truth v3.0)
  ✓ Sind Grenzen synchronized?
  
WENN JA zu allen: Daten konsistent ✓
WENN NEIN: Bug in Klassifikation! 🚨
```

#### T12: (CL112 OR CL113) OHNE (CL110 OR CL111)

**Chunking v5.1:**
```
T12-Auslösung: CL112=1 OR CL113=1 (Unknown Process)
               ABER NICHT CL110=1 (Retrieval) 
               ABER NICHT CL111=1 (Storage)
Resultat: — neue Chunk-Grenze
```

**Ground Truth v3.0:**
```
Schritt 1: Global Interrupts (nach CL134 check)
  IF (cl112[i] == 1 OR cl113[i] == 1) AND NOT (cl110[i] == 1 OR cl111[i] == 1):
      scenario[i] = "Other_Process"
      RETURN
```

**SYNCHRONISIERUNG:**
```
Frame 300: CL110=1, CL112=0 — S1 (Retrieval)
Frame 301: CL110=0, CL112=1 (Unknown Process ohne Retrieval/Storage)
           — TRIGGER T12! Neue Chunk-Grenze
           — Ground Truth: "Other_Process"
           — SYNCHRONE GRENZEN (Pattern A) ✓
```

#### T13: CL103 = No Order AND CL108 = No IT

**Chunking v5.1:**
```
T13-Auslösung: CL103=1 (No Order)
               AND CL108=1 (No IT)
Resultat: — neue Chunk-Grenze
```

**Ground Truth v3.0:**
```
Schritt 1: Global Interrupts
  IF (cl103[i] == 1 AND cl108[i] == 1):
      scenario[i] = "Other_NoData"
      RETURN
```

**SYNCHRONISIERUNG:**
```
Frame 200: CL100=2904, CL105=List+Pen — S1
Frame 201: CL103=1, CL108=1 (weder Order noch IT!)
           — TRIGGER T13! Neue Chunk-Grenze
           — Ground Truth: "Other_NoData"
           — SYNCHRONE GRENZEN (Pattern A) ✓
```

### 4.5.3 Validierungs-Checkliste: T11-T13 -> GTV3.0 Alignment

```python
# Für jeden Frame mit T11, T12 oder T13:

IF chunk.trigger_list contains (T11 OR T12 OR T13):
    trigger_frame = chunk.end  # Frame vor dem Trigger
    next_frame = trigger_frame + 1
    
    IF trigger == T11:  # CL134 state change
        ✓ MUSS: scenario[next_frame] == "Other_Waiting"
        ✓ MUSS: CL134[next_frame] == 1
        ✓ MUSS: Chunk-Grenze synchron
        
    ELIF trigger == T12:  # CL112/CL113 ohne High-Level
        ✓ MUSS: scenario[next_frame] == "Other_Process"
        ✓ MUSS: (CL112[next_frame] OR CL113[next_frame])
        ✓ MUSS: NOT (CL110 OR CL111)
        
    ELIF trigger == T13:  # No Order AND No IT
        ✓ MUSS: scenario[next_frame] == "Other_NoData"
        ✓ MUSS: CL103[next_frame] == 1 AND CL108[next_frame] == 1
    
    IF ANY check fails:
        ❌ ERROR: T11-T13 Trigger -> GTV3.0 Mismatch!
        Log: frame, manual review erforderlich
```

### 4.5.4 Skill-Integration

**Beispiel User-Query:** "Warum ist mein Chunk 'Other_Waiting'?"

**Skill Routing (SKILL.md):**
```
"Other_Waiting" Query — chunking.md Kapitel 4.5
  1. Definition T11 (CL134 state change)
  2. GTV3.0 Klassifikation "Other_Waiting"
  3. Validierungs-Checkliste
  — Nutzer versteht komplette Kette!
```

---

## 4.6 MULTI-ORDER HANDLING: S7 UND S8 [NEU v5.1!]

### 4.6.1 Überblick: Single-Order vs Multi-Order

#### Single-Order Szenarien (S1-S6)

```
Zeitstrahl: 0s    10s   20s   30s   40s   50s   60s
Order:      2904  2904  2904  2904  2904  2904  2904
           |———————————————————— Frames 0-600 ——————————————————————|

Chunk-Szenario-Konsistenz:
  Alle Frames mit Order 2904 nur
  — S1 oder S2 oder S3 (Retrieval)
  — S4 oder S5 oder S6 (Storage)

Chunk-Grenzen entstehen durch:
  T1-T13, aber NICHT wegen Order-Wechsel
  (Order bleibt konstant 2904)
```

#### Multi-Order Szenarien (S7 & S8)

```
Zeitstrahl: 0s    10s   20s   30s   40s   50s   60s
Order:      2904  2904  2905  2905  2904  2904  2904
                       — ORDER ADDITION!
           Szenario: S1    S7         S1    S1    S1

Frame 20—21: ORDER ADDITION (CL100=1, CL101=1)
             — TRIGGER T6! Neue Chunk-Grenze
             — Ground Truth S1—S7 (Szenario-Wechsel)
             — Pattern A: SYNCHRONE GRENZEN ✓

Frame 30—31: ORDER REMOVAL (CL101: 1—0)
             — TRIGGER T6! Neue Chunk-Grenze
             — Ground Truth S7—S1
             — Pattern A: SYNCHRONE GRENZEN ✓
```

### 4.6.2 S7: Multi-Order Retrieval

**Definition:**
```
High-Level: CL110 = Retrieval (Worker pickt)
Orders:     CL100=1 (Order 2904) AND CL101=1 (Order 2905)
IT-System:  CL105 oder CL106 oder CL107 (variabel!)
Mid-Level:  CL115, CL116, CL118, CL121
```

**Erlaubte Order-Kombinationen:**
```
✓ ERLAUBT:
   CL100=1 + CL101=1    (2904 + 2905) — S7!
   
❌ NICHT ERLAUBT (Anomalie!):
   CL100=1 + CL102=1    (2904 + 2906) — Multi_Retrieval_Anomaly
   CL101=1 + CL102=1    (2905 + 2906) — Multi_Retrieval_Anomaly
```

**Praktisches Szenario: S7 in Frames 1-100**

```
Frames 1-20:
  CC01=Walking, CC02=Gait, CL110=Retrieval, CL105=List+Pen
  CL100=2904, CL101=0 (nur eine Order)
  Szenario: S1

Frame 21: ORDER ADDITION!
  CL100 bleibt 1 (war schon)
  CL101 wird 1 (neu!) — TRIGGER T6
  — Neue Chunk-Grenze
  
Frames 21-30:
  CC01=Walking, CC02=Gait, CL110=Retrieval, CL105=List+Pen
  CL100=2904, CL101=2905 (BEIDE aktiv!)
  Szenario: S7 — Multi-Order Retrieval!
  
  Ground Truth v3.0 Klassifikation (Frame 21):
    Schritt 1: Global Interrupts? NEIN
    Schritt 2: Process = Retrieval (CL110=1) ✓
    Schritt 3: Order Strategy = Multi (CL100 AND CL101 beide 1) ✓
    Schritt 4: IT System = List+Pen (CL105=1) ✓
    Schritt 5: Final Assignment?
      IF strategy == MULTI_ORDER AND multi_combo == "2904_2905":
          scenario = S7 ✓

Frames 31-50: ORDER REMOVAL
  CL101 wird 0 — TRIGGER T6
  — Neue Chunk-Grenze
  
Frames 31+:
  Szenario: zurück zu S1 (nur CL100=2904)
```

**Validierungsregeln für S7:**
```
V1 (Single-Label):
  ✓ CL110=1 (exakt Retrieval)
  ✓ CL105 OR CL106 OR CL107 (genau 1 IT-System)
  
V2 (Multi-Label für Order):
  ✓ CL100 AND CL101 (genau diese 2!)
  ❌ NICHT (CL100 AND CL102) oder (CL101 AND CL102)
  
V3 (Prozess-Hierarchie):
  IF CL110=Retrieval AND Multi-Order:
    DANN CC09 ∈ {CL115, CL116, CL118, CL121} ✓
    
S7-spezifisch:
  ✓ Chunk hat Order-Addition (T6) oder -Removal (T6)?
     Falls JA: Chunk-Grenze sollte synchron mit Szenario sein!
```

### 4.6.3 S8: Multi-Order Storage

**Definition:**
```
High-Level: CL111 = Storage (Worker packt)
Orders:     CL100=1 (Order 2904) AND CL101=1 (Order 2905)
IT-System:  CL105 = List+Pen (KONSTANT für Storage!)
Mid-Level:  CL117, CL119, CL120, CL121
```

**Unterschied zu S7:**
```
              S7 (Retrieval)     S8 (Storage)
————————————————————————————————————————————————————————————————————————————————
IT-System     Variabel           Konstant (List+Pen)
Komplexität   Höher              Niedriger
Navigation    Mehrere Regale     Ein Packing-Bereich
Motorik       Höher              Niedriger
```

**Praktisches Szenario: S8 in Frames 1-100**

```
Frames 1-20: Storage für Order 2904 (S4)
  CL111=Storage, CL105=List+Pen, CL100=2904

Frame 21: ORDER ADDITION
  CL101=1 — TRIGGER T6
  — Neue Chunk-Grenze
  
Frames 21-50: S8 (Multi-Order Storage)
  Worker PACKT beide Orders
  
Frame 51: ORDER REMOVAL
  CL100 oder CL101 wird 0
  — Neue Chunk-Grenze
  
Frames 51-100: Zurück zu Single-Order Storage
  (S4, S5, oder S6 je nach verbleibender Order)
```

### 4.6.4 Edge Cases & Anomalien

#### Edge Case 1: Sehr kurze Multi-Order Phase
```
Frame 20: CL100=1, CL101=0 — S1
Frame 21: CL100=1, CL101=1 — S7 (Addition, T6)
Frame 22: CL100=1, CL101=0 — S1 (Removal, T6)

Status: ✓ Technisch OK
Aber: S7 dauert nur 1 Frame!
Empfehlung: Video prüfen - war Order wirklich so kurz aktiv?
           Oder Annotation-Fehler?
```

#### Edge Case 2: Unerwünschte Multi-Order
```
Frame 20: CL100=1, CL102=0 — S1
Frame 21: CL100=1, CL102=1 — ANOMALIE!

Status: ❌ NICHT ERLAUBT!
Grund: 2904+2906 ist keine dokumentierte Kombination
Ground Truth: "Multi_Retrieval_Anomaly"
Validierung V2: ❌ FAIL (Multi-Label Regel verletzt!)
Empfehlung: Annotation korrigieren (CL102 sollte 0 sein)
```

#### Edge Case 3: Order-Wechsel statt Addition
```
Frame 20: CL100=1, CL101=0 — S1
Frame 21: CL100=0, CL101=1 — S2 (nicht S7!)

Status: ✓ OK technisch
Aber: Das ist Order-Wechsel (2904—2905), nicht Multi-Order
Trigger: T6 wird ausgelöst (CL100—0 und CL101—1)
Szenario-Transition: S1—S2 (Single-Order Wechsel)
Grund: Keine Multi-Order, daher nicht S7
```

### 4.6.5 S7/S8 Transitions - Komplette Beispiele

**Beispiel 1: S1—S7—S1 (Retrieval Multi-Order)**
```
FRAMES 1-20: Single-Order Retrieval (S1)
  Labels: CL110=1, CL105=1, CL100=1, CL101=0, CL115/CL116
  Activity: Picking Order 2904
  Chunk-Count: ~4-5 chunks (T1-T5 variationen)
  
FRAME 21: ORDER ADDITION (T6)
  CL101: 0—1 (Order 2905 kommt hinzu)
  NEW CHUNK-GRENZE
  Szenario: S1—S7
  
FRAMES 21-60: Multi-Order Retrieval (S7)
  Labels: CL110=1, CL105=1, CL100=1, CL101=1, CL115/CL116
  Activity: Picking BOTH Orders 2904+2905
  Complexity: May visit different aisles for each order
  Chunk-Count: ~8-12 chunks (mehr Variationen wegen 2 Orders)
  
FRAME 61: ORDER REMOVAL (T6)
  CL101: 1—0 (Order 2905 wird entfernt)
  NEW CHUNK-GRENZE
  Szenario: S7—S1
  
FRAMES 61-100: Back to Single-Order (S1)
  Labels: CL110=1, CL105=1, CL100=1, CL101=0
  Activity: Finishing Order 2904
  Chunk-Count: ~6-8 chunks

VALIDATION SUMMARY:
  ✓ Chunks bei T6 Transitions (Frame 21, 61)
  ✓ Szenario bei T6 Transitions wechselt
  ✓ V2 Check: CL100 AND CL101 gültig
  ✓ Pattern A: Chunk + Szenario synchron
  
EXPECTED CHUNK COUNT: ~25-30 chunks in 100 Frames
```

**Beispiel 2: S4—S8—S4 (Storage Multi-Order)**
```
FRAMES 1-30: Single-Order Storage (S4)
  Labels: CL111=1, CL105=1, CL100=1, CL101=0, CL117/CL120
  Activity: Unpacking and storing Order 2904
  Chunk-Count: ~5-7 chunks
  
FRAME 31: ORDER ADDITION (T6)
  CL101: 0—1
  NEW CHUNK-GRENZE
  Szenario: S4—S8
  
FRAMES 31-70: Multi-Order Storage (S8)
  Labels: CL111=1, CL105=1, CL100=1, CL101=1
  Difference from S7: IT-System KONSTANT (CL105 immer!)
  Activity: Packing and storing BOTH Orders
  Complexity: Less than S7 (more structured process)
  Chunk-Count: ~8-10 chunks (weniger als S7)
  
FRAME 71: ORDER REMOVAL (T6)
  CL101: 1—0
  NEW CHUNK-GRENZE
  Szenario: S8—S4
  
FRAMES 71-100: Back to Single-Order (S4)
  Chunk-Count: ~6-8 chunks

VALIDATION:
  ✓ IT konstant CL105 (nie CL106/CL107)
  ✓ Orders: CL100+CL101 synchron
  ✓ Pattern A: Chunk+Szenario synchron

EXPECTED CHUNK COUNT: ~22-28 chunks (weniger als S7-Beispiel!)
REASON: Storage weniger variabel als Retrieval
```

### 4.6.6 Validierungs-Checkliste für S7/S8

```python
# MASTER CHECKLIST für Multi-Order Chunks

def validate_s7_s8_chunk(chunk):
    """Validiere S7 oder S8 Chunks"""
    
    # === V1: Single-Label Exklusivität ===
    assert chunk.cc01.count() == 1, "Main Activity muss exakt 1 sein"
```    assert chunk.cc02.count() == 1, "Legs muss exakt 1 sein"
    assert chunk.cc08.count() == 1, "High-Level muss exakt 1 sein"
    assert chunk.cc09.count() == 1, "Mid-Level muss exakt 1 sein"
    assert chunk.cc10.count() == 1, "Low-Level muss exakt 1 sein"
    
    # === V2: Multi-Label Order Gültigkeit ===
    if chunk.scenario in ["S7", "S8"]:
        assert chunk.cl100 == 1 and chunk.cl101 == 1, "Multi: beide Orders aktiv"
        assert chunk.cl102 == 0, "CL102 muss 0 sein (nicht erlaubte Kombo)"
    
    # === V3: Prozess-Hierarchie ===
    if chunk.cl110 == 1:  # Retrieval
        assert chunk.cc09 in [CL115, CL116, CL118, CL121], "Invalid Mid-Level"
    if chunk.cl111 == 1:  # Storage
        assert chunk.cc09 in [CL117, CL119, CL120, CL121], "Invalid Mid-Level"
    
    # === S7-spezifisch ===
    if chunk.scenario == "S7":
        assert chunk.cl110 == 1, "S7 muss Retrieval sein"
        assert chunk.cl105 or chunk.cl106 or chunk.cl107, "S7 braucht IT"
    
    # === S8-spezifisch ===
    if chunk.scenario == "S8":
        assert chunk.cl111 == 1, "S8 muss Storage sein"
        assert chunk.cl105 == 1, "S8 IT MUSS List+Pen sein (CL105)"
        assert chunk.cl106 == 0 and chunk.cl107 == 0, "Nur CL105 in S8"
    
    # === Transitions ===
    if chunk.trigger_list contains T6:
        # Order hat sich geändert
        assert chunk.is_boundary, "T6 sollte Boundary-Chunk erzeugen"
        if chunk.scenario in ["S7", "S8"]:
            # Multi-Order Phase startet/endet
            assert previous_chunk.scenario != chunk.scenario, "Szenario sollte wechseln"
    
    return True  # Wenn alle Checks bestanden


# ANWENDUNG:
for chunk in all_chunks:
    try:
        validate_s7_s8_chunk(chunk)
        print(f"✓ Chunk {chunk.id} VALID")
    except AssertionError as e:
        print(f"✗ Chunk {chunk.id} INVALID: {e}")
        log_for_review(chunk.id)
```

---

## 5. PRAKTISCHE BEISPIELE

### 5.1 Frame-by-Frame Chunk-Konstruktion

**Raw Frame-Daten (Auszug aus Proband S14):**

```
Frame | CC01 | CC02 | CC04_Pos | CC08 | CC09 | CC10 | CC06 | Szenario
------|------|------|----------|------|------|------|------|----------
500   | Walk | Gait | Upwards  | Retr | Pick | Retri| 2904 | S1
501   | Walk | Gait | Upwards  | Retr | Pick | Retri| 2904 | S1
502   | Walk | Gait | Downward | Retr | Pick | Retri| 2904 | S1  –   T4 Hand
503   | Walk | Gait | Centered | Retr | Pick | Move | 2904 | S1  –   T4+T8c
504   | Stand| Still| Centered | Retr | Pick | Move | 2904 | S1  –   T1+T2
505   | Stand| Still| Centered | Retr | Pick | Move | 2904 | S1
```

**Chunk-Konstruktion:**

```
CHUNK 1:  Frames 500-501 (Chunk stabil)
  Labels: CC01=Walking, CC02=Gait, CL110=Retrieval, CL105=List+Pen
  Szenario: S1

CHUNK 2:  Frame 502 (T4: CC04 Hand-Position ändert)
  Trigger: T4 (Upwards -> 'Downward)
  Szenario: S1
  
CHUNK 3:  Frame 503 (T4+T8c: Hand UND Low-Level Process ändern)
  Trigger: T4 (Centered), T8c (CL137 -> 'Move)
  Szenario: S1
  
CHUNK 4:  Frames 504-505 (T1+T2: Main Activity + Legs)
  Trigger: T1 (Walking -> 'Standing), T2 (Gait -> 'Still)
  Szenario: S1
  Pattern: ASYNCHRONE CHUNK-GRENZE (Motor-Changes ohne Szenario-Effekt)
```

### 5.2 Spezialfälle

#### Gleichzeitige Trigger
```
Frame 100: CC01=Walking, CC06=Order2904
Frame 101: CC01=Standing, CC06=Order2905

Trigger: T1 (Main Activity) + T6 (Order)
-> EINE Chunk-Grenze (nicht 2!)
chunk.trigger_list = [T1, T6]
```

---

## 6. HIERARCHIE UND BEZIEHUNGEN

### 6.1 Chunk –  Prozess –  Szenario Hierarchie

```
EBENE 0: Frame-Level (30 fps, ≈18,000 frames pro Proband)
    Rohe Annotationsdaten, hochfrequent

EBENE 1: Chunk-Level (T1-T13 segmentiert, ≈2,000-3,000 chunks)
    Stabile Zustände, determiniert durch Trigger
    
EBENE 2: Prozess-Level (CC08/CC09/CC10 kontinuierlich, ≈200-400 Prozess-Blöcke)
    High-Level (Retrieval/Storage)
        -> Mid-Level (Travel/Pick/Store/...)
            -> Low-Level (atomic actions)
    
EBENE 3: Szenario-Level (S1-S8 + Other, ≈100-200 Szenarien)
    Ground Truth v3.0 Klassifikation pro Frame
    Aggregiert zu Chunk-Szenario Zuordnung
```

### 6.2 Cross-References

Diese Datei fokussiert auf Chunk-BILDUNG. Für Details siehe:

- **Label-Definitionen (CL001-CL207):** -> `labels_207_v5.0.md`
- **Prozess-Hierarchie (CC08/CC09/CC10):** -> `process_hierarchy_v5.0.md`
- **Szenario-Erkennung (Ground Truth v3.0):** -> `ground_truth_central_v5.0.md`
- **Validierungsregeln (Master-Slave):** -> `core_validation_rules_v5_0.md`
- **BPMN & Konformität:** -> `bpmn_validation_v5.0.md`

---

## APPENDIX A: Schnell-Referenz – Chunk-Szenario Transitions

**Wann erzeugt Szenario-Wechsel IMMER Chunk-Grenze?**

| Transition | High-Level Wechsel? | Triggertyp | Chunk-Grenze? | Grund |
|-----------|---------------------|-----------|---------------|-------|
| S1 -> S2 | Nein (beide Retr) | T6 + T7 | ✓ JA | Order + IT wechsel |
| S1 -> S7 | Nein (beide Retr) | T6 | ✓ JA | Order Addition |
| S1 -> S4 | **Ja** (Retr -> Stor) | T8 | ✓ JA | High-Level Wechsel |
| S4 -> S5 | Nein (beide Stor) | T6 | ✓ JA | Order wechsel |
| S7 -> S1 | Nein | T6 | ✓ JA | Order Removal |
| S4 -> Other_Waiting | Ja (-> CL134) | T11 | ✓ JA | Global Interrupt |
| S8 -> S4 | Nein (beide Stor) | T6 | ✓ JA | Order Removal |

**Wann KEINE Chunk-Grenze aber Szenario gleich?**

| Beispiel | Change | Trigger | Chunk-Grenze? | Szenario-Effekt |
|----------|--------|---------|---------------|-----------------|
| S1 stabil | CC01: Walk -> Stand | T1 | ✓ JA | S1 -> S1 (kein Effekt) |
| S1 stabil | CC04 Hand-Pos | T4 | ✓ JA | S1 -> S1 (kein Effekt) |
| S1 stabil | CC11 Location | T9 | ✓ JA | S1 -> S1 (kein Effekt) |
| S1 stabil | Alle stabil | keine | ✗ NEIN | S1 -> S1 (selber Chunk) |

---

## APPENDIX B: Quality Metrics und Monitoring

**Pro Proband - Zielmetriken:**

```
Chunk Count:               ≈2,000-3,000 (abhängig vom Datensatz-Umfang)
Avg Chunk Duration:        1-3 Sekunden (typisch)
Min Chunk Duration:        0.03 Sekunden (1 Frame)
Max Chunk Duration:        30+ Sekunden (lange stabile Zustände möglich)

Valid Chunks:              >95%
Pure Chunks (1 Szenario):  70-80%
Boundary Chunks (2 Szenarien): 15-20%
Anomalous Chunks:          <5%

Trigger Distribution:
  T8c (Low-Level):         ≈40-50% (häufigster)
  T4/T5 (Hand):            ≈15-20%
  T1 (Main Activity):       ≈10-15%
  T8b (Mid-Level):         ≈5-10%
  T6 (Order):              ≈5-10%
  Andere (T2,T3,T7,T9,T10): ≈5-10%
  T11-T13 (Classification): ≈1-5%
```

---

---

**Verwendungshinweise:**

Diese Datei nutzen für:
- Verständnis der Chunk-Bildung und Trigger-Mechanismen (T1-T13)
- Zeitliche Segmentierung von Frame-Daten
- Validierung von Chunk-Integrität (V1-V3, C1-C3, A1-A2)
- Chunk-Szenario Synchronisation (Pattern A/B/C)
- Multi-Order Handling (S7/S8)

Nicht in dieser Datei:
- Label-Definitionen (CL001-CL207): -> Siehe [labels_207_v5.0.md](../core/labels_207_v5.0.md)
- Szenario-Erkennung (Ground Truth v3.0): -> Siehe [ground_truth_central_v5.0.md](../core/ground_truth_central_v5.0.md)
- Prozess-Hierarchie (CC08/09/10): -> Siehe [process_hierarchy_v5.0.md](../processes/process_hierarchy_v5.0.md)
- Validierungsregeln (Master-Slave): -> Siehe [core_validation_rules_v5_0.md](../core/core_validation_rules_v5_0.md)
- BPMN & Konformität: -> Siehe [bpmn_validation_v5.0.md](../processes/bpmn_validation_v5.0.md)

---

**Skill-Version:** 5.0  
**Erstellt:** 05.12.2025  
**Update:** 29.01.2026  
**Quelle:** DaRa Dataset Description, Teil 3 – Chunking


---

## Metadaten v5.0
- **Version:** 5.0
- **Status:** finalisiert
- **v5.0-Konvertierung:** 04.02.2026
- **Änderungstyp:** [Ü] ÜBERARBEITEN (Referenz-Versionierung)
- **Referenzen aktualisiert:** labels_207_v5.0, process_hierarchy_v5.0, ground_truth_central_v5.0, core_validation_rules_v5_0, bpmn_validation_v5.0