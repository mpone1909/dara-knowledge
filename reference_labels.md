---
version: 6.0
status: finalisiert
created: 2026-02-04
updated: 2026-02-25
source: "DaRa Dataset Description + Documentation (authoritative PDF)"
---

# reference_labels.md — Vollständiges Label-Inventar

**DaRa Dataset Expert Skill — v6.0**
**Umfang:** 207 Labels | 12 Kategorien (CC01–CC12)
**Validierungslogik:** reference_validation_rules.md

---

## 1. Systematische Klassifizierung (Multi-dimensionale Matrix)

Die 12 Klassenkategorien erfüllen unterschiedliche Funktionen im System. Diese Matrix definiert ihre Rolle hinsichtlich Semantik, Struktur, REFA-Relevanz und Abhängigkeit.

| Klasse | Semantik | Struktur | REFA-Relevanz | Abhängigkeits-Typ | Stabilität |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **CC01** | Motorik (Master) | Flach | Fallback / Validierung | **Master** → CC02-05 | Hochfrequent |
| **CC02** | Motorik (Beine) | Flach | Indirekt ($t_{er}$ via Hocke) | Slave ← CC01 | Hochfrequent |
| **CC03** | Motorik (Torso) | Flach | **Primär ($t_{er}$)** | Slave ← CC01 | Hochfrequent |
| **CC04** | Motorik (L-Hand) | **Hierarchisch (4 Ebenen)** | Indirekt (Lastklasse) | Slave ← CC01 | Hochfrequent |
| **CC05** | Motorik (R-Hand) | **Hierarchisch (4 Ebenen)** | Indirekt (Lastklasse) | Slave ← CC01 | Hochfrequent |
| **CC06** | Kontext (Order) | Flach | Trigger (Auftragswechsel) | Kontext-Geber | Niederfrequent |
| **CC07** | Kontext (IT) | Flach | Prozess-Optimierung | Ergänzung | Mittelfrequent |
| **CC08** | Prozess (High) | Flach | Kontext-Validierung | **Master** → CC09 | Niederfrequent |
| **CC09** | Prozess (Mid) | Flach | **Primär ($t_{R}$, $t_{MH}$, $t_{MN}$)** | Slave ← CC08, **Master** → CC10 | Mittelfrequent |
| **CC10** | Prozess (Low) | Flach | Differenzierung ($t_{w}$ vs $t_{v}$) | Slave ← CC09 | Hochfrequent |
| **CC11** | Location (Mensch) | **Hierarchisch (5 Ebenen)** | Wegzeit-Validierung | Räumliche Ergänzung | Mittelfrequent |
| **CC12** | Location (Wagen) | **Hierarchisch (5 Ebenen)** | Layout-Analyse | Räumliche Ergänzung | Mittelfrequent |

### Funktionsgruppen

- **Gruppe A (Motorische Hierarchie):** CC01 bestimmt den Körperzustand, CC02–CC05 liefern die Details.
- **Gruppe B (Prozess-Hierarchie):** CC08–CC10 bilden den logistischen Ablauf nach BPMN ab.
- **Gruppe C (Kontext & Raum):** CC06, CC07, CC11, CC12 situieren die Handlung in Auftrag und Raum.

---

## 2. Überblick: Kategorisierung

| ID | Kategorie-Name | Anzahl Labels | Label-Range | Typ | Hierarchisch |
|:---|:---|:---:|:---|:---|:---|
| **CC01** | Main Activity | 15 | CL001–CL015 | Single-Select | Nein |
| **CC02** | Sub-Activity — Legs | 8 | CL016–CL023 | Single-Select | Nein |
| **CC03** | Sub-Activity — Torso | 6 | CL024–CL029 | Optional Multi (1-2) | Nein |
| **CC04** | Sub-Activity — Left Hand | 35 | CL030–CL064 | Required Multi (4 Gruppen) | Ja (4 Gruppen) |
| **CC05** | Sub-Activity — Right Hand | 35 | CL065–CL099 | Required Multi (4 Gruppen) | Ja (4 Gruppen) |
| **CC06** | Order | 5 | CL100–CL104 | Optional Multi (1-2) | Nein |
| **CC07** | Information Technology | 5 | CL105–CL109 | Single-Select | Nein |
| **CC08** | High-Level Process | 4 | CL110–CL113 | Single-Select | Nein |
| **CC09** | Mid-Level Process | 10 | CL114–CL123 | Single-Select | Nein |
| **CC10** | Low-Level Process | 31 | CL124–CL154 | Single-Select | Nein |
| **CC11** | Location — Human | 26 | CL155–CL180 | Hierarchical Multi (1-3) | Ja (5 Gruppen) |
| **CC12** | Location — Cart | 27 | CL181–CL207 | Hierarchical Multi (1-4) | Ja (5 Gruppen) |
| **TOTAL** | | **207** | CL001–CL207 | | |

### Typ-Definitionen

- **Single-Select (Exclusive):** Genau 1 Label muss pro Frame aktiv sein
- **Optional Multi:** 1–2 Labels können aktiv sein (Annotator-Wahl)
- **Required Multi (Faceted):** Mehrere spezifische Labels MÜSSEN aktiv sein (alle Gruppen erforderlich)
- **Hierarchical Multi:** 1–3 Labels repräsentieren Hierarchiestufen (Parent-Child Drill-Down)
- **Scenario-dependent:** Aktive Labels variieren nach Szenario S1–S8

### Hierarchische Binnenstrukturen

**Hand-Kategorien (CC04, CC05):**

```
Left/Right Hand
├── Primary Position (Upwards, Centered, Downwards)
├── Type of Movement (Reaching/Grasping, Manipulating, Holding, etc.)
├── Object (Items, Cart, Box, etc.)
└── Tool (PDT, Scanner, Pen, Knife, etc.)
```

**Location-Kategorien (CC11, CC12):**

```
Location (Human/Cart)
├── Main Area (Office, Base, Cart Area, etc.)
├── Path (Office, Cart Area, Cardboard Box Area, Issuing Area)
├── Cross Aisle Path (1-2, 2-3, 3-4, 4-5)
├── Aisle Path (1, 2, 3, 4, 5, Front, Back)
└── Other (Another Location, Location Unknown)
```

### Kombinatorik

Durch Kombination aller 12 Kategorien entstehen über **68.000 einzigartige Labelrepräsentationen** (theoretisch mögliche Zustandskombinationen).

---

## 3. CC01 — Main Activity (15 Labels)

**Beschreibung:** Die dominante körperliche Handlung des Subjekts.
**Rolle:** Master-Klasse für motorische Validierung.
**Label-Range:** CL001–CL015

### Vollständige Label-Liste

- **CL001** | Synchronization
- **CL002** | Confirming with Pen
- **CL003** | Confirming with Screen
- **CL004** | Confirming with Button
- **CL005** | Scanning
- **CL006** | Pulling Cart
- **CL007** | Pushing Cart
- **CL008** | Handling Upwards
- **CL009** | Handling Centered
- **CL010** | Handling Downwards
- **CL011** | Walking
- **CL012** | Standing
- **CL013** | Sitting
- **CL014** | Another Main Activity
- **CL015** | Main Activity Unknown

### Gruppierung nach Aktivitätstyp

**Bewegungsaktivitäten:**

- CL011 (Walking)
- CL006/CL007 (Pulling/Pushing Cart)

**Stationäre Aktivitäten:**

- CL012 (Standing)
- CL013 (Sitting)

**Interaktionsaktivitäten:**

- CL002–CL004 (Confirming)
- CL005 (Scanning)
- CL008–CL010 (Handling)

**Sonstige:**

- CL001 (Synchronization)
- CL014 (Another)
- CL015 (Unknown)

### Anwendung

- **Confirming:** Bestätigung einer Aktion (Stift, Bildschirm, Knopf)
- **Scanning:** Erfassung von Barcodes mit PDT oder Glove Scanner
- **Handling:** Greifen/Ablegen in verschiedenen Höhen (relevant für Ergonomie)
- **Walking:** Fortbewegung ohne Last
- **Pulling/Pushing Cart:** Fortbewegung mit Kommissionierwagen

---

## 4. CC02 — Sub-Activity: Legs (8 Labels)

**Beschreibung:** Beinaktivität und Körperhaltung.
**Rolle:** Slave zu CC01. Relevant für Erholungszeit bei extremen Haltungen.
**Label-Range:** CL016–CL023

### Vollständige Label-Liste

- **CL016** | Gait Cycle
- **CL017** | Step
- **CL018** | Standing Still
- **CL019** | Sitting
- **CL020** | Squat
- **CL021** | Lunges
- **CL022** | Another Leg Activity
- **CL023** | Leg Activity Unknown

### Semantische Gruppen

**Bewegung:**

- CL016 (Gait Cycle) — Kontinuierliches Gehen
- CL017 (Step) — Einzelner Schritt

**Stationär:**

- CL018 (Standing Still) — Stillstand
- CL019 (Sitting) — Sitzposition

**Intensiv (REFA-relevant für Erholung):**

- CL020 (Squat) — Kniebeuge (Hohe Belastung → Hoher Zuschlag)
- CL021 (Lunges) — Ausfallschritt

### Anwendung

- **Gait Cycle:** Normale Gehbewegung während Travel Time
- **Step:** Einzelner Schritt z.B. bei Positionierung am Regal
- **Standing Still:** Normale Standposition bei Picking/Scanning
- **Squat:** Tiefe Hocke bei Bodenfächern (ergonomisch belastend)

---

## 5. CC03 — Sub-Activity: Torso (6 Labels)

**Beschreibung:** Oberkörperbewegung und Beugung.
**Rolle:** Primärquelle für Haltungs-Erholungszeit ($t_{er}$).
**Label-Range:** CL024–CL029

### Vollständige Label-Liste

- **CL024** | No Bending (< 10°)
- **CL025** | Slightly Bending (10° – 30°)
- **CL026** | Strongly Bending (> 30°)
- **CL027** | Torso Rotation
- **CL028** | Another Torso Activity
- **CL029** | Torso Activity Unknown

### Intensitätsstufen

**Beugungsgrade:**

1. CL024 — Keine Beugung (0% Erholungszuschlag)
2. CL025 — Leichte Beugung (~4–8% Zuschlag)
3. CL026 — Starke Beugung (~15–20% Zuschlag)

**Rotation:**

- CL027 — Torso-Rotation (+5% additiver Zuschlag)

### Anwendung

- **No Bending:** Aufrechtes Gehen, Stehen, Greifen auf Augenhöhe
- **Slightly Bending:** Leichtes Bücken (z.B. mittlere Regalhöhe)
- **Strongly Bending:** Tiefes Bücken (z.B. untere Regalhöhe, Boden)
- **Torso Rotation:** Drehbewegungen beim Greifen oder Platzieren

---

## 6. CC04 — Sub-Activity: Left Hand (35 Labels)

**Beschreibung:** Linke Hand — Position, Bewegung, Objekt, Werkzeug.
**Rolle:** Detaillierte Tätigkeitsbeschreibung. Lastklasse für Erholungszeit.
**Label-Range:** CL030–CL064
**Struktur:** Hierarchisch in 4 Unterkategorien.

### Primary Position (4 Labels)

- **CL030** | Upwards
- **CL031** | Centered
- **CL032** | Downwards
- **CL033** | Position Unknown

**Bedeutung:**

- Upwards: Hand über Schulterhöhe
- Centered: Hand auf Schulterhöhe
- Downwards: Hand unter Schulterhöhe

---

### Type of Movement (6 Labels)

- **CL034** | Reaching, Grasping, Moving, Positioning and Releasing
- **CL035** | Manipulating
- **CL036** | Holding
- **CL037** | No Movement
- **CL038** | Another Movement
- **CL039** | Movement Unknown

**Bedeutung:**

- CL034: Dynamische Greif- und Positionierungsbewegungen
- CL035: Feinmotorische Manipulation (z.B. Drücken, Drehen)
- CL036: Halten eines Objekts ohne Bewegung
- CL037: Hand inaktiv

---

### Object (12 Labels)

- **CL040** | No Object
- **CL041** | Large Item (> 800g, Laststufe 3)
- **CL042** | Medium Item (50–800g, Laststufe 2)
- **CL043** | Small Item (≤ 50g, Laststufe 1)
- **CL044** | Tool
- **CL045** | Cart
- **CL046** | Load Carrier
- **CL047** | Cardboard Box
- **CL048** | On Body
- **CL049** | Another Logistic Object
- **CL050** | No Logistic Object
- **CL051** | Object Unknown

**Größenkategorien (REFA-relevant):**

- Large Item: Große Waren (hohe Belastung)
- Medium Item: Mittelgroße Waren (mittlere Belastung)
- Small Item: Kleine Waren (vernachlässigbare Belastung)

**Logistikobjekte:**

- Cart: Kommissionierwagen
- Load Carrier: Ladungsträger
- Cardboard Box: Karton

---

### Tool (13 Labels)

- **CL052** | Portable Data Terminal
- **CL053** | Glove Scanner
- **CL054** | Plastic Bag
- **CL055** | Picking List
- **CL056** | Pen
- **CL057** | Button
- **CL058** | Computer
- **CL059** | Bubble Wrap
- **CL060** | Tape Dispenser
- **CL061** | Knife
- **CL062** | Shipping/Return Label
- **CL063** | Elastic Band
- **CL064** | Another Tool

**Tool-Kategorien:**

- IT-Tools: CL052 (PDT), CL053 (Glove Scanner), CL058 (Computer)
- Dokumentations-Tools: CL055 (Picking List), CL056 (Pen), CL062 (Labels)
- Verpackungs-Tools: CL059 (Bubble Wrap), CL060 (Tape Dispenser), CL061 (Knife), CL063 (Elastic Band)
- Sonstige: CL054 (Plastic Bag), CL057 (Button), CL064 (Another Tool)

---

## 7. CC05 — Sub-Activity: Right Hand (35 Labels)

**Beschreibung:** Rechte Hand — Position, Bewegung, Objekt, Werkzeug.
**Struktur:** Identisch zu CC04, Labels CL065–CL099.
**Label-Range:** CL065–CL099

### Primary Position (4 Labels)

- **CL065** | Upwards
- **CL066** | Centered
- **CL067** | Downwards
- **CL068** | Position Unknown

---

### Type of Movement (6 Labels)

- **CL069** | Reaching, Grasping, Moving, Positioning and Releasing
- **CL070** | Manipulating
- **CL071** | Holding
- **CL072** | No Movement
- **CL073** | Another Movement
- **CL074** | Movement Unknown

---

### Object (12 Labels)

- **CL075** | No Object
- **CL076** | Large Item
- **CL077** | Medium Item
- **CL078** | Small Item
- **CL079** | Tool
- **CL080** | Cart
- **CL081** | Load Carrier
- **CL082** | Cardboard Box
- **CL083** | On Body
- **CL084** | Another Logistic Object
- **CL085** | No Logistic Object
- **CL086** | Object Unknown

---

### Tool (13 Labels)

- **CL087** | Portable Data Terminal
- **CL088** | Glove Scanner
- **CL089** | Plastic Bag
- **CL090** | Picking List
- **CL091** | Pen
- **CL092** | Button
- **CL093** | Computer
- **CL094** | Bubble Wrap
- **CL095** | Tape Dispenser
- **CL096** | Knife
- **CL097** | Shipping/Return Label
- **CL098** | Elastic Band
- **CL099** | Another Tool

**Hinweis:** Die Tool-Labels CL087–CL099 sind strukturell identisch zu CL052–CL064, nur für die rechte Hand.

---

## 8. CC06 — Order (5 Labels)

**Beschreibung:** Kundenauftragsnummer.
**Rolle:** Szenario-Identifikator und Rüstzeit-Trigger (Chunking T6).
**Label-Range:** CL100–CL104

### Vollständige Label-Liste

- **CL100** | 2904
- **CL101** | 2905
- **CL102** | 2906
- **CL103** | No Order
- **CL104** | Order Unknown

### Bedeutung

**Spezifische Orders:**

- 2904, 2905, 2906: Konkrete Auftragsnummern im Datensatz (Retrieval-Szenarien S1–S3, S7)

**Status:**

- No Order: Kein aktiver Auftrag (z.B. Vorbereitung, Pause)
- Order Unknown: Auftrag unklar oder nicht identifizierbar

---

## 9. CC07 — Information Technology (5 Labels)

**Beschreibung:** Genutztes Informationstechnologie-System.
**Rolle:** Prozess-Optimierung und Validierung (CC07 vs. CC04/05 Tools).
**Label-Range:** CL105–CL109

### Vollständige Label-Liste

- **CL105** | List and Pen
- **CL106** | List and Glove Scanner
- **CL107** | Portable Data Terminal
- **CL108** | No Information Technology
- **CL109** | Information Technology Unknown

### IT-Systeme

**Papierbasiert:**

- CL105: Picking-Liste mit Stift (manuelle Bestätigung)
- CL106: Liste mit Glove Scanner (hybrid)

**Digital:**

- CL107: Portable Data Terminal (PDT) — volldigitale Erfassung

**Status:**

- CL108: Keine IT im Einsatz
- CL109: IT-System unklar

---

## 10. CC08 — High-Level Process (4 Labels)

**Beschreibung:** Oberste Prozessebene (Makro-Prozess).
**Rolle:** Master für Prozesshierarchie, Kontext-Validierung.
**Label-Range:** CL110–CL113

### Vollständige Label-Liste

- **CL110** | Retrieval (Auslagerung)
- **CL111** | Storage (Einlagerung)
- **CL112** | Another High-Level Process
- **CL113** | High-Level Process Unknown

### Prozess-Typen

**Hauptprozesse:**

- **Retrieval (CL110):** Kommissionierung — Waren aus Lager entnehmen
- **Storage (CL111):** Einlagerung — Waren ins Lager einräumen

**Sonstige:**

- CL112: Andere Prozesse (z.B. Sortierung, Verpackung außerhalb Retrieval/Storage)
- CL113: Prozess unbekannt

### BPMN-Zuordnung

- **Retrieval:** Entspricht Retrieval-Pfad im BPMN (siehe references/processes/bpmn_validation_v5_0.md)
- **Storage:** Entspricht Storage-Pfad im BPMN

---

## 11. CC09 — Mid-Level Process (10 Labels)

**Beschreibung:** Mittlere Prozessebene (Prozess-Phasen).
**Rolle:** Primäre Quelle für REFA-Zeitarten ($t_{R}$, $t_{MH}$, $t_{MN}$).
**Label-Range:** CL114–CL123

### Vollständige Label-Liste

- **CL114** | Preparing Order → $t_{R}$ (Rüstzeit)
- **CL115** | Picking — Travel Time → $t_{MN}$ (Nebentätigkeit)
- **CL116** | Picking — Pick Time → $t_{MH}$ (Haupttätigkeit)
- **CL117** | Unpacking
- **CL118** | Packing
- **CL119** | Storing — Travel Time → $t_{MN}$ (Nebentätigkeit)
- **CL120** | Storing — Store Time → $t_{MH}$ (Haupttätigkeit)
- **CL121** | Finalizing Order → $t_{R}$ (Rüstzeit)
- **CL122** | Another Mid-Level Process
- **CL123** | Mid-Level Process Unknown

### Prozess-Phasen nach High-Level

**Retrieval-Phasen (CL110):**

1. CL114 — Preparing Order
2. CL115 — Picking Travel Time (Bewegung zum Lagerort)
3. CL116 — Picking Pick Time (Entnahme der Ware)
4. CL118 — Packing (Verpacken)
5. CL121 — Finalizing Order

**Storage-Phasen (CL111):**

1. CL114 — Preparing Order
2. CL117 — Unpacking (Auspacken)
3. CL119 — Storing Travel Time (Bewegung zum Lagerort)
4. CL120 — Storing Store Time (Einlagerung)
5. CL121 — Finalizing Order

### BPMN-Mapping

Diese Labels entsprechen **direkt den Aktivitätsschritten** im BPMN-Diagramm (siehe references/processes/bpmn_validation_v5_0.md).

---

## 12. CC10 — Low-Level Process (31 Labels)

**Beschreibung:** Detaillierte Prozessebene (atomare Aktivitäten).
**Rolle:** Fein-Differenzierung von Zeitarten (z.B. $t_{w}$ vs $t_{v}$).
**Label-Range:** CL124–CL154

### Vollständige Label-Liste

- **CL124** | Collecting Order and Hardware
- **CL125** | Collecting Cart
- **CL126** | Collecting Empty Cardboard Boxes
- **CL127** | Collecting Packed Cardboard Boxes
- **CL128** | Transporting a Cart to the Base
- **CL129** | Transporting to the Packaging/Sorting Area
- **CL130** | Handing Over Packed Cardboard Boxes
- **CL131** | Returning Empty Cardboard Boxes
- **CL132** | Returning Cart
- **CL133** | Returning Hardware
- **CL134** | Waiting → $t_{w}$ oder $t_{s}$ (kontextabhängig)
- **CL135** | Reporting and Clarifying the Incident → $t_{s}$ (Störzeit)
- **CL136** | Removing Cardboard Box/Item from the Cart
- **CL137** | Moving to the Next Position
- **CL138** | Placing Items on a Rack
- **CL139** | Retrieving Items
- **CL140** | Moving to a Cart
- **CL141** | Placing Cardboard Box/Item on a Table
- **CL142** | Opening Cardboard Box
- **CL143** | Disposing of Filling Material or Shipping Label
- **CL144** | Sorting
- **CL145** | Filling Cardboard Box with Filling Material
- **CL146** | Printing Shipping Label and Return Slip
- **CL147** | Preparing or Adding Return Label
- **CL148** | Attaching Shipping Label
- **CL149** | Removing Elastic Band
- **CL150** | Sealing Cardboard Box
- **CL151** | Placing Cardboard Box/Item in a Cart
- **CL152** | Tying Elastic Band Around Cardboard
- **CL153** | Another Low-Level Process
- **CL154** | Low-Level Process Unknown

### Gruppierung nach Aktivitätstyp

**Vorbereitung (Collecting):**

- CL124 (Order and Hardware)
- CL125 (Cart)
- CL126 (Empty Cardboard Boxes)
- CL127 (Packed Cardboard Boxes)

**Transport:**

- CL128 (Cart to Base)
- CL129 (To Packaging/Sorting Area)
- CL137 (To Next Position)
- CL140 (To Cart)

**Übergabe/Rückgabe:**

- CL130 (Handing Over)
- CL131 (Returning Boxes)
- CL132 (Returning Cart)
- CL133 (Returning Hardware)

**Picking-Aktivitäten:**

- CL139 (Retrieving Items)
- CL138 (Placing Items on Rack)
- CL136 (Removing from Cart)

**Verpackung:**

- CL142 (Opening Cardboard Box)
- CL145 (Filling with Material)
- CL148 (Attaching Label)
- CL150 (Sealing Box)
- CL152 (Tying Elastic Band)

**Sortierung:**

- CL144 (Sorting)
- CL141 (Placing on Table)

**Dokumentation:**

- CL146 (Printing Labels)
- CL147 (Preparing Return Label)

**Entsorgung:**

- CL143 (Disposing Material/Label)
- CL149 (Removing Elastic Band)

**Sonstige:**

- CL134 (Waiting)
- CL135 (Reporting Incident)
- CL153 (Another)
- CL154 (Unknown)

---

## 13. CC11 — Location: Human (26 Labels)

**Typ:** Hierarchical Multi-Select (1–3 Labels)
**Struktur:** Level 1 (Main Area) → Level 2 (Sub-Area) → Level 3 (Position)
**Scope:** Alle Szenarien (S1–S8)
**Label-Range:** CL155–CL180

---

### Main Area (9 Labels)

- **CL155** | Office
- **CL156** | Cart Area
- **CL157** | Cardboard Box Area
- **CL158** | Base
- **CL159** | Packing/Sorting Area
- **CL160** | Issuing/Receiving Area
- **CL161** | Path
- **CL162** | Cross Aisle Path
- **CL163** | Aisle Path

**Bedeutung:**

- Office: Bürobereich
- Cart Area: Wagen-Abstellbereich
- Cardboard Box Area: Karton-Lagerbereich
- Base: Zentrale Ausgangsbasis
- Packing/Sorting Area: Pack-/Sortierbereich
- Issuing/Receiving Area: Waren-Ausgabe/-Annahme

---

### Path — Sub-Area (4 Labels, Kinder von CL161)

- **CL164** | Path (Office)
- **CL165** | Path (Cardboard Box Area)
- **CL166** | Path (Cart Area)
- **CL167** | Path (Issuing Area)

**Bedeutung:** Verbindungswege zwischen Hauptbereichen

---

### Cross Aisle Path — Sub-Area (4 Labels, Kinder von CL162)

- **CL168** | 1-2
- **CL169** | 2-3
- **CL170** | 3-4
- **CL171** | 4-5

**Bedeutung:** Quergang zwischen Regalreihen (Aisle 1↔2, 2↔3, etc.)

---

### Aisle Path — Sub-Area (7 Labels, Kinder von CL163)

- **CL172** | Aisle 1
- **CL173** | Aisle 2
- **CL174** | Aisle 3
- **CL175** | Aisle 4
- **CL176** | Aisle 5
- **CL177** | Front Position
- **CL178** | Back Position

**Bedeutung:**

- Aisle 1–5: Spezifische Regalreihen
- Front: Vorderer Bereich der Regalreihe
- Back: Hinterer Bereich der Regalreihe

---

### Other (2 Labels)

- **CL179** | Another Location — Human
- **CL180** | Human Location Unknown

---

## 14. CC12 — Location: Cart (27 Labels)

**Typ:** Hierarchical Multi-Select (1–4 Labels)
**Struktur:** Level 1 (Main Area) → Level 2 (Sub-Area) → Level 3 (Position) → Level 4 (Beacon)
**Scope:** Alle Szenarien (S1–S8)
**Label-Range:** CL181–CL207
**Besonderheit:** CC12 hat gegenüber CC11 ein zusätzliches Label (CL181), das den physischen Übergang des Wagens zwischen Bereichen erfasst. Dieses strukturelle Unterscheidungsmerkmal existiert bei CC11 (Human Location) nicht.

---

### Main Area (10 Labels)

- **CL181** | Transition between Areas *(nur CC12, kein Pendant in CC11)*
- **CL182** | Office
- **CL183** | Cart Area
- **CL184** | Cardboard Box Area
- **CL185** | Base
- **CL186** | Packing/Sorting Area
- **CL187** | Issuing/Receiving Area
- **CL188** | Path
- **CL189** | Cross Aisle Path
- **CL190** | Aisle Path

#### CL181 — Transition between Areas (Detaildefinition)

**Beschreibung:**
CL181 erfasst den exakten Zeitraum, in dem der Kommissionierwagen eine Bereichsgrenze überquert (im Labor durch Klebeband-Linien markiert). Es ist das einzige Label, das die Kategorie CC12 strukturell von CC11 unterscheidet.

**Physische Grenzen (Start und Ende):**

- **Start:** Das Label beginnt in dem Moment, in dem das **erste Rad** des Wagens die Bereichslinie berührt.
- **Ende:** Das Label endet, sobald das **letzte Rad** die Linie überquert hat und sich der gesamte Wagen im neuen Bereich befindet.

**Multi-Labeling und Beacon-Abhängigkeit:**
CL181 tritt **immer gemeinsam** mit einem weiteren Orts-Label auf (nie allein). Das gleichzeitig aktive Orts-Label richtet sich nach der aktuellen Position des am Wagen befestigten Bluetooth-Beacons:

- Solange der Beacon noch im alten Bereich ist → CL181 + altes Bereichs-Label
- Sobald der Beacon die Linie überquert → CL181 + neues Bereichs-Label
- Ein neues Annotationsfenster (Window) wird gesetzt, sobald der Beacon die Linie überquert, auch wenn die Räder noch in Transition sind.

**Aufteilung in Transition-Windows (Beispiel: Wechsel Path Office → Packing Area):**

| Window | Labels | Zustand |
|--------|--------|---------|
| Window 1 | Path (Office) [CL188+CL191] | Wagen vollständig im alten Bereich |
| Window 2 | CL181 + Path (Office) [CL188+CL191] | Erste Räder über der Linie, Beacon noch im alten Bereich |
| Window 3 | CL181 + Packing/Sorting Area [CL186] | Beacon hat Linie überquert, letzte Räder noch in Transition |
| Window 4 | Packing/Sorting Area [CL186] | Wagen vollständig im neuen Bereich |

**Annotationsregel:** CL181 darf **niemals ohne** ein zweites Orts-Label annotiert werden. Die Wahl des zweiten Labels folgt ausschließlich der Beacon-Position, nicht der Rad-Position.

---

### Path — Sub-Area (4 Labels, Kinder von CL188)

- **CL191** | Path (Office) — Cart
- **CL192** | Path (Cardboard Box Area) — Cart
- **CL193** | Path (Cart Area) — Cart
- **CL194** | Path (Issuing Area) — Cart

---

### Cross Aisle Path — Sub-Area (4 Labels, Kinder von CL189)

- **CL195** | 1-2 (Cart)
- **CL196** | 2-3 (Cart)
- **CL197** | 3-4 (Cart)
- **CL198** | 4-5 (Cart)

---

### Aisle Path — Sub-Area (7 Labels, Kinder von CL190)

- **CL199** | Aisle 1 (Cart)
- **CL200** | Aisle 2 (Cart)
- **CL201** | Aisle 3 (Cart)
- **CL202** | Aisle 4 (Cart)
- **CL203** | Aisle 5 (Cart)
- **CL204** | Front Position (Cart)
- **CL205** | Back Position (Cart)

---

### Other (2 Labels)

- **CL206** | Another Location — Cart
- **CL207** | Cart Location Unknown

---

## 15. Prozess-Hierarchie (Zusammenfassung)

```
High-Level (CC08)
├── Retrieval (CL110)
│   ├── Mid-Level (CC09): CL114, CL115, CL116, CL118, CL121
│   └── Low-Level (CC10): CL124–CL154 (je nach Kontext)
│
└── Storage (CL111)
    ├── Mid-Level (CC09): CL114, CL117, CL119, CL120, CL121
    └── Low-Level (CC10): CL124–CL154 (je nach Kontext)
```

### Hierarchie-Mapping (Detailliert, korrigiert v6.0)

**WICHTIG:** Für das autoritative CC09→CC10 Mapping siehe phase4_bpmn_validation.md.
Die folgenden Beispiele zeigen typische (nicht vollständige) CC10-Labels pro Phase.

```
High-Level (CC08)
    ├── Retrieval (CL110)
    │   ├── Mid-Level (CC09)
    │   │   ├── Preparing Order (CL114)
    │   │   │   └── Low-Level (CC10): CL124, CL125, CL126, etc.
    │   │   ├── Picking Travel Time (CL115)
    │   │   │   └── Low-Level (CC10): CL128, CL137, CL135, etc.
    │   │   ├── Picking Pick Time (CL116)
    │   │   │   └── Low-Level (CC10): CL139, CL140, CL151, etc.
    │   │   ├── Packing (CL118)
    │   │   │   └── Low-Level (CC10): CL149, CL144, CL145, CL150, etc.
    │   │   └── Finalizing Order (CL121)
    │   │       └── Low-Level (CC10): CL130, CL132, CL133, etc.
    │
    └── Storage (CL111)
        ├── Mid-Level (CC09)
        │   ├── Preparing Order (CL114)
        │   │   └── Low-Level (CC10): CL124, CL125, CL127, etc.
        │   ├── Unpacking (CL117)
        │   │   └── Low-Level (CC10): CL142, CL143, CL144, CL152, etc.
        │   ├── Storing Travel Time (CL119)
        │   │   └── Low-Level (CC10): CL128, CL137, CL135, etc.
        │   ├── Storing Store Time (CL120)
        │   │   └── Low-Level (CC10): CL136, CL140, CL138, etc.
        │   └── Finalizing Order (CL121)
        │       └── Low-Level (CC10): CL131, CL132, CL133, etc.
```

---

## USAGE GUIDELINES

### For Annotators

1. **Cardinality:** Siehe references/core/category_activation_matrix_v5_0.md für Min/Max-Regeln pro Szenario
2. **Type Details:** Siehe references/core/validation_rules_v5_0.md für Single/Multi/Required/Hierarchical-Regeln
3. **Constraints:** Siehe validation_rules_v5_0.md für Hard-Constraints (insbesondere CC09→CC10, CC06↔CC07)
4. **Query Patterns:** Siehe assets/query_patterns_v5_0.md für Suchmuster und Beispiele
5. **Scenario Binding:** Siehe validation_rules_v5_0.md für szenario-spezifische Label-Aktivierung

### Quick Reference: Label-Suche

**Nach Label-ID:** "Was ist CL115?"
→ Suche in diesem Dokument nach "CL115"
→ Ergebnis: CC09 — Picking — Travel Time → $t_{MN}$ (Nebentätigkeit)

**Nach Label-Name:** "In welcher Kategorie ist 'Portable Data Terminal'?"
→ Ergebnis: CL052 (CC04 — Left Hand, Tool) und CL087 (CC05 — Right Hand, Tool)

**Nach Kategorie:** "Alle Labels für Torso?"
→ Navigiere zu CC03: CL024–CL029 (6 Labels)

**Nach REFA-Relevanz:** "Welche Kategorien sind primär für REFA?"
→ Prüfe Tabelle in Abschnitt 1: CC03 (Erholungszeit), CC09 (Zeitarten)

### Cross-References

- **Datensatz-Struktur:** reference_dataset.md (Probanden, Sessions, CSV-Format)
- **Validierungslogik:** reference_validation_rules.md
- **Szenarioerkennung:** phase1_scenario_recognition.md
- **REFA-Zeitarten:** phase2_refa_analysis.md
- **Artikel-Stammdaten:** reference_articles.md
- **Warehouse-Layout:** reference_warehouse.md (Zonen, Gassen, Regalplätze)
- **BPMN CC09→CC10:** phase4_bpmn_validation.md

---

**Version:** 6.0
**Release-Datum:** 2026-02-25
**Status:** Finalisiert ✅
**Änderungen v6.0:** Hierarchie-Mapping korrigiert (CL115/CL116/CL118/CL120 CC10-Beispiele), Cross-References auf v6.0-Dateien aktualisiert.
