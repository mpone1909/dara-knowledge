# Referenz: Artikel-Stammdaten — 3 Orders, 74 Artikel

**Version:** 6.2.0 (2026-03-05)
**Quelle:** DaRa Dataset Description (verifiziert 22.01.2026)
**Änderungen v6.2.0:**
- MTM-relevante Spalten ergänzt: Regal-Ebene, Bend-Flag, Walk-Segment (CC11/CC12), TMU-Schätzwert
- Order → Szenario-Mapping aus Phase 1 cross-referenziert
- Gassen-Abstand-Basis: `reference_warehouse.md` (12,76m Regalbereich, ~2,55m pro Gassen-Abstand)

---

## 1. Gewichtsklassen

| Klasse | Gewichtsbereich | Volumen | CC04/05 Label | MTM Grasp | MTM Move |
|:-------|:----------------|:--------|:--------------|:----------|:---------|
| Small [S] | ≤ 50g | ≤ 100 cm³ | CL043/CL078 Small Item | G1C (7,3–12,9 TMU) | M_B_30 (9,7 TMU) |
| Medium [M] | 50–800g | 100–6000 cm³ | CL042/CL077 Medium Item | G1B (3,5 TMU) | M_B_30 (9,7 TMU) |
| Large [L] | > 800g | > 6000 cm³ | CL041/CL076 Large Item | G1A (2,0 TMU) | M_C_40 (14,4 TMU) |

Gewichtsspektrum: 0,4g (Kleinteile) bis 5149g (Palmenerde).

---

## 2. Order 2904 (CL100) — Szenarien S1 (Retrieval) / S4 (Storage)

| Pos | Lagerort | Artikel | Menge | Gewicht | Kl | Gasse | Ebene | Bend? | Walk-Seg (CC11) | R-TMU | Σ-TMU |
|:----|:---------|:--------|:-----:|:--------|:---|:------|:------|:------|:----------------|:------|:------|
| 1 | R1.2.7.A | Hexagonal Cap Nut M5 | 20 | ~1g | S | 1 | 7 | Nein | CL172 + CL177/178 | R_A_30 (8,7) | ~30 |
| 2 | R1.4.5.A | Locknut | 10 | ~1g | S | 1 | 5 | Nein | CL172 + CL177/178 | R_B_30 (9,4) | ~31 |
| 3 | R2.1.4.A | Softshell Jacket S | 1 | ~600g | M | 2 | 4 | Nein | CL173 + CL177/178 | R_B_30 (9,4) | ~25 |
| 4 | R2.4.3.B | Gloves Yellow, Size 10 | 1 | ~200g | M | 2 | 3 | Ggf. | CL173 + CL177/178 | R_B_30 (9,4) | ~25 |
| 5 | R3.1.4.A | Hoody White, Size L | 1 | ~400g | M | 3* | 4 | Nein | CL174 + CL177/178 | R_B_30 (9,4) | ~25 |
| 6 | R3.4.3.A | Carrier Bag Grey | 1 | ~100g | M | 3* | 3 | Ggf. | CL174 + CL177/178 | R_B_30 (9,4) | ~25 |
| 7 | R4.1.5.A | Ice Scratcher | 1 | ~100g | M | 3 | 5 | Nein | CL174 + CL177/178 | R_B_30 (9,4) | ~25 |
| 8 | R4.2.2.B | Hexagonal Nut | 2 | ~1g | S | 3 | 2 | Ggf. | CL174 + CL177/178 | R_B_30 (9,4) | ~31 |
| 9 | R4.3.5.B | Tearing Pin | 3 | ~10g | S | 3 | 5 | Nein | CL174 + CL177/178 | R_B_30 (9,4) | ~31 |
| 10 | R5.2.4.B | Notebook A5 Black | 1 | ~200g | M | 3 | 4 | Nein | CL174 + CL177/178 | R_B_30 (9,4) | ~25 |
| 11 | R6.1.1.A | Hacksaw | 1 | ~500g | M | 4 | **1** | **Ja** | CL175 + CL177/178 | R_B_50 (15,6) | ~60 |
| 12 | R6.3.8.A | Letter Tray | 1 | ~300g | M | 4 | 8 | Nein | CL175 + CL177/178 | R_A_40 (10,8) | ~26 |
| 13 | R7.2.2.A | Compartment Divider | 1 | ~100g | M | 4 | 2 | Ggf. | CL175 + CL177/178 | R_B_30 (9,4) | ~25 |
| 14 | R7.3.1.A | **Palm Soil 5149g** | 1 | 5149g | **L** | 4 | **1** | **Ja** | CL175 + CL178 Back | R_B_50 (15,6) | ~61 |
| 15 | R8.3.1.A | Isotonic Sports Drink | 5 | ~500g | M | 5 | **1** | **Ja** | CL176 + CL177/178 | R_B_50 (15,6) | ~60 |

**Besonderheiten Order 2904:**
- Pos 1, 2: Kleinteile mit hoher Stückzahl (20+10) → G1C, hohe Pickzeit
- Pos 11, 14, 15: Ebene 1 → Bend (B) obligatorisch, +29,0 TMU + Erholungszeit
- Pos 14: Schwerster Artikel im Datensatz (5149g) → Large [L], M_C_40, +35–40% Erholung
- Gassen-Abdeckung: 1→2→3→4→5, 4 Transitionen × ~51 TMU = ~204 TMU Walk (Cross Aisle)
- Zugehörige Szenarien: **S1** (Retrieval, CC08=CL110) / **S4** (Storage, CC08=CL111)

*Pos 5+6 im Regal R3 → Gasse 2 (zwischen R2 und R3) oder Gasse 3 (zwischen R4 und R5)?
Bei R3 gilt: die Gasse an Seite A vs B des Regals. Konservative Annahme: Gasse 2–3.
Im Zweifel CC11/CC12 CL173/CL174 prüfen.

---

## 3. Order 2905 (CL101) — Szenarien S2 (Retrieval) / S5 (Storage)

| Pos | Lagerort | Artikel | Menge | Gewicht | Kl | Gasse | Ebene | Bend? | Walk-Seg (CC11) | R-TMU | Σ-TMU |
|:----|:---------|:--------|:-----:|:--------|:---|:------|:------|:------|:----------------|:------|:------|
| 1 | R1.1.6.A | M5 Locknuts | 20 | ~1g | S | 1 | 6 | Nein | CL172 + CL177/178 | R_A_30 (8,7) | ~30 |
| 2 | R1.4.4.A | Washer A8,4 | 10 | ~1g | S | 1 | 4 | Nein | CL172 + CL177/178 | R_B_30 (9,4) | ~31 |
| 3 | R2.2.3.C | Factory Xperts | 1 | ~500g | M | 2 | 3 | Ggf. | CL173 + CL177/178 | R_B_30 (9,4) | ~25 |
| 4 | R2.3.4.A | Softshell Jacket M | 1 | ~700g | M | 2 | 4 | Nein | CL173 + CL177/178 | R_B_30 (9,4) | ~25 |
| 5 | R3.1.4.A | Hoody White, Size L | 1 | ~400g | M | 2/3 | 4 | Nein | CL173/174 + CL177/178 | R_B_30 (9,4) | ~25 |
| 6 | R3.4.3.B | Polo Shirt White | 1 | ~200g | M | 2/3 | 3 | Ggf. | CL173/174 + CL177/178 | R_B_30 (9,4) | ~25 |
| 7 | R4.2.3.C | Bit 6,5 mm Slot | 2 | ~5g | S | 3 | 3 | Ggf. | CL174 + CL177/178 | R_B_30 (9,4) | ~31 |
| 8 | R4.2.6.E | Ballpoint Pen PSI | 3 | ~10g | S | 3 | 6 | Nein | CL174 + CL177/178 | R_A_30 (8,7) | ~30 |
| 9 | R4.4.5.D | Bit T 27 | 1 | ~5g | S | 3 | 5 | Nein | CL174 + CL177/178 | R_B_30 (9,4) | ~31 |
| 10 | R5.3.6.C | Flat-Washer M6 | 1 | ~1g | S | 3 | 6 | Nein | CL174 + CL177/178 | R_A_30 (8,7) | ~30 |
| 11 | R6.1.2.C | Anti-Stress Ball | 1 | ~50g | M | 4 | 2 | Ggf. | CL175 + CL177/178 | R_B_30 (9,4) | ~25 |
| 12 | R6.2.5.B | Hand Washing Paste | 1 | ~300g | M | 4 | 5 | Nein | CL175 + CL177/178 | R_B_30 (9,4) | ~25 |
| 13 | R7.2.1.A | **Hand Axe 1000g** | 1 | ~1000g | **L** | 4 | **1** | **Ja** | CL175 + CL177/178 | R_B_50 (15,6) | ~61 |
| 14 | R7.3.6.A | Chain Lights Xmas | 1 | ~400g | M | 4 | 6 | Nein | CL175 + CL177/178 | R_A_30 (8,7) | ~25 |
| 15 | R8.3.1.A | Isotonic Sports Drink | 3 | ~500g | M | 5 | **1** | **Ja** | CL176 + CL177/178 | R_B_50 (15,6) | ~60 |

**Besonderheiten Order 2905:**
- Pos 1, 2: Kleinteile mit hoher Stückzahl (20+10)
- Pos 13: Schwerer Artikel (1000g, Ebene 1) → B obligatorisch, Large [L], +35–40% Erholung
- Pos 15: Ebene 1 → B obligatorisch
- Zugehörige Szenarien: **S2** (Retrieval, IT=PDT CL107) / **S5** (Storage, IT=List+Pen CL105)

---

## 4. Order 2906 (CL102) — Szenarien S3 (Retrieval) / S6 (Storage)

| Pos | Lagerort | Artikel | Menge | Gewicht | Kl | Gasse | Ebene | Bend? | Walk-Seg (CC11) | R-TMU | Σ-TMU |
|:----|:---------|:--------|:-----:|:--------|:---|:------|:------|:------|:----------------|:------|:------|
| 1 | R1.2.6.A | Washer 5,3 | 20 | ~1g | S | 1 | 6 | Nein | CL172 + CL177/178 | R_A_30 (8,7) | ~30 |
| 2 | R1.3.5.A | M4 Bolt Charge 6 | 10 | ~1g | S | 1 | 5 | Nein | CL172 + CL177/178 | R_B_30 (9,4) | ~31 |
| 3 | R2.3.2.A | Tie Grey | 1 | ~100g | M | 2 | 2 | Ggf. | CL173 + CL177/178 | R_B_30 (9,4) | ~25 |
| 4 | R2.3.3.B | Gloves Blue, Size 8 | 1 | ~150g | M | 2 | 3 | Ggf. | CL173 + CL177/178 | R_B_30 (9,4) | ~25 |
| 5 | R3.1.4.A | Hoody White, Size L | 1 | ~400g | M | 2/3 | 4 | Nein | CL173/174 + CL177/178 | R_B_30 (9,4) | ~25 |
| 6 | R3.4.3.A | Carrier Bag Grey | 1 | ~100g | M | 2/3 | 3 | Ggf. | CL173/174 + CL177/178 | R_B_30 (9,4) | ~25 |
| 7 | R4.2.2.E | Bit Hexagonal 4 mm | 2 | ~5g | S | 3 | 2 | Ggf. | CL174 + CL177/178 | R_B_30 (9,4) | ~31 |
| 8 | R4.2.6.B | Bit PH 3 | 3 | ~5g | S | 3 | 6 | Nein | CL174 + CL177/178 | R_A_30 (8,7) | ~30 |
| 9 | R4.4.5.A | CD-Drivers | 1 | ~20g | S | 3 | 5 | Nein | CL174 + CL177/178 | R_B_30 (9,4) | ~31 |
| 10 | R5.2.4.B | Notebook A5 Black | 1 | ~200g | M | 3 | 4 | Nein | CL174 + CL177/178 | R_B_30 (9,4) | ~25 |
| 11 | R6.3.1.A | Drone Eachine | 1 | ~100g | M | 4 | 1 | **Ja** | CL175 + CL177/178 | R_B_50 (15,6) | ~60 |
| 12 | R6.4.4.C | Notebook A4 IML | 1 | ~300g | M | 4 | 4 | Nein | CL175 + CL177/178 | R_B_30 (9,4) | ~25 |
| 13 | R7.2.2.A | Compartment Divider | 3 | ~100g | M | 4 | 2 | Ggf. | CL175 + CL177/178 | R_B_30 (9,4) | ~25 |
| 14 | R7.3.3.B | **Hand Axe 800g** | 1 | ~800g | **L** | 4 | 3 | Ggf. | CL175 + CL177/178 | R_B_30 (9,4) | ~27 |
| 15 | R8.2.2.A | **Hand Axe 1200g** | 1 | ~1290g | **L** | 5 | 2 | Ggf. | CL176 + CL177/178 | R_B_30 (9,4) | ~29 |

**Besonderheiten Order 2906:**
- Pos 1, 2: Kleinteile mit hoher Stückzahl (20+10)
- Pos 11: Ebene 1 → B obligatorisch
- Pos 14+15: Large [L] — Pos 14 Ebene 3 (kein Bend), Pos 15 Ebene 2 (Ggf. Bend)
- Zugehörige Szenarien: **S3** (Retrieval, IT=Scanner CL106) / **S6** (Storage, IT=List+Pen CL105)

---

## 5. Multi-Order (S7/S8): 2904 + 2905 = 30 Positionen

**Kombination:** CL100 + CL101
**Gesamtpositionen:** 30 (15 + 15)
**Zugehörige Szenarien: S7** (Retrieval Multi) / **S8** (Storage Multi)

**Besonderheiten:**
- 4 Positionen mit Kleinteilen hoher Stückzahl (Order 2904 Pos 1+2, Order 2905 Pos 1+2)
- 2 schwere Artikel: Palmenerde (5149g, Order 2904 Pos 14) + Handbeil 1000g (Order 2905 Pos 13)
- Beide Schwer-Artikel: Ebene 1 → Bend obligatorisch, Large [L]
- Gassen-Abdeckung: Alle 5 Gassen (1–5)
- Walk-Budget Cross Aisle (S7/S8): ~204 TMU = ~7,3s (wie Einzel-Orders)

---

## 6. Artikel-Verteilung nach Gassen

| Gasse | CC11 | CC12 | Regalkomplexe | Artikel-Typen | Bend-Risiko |
|:------|:-----|:-----|:--------------|:-------------|:------------|
| Aisle 1 | CL172 | CL199 | R1 | Kleinteile (Muttern, Unterlegscheiben, Schrauben) | Gering (hohe Ebenen) |
| Aisle 2 | CL173 | CL200 | R2, R3 | Textilien (Jacken, Handschuhe, Hoodies) | Mittel (Ebene 2–4) |
| Aisle 3 | CL174 | CL201 | R4, R5 | Werkzeuge (Bits, Eiskratzer, Notizbücher) | Mittel |
| Aisle 4 | CL175 | CL202 | R6, R7 | Schwere Güter (Beile, Palmenerde, Bügelsäge) | **Hoch** (Ebene 1) |
| Aisle 5 | CL176 | CL203 | R8 | Abschlussbereich (Handbeil 1200g, Sportgetränke) | **Hoch** (Ebene 1) |

**Gesamt:** 45 Positionen über 3 Orders verteilt. Mit Mehrfachnennungen wie
"Hoody White, Size L" (in allen 3 Orders): ~74 einzelne Artikel-Vorkommen.

### Bend-Risiko-Zusammenfassung über alle Orders:

| Ebene 1 Artikel | Order | Pos | Klasse | MTM-Impact |
|:----------------|:------|:----|:-------|:-----------|
| Hacksaw | 2904 | 11 | M | B+AB = +60,9 TMU, +15–20% Erh. |
| **Palm Soil 5149g** | 2904 | 14 | **L** | B+AB = +60,9 TMU, +35–40% Erh. |
| Isotonic Sports Drink | 2904 | 15 | M | B+AB = +60,9 TMU, +15–20% Erh. |
| **Hand Axe 1000g** | 2905 | 13 | **L** | B+AB = +60,9 TMU, +35–40% Erh. |
| Isotonic Sports Drink | 2905 | 15 | M | B+AB = +60,9 TMU, +15–20% Erh. |
| Drone Eachine | 2906 | 11 | M | B+AB = +60,9 TMU, +15–20% Erh. |

---

## 7. Walk-Sequenz und Location-Chaining

Die optimale Pick-Reihenfolge folgt Gasse 1→2→3→4→5 (keine Rückwärtsbewegungen).
Die Cross-Aisle-Transitionen entsprechen CC11/CC12 Segment-Labels:

| Transition | CC11 Human | CC12 Cart | Walk-TMU | Walk-Zeit |
|:-----------|:-----------|:----------|:---------|:----------|
| Start (Office→Base) | CL155→CL158 | CL182→CL185 | variabel | variabel |
| Base→Aisle 1 | CL158→CL162→CL172 | CL185→CL189→CL199 | ~30–40 | ~1–1,5s |
| Aisle 1→Aisle 2 | CL168 (1-2) | CL195 (1-2) | ~51 | ~1,8s |
| Aisle 2→Aisle 3 | CL169 (2-3) | CL196 (2-3) | ~51 | ~1,8s |
| Aisle 3→Aisle 4 | CL170 (3-4) | CL197 (3-4) | ~51 | ~1,8s |
| Aisle 4→Aisle 5 | CL171 (4-5) | CL198 (4-5) | ~51 | ~1,8s |
| Letzte Aisle→Base | CL163→CL162→CL158 | CL190→CL189→CL185 | ~30–40 | ~1–1,5s |

---

## 8. Verwendungshinweise

**Diese Datei nutzen für:**
- Artikel-Lagerort-Mapping (Storage Compartment IDs)
- Gewichtsklassen-Definitionen (Small/Medium/Large) + MTM Grasp/Move-Varianten
- Order-Struktur (2904=CL100, 2905=CL101, 2906=CL102)
- Szenario-spezifische Artikelsets (S1–S8 über Phase 1 Ergebnis)
- MTM-Vorplanung: Bend-Artikel identifizieren, Walk-Budget schätzen
- Location-Chaining: Walk-TMU aus CC11/CC12 Segment-Transitionen ableiten

**Verwandte Dateien:**

- `reference_warehouse.md` — Lagerlayout, Gassen-Abstände, Zone-Labels
- `reference_labels.md` — Object-Labels (CC04/CC05), Location-Labels (CC11/CC12)
- `phase1_scenario_recognition.md` — Szenario-Order-Mapping (welche Order in welchem Szenario)
- `phase2_refa_analysis.md` — Erholungszeit nach Lastklasse
- `phase3_mtm_analysis.md` — MTM-Sequenzen mit Order- und Location-Kontext

<!-- VERIFICATION_TOKEN: DARA-ARTCL-2M8C-v630 -->
