---
version: 6.2.3
references:
  - reference_labels.md
  - reference_articles.md
  - reference_warehouse.md
  - phase1_scenario_recognition.md
  - phase2_refa_analysis.md
output_used_by:
  - phase5_report.md
---

<!-- PRE-ANSWER CHECKLIST (PAC) — Phase 3
Before answering ANY question about this phase:
[ ] I have read this file COMPLETELY using the Read tool
[ ] I have read reference_labels.md
[ ] I have read reference_warehouse.md (for distances)
[ ] I have extracted the VERIFICATION_TOKEN from the end of this file
[ ] I am citing specific MTM codes and TMU values from the tables
-->

# Phase 3: MTM-Analyse — Grundbewegungen und DaRa-Mapping

**Version:** 6.2.3 (2026-03-05)
**Basis:** MTM-1 Methodenlehre
**Quelle:** PDF "Anatomisch-Biomechanische Bewegungsanalyse"
**Änderungen v6.2.2 (gegenüber v6.2.1):**
- Gewichtsfaktor SC+DF für Move (M) bei schweren Artikeln (§2, §6)
- TBC1/TBC2 Körperdrehung mit DaRa-Mapping (§1.2, §2, §3.2)
- W-PO (Gehen behindert, >23kg) als Grenzwert dokumentiert (§2)
- Apply Pressure (AP) für Packing-Sequenzen (§1.1, §2, §5)
- KOK/AKOK vs. B/AB Differenzierung Ebene 1–3 (§1.2, §2, §3.2)
- ET/EF Eye Travel/Focus nach IT-System CC07 (§1.3, §2, §5)
- Probanden-spezifische Normabweichungen (§6.2, §6.3)

---

## 1. MTM-1 Grundbewegungen

### 1.1 Obere Extremitäten

| Code | Bewegung | Beschreibung | DaRa-Label |
|:-----|:---------|:-------------|:-----------|
| **R** | Reach | Hand zum Objekt bewegen | CC04/05: Reaching/Grasping (CL034/CL069) |
| **G** | Grasp | Objekt greifen | CC04/05: Reaching/Grasping (CL034/CL069) |
| **M** | Move | Objekt transportieren | CC04/05: Reaching/Grasping (CL034/CL069) |
| **P** | Position | Objekt positionieren | CC04/05: Manipulating (CL035/CL070) |
| **AP** | Apply Pressure | Kraft ausüben / andrücken | CC04/05: Manipulating (CL035/CL070) |
| **RL** | Release | Objekt loslassen | CC04/05: Reaching/Grasping (CL034/CL069) |

### 1.2 Körperbewegungen

| Code | Bewegung | TMU | Beschreibung | DaRa-Label |
|:-----|:---------|:----|:-------------|:-----------|
| **B** | Bend | 29,0 | Beugen (Oberkörper nach vorn) | CC03: Strongly Bending (CL026) |
| **AB** | Arise from Bend | 31,9 | Aufrichten nach Beugen | CC03: No Bending (CL024) |
| **KOK** | Kneel on One Knee | 69,4 | Niederknien auf ein Knie | CC03: CL026 + CC02: Squat (CL020) |
| **AKOK** | Arise from KOK | 76,7 | Aufrichten vom Knien | CC03: No Bending (CL024) |
| **TBC1** | Turn Body I | 18,6 | Körperdrehung 45–90°, Fuß bleibt | CC03: Torso Rotation (CL027) |
| **TBC2** | Turn Body II | 37,2 | Körperdrehung 45–90°, Fuß nachziehen | CC03: Torso Rotation (CL027) |
| **W** | Walk | 15,0/Schritt | Gehen (~0,75 m/Schritt) | CC01: CL011 + CC02: CL016 |
| **W-PO** | Walk Obstructed | 17,0/Schritt | Gehen mit Last >23 kg | CC01: CL011 |

### 1.3 Augenbewegungen

| Code | Bewegung | TMU | Beschreibung | DaRa-Relevanz |
|:-----|:---------|:----|:-------------|:--------------|
| **ET** | Eye Travel | 15,2×T/D (max. 20,0) | Blickwechsel zwischen Punkten | CC07: IT-System-Nutzung |
| **EF** | Eye Focus | 7,3 | Fokussieren auf Detail | CC07: Lesen/Scannen |

---

## 2. TMU-Referenzwerte

**Einheit:** 1 TMU = 0,036 Sekunden

### Reach (R)

| Variante | 20cm | 30cm | 40cm | 50cm | 60cm | 80cm |
|:---------|:-----|:-----|:-----|:-----|:-----|:-----|
| R_A (definierter Ort) | 6,5 | 8,7 | 10,8 | 12,9 | 14,7 | — |
| R_B (einzelnes Objekt) | 6,5 | 9,4 | 12,8 | 15,6 | 18,4 | 22,8 |
| R_C (Suche in Gruppe) | 8,9 | 11,8 | 14,2 | 17,0 | 19,8 | — |

### Grasp (G)

| Variante | TMU | Beschreibung | Regaltyp / Kontext |
|:---------|:----|:-------------|:-------------------|
| G1A | 2,0 | Pick Up, alleinstehend | R7, R8 (Large Items); Hängeware R2/R3 |
| G1B | 3,5 | Klein, flach auf Fläche | Flache Einzelartikel |
| G1C1 | 7,3 | Ø>12mm, in Gruppe/Behälter | R1, R6 (Sichtlagerkästen) |
| G1C2 | 8,7 | Ø6–12mm | R4, R5 (19cm Fach, Stifte/Bits) |
| G1C3 | 12,9 | Ø<6mm | R4 (Schrauben, Muttern) |
| G4 | 5,6–9,1 | Umgreifen | Bei Übergabe |
| G5 | 0,0 | Kontaktgriff | — |

**Erfahrungsabhängigkeit G1C:** Unerfahrene Probanden (72% des DaRa-Kollektivs)
tendieren zu G1C_max (12,9 TMU statt 7,3 TMU). Differenz: +76% TMU.
Betrifft besonders Pos. 1+2 jeder Order (Muttern, Schrauben, Unterlegscheiben).

### Grasp-Matrix nach Regaltyp

| Komplex | Fachbreite | Regaltyp | G-Variante | TMU | Begründung |
|:--------|:-----------|:---------|:-----------|:----|:-----------|
| R1 | 95,5 cm | Sichtlastkasten | G1C1 | 7,3 | Kleinteile in Behälter, Rand als Hindernis |
| R2/R3 | 95,5 cm | Kleiderstange | G1A | 2,0 | Hängeware, allein, kein Hindernis |
| R2/R3 | 28,5 cm | Standard / lose | G1A | 2,0 | Lose Ware, allein liegend |
| R3 | Flow | Durchlaufregal | G1A | 2,0 | Artikel rollt nach vorne → immer vorne |
| R4/R5 | 19 cm | Sichtlastkasten eng | G1C2 | 8,7 | Ø6–12mm in 19cm Fach |
| R4/R5 | 19 cm | Schrauben/Muttern | G1C3 | 12,9 | Ø<6mm, aus Gruppe, eng |
| R6 | 22 cm | Sichtlagerkasten | G1C1 | 7,3 | Offener Behälter, Rand seitlich |
| R6/R7 | 47,5 cm | Standard breit | G1A | 2,0 | Breites Fach, allein liegend |
| R7 | 95,5 cm | Lose Großartikel | G1A | 2,0 | Palm Soil, Hand Axe: allein, groß |
| R8 | 95,5 cm | Breite Fächer H=41cm | G1A | 2,0 | Isotonic Drink, allein liegend |

### Move (M) — Basiswerte

| Variante | 20cm | 30cm | 40cm | 50cm |
|:---------|:-----|:-----|:-----|:-----|
| M_A (gegen Anschlag) | 6,1 | 8,0 | 10,0 | 11,8 |
| M_B (ungefähres Ziel) | 6,5 | 9,7 | 12,2 | 15,6 |
| M_C (exaktes Ziel) | 8,0 | 10,8 | 14,4 | 18,0 |

### Move (M) — Gewichtsfaktor SC+DF

Bei Artikeln >2 kg: `TMU_eff = SC + (Basis-TMU × DF)`

| Gewicht | SC (TMU) | DF | DaRa-Artikel | M_B_30 effektiv |
|:--------|:---------|:---|:-------------|:----------------|
| 2 kg | 1,6 | 1,04 | — | 11,7 TMU |
| 4 kg | 2,8 | 1,07 | — | 13,2 TMU |
| ~5,15 kg | 4,3 | 1,11 | **Palm Soil 5149g** | 15,1 TMU |
| 6 kg | 4,3 | 1,12 | — | 15,2 TMU |
| 8 kg | 5,8 | 1,17 | — | 17,1 TMU |
| 10 kg | 7,3 | 1,22 | — | 19,1 TMU |

**Betroffene DaRa-Artikel:**

| Artikel | Gewicht | SC | DF | M_C_40 effektiv |
|:--------|:--------|:---|:---|:----------------|
| Palm Soil | 5.149 g | 4,3 | 1,11 | ~20,3 TMU |
| Hand Axe 1200g | 1.200 g | 1,6 | 1,04 | ~16,6 TMU |
| Hand Axe 1000g | 1.000 g | 1,6 | 1,04 | ~16,6 TMU |
| Hand Axe 800g | 800 g | Grenzfall | 1,00 | 14,4 TMU (Standard) |

### Position (P)

| Variante | TMU | Beschreibung |
|:---------|:----|:-------------|
| P1SE (symmetrisch, leicht) | 5,6 | Standard-Positionierung |
| P1SS (symmetrisch, eng) | 9,1 | Enge Passung (19cm Fächer R4/R5) |
| P2SE (halbsymmetrisch) | 16,2 | Drehung nötig; unerfahrene Probanden |

**Erfahrungsabhängigkeit P:** Unerfahrene nutzen häufiger P2SE (16,2 TMU)
statt P1SE (5,6 TMU) beim Einlagern. Relevant für Storage S4–S6, S8.

### Apply Pressure (AP)

| Variante | TMU | DaRa-Kontext |
|:---------|:----|:-------------|
| AP (einfach) | 10,6 | Klebeband andrücken, Karton verschließen |
| APA (mit Repositionierung) | 16,2 | Etikett andrücken mit Neugriff |

**DaRa-Mapping AP:**
- CC10: CL150 Sealing Cardboard Box → AP obligatorisch (Klebeband)
- CC10: CL148 Attaching Shipping Label → AP oder APA
- CC01: CL009 Handling Centered bei Packing-Sequenz → AP möglich
- CC09: CL118 Packing → AP als Bestandteil der Gesamtsequenz

### Körperbewegungen und Walk (Übersicht)

| Code | TMU | DaRa-Relevanz |
|:-----|:----|:--------------|
| RL1 | 2,0 | Ablegen nach Greifen |
| B | 29,0 | Ebenen 1–3; CC03=CL026 |
| AB | 31,9 | Aufrichten; Senioren langsamer |
| KOK | 69,4 | Alternative zu B, CC02=CL020 (Squat) |
| AKOK | 76,7 | Aufrichten vom Knien |
| TBC1 | 18,6 | Regal→Wagen, Fuß bleibt; CC03=CL027 |
| TBC2 | 37,2 | Enge Gasse (Aisle 1, 0,91m); Fuß nachziehen |
| W | 15,0/Schritt | CC01=CL011 + CC02=CL016 |
| W-PO | 17,0/Schritt | Grenzwert: kein DaRa-Artikel >23kg; relevant S7/S8 |

### Eye Travel / Focus (ET/EF)

| Code | TMU | DaRa-Kontext (CC07) |
|:-----|:----|:--------------------|
| ET | 15,2×T/D (max. 20,0) | Blick Liste→Regal, PDT→Regal |
| EF | 7,3 | Lesen Picking-Liste, PDT-Display, Etikett |

**IT-System-spezifisches ET/EF-Mapping:**

| CC07 | IT-System | Overhead-TMU/Pick | Sequenz |
|:-----|:----------|:------------------|:--------|
| CL105 List+Pen | Papierliste | ~28–35 TMU | EF×n (Zeilen) + ET (Liste→Regal) |
| CL107 PDT | Datenhandterminal | ~27–34 TMU | ET (Display→Regal) + EF (Display) |
| CL106 Glove Scanner | Scanner+Liste | ~25–30 TMU | ET + EF + T (Scan-Handgelenk) |
| CL108 No IT | — | 0 TMU | — |

---

## 3. Order-Kontext und Szenario-Integration

### 3.1 Szenario → Order → Artikelset

| Szenario | Order (CC06) | Artikelset | Gassen | Lastklassen |
|:---------|:-------------|:-----------|:-------|:------------|
| **S1** (Retrieval) | 2904 (CL100) | 15 Pos → `reference_articles.md §2` | Aisles 1–5 | S×4, M×10, L×1 |
| **S2** (Retrieval) | 2905 (CL101) | 15 Pos → `reference_articles.md §3` | Aisles 1–5 | S×6, M×8, L×1 |
| **S3** (Retrieval) | 2906 (CL102) | 15 Pos → `reference_articles.md §4` | Aisles 1–5 | S×5, M×8, L×2 |
| **S4** (Storage) | 2904 (CL100) | Wie S1, umgekehrt | Aisles 1–5 | S×4, M×10, L×1 |
| **S5** (Storage) | 2905 (CL101) | Wie S2, umgekehrt | Aisles 1–5 | S×6, M×8, L×1 |
| **S6** (Storage) | 2906 (CL102) | Wie S3, umgekehrt | Aisles 1–5 | S×5, M×8, L×2 |
| **S7** (Multi-Retr) | 2904+2905 | 30 Pos, `reference_articles.md §5` | Aisles 1–5 | S×10, M×18, L×2 |
| **S8** (Multi-Stor) | 2904+2905 | 30 Pos, umgekehrt | Aisles 1–5 | S×10, M×18, L×2 |

**Retrieval:** R→G→M→RL | **Storage:** R→G→M→P→RL (P obligatorisch)

### 3.2 Regal-Ebene → MTM-Reach und Körperhaltung

**H=21cm Standard (reference_warehouse.md §6.3):**

| Ebene | Obj.-Mitte | Reach Front | Reach Back | CC03 | CC04/05 |
|:------|:-----------|:------------|:-----------|:-----|:--------|
| 1 | 10,5 cm | R_B_80 (22,8) | R_B_80 (22,8) | **B/KOK** CL026 | Downwards CL032/067 |
| 2 | 31,5 cm | R_B_40–50 | R_B_50–80 | **B/KOK** CL026 | Downwards CL032/067 |
| 3 | 52,5 cm | R_B_20–30 | R_B_40–50 | **B/KOK** CL026 | Downwards CL032/067 |
| 4 | 73,5 cm | R_B_20 (6,5) | R_B_40 (12,8) | SlBend CL025 | Downwards CL032/067 |
| 5 | 94,5 cm | R_B_20–30 | R_B_40–50 | NoBend/SlBend* | Centered CL031/066 |
| 6 | 115,5 cm | R_B_40–50 | R_B_80 (22,8) | NoBend CL024 | Centered CL031/066 |
| 7 | 136,5 cm | R_B_80 (22,8) | R_B_80 (22,8) | NoBend CL024 | Upwards CL030/065 |
| 8 | 157,5 cm | R_B_>80 | R_B_>80 | NoBend CL024 | Upwards CL030/065 |

*Ebene 5: NoBend für S08/S10 (<165cm); SlBend für S18/S12 (>185cm).

**Bend-Universalregel (alle 18 Probanden):**
- Ebenen 1–3: **B obligatorisch** (52,5cm < Knie-Min 52,8cm bei S10)
- Ebene 4: **SlightBend universal**
- Ebene 5: **Grauzone** (körpergrößenabhängig)
- Ebenen 6+: **NoBend universal**

**B vs. KOK — Ebene 1:**
- B + AB = 60,9 TMU (Standard, aufrecht beugen)
- KOK + AKOK = 146,1 TMU (Knien, +139% TMU)
- KOK diagnostisch erkennbar: CC02=CL020 (Squat) statt CL018 (Standing)
- KOK wahrscheinlicher bei: Back-Artikel (34cm Tiefe), Large [L], unerfahrene Probanden

**TBC Körperdrehung Regal→Wagen:**
- TBC1 (18,6 TMU): Standard S1–S6, Aisle 2–5 (Breite 1,19m)
- TBC2 (37,2 TMU): Aisle 1 (Breite 0,91m), Fuß muss nachziehen
- Kein TBC: Wenn Wagen direkt in Gasse neben Person (nicht Base-Strategie)

**Sonderfall Komplex 8 (H=41cm, max. Ebene 3):**

| Ebene | Obj.-Mitte | CC03 | Reach |
|:------|:-----------|:-----|:------|
| 1 | 20,5 cm | B obligatorisch | R_B_40–50 |
| 2 | 61,5 cm | SlBend universal | R_B_20–30 |
| 3 | 102,5 cm | NoBend/SlBend* | R_B_30–50 |

---

## 4. Walk (W) — Streckenkalibrierung aus Planmaßen

### 4.1 Cross Aisle Segmente

| Segment | Strecke | TMU | CC11/CC12 |
|:--------|:--------|:----|:----------|
| Aisle 1→2 (CL168/CL195) | 1,76 m | 35 TMU | CL162/CL189 + CL168/CL195 |
| Aisle 2→3 (CL169/CL196) | 2,04 m | 41 TMU | CL162/CL189 + CL169/CL196 |
| Aisle 3→4 (CL170/CL197) | 2,04 m | 41 TMU | CL162/CL189 + CL170/CL197 |
| Aisle 4→5 (CL171/CL198) | 2,04 m | 41 TMU | CL162/CL189 + CL171/CL198 |
| Aisle 1→5 gesamt | 7,88 m | 158 TMU | — |

### 4.2 Gassen-Tiefe

| Position | Strecke | TMU | CC11 | CC12 |
|:---------|:--------|:----|:-----|:-----|
| Front | 2,05 m | 41 TMU | CL163+CL177 | CL190+CL204 |
| Back | 4,09 m | 82 TMU | CL163+CL178 | CL190+CL205 |

### 4.3 Gassen-Eingang

| Gasse | Breite | TMU | TBC-Empfehlung |
|:------|:-------|:----|:---------------|
| Aisle 1 | 0,91 m | 18 TMU | TBC2 (37,2 TMU) |
| Aisle 2–5 | 1,19 m | 24 TMU | TBC1 (18,6 TMU) |

### 4.4 Walk-Kontext CC10/CC11

| CC10 | CC11 | CC12 | Walk-Typ |
|:-----|:-----|:-----|:---------|
| CL137 | CL162/CL163 | CL189/CL190 | W Cross/Aisle |
| CL137 | CL168–CL171 | CL195–CL198 | W Gassen-Transition |
| CL140 | CL163 | CL185 | W Aisle→Base |
| CL128 | CL158 | CL185 | W mit Wagen |

---

## 5. DaRa-Label → MTM-Code Mapping

| MTM-Code | CC10 | CC01 | CC09 | REFA |
|:---------|:-----|:-----|:-----|:-----|
| R | CL139 | CL008/09/10 | CL116/CL120 | $t_{MH}$ |
| G | CL139 | CL008/09/10 | CL116/CL120 | $t_{MH}$ |
| M | CL140 | CL008/09/10 | CL116/CL120 | $t_{MH}$ |
| P | CL138 | CL008/09/10 | CL120 | $t_{MH}$ |
| AP | CL150/CL148 | CL009 | CL118 | $t_{MH}$ |
| RL | CL138/CL151 | CL008/09/10 | CL116/CL120 | $t_{MH}$ |
| B/KOK | — | — | CL116/CL120 | $t_{MH}$+$t_E$ |
| TBC | CL140 | CC03=CL027 | CL116/CL120 | $t_{MH}$ |
| W | CL137 | CL011 | CL115/CL119 | $t_{MN}$ |
| ET/EF | CL139/CL124 | CL002/03/05 | CL114/CL116 | $t_{MH}$ |

**B/KOK:** CC03=CL026; CC02=CL018 (B) oder CL020 (KOK); Ebenen 1–3
**TBC:** CC03=CL027 Torso Rotation; TBC2 bei Aisle 1
**ET/EF:** Nicht direkt als Frame-Label — Overhead-TMU pro Pick-Position nach CC07

---

## 6. Lastklassen-spezifische MTM-Parameter

### 6.1 Basisparameter

| Lastklasse | Gewicht | Grasp | TMU | Move | TMU | Erholung | CC04/05 |
|:-----------|:--------|:------|:----|:-----|:----|:---------|:--------|
| Small [S] | ≤50g | G1C | 7,3–12,9 | M_B_30 | 9,7 | +5% | CL043/CL078 |
| Medium [M] | 50–800g | G1B | 3,5 | M_B_30 | 9,7 | +10–20% | CL042/CL077 |
| Large [L] | >800g | G1A | 2,0 | M_C_40+SC/DF | var. | **+25–40%** | CL041/CL076 |

### 6.2 Erholungszeit-Tabelle ($t_E$)

| Situation | Zuschlag | Kommentar |
|:----------|:---------|:----------|
| Large [L], Ebene 4–8 | +10–15% | Schwere Last, aufrechte Haltung |
| Large [L], Ebenen 1–3 (B/KOK) | **+30–40%** | Max. Belastung |
| Medium [M], Ebenen 1–3 (B) | +15–20% | Beugen ohne schwere Last |
| Small [S], beliebig | +5% | Greifaufwand Kleinteile |
| Repetitionen >10× | +5–10% additiv | Pos. 1+2 jeder Order |
| Senior ≥50J + B/KOK | +5–10% additiv | S03(64J), S05(67J), S11(59J), S13(52J) |
| Unerfahren + Storage P | +5% additiv | P2SE statt P1SE wahrscheinlich |

### 6.3 Probanden-spezifische Normabweichungen

MTM-Norm = eingearbeiteter Durchschnittsarbeiter. 72% DaRa-Probanden unerfahren.

| Merkmal | Probanden | MTM-Auswirkung |
|:--------|:----------|:---------------|
| Unerfahren (Level 5–6) | S03,S04,S06–S09,S12–S18 | G1C_max, P2SE, höhere Streuung |
| Erfahren (Level 2–3) | S01,S02,S10,S11 | Näher an MTM-Norm |
| Senior ≥50J | S03,S05,S11,S13 | AB/AKOK +5–10% langsamer |
| Schwergewicht >95kg | S05,S12,S16 | B/AB höhere Rückenbelastung |
| Linkshänder | S04 | CC04=Haupthand, CC05=Hilfshand (Rollentausch) |
| Klein <165cm | S08,S10 | Ebene 5: NoBend; kürzere Schrittlänge |
| Groß >185cm | S12,S18 | Ebene 5: SlBend; mehr Schritte |

**Betroffene Artikel Ebene 1 + Large:**

| Order | Pos | Artikel | Klasse | Compartment | Erholung | SC | DF |
|:------|:----|:--------|:-------|:------------|:---------|:---|:---|
| 2904 | 14 | Palm Soil 5149g | **L** | R7.3.1.A (E1) | +35–40% | 4,3 | 1,11 |
| 2904 | 11 | Hacksaw | M | R6.1.1.A (E1) | +15–20% | — | — |
| 2904 | 15 | Isotonic Sports Drink | M | R8.3.1.A (E1) | +15–20% | — | — |
| 2905 | 13 | Hand Axe 1000g | **L** | R7.2.1.A (E1) | +35–40% | 1,6 | 1,04 |
| 2906 | 14 | Hand Axe 800g | **L** | R7.3.3.B (E1) | +35–40% | Grenzfall | 1,00 |
| 2906 | 15 | Hand Axe 1200g | **L** | R8.2.2.A (E2) | +25–30% | 1,6 | 1,04 |

---

## 7. Anwendungsbeispiele

### S1 — Order 2904, Pos. 14 (Palmenerde, Retrieval)

```
Palm Soil 5149g, R7.3.1.A → Aisle 4, Ebene 1, Back
CC08=CL110, CC06=CL100, CC07=CL105

MTM-Sequenz:
1. W Cross Aisle 3→4 (CL162+CL170):   41 TMU
2. W Aisle 4 Back (CL163+CL178):       82 TMU
3. TBC1 Regal→Wagen (CC03=CL027):      18,6 TMU
4. R_B_80 (Ebene 1 Back):              22,8 TMU
5. B (CC03=CL026, Ebene 1):            29,0 TMU
6. G1A (CC04/05=CL041/CL076):           2,0 TMU
7. AB (Aufrichten):                    31,9 TMU
8. M_C_40 + SC/DF (5149g):            ~20,3 TMU
9. RL1:                                 2,0 TMU

Handhabungs-TMU (ohne Walk): ~126,6 TMU = 4,6s
Walk-TMU: ~123 TMU = 4,4s
Gesamt: ~249 TMU = 9,0s
+ Erholung Large[L]+E1 (+35%): ~336 TMU = 12,1s
```

### S1 — Packing-Sequenz (CL150 Sealing)

```
CC10=CL150, CC01=CL009, CC09=CL118

1. R_B_30 (Reach Klebeband):   9,4 TMU
2. G1A (Klebebandabroller):    2,0 TMU
3. M_B_30 (Move zu Karton):    9,7 TMU
4. AP (Klebeband andrücken):  10,6 TMU
5. RL1:                        2,0 TMU
Sealing-TMU: ~33,7 TMU = 1,2s
```

### DaRa-Label-Sequenz (S1, Palmenerde)

| Schritt | CC01 | CC02 | CC03 | CC04/05 Pos | CC04/05 Mov | CC10 | CC11 | CC12 |
|:--------|:-----|:-----|:-----|:------------|:------------|:-----|:-----|:-----|
| Walk Cross | CL011 | CL016 | CL024 | CL031/66 | CL037/72 | CL137 | CL162+CL170 | CL189+CL197 |
| Walk Aisle | CL011 | CL016 | CL024 | CL031/66 | CL037/72 | CL137 | CL163+CL178 | CL190+CL205 |
| TBC | CL012 | CL018 | CL027 | CL031/66 | CL037/72 | CL139 | CL163+CL178 | CL185 |
| Reach | CL010 | CL018 | CL026 | CL032/67 | CL034/69 | CL139 | CL163+CL178 | CL185 |
| Grasp | CL010 | CL018 | CL026 | CL032/67 | CL034/69 | CL139 | CL163+CL178 | CL185 |
| Move | CL009 | CL018 | CL024 | CL031/66 | CL034/69 | CL140 | CL163 | CL185 |
| Release | CL009 | CL018 | CL024 | CL031/66 | CL034/69 | CL151 | CL163 | CL185 |

---

## 8. REFA-Zeitarten-Zuordnung

| MTM-Code | REFA | Symbol | CC09 |
|:---------|:-----|:-------|:-----|
| R, G, M, P, AP, RL | Haupttätigkeit | $t_{MH}$ | CL116/CL120 |
| ET, EF | Haupttätigkeit | $t_{MH}$ | CL114/CL116 |
| W | Nebentätigkeit | $t_{MN}$ | CL115/CL119 |
| B, AB, KOK, AKOK | Haupttätigkeit + Erholung | $t_{MH}$+$t_E$ | CL116/CL120 |
| TBC | Haupttätigkeit | $t_{MH}$ | CL116/CL120 |

---

## 9. TMU-Gesamtschätzung pro Order

| Order | Szenario | Handhabungs-TMU | Walk-TMU | Summe TMU | Summe (s) | Mit Erholung (s) |
|:------|:---------|:----------------|:---------|:----------|:----------|:-----------------|
| 2904 | S1/S4 | ~510* | ~158 | ~668 | ~24 | ~29–33 |
| 2905 | S2/S5 | ~495* | ~158 | ~653 | ~24 | ~28–32 |
| 2906 | S3/S6 | ~530* | ~158 | ~688 | ~25 | ~30–35 |
| 2904+2905 | S7/S8 | ~1005* | ~158 | ~1163 | ~42 | ~51–60 |

*Erhöht gegenüber v6.2.1 durch SC+DF (+5,9 TMU Palm Soil, +2,2 TMU Hand Axe)
und TBC (+18,6 TMU je Pick-Position mit Körperdrehung).

Walk-TMU ~158 TMU = Cross-Aisle-Transitionen Aisle 1→5.
Zusätzlich je Position: Gassen-Eingang (18–24 TMU), Tiefe (41/82 TMU Front/Back),
TBC (18,6–37,2 TMU), ET/EF (~25–35 TMU je IT-System.
Packing (CL118, CL145–CL150) und Vor-/Nachbereitung (CL114, CL121,
CL124–CL126, CL132–CL133) NICHT enthalten.

---

## 10. Verwandte Dateien

| Datei | Relevanz |
|:------|:---------|
| `phase1_scenario_recognition.md` | Szenario → Order (CC08/CC06/CC07) |
| `reference_articles.md` | Artikel, Lagerorte, Gewichte |
| `reference_warehouse.md` | Planmaße, Ebenen-Höhen, Fachtypen |
| `reference_labels.md` | Label-Definitionen CC01–CC12 |
| `phase2_refa_analysis.md` | REFA-Zeitarten, Erholungszuschläge |

<!-- VERIFICATION_TOKEN: DARA-P3MTM-6A5F-v630 -->
