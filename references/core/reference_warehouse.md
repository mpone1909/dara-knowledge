# Referenz: Warehouse-Layout - Fraunhofer IML Picking Lab

**Version:** 6.1.3 (2026-03-05)
**Quelle:** DaRa Dataset Description + DaRa Documentation
**Änderungen v6.1.3:** Vollständige Planmaße (§2.5), Geometrische Kennwerte (§3.2),
Regalkomplex-Regaltypen (§3.5), Compartment-Inventar (§5.1/5.2),
Fachabmessungen (§6), erweiterte Infrastruktur/Sensorik (§7).
Semantische Zonen-Definitionen, Return-Aisle-Prozedur und CL181 aus v6.1.2 erhalten.

---

## 1. Überblick

Das Versuchsumfeld bildet ein realistisches Kleinteilelager mit zwei funktionalen
Bereichen ab:

- Rack storage system: 8 Regalkomplexe in 5 Aisles
- Open area in front of rack storage system: Prozess- und Materialflusszonen

**Gesamtraum (offiziell):**

- Länge: 17,35 m
- Breite: 12,76 m

---

## 2. Main Areas und Topologie

### 2.1 Neun Hauptbereiche (CC11/CC12)

| Zone | Funktion | CC11 (Human) | CC12 (Cart) |
|:-----|:---------|:-------------|:------------|
| Office | Auftragsannahme, Hardware-Rückgabe | CL155 | CL182 |
| Cart Area | Abstell-/Bereitstellungsbereich | CL156 | CL183 |
| Cardboard Box Area | Lagerort für leere Kartons | CL157 | CL184 |
| Base | Zentraler Parkbereich (Pick-Prozess) | CL158 | CL185 |
| Packing/Sorting Area | Verpacken und Sortieren | CL159 | CL186 |
| Issuing/Receiving Area | Warenein-/ausgang | CL160 | CL187 |
| Path | Verbindungswege zwischen Bereichen | CL161 | CL188 |
| Cross Aisle Path | Quergang vor Regalgassen | CL162 | CL189 |
| Aisle Path | Kommissioniergassen im Regal | CL163 | CL190 |

Abgrenzung: Absperrstände mit Gurtbändern + Bodenmarkierungen (Klebeband).
Exakte metrische Zonenpolygone (X/Y-Eckpunkte): **NICHT DOKUMENTIERT**

### 2.2 Semantische Zonen-Definitionen

**Office (CL155/CL182):** Administrativer Bereich, in dem der Proband den
Kommissionierauftrag erhält und Hardware (PDT, Glove Scanner) ausgehändigt
bekommt. Am Ende des Prozesses wird hier die Hardware zurückgegeben.

**Cart Area (CL156/CL183):** Abstellbereich für Kommissionierwagen. Probanden
holen sich hier ihren Wagen ab und bringen ihn am Ende zurück.

**Cardboard Box Area (CL157/CL184):** Lagerbereich für leere Kartons, die für
den Kommissionierprozess benötigt werden. Nur in Retrieval-Szenarien besucht.

**Base (CL158/CL185):** Zentraler Parkpunkt während des Picking-Prozesses.
Bei der Return-Aisle-Strategie wird der Wagen hier abgestellt, während der
Proband die Gasse zu Fuß betritt. Befindet sich am Cross Aisle Path.

**Packing/Sorting Area (CL159/CL186):** Bereich mit Packtisch, an dem Ware
verpackt (Retrieval) oder ausgepackt (Storage) wird. Enthält Klebebandabroller,
Computer, Drucker, Füllmaterial und Schreibutensilien.

**Issuing/Receiving Area (CL160/CL187):** Warenausgangs- und -eingangsbereich.
In Retrieval: Ort der Übergabe fertig gepackter Kartons.
In Storage: Ort der Annahme zu lagernder Ware.

### 2.3 Path-Subzonen (offiziell)

| Path-Subzone | CC11 | CC12 |
|:-------------|:-----|:-----|
| Path (Office) | CL164 | CL191 |
| Path (Cardboard Box Area) | CL165 | CL192 |
| Path (Cart Area) | CL166 | CL193 |
| Path (Issuing Area) | CL167 | CL194 |

### 2.4 Nachbarschaften (konzeptionell nach Grundriss)

| Zone | Direkte Nachbarn |
|:-----|:-----------------|
| Office | Issuing/Receiving Area, Path |
| Issuing/Receiving Area | Office, Cardboard Box Area, Path |
| Cardboard Box Area | Issuing/Receiving Area, Path |
| Cart Area | Path |
| Packing/Sorting Area | Path |
| Path | Office, Issuing/Receiving, Cardboard Box Area, Cart Area, Packing/Sorting Area, Base |
| Base | Path, Cross Aisle Path |
| Cross Aisle Path | Base, Aisle Path |
| Aisle Path | Cross Aisle Path |

### 2.5 Hart bestätigte Planmaße (Grundriss)

Die Bereichsbezeichnungen folgen direkt den bemaßten Ketten im Plan
(oben, links, rechts, unten, Rackbereich).

| Planbereich (Bezeichnung) | Wert |
|:--------------------------|:-----|
| Obere Hauptkette: Gesamtbreite Innenkontur | 17,35 m |
| Obere Kette Segment A: Linke Innenwand bis Rackbeginn | 0,5 m |
| Obere Kette Segment B: Rackkomplex-Länge | 4,09 m |
| Obere Kette Segment C: Anschlusssegment nach Rackbereich | 2,74 m |
| Obere Kette Segment D: Office-Abschnitt | 2,71 m |
| Obere Kette Segment E: Abschnitt rechts neben Office | 2,11 m |
| Obere Kette Segment F: Abschnitt vor Hall-gate | 1,91 m |
| Obere rechte Kante: Hall-gate Breite | 3,29 m |
| Linke Vertikalkette: Gesamthöhe | 9,07 m |
| Rechte Vertikalkette oben | 2,45 m |
| Rechte Vertikalkette Mitte (Versatz) | 1,33 m |
| Rechte Vertikalkette unten | 6,02 m |
| Vertikal am Hall-gate-Versatz (oben rechts) | 0,73 m |
| Rackbereich: Regalkomplex-Breite | 0,85 m |
| Rackbereich: Aisle 1 Breite | 0,91 m |
| Rackbereich: Aisle 2-5 Breite (je Gasse) | 1,19 m |
| Mittlere horizontale Innenkette | 12,76 m |
| Untere Kette links: Abstand linke Innenwand bis Rampenbeginn | 2,30 m |
| Untere Kette rechts: Abstand Rampenende bis rechte Innenwand | 1,92 m |

### 2.6 Raumanordnung für LLM (direktional aus Grundriss)

Referenzrichtung: links = West, rechts = Ost, oben = Nord, unten = Süd.

1. Westlicher Block (links): `Aisle Path` über fast die volle Raumhöhe.
   - 5 horizontale Gassen (Aisle 1..5), jeweils in `back` (westliche Hälfte)
     und `front` (östliche Hälfte) geteilt.
   - Regalkomplexe sind im Aisle-Bereich verortet; die eingezeichnete
     Komplexnummerierung steigt von unten nach oben (1/2, 3/4, 5/6, 7/8).

2. Zwischenblock: Direkt östlich des Aisle Path liegt der vertikale
   `Cross Aisle Path`.
   - Segmentierung gemäß Labelsystem: `1-2`, `2-3`, `3-4`, `4-5`.
   - `Base` liegt unten östlich des Cross Aisle Path als Puffer zur offenen
     Fläche.

3. Östlicher Prozessblock (rechts):
   - Nord/Oberes Band (West → Ost): `Office` → `Path (Issuing area)` →
     `Issuing/Receiving Area` (am `Hall gate`).
   - Mittelband (West → Ost): `Path (Office)` → `Path (Cardboard box area)`
     → `Cardboard box area`.
   - Süd/Unteres Band (West → Ost): `Packaging/sorting area` →
     `Path (Cart area)` → `Cart area`.

4. Symbolische Objektverortung laut Grundriss:
   - Euro pallets im `Issuing/Receiving Area` nahe Hall gate.
   - Tisch-/Supervisor-Symbole in `Office` und `Packaging/sorting area`.
   - Cart-Symbole in Prozess-/Übergangsbereichen (u. a. nahe Base/Path/Packing).

---

## 3. Regalsystem und Gassen

### 3.1 Aisles

| Gasse | Regalkomplexe | CC11 | CC12 | Artikel-Typen |
|:------|:-------------|:-----|:-----|:-------------|
| Aisle 1 | R1 | CL172 | CL199 | Kleinteile (Muttern, Schrauben) |
| Aisle 2 | R2, R3 | CL173 | CL200 | Textilien (Jacken, Handschuhe, Hoodies) |
| Aisle 3 | R4, R5 | CL174 | CL201 | Werkzeuge, Stifte, Notizbücher |
| Aisle 4 | R6, R7 | CL175 | CL202 | Sichtlastkasten + Schwere Güter |
| Aisle 5 | R8 | CL176 | CL203 | Schwere/große Artikel (Hand Axe, Isotonic) |

**Gassen-Definitionen:**

- Aisle 1: Zwischen Wand und Regal 1
- Aisle 2: Zwischen Regal 2 und 3
- Aisle 3: Zwischen Regal 4 und 5
- Aisle 4: Zwischen Regal 6 und 7
- Aisle 5: Neben Regal 8

### 3.2 Geometrische Kennwerte (bestätigt)

| Element | Wert |
|:--------|:-----|
| Aisle 1 Breite | 0,91 m |
| Aisle 2-5 Breite (je Gasse) | 1,19 m |
| Regalkomplex-Breite (je Komplex) | 0,85 m |
| Regalkomplex-Länge (je Komplex) | 4,09 m |
| Abstand Regalkomplexe zur linken Wand | 0,5 m |

### 3.3 Front / Back

| Position | CC11 | CC12 | Bedeutung |
|:---------|:-----|:-----|:----------|
| Front | CL177 | CL204 | Vordere Hälfte der Gasse (Eingangsseite) |
| Back | CL178 | CL205 | Hintere Hälfte der Gasse (Wandseite) |

**MTM-Relevanz:** Back-Artikel liegen ~34 cm tiefer im Fach → längere Reach-Distanz
(R_B_50–80 statt R_B_40–50 bei Front). Fachtiefe W=39,5 cm.

### 3.4 Cross Aisle Path

| Abschnitt | CC11 | CC12 | Verbindung | Strecke | TMU |
|:----------|:-----|:-----|:-----------|:--------|:----|
| 1-2 | CL168 | CL195 | Aisle 1 ↔ Aisle 2 | 1,76 m | 35 TMU |
| 2-3 | CL169 | CL196 | Aisle 2 ↔ Aisle 3 | 2,04 m | 41 TMU |
| 3-4 | CL170 | CL197 | Aisle 3 ↔ Aisle 4 | 2,04 m | 41 TMU |
| 4-5 | CL171 | CL198 | Aisle 4 ↔ Aisle 5 | 2,04 m | 41 TMU |

**Berechnung:** Segment 1-2 = Aisle1(0,91m) + Rack(0,85m) = 1,76m.
Segmente 2-3/3-4/4-5 = Aisle2-5(1,19m) + Rack(0,85m) = 2,04m je.
Walk W = 15,0 TMU/Schritt bei 0,75m/Schritt (MTM-Norm).
Gesamtstrecke Aisle 1→5: 7,88 m = 158 TMU.

### 3.5 Regalkomplexe: Genutzte Racks und Lagerarten

| Komplex | Gasse | Regale | Regaltyp / Art der Lagerung |
|:--------|:------|:-------|:-----------------------------|
| R1 | 1 | 1,2,3,4 | Fachbodenregale: Sichtlagerkästen mit Kleinteilen (Muttern, Unterlegscheiben) |
| R2 | 2 | 1,2,3,4 | Kleiderstangen für Hängeware (Softshelljacken) + Flächen für lose Artikel |
| R3 | 2 | 1,4 | Durchlaufkanäle (Flow Channels) + Kleiderstangen (Hoodies) |
| R4 | 3 | 1,2,3,4 | Fachbodenregale: schmale Sichtlagerkästen 19 cm (Bits, Stifte, Schrauben) |
| R5 | 3 | 2,3 | Fachbodenregale: schmale Sichtlagerkästen 19 cm (Notizbücher, Unterlegscheiben) |
| R6 | 4 | 1,2,3,4 | Sichtlagerkästen (open-fronted bins), blau+grün, Kleinteile + lose Artikel |
| R7 | 4 | 2,3 | Breite Fachbodenregale: lose, große, schwere Artikel (Palm Soil, Hand Axe, Chain Lights) |
| R8 | 5 | 2,3 | Breite Fachbodenregale H=41cm: große/schwere Artikel (Hand Axe 1200g, Isotonic Drink) |

---

## 4. Bewegungslogik

### 4.1 Base

Die Base bildet die Pufferzone zwischen offenem Bereich und Regalsystem.
Der Wagen wird dort geparkt, während die Person die Aisles zu Fuß betritt.

### 4.2 Return-Aisle-Strategie (Standardvorgehen S1–S6)

1. Wagen an Base (CL158/CL185) parken
2. Gasse zu Fuß ohne Wagen betreten (CC11: CL163, CC12: CL185)
3. Ware entnehmen/einlagern
4. Zur Base zurückkehren
5. Wagen greifen, zur nächsten Gasse fahren

S7/S8 (Multi-Order): Routenwahl frei, mehrere Positionen pro Durchgang möglich.

---

## 5. Storage Compartment ID

**Format:** `R<Komplex>.<Regal>.<Ebene>.<Fach>`

| Komponente | Bedeutung | Dokumentierter Bereich |
|:-----------|:----------|:-----------------------|
| `R<Komplex>` | Regalkomplex | R1–R8 |
| `<Regal>` | Regal im Komplex | 1–4 (in Master Data genutzt) |
| `<Ebene>` | Vertikale Ebene (unten → oben) | 1–8 (in Master Data genutzt) |
| `<Fach>` | Horizontale Fachspalte (links → rechts) | A–E (in Master Data genutzt) |

**Konventionen:**

- Ebene 1 = Bodenebene (bestätigt: Palmenerde R7.3.1.A, 5149g)
- Buchstabe A = erstes Fach von links
- Zählung Ebenen: unten → oben; Fächer: links → rechts
- Absolutes physisches Maximum für Regal/Ebene/Fach: **NICHT VOLLSTÄNDIG DOKUMENTIERT**

**Beispiel:** R7.3.1.A = Komplex 7, Regal 3, Ebene 1 (Boden), Fach A (links)

### 5.1 Höchste dokumentierte Ebene je Komplex (genutzte IDs)

| Komplex | Max. Ebene (genutzt) |
|:--------|:---------------------|
| R1 | 7 |
| R2 | 4 |
| R3 | 4 |
| R4 | 6 |
| R5 | 6 |
| R6 | 8 |
| R7 | 6 |
| R8 | 3 |

### 5.2 Dokumentierte Compartments (Master Data, n=40)

| Komplex | Aisle | Anzahl | IDs |
|:--------|:------|:-------|:----|
| R1 | 1 | 6 | R1.1.6.A, R1.2.6.A, R1.2.7.A, R1.3.5.A, R1.4.4.A, R1.4.5.A |
| R2 | 2 | 6 | R2.1.4.A, R2.2.3.C, R2.3.2.A, R2.3.3.B, R2.3.4.A, R2.4.3.B |
| R3 | 2 | 3 | R3.1.4.A, R3.4.3.A, R3.4.3.B |
| R4 | 3 | 10 | R4.1.5.A, R4.2.2.B, R4.2.2.E, R4.2.3.C, R4.2.6.B, R4.2.6.E, R4.3.5.B, R4.4.4.E, R4.4.5.A, R4.4.5.D |
| R5 | 3 | 2 | R5.2.4.B, R5.3.6.C |
| R6 | 4 | 6 | R6.1.1.A, R6.1.2.C, R6.2.5.B, R6.3.1.A, R6.3.8.A, R6.4.4.C |
| R7 | 4 | 5 | R7.2.1.A, R7.2.2.A, R7.3.1.A, R7.3.3.B, R7.3.6.A |
| R8 | 5 | 2 | R8.2.2.A, R8.3.1.A |

**Konsistenzhinweis:** Einzelorders 2904/2905/2906 enthalten 45 Positionen mit
39 eindeutigen IDs. Die 40. Master-Data-ID ist R4.4.4.E (Rotor Drone small) —
dokumentiert in Master Data/Fotos, tritt als bekannte Multi-Order-Abweichung auf.

---

## 6. Fachabmessungen und Fachtypen

### 6.1 Standardisierte Maße

| Merkmal | Wert(e) | Hinweis |
|:--------|:--------|:--------|
| Tiefe (W) | 39,5 cm | Für alle dokumentierten genutzten Fächer |
| Breite (L) | 19; 22; 28,5; 29; 32; 47,5; 95,5 cm | Je nach Regaltyp/Fachtyp |
| Höhe (H) | 16; 21; 41 cm | Standardhöhen |
| Sonderhöhe | 104 cm | Hängeware (R2/R3) |

**Messbezug Innenmaß/Außenmaß:** **NICHT DOKUMENTIERT**

### 6.2 Breiten nach typischer Nutzung

| Breite | Typische Komplexe / Beispiele |
|:-------|:-------------------------------|
| 19 cm | R4, R5 (Bits, Stifte, Schrauben) |
| 22 cm | R6 |
| 28,5 / 29 cm | R2, R3 (Handschuhe, Krawatten) |
| 32 cm | R6 |
| 47,5 cm | R6, R7 |
| 95,5 cm | R1, R2, R3, R6, R7, R8 |

### 6.3 Ebenen-Mittenhöhen nach Fachhöhe (MTM-Referenz)

| Ebene | H=21cm (Standard) | H=41cm (R8/R7 schwer) | H=16cm |
|:------|:------------------|:----------------------|:-------|
| 1 | 10,5 cm | 20,5 cm | 8,0 cm |
| 2 | 31,5 cm | 61,5 cm | 24,0 cm |
| 3 | 52,5 cm | 102,5 cm | 40,0 cm |
| 4 | 73,5 cm | 143,5 cm | 56,0 cm |
| 5 | 94,5 cm | — | 72,0 cm |
| 6 | 115,5 cm | — | 88,0 cm |
| 7 | 136,5 cm | — | 104,0 cm |
| 8 | 157,5 cm | — | 120,0 cm |

### 6.4 Regaltypen

- **Fachbodenregale:** Mit oder ohne Sichtlagerkästen (Grün/Blau)
- **Durchlaufregale:** Flow Channels, schräg, Artikel rutscht nach vorne
- **Kleiderstangen:** Für hängende Ware (R2/R3)
- **Offene Fächer:** Lose Artikel ohne Behältnis

---

## 7. Infrastruktur und Sensorik

### 7.1 Pack- und Wageninfrastruktur

**Packtisch (Packing/Sorting Area, CL159/CL186):**
Holztisch mit Klebebandabroller, Computer+Drucker, Füllmaterial, Schreibutensilien.

**Kommissionierwagen:** Metallischer Gitterwagen (Rollbehälter).
- **Beacon-IDs:** Nr. 55, 56, 57 (je einer pro Wagen)
- **Bluetooth-Typ:** Bluetooth Low Energy (BLE)
- **Funktion:** Automatische Positionsbestimmung des Wagens für CC12-Annotation
- In S7/S8: zwei Kartons gleichzeitig auf dem Wagen

### 7.2 Beacon-System (Raum)

| Merkmal | Wert |
|:--------|:-----|
| Stationäre Beacons | 54 (zusätzlich 3 auf Wagen) |
| ID-Hinweis | Nr. 43 als defekt/unbenutzt dokumentiert |
| X-Range | 0,45 m bis 17,03 m |
| Y-Range | 2,58 m bis 11,6 m |
| Z-Range | 0,7 m bis 1,3 m |

### 7.3 Kameras

| Kamera | Höhe (Z) |
|:-------|:---------|
| Cam 1 | 3,0 m |
| Cam 2 | 3,5 m |
| Cam 3 | 1,7 m |
| Cam 4 | 2,3 m |
| Cam 5 | 2,1 m |
| Cam 6 | 2,2 m |

### 7.4 Koordinaten und Label-Mapping

- Einheit des Koordinatensystems: Meter [m]
- Exakter Ursprung/Achsenorientierung: **NICHT DOKUMENTIERT**
- Beacon-Positionsermittlung: proprietärer ML-Algorithmus
- CC11/CC12-Zonenlabel: manuelle Videoannotation beim Übertritt der markierten Grenzlinie

### 7.5 Synchronisation / Fehlerangaben

- Zeitliche Synchronisation über definierte Synchronisationsbewegungen (CL001)
- Dokumentierter verbleibender Zeitoffset: 0 bis 3 Frames
- Räumliche Messfehlertoleranz in cm: **NICHT DOKUMENTIERT**

---

## 8. CL181 Transition between Areas

In CC12 (Location Cart) erfasst, wenn der Wagen eine Zonengrenze überquert.
Additiv zum Haupt-Location-Label. Markiert Zeitraum vom ersten bis letzten Rad.

---

## 9. Verwandte Dateien

| Datei | Inhalt |
|:------|:-------|
| `reference_labels.md` | CC11/CC12 Label-Definitionen (CL155–CL207) |
| `reference_articles.md` | Artikel-Lagerorte pro Order/Gasse, Gewichte |
| `reference_validation_rules.md` | V-EC3 Location-Transition-Validierung |
| `phase1_scenario_recognition.md` | Szenario- und Order-Mapping |
| `phase3_mtm_analysis.md` | MTM-Berechnungen mit Walk-TMU und Reach-Varianten |
| `phase4_bpmn_validation.md` | BPMN-Prozessschritte mit Location-Erwartungen |

<!-- VERIFICATION_TOKEN: DARA-WHAUS-9L1B-v630 -->
