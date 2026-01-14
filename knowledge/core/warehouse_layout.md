# DaRa Dataset – Lagerlayout (Fraunhofer IML Picking Lab)

**Quelle:** DaRa Dataset Description (Stand 20.10.2025) + Lagerlayout-Dokumentation  
**Version:** 3.0 (14.01.2026)

---

## 1. Räumliche Abmessungen

- **Gesamtlänge Regalbereich:** 12,76 m
- **Gesamtlänge Bereich vor Hallentor:** 17,35 m
- **Breite Hallentor:** 3,29 m
- **Breite Regalblock (Gassen):** 4,09 m

---

## 2. Funktionale Hauptbereiche (9 Zonen)

| Zone | DaRa-Label (CC11 Human) | DaRa-Label (CC12 Cart) | Funktion |
|------|-------------------------|------------------------|----------|
| **Office** | CL155 | CL182 | Auftragsvergabe und -verwaltung |
| **Cart Area** | CL156 | CL183 | Abstell- und Bereitstellungsbereich für Kommissionierwagen |
| **Cardboard Box Area** | CL157 | CL184 | Entnahme leerer Kartonagen |
| **Base** | CL158 | CL185 | Zentraler Parkbereich des Wagens während Pick-Vorgang |
| **Packing / Sorting Area** | CL159 | CL186 | Verpacken und Sortieren der kommissionierten Artikel |
| **Issuing / Receiving Area** | CL160 | CL187 | Wareneingang und Warenausgang |
| **Path** | CL161 | CL188 | Verbindungswege zwischen Funktionsbereichen |
| **Cross Aisle Path** | CL162 | CL189 | Quergang vor den Regalgassen |
| **Aisle Path** | CL163 | CL190 | Kommissioniergassen innerhalb der Regalanlage |

**Zonengrenzen:**
- Physische Abgrenzung: Absperrständer mit Gurtbändern
- Konzeptionelle Abgrenzung: Bodenmarkierungen (Klebeband)

---

## 3. Gassen-System: 5 Aisles mit 8 Regalkomplexen

| Gasse | Regalkomplexe | DaRa-Label (CC11) | DaRa-Label (CC12) | Artikel-Typen |
|-------|---------------|-------------------|-------------------|---------------|
| **Aisle 1** | R1 | CL172 | CL199 | Kleinteile (Muttern, Schrauben, Unterlegscheiben) |
| **Aisle 2** | R2, R3 | CL173 | CL200 | Textilien (Jacken, Handschuhe, Hoodies) |
| **Aisle 3** | R4, R5 | CL174 | CL201 | Werkzeuge (Bits, Eiskratzer, Drohnen) |
| **Aisle 4** | R6, R7 | CL175 | CL202 | Schwere Güter (Bügelsäge, Handbeile, Palmenerde) |
| **Aisle 5** | R8 | CL176 | CL203 | Abschlussbereich (Handbeile, Sportgetränke) |

---

## 4. Gassen-Position (Front / Back)

**Position innerhalb einer Gasse:**
- **Front:** CL177 (Human), CL204 (Cart) – Vorderer Bereich der Gasse
- **Back:** CL178 (Human), CL205 (Cart) – Hinterer Bereich der Gasse

**Zweck:** Präzise Positionierung während der Kommissionierung

---

## 5. Cross Aisle Path – Abschnitte

**Quergang-Abschnitte zwischen Gassen:**

| Abschnitt | DaRa-Label (CC11 Human) | DaRa-Label (CC12 Cart) | Verbindung |
|-----------|-------------------------|------------------------|------------|
| **1-2** | CL168 | CL195 | Quergang zwischen Aisle 1 und Aisle 2 |
| **2-3** | CL169 | CL196 | Quergang zwischen Aisle 2 und Aisle 3 |
| **3-4** | CL170 | CL197 | Quergang zwischen Aisle 3 und Aisle 4 |
| **4-5** | CL171 | CL198 | Quergang zwischen Aisle 4 und Aisle 5 |

**Zweck:** Navigation zwischen Gassen ohne vollständige Durchquerung

---

## 6. Regalfächer (Compartments)

### Standardfächer
- **Maße:** 95,5 × 39,5 × 21 cm (Länge × Breite × Höhe)
- **Verwendung:** Kleinteile (Schrauben, Muttern, Unterlegscheiben, Bits)

### Spezialmaße

| Typ | Höhe | Verwendung |
|-----|------|------------|
| **Textilien** | 104 cm | Hängende Kleidung (Jacken, Hoodies) |
| **Schwere Güter** | 41 cm | Handbeile, Werkzeuge |
| **Flache Kartons** | 16 cm | Flache Lagergüter |
| **Schmale Fächer** | Breite 19-22 cm | Bits, Schreibwaren |

---

## 7. Storage Compartment ID – Hierarchie

**Format:** `R<Komplex>.<Regal>.<Ebene>.<Fach>`

### Beispiel: R1.2.7.A

| Komponente | Bedeutung | Beispiel-Wert |
|------------|-----------|---------------|
| **R1** | Regalkomplex (R1-R8) | Komplex 1 (Gasse 1) |
| **2** | Regalnummer innerhalb des Komplexes | Regal 2 |
| **7** | Ebene (vom Boden nach oben gezählt) | Ebene 7 |
| **A** | Fach (Buchstabe, von links nach rechts) | Fach A (linkstes Fach) |

### Wichtige Konventionen

- **Ebene 1 = Bodenebene**  
  Bestätigt durch Artikel wie:
  - Palmenerde (R7.3.1.A, 5149g)
  - Hand Axe Rhenish 1000g (R7.2.1.A)
  
- **Buchstabe A = Erstes Fach von links**
- **Zählrichtung:**
  - Ebenen: Von unten nach oben (1, 2, 3, ...)
  - Fächer: Von links nach rechts (A, B, C, ...)

---

## 8. Lagereinheiten (Lagermittel)

**Verschiedene Lagersysteme zur Abbildung realer Lagerbedingungen:**

- **Kleinladungsträger:** Für Kleinteile
- **Sichtlagerkästen:** Grün und blau (z.B. Regalkomplex 6)
- **Fächer ohne Behälter:** Lose Artikel
- **Kartons:** Verpackte Güter
- **Kleiderstangen mit Kleiderbügeln:** Textilien (Regalkomplex 2)
- **Durchlaufkanäle:** Für lose Artikel (Regalkomplex 3)

**Zweck:** Realitätsnahe Abbildung unterschiedlicher Lagersysteme

---

## 9. Analogie zur Verständnis-Erleichterung

**Storage Compartment ID als Postanschrift:**

| Komponente | Analogie | Beispiel |
|------------|----------|----------|
| Gasse | Straße | "Musterstraße" |
| Regalkomplex | Gebäude | "Haus Nr. 7" |
| Ebene | Stockwerk | "3. Stock" |
| Fach | Wohnungstür | "Tür A (links)" |

**Beispiel:** R7.3.1.A = "Musterstraße, Haus 7, Erdgeschoss, Tür A"

---

## Metadaten

**Datei-Version:** 1.0  
**Erstellt:** 14.01.2026  
**Quelle:** DaRa Dataset Description (Stand 20.10.2025), Lagerlayout-Dokumentation  
**Verwendung:** Referenz für Lagerlayout, Gassen-Struktur, Storage Compartment ID Logik
