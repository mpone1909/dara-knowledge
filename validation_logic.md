# DaRa Dataset – Validierungslogik und Abhängigkeiten

Diese Datei definiert die **logischen Abhängigkeitsregeln** des DaRa-Datensatzes. Sie dient als Grundlage für automatisierte Integritätschecks (Sanity Checks) und stellt sicher, dass semantische Kombinationen zwischen den 12 Klassenkategorien widerspruchsfrei sind.

**Zweck:** Definition formaler Regeln zur Prüfung der semantischen Konsistenz.
**Status:** Normativ für die Datenqualitätssicherung.

---

## 1. Validierungskonzept

Die Validierung im DaRa-Datensatz basiert auf drei Prinzipien:

1.  **Master-Slave-Prinzip (Hierarchische Validierung):** Eine übergeordnete Klasse ("Master") schränkt den zulässigen Wertebereich untergeordneter Klassen ("Slaves") ein.
2.  **Cross-Validation (Querprüfung):** Logische Plausibilitätsprüfung zwischen unabhängigen Dimensionen (z. B. Motorik vs. Prozess).
3.  **Konsistenz-Prüfung (Objekt-Permanenz):** Prüfung, ob physische Objekte (Tools, Items) logisch konsistent über Klassen hinweg abgebildet sind.

---

## 2. Motorische Validierung (Kategorie G1)

Diese Regeln stellen sicher, dass die körperliche Gesamtbewegung (**CC01**) mit den Detailbewegungen der Körperteile (**CC02–CC05**) übereinstimmt.

**Master:** `CC01 Main Activity`
**Slaves:** `CC02 Legs`, `CC03 Torso`, `CC04/05 Hands`

### 2.1 Abhängigkeitsmatrix: Motorik

| CC01 Main Activity (Master) | Zulässige CC02 (Legs) | Zulässige CC03 (Torso) | Erwartete CC04/05 (Hands) |
| :--- | :--- | :--- | :--- |
| `CL011 Walking` | **Zwingend:** `CL016 Gait Cycle` oder `CL017 Step` | Meist: `CL024 No Bending` | Movement: `No Movement` oder `Holding` |
| `CL012 Standing` | **Zwingend:** `CL018 Standing Still` oder `CL027 Rotation` | Alle erlaubt | Alle erlaubt |
| `CL013 Sitting` | **Zwingend:** `CL019 Sitting` | Alle erlaubt | Alle erlaubt |
| `CL005 Scanning` | `CL018 Standing Still` | `CL024 No Bending` | **Zwingend:** Tool = `Scanner/PDT` in mind. 1 Hand |
| `CL010 Handling Downwards` | `CL018 Standing Still` oder `CL020 Squat` | **Zwingend:** `CL026 Strongly Bending` oder `CL025 Slightly` | Position: `Downwards` (in mind. 1 Hand) |
| `CL006/007 Pulling/Pushing` | `CL016 Gait Cycle` oder `CL017 Step` | Meist: `CL025 Slightly Bending` | **Zwingend:** Object = `Cart` (in mind. 1 Hand) |

### 2.2 Validierungsregeln (Code-Logik)

**Regel M-01 (Geh-Konsistenz):**
> IF `CC01` == 'Walking' AND `CC02` NOT IN ['Gait Cycle', 'Step']
> THEN **INVALID** (Bewegung ohne Beinarbeit)

**Regel M-02 (Beuge-Konsistenz):**
> IF `CC01` == 'Handling Downwards' AND `CC03` == 'No Bending' AND `CC02` != 'Squat'
> THEN **WARNING** (Tiefes Greifen ohne Bücken oder Hocke physikalisch unplausibel)

**Regel M-03 (Tool-Konsistenz):**
> IF `CC01` == 'Scanning' AND (Tool in `CC04` != 'Scanner/PDT' AND Tool in `CC05` != 'Scanner/PDT')
> THEN **INVALID** (Scannen ohne Scanner in der Hand)

---

## 3. Prozess-Validierung (Kategorie G2)

Diese Regeln sichern die Einhaltung der BPMN-Logik und die Konsistenz der Prozesshierarchie (`CC08` → `CC09` → `CC10`).

**Master:** `CC08 High-Level Process`
**Slave:** `CC09 Mid-Level Process`
**Sub-Slave:** `CC10 Low-Level Process`

### 3.1 Hierarchische Pfad-Matrix

| CC08 High-Level | Zulässige CC09 Mid-Level | Typische CC10 Low-Level (Auszug) |
| :--- | :--- | :--- |
| `CL110 Retrieval` | `CL114 Preparing Order` | `CL124`, `CL125`, `CL146` |
| | `CL115 Picking Travel Time` | `CL137`, `CL140`, `CL128` |
| | `CL116 Picking Pick Time` | `CL139`, `CL136`, `CL151`, `CL146` |
| | `CL118 Packing` | `CL142`, `CL145`, `CL150` |
| | `CL121 Finalizing Order` | `CL132`, `CL133`, `CL130` |
| `CL111 Storage` | `CL114 Preparing Order` | `CL124`, `CL125` |
| | `CL117 Unpacking` | `CL142`, `CL143`, `CL144` |
| | `CL119 Storing Travel Time` | `CL137`, `CL140` |
| | `CL120 Storing Store Time` | `CL138`, `CL151` |
| | `CL121 Finalizing Order` | `CL132`, `CL133` |

### 3.2 Prozess-Regeln

**Regel P-01 (Pfad-Trennung):**
> IF `CC08` == 'Retrieval' AND `CC09` IN ['Unpacking', 'Storing Travel', 'Storing Store']
> THEN **INVALID** (Storage-Aktivität im Retrieval-Prozess)

**Regel P-02 (Pick-Inhalt):**
> IF `CC09` == 'Picking Pick Time' AND `CC10` IN ['Transporting Cart', 'Returning Hardware']
> THEN **INVALID** (Logistischer Widerspruch: Transport während Entnahme)

---

## 4. Cross-Validierung (Kategorie H)

Diese Regeln prüfen die Plausibilität zwischen Dimensionen, die technisch unabhängig, aber logisch verknüpft sind.

### 4.1 Motorik vs. Prozess (CC01 vs. CC09)

Prüft, ob die körperliche Aktivität zum Prozessstatus passt.

| CC09 Mid-Level | Erwartete CC01 Main Activity | Verbotene CC01 (Fehler) |
| :--- | :--- | :--- |
| `CL115/119 Travel Time` | `Walking`, `Pulling/Pushing Cart` | `Sitting`, `Handling Downwards`, `Scanning` (außer bei Fehlern) |
| `CL116/120 Pick/Store` | `Handling`, `Scanning`, `Confirming`, `Standing` | `Walking` (außer min. Schritte), `Sitting` |
| `CL118 Packing` | `Standing`, `Handling`, `Manipulating` | `Walking` (Lange Strecken), `Pulling Cart` |

**Regel C-01 (Unmögliche Gleichzeitigkeit):**
> IF `CC01` == 'Walking' AND `CC09` == 'Pick Time' (für > 30 Frames)
> THEN **WARNING** (Längeres Gehen sollte 'Travel Time' sein, nicht 'Pick Time')

### 4.2 IT-System vs. Hände (CC07 vs. CC04/05)

Prüft, ob das in `CC07` definierte führende IT-System auch physisch vorhanden ist.

**Regel C-02 (System-Präsenz):**
> IF `CC07` == 'Portable Data Terminal'
> AND ('PDT' NOT IN `CC04_Tool` AND 'PDT' NOT IN `CC05_Tool`)
> THEN **WARNING** (System ist aktiv, aber Gerät nicht in der Hand)

**Regel C-03 (Papier-Logik):**
> IF `CC07` == 'List and Pen'
> AND ('Pen' NOT IN `CC04/05_Tool` AND 'List' NOT IN `CC04/05_Object`)
> THEN **WARNING** (Analoger Prozess ohne Stift/Liste)

---

## 5. Kontext-Validierung (Kategorie I)

### 5.1 Auftrags-Konsistenz (CC06 vs. CC08)

Bestimmte Auftragsnummern sind festen Szenarien (Retrieval/Storage) zugeordnet.

* **Order 2904, 2905, 2906** → Primär `Retrieval` (Szenarien S1-S3, S7)
* **Storage-Aufträge** → Primär `Storage` (Szenarien S4-S5, S8)

**Regel K-01 (Szenario-Fit):**
> IF `CC06` IN ['2904', '2905', '2906'] AND `CC08` == 'Storage'
> THEN **CHECK** (Ist dies eine Rücklagerung? Falls nein: Annotationsfehler)

### 5.2 Räumliche Konsistenz (CC11 vs. CC09)

Prüft, ob der Ort zum Prozess passt.

**Regel K-02 (Ort-Prozess-Match):**
> IF `CC09` == 'Pick Time' AND `CC11` IN ['Office', 'Base', 'Packing Area']
> THEN **INVALID** (Kommissionierung kann nur im 'Aisle Path' stattfinden)

> IF `CC09` == 'Packing' AND `CC11` NOT IN ['Packing Area', 'Tables']
> THEN **WARNING** (Verpacken an untypischem Ort)

---

## 6. Algorithmische Implementierung (Pseudo-Code)

Zur Integration in Qualitätssicherungs-Scripts (`check_integrity.py`) können folgende Funktionen genutzt werden:

```python
def validate_frame(frame):
    errors = []
    
    # 1. Motoric Master-Slave Check
    if frame.cc01 == 'CL011': # Walking
        if frame.cc02 not in ['CL016', 'CL017']:
            errors.append("MOTORIC_ERROR: Walking without Gait Cycle")
            
    # 2. Process Flow Check
    if frame.cc08 == 'CL110': # Retrieval
        if frame.cc09 in ['CL117', 'CL119', 'CL120']: # Storage-Phasen
            errors.append("PROCESS_ERROR: Storage phase in Retrieval process")
            
    # 3. Tool Consistency Check
    if frame.cc01 == 'CL005': # Scanning
        has_scanner = ('CL052' in frame.cc04_tools) or ('CL087' in frame.cc05_tools)
        if not has_scanner:
            errors.append("OBJECT_ERROR: Scanning action without scanner tool")
            
    return errors
```

---

## Verwendungshinweise

**Diese Datei nutzen für:**

- Entwicklung von `check_integrity`-Skripten.
- Analyse von Annotationsfehlern.
- Filterung ungültiger Frames vor dem Modelltraining.
- Verständnis der semantischen Logik des Datensatzes.

**Nicht in dieser Datei:**

- Definition der Labels → `class_hierarchy.md`.
- REFA-Zeitarten-Logik → `analytics_refa.md`.

**Erstellt:** 23.12.2025
**Basis:** DaRa Semantik-Analyse & Dependency Matrix
