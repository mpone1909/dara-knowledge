# DaRa Dataset â€“ Physische Umgebung & Laboraufbau

**Zentrale Referenz fÃ¼r das Fraunhofer IML Picking Lab Layout**

**Quellen:** DaRa Dataset Description (Stand 20.10.2025) + Lagerlayout-Dokumentation  
**Version:** 5.0 (04.02.2026)

---

## 1. Ãœberblick: OMNI Warehouse (Fraunhofer IML Picking Lab)

Das Labor ("Picking Lab") am Fraunhofer IML bildet ein realitÃ¤tsnahes Lagerumfeld fÃ¼r die "Person-zur-Ware"-Kommissionierung ab. Das Layout ist in spezifische Zonen unterteilt, um einen vollstÃ¤ndigen Materialfluss von der Auftragsannahme bis zum Versand zu simulieren.

### Gesamtabmessungen

- **GesamtlÃ¤nge Regalbereich:** 12,76 m
- **GesamtlÃ¤nge Bereich vor Hallentor:** 17,35 m
- **Breite Hallentor:** 3,29 m
- **Breite Regalblock (Gassen):** 4,09 m

---

## 2. Neun Hauptbereiche (Funktionale Zonen)

Die Zonenaufteilung ist **farblich codiert** und durch **Bodenmarkierungen** (Klebeband und AbsperrstÃ¤nde) definiert.

| Zone | Funktion | DaRa-Label (CC11 Human) | DaRa-Label (CC12 Cart) |
|------|----------|------------------------|----------------------|
| **Office** | Auftragsannahme, RÃ¼ckgabe der Technik | CL155 | CL182 |
| **Cart Area** | Abstell- und Bereitstellungsbereich | CL156 | CL183 |
| **Cardboard Box Area** | Lagerort fÃ¼r leere Kartons | CL157 | CL184 |
| **Base** | Zentraler Parkbereich wÃ¤hrend Pick-Prozess | CL158 | CL185 |
| **Packing/Sorting Area** | Verpacken und Sortieren | CL159 | CL186 |
| **Issuing/Receiving Area** | Wareneingang und Warenausgang | CL160 | CL187 |
| **Path** | Verbindungswege zwischen Funktionsbereichen | CL161 | CL188 |
| **Cross Aisle Path** | Quergang vor den Regalgassen | CL162 | CL189 |
| **Aisle Path** | Kommissioniergassen innerhalb der Regalanlage | CL163 | CL190 |

### Zonengrenzen-Definition

- **Physische Abgrenzung:** AbsperrstÃ¤nde mit GurtbÃ¤ndern
- **Konzeptionelle Abgrenzung:** Bodenmarkierungen (Klebeband)

---

## 3. Regalsystem: 5 Aisles mit 8 Regalkomplexen

Das Lager besteht aus **acht Regalkomplexen**, die **fÃ¼nf Gassen (Aisles)** bilden. Die Gassen sind von links nach rechts durchnummeriert.

### Gassen-Ãœbersicht

| Gasse | Regalkomplexe | DaRa-Label (CC11) | DaRa-Label (CC12) | Artikel-Typen |
|-------|---------------|-------------------|-------------------|---------------|
| **Aisle 1** | R1 | CL172 | CL199 | Kleinteile (Muttern, Schrauben, Unterlegscheiben) |
| **Aisle 2** | R2, R3 | CL173 | CL200 | Textilien (Jacken, Handschuhe, Hoodies) |
| **Aisle 3** | R4, R5 | CL174 | CL201 | Werkzeuge (Bits, Eiskratzer, Drohnen) |
| **Aisle 4** | R6, R7 | CL175 | CL202 | Schwere GÃ¼ter (BÃ¼gelsÃ¤ge, Handbeile, Palmenerde) |
| **Aisle 5** | R8 | CL176 | CL203 | Abschlussbereich (Handbeile, SportgetrÃ¤nke) |

### Gassen-Definitionen (textlich)

- **Aisle 1:** Zwischen Wand/FreiflÃ¤che und Regal 1.
- **Aisle 2:** Zwischen Regal 2 und 3.
- **Aisle 3:** Zwischen Regal 4 und 5.
- **Aisle 4:** Zwischen Regal 6 und 7.
- **Aisle 5:** Neben Regal 8.

---

## 4. Gassen-Positionen: Front / Back

Innerhalb jeder Gasse wird zwischen zwei Positionen unterschieden:

| Position | DaRa-Label (CC11 Human) | DaRa-Label (CC12 Cart) | Beschreibung |
|----------|-------------------------|----------------------|--------------|
| **Front** | CL177 | CL204 | Vorderer Bereich der Gasse |
| **Back** | CL178 | CL205 | Hinterer Bereich der Gasse |

**Gangbreite:** 0,91 m (auf vorne und hinten verteilt)

**Zweck:** PrÃ¤zise Positionierung wÃ¤hrend der Kommissionierung

---

## 5. Cross Aisle Path â€“ Abschnitte

Der **Quergang (Cross Aisle Path)** verbindet alle Gassen miteinander. Er ist in vier Abschnitte unterteilt, die den ÃœbergÃ¤ngen zwischen benachbarten Gassen entsprechen.

| Abschnitt | DaRa-Label (CC11 Human) | DaRa-Label (CC12 Cart) | Verbindung |
|-----------|-------------------------|------------------------|------------|
| **1-2** | CL168 | CL195 | Quergang zwischen Aisle 1 und Aisle 2 |
| **2-3** | CL169 | CL196 | Quergang zwischen Aisle 2 und Aisle 3 |
| **3-4** | CL170 | CL197 | Quergang zwischen Aisle 3 und Aisle 4 |
| **4-5** | CL171 | CL198 | Quergang zwischen Aisle 4 und Aisle 5 |

---

## 6. Regalsystem & RegelfÃ¤cher (Compartments)

### Regaltypen

- **Fachbodenregale:** Mit SichtlagerkÃ¤sten (GrÃ¼n/Blau), z.B. Regalkomplex 6
- **Durchlaufregale:** Flow Channels fÃ¼r schnelle Entnahme (z.B. Regalkomplex 3)
- **Kleiderstangen:** FÃ¼r hÃ¤ngende Ware (Textilien, z.B. Regalkomplex 2)
- **Offene FÃ¤cher:** Lose Artikel ohne BehÃ¤ltnis

### StandardfÃ¤cher (Haupttyp)

| MaÃŸ | Wert | Verwendung |
|-----|------|-----------|
| **LÃ¤nge** | 95,5 cm | GroÃŸteile |
| **Breite (W)** | 39,5 cm | Standardtiefe |
| **HÃ¶he** | 21 cm | StandardhÃ¶he |

**Typische Artikel:** Kleine Teile (Schrauben, Muttern, Unterlegscheiben, Bits)

### SpezialfÃ¤cher (Varianten)

| Typ | HÃ¶he | Breite | Verwendung |
|-----|------|--------|-----------|
| **Textilien-FÃ¤cher** | 104 cm | 39,5 cm | HÃ¤ngende Kleidung (Jacken, Hoodies) |
| **Schwere-GÃ¼ter-FÃ¤cher** | 41 cm | 39,5 cm | Handbeile, schwere Werkzeuge |
| **Flache-Kartons-FÃ¤cher** | 16 cm | 39,5 cm | Flache LagergÃ¼ter |
| **Schmale-FÃ¤cher** | 21 cm | 19-22 cm | Bits, Schreibwaren |

---

## 7. Storage Compartment ID â€“ Hierarchische Kodierung

Die Identifikation von LagerfÃ¤chern folgt einem hierarchischen System: `R<Komplex>.<Regal>.<Ebene>.<Fach>`

### Format-Beispiel: R1.2.7.A

| Komponente | Bedeutung | Beispiel-Wert | Bereich |
|------------|-----------|---------------|---------|
| **R1** | Regalkomplex | 1 (aus Gasse 1) | R1â€“R8 |
| **2** | Regalnummer innerhalb des Komplexes | 2. Regal | 1â€“3 pro Komplex |
| **7** | Ebene (vom Boden nach oben gezÃ¤hlt) | 7. Ebene | 1+ (1 = Boden) |
| **A** | Fach (von links nach rechts) | Linkstes Fach | A, B, C, ... |

### Konventionen

- **Ebene 1 = Bodenebene** (bestÃ¤tigt durch Artikel wie Palmenerde R7.3.1.A mit 5149g)
- **Buchstabe A = Erstes Fach von links**
- **ZÃ¤hlrichtung Ebenen:** Von unten nach oben (1, 2, 3, ...)
- **ZÃ¤hlrichtung FÃ¤cher:** Von links nach rechts (A, B, C, ...)

### Analogie zur Veranschaulichung

| Komponente | Analogie | Beispiel |
|------------|----------|----------|
| Gasse | StraÃŸe | "MusterstraÃŸe" |
| Regalkomplex | GebÃ¤ude | "Haus Nr. 7" |
| Ebene | Stockwerk | "3. Stock" |
| Fach | WohnungstÃ¼r | "TÃ¼r A (links)" |

**Beispiel-Interpretation:** R7.3.1.A = "Gasse 4 (oder 5), Haus 7, Erdgeschoss, TÃ¼r A"

---

## 8. Lagereinheiten (Storage Media)

Das Labor nutzt verschiedene **Lagersysteme**, um reale Lagerbedingungen abzubilden:

- **KleinladungstrÃ¤ger:** FÃ¼r Kleinteile und strukturierte BestÃ¤nde
- **SichtlagerkÃ¤sten:** Farblich gekennzeichnet (GrÃ¼n, Blau), z.B. in Regalkomplex 6
- **FÃ¤cher ohne BehÃ¤lter:** Lose Artikel in offenen FÃ¤chern
- **Kartons:** Verpackte GÃ¼ter auf Paletten oder frei
- **Kleiderstangen mit KleiderbÃ¼geln:** FÃ¼r Textilien (Regalkomplex 2)
- **DurchlaufkanÃ¤le:** FÃ¼r lose Artikel mit Durchlaufprinzip (Regalkomplex 3)

**Zweck:** RealitÃ¤tsnahe Abbildung unterschiedlicher Lagersysteme und Handhabungsvarianten

---

## 9. Packtisch und Infrastruktur

### Packtisch (Packing/Sorting Area)

- **Material:** Holz
- **Standort:** Packing/Sorting Area (CL159 / CL186), hellblau markiert
- **Ausstattung:**
  - Klebebandabroller (mehrfach)
  - Computer mit Drucker
  - FÃ¼llmaterial-VorrÃ¤te (Polstermaterial, Papier)
  - Schreibutensilien

**Funktion:** Zentrale Verpackungs- und Sortierstelle fÃ¼r alle Szenarien

### Kommissionierwagen (Picking Cart)

- **Konstruktion:** Metallischer Gitterwagen (RollbehÃ¤lter)
- **TragfÃ¤higkeit:** Mehrere Ebenen fÃ¼r Kartons
- **Tracking:** Ausgestattet mit Bluetooth-Beacons (Nr. 55â€“57) zur separaten Ortung
- **Verwendung in S7/S8:** Zwei Kartons befinden sich gleichzeitig auf dem Wagen (Multi-Order)

**Funktion:** Sammelstelle fÃ¼r Kartons wÃ¤hrend des Pick-Prozesses

---

## 10. Operationale Strategien

### Return-Aisle-Strategie

Die **Return-Aisle-Strategie** ist das Standardvorgehen:

1. Proband parkt den Wagen an der **Base** (CL158)
2. Proband betritt die **Gasse (Aisle)** zu FuÃŸ **ohne Wagen**
3. Proband entnimmt die Ware
4. Proband kehrt zur **Base** zurÃ¼ck
5. Proband greift Wagen und fÃ¤hrt zur nÃ¤chsten Gasse

**Vorteile:** Reduzierte WendemanÃ¶ver, bessere Platznutzung in engen Gassen

### Transition between Areas (CL181)

Der Status **"Transition between Areas"** wird in **CC12 (Location Cart)** erfasst, wenn:

- Der Wagen eine Zonengrenze Ã¼berquert
- Der Wagen die Basisposition verlÃ¤sst
- Der Wagen eine neue Gasse ansteuert

**DaRa-Label:** CL181 (zusÃ¤tzlich zu Haupt-Location in CC12)

---

## 11. Zonenlogik und Datendefinitionen

### Zone-ID Mapping (Mensch vs. Wagen)

Jede Zone hat zwei separate Label-Sets:
- **CC11 (Location Human):** Wo sich die **Person** befindet
- **CC12 (Location Cart):** Wo sich der **Wagen** befindet

Diese kÃ¶nnen **unterschiedlich sein** (z.B. Proband in Aisle 3, Wagen in Base).

### Hierarchische Struktur der Location-Labels

```
Location (Human/Cart)
â”œâ”€â”€ Hauptbereich (Office, Base, Aisle, etc.)
â”‚   â”œâ”€â”€ Cross Aisle Abschnitte (1-2, 2-3, etc.)
â”‚   â”œâ”€â”€ Aisle-Nummer (1, 2, 3, 4, 5)
â”‚   â””â”€â”€ Position (Front, Back)
â””â”€â”€ Spezial-Labels
    â”œâ”€â”€ Another Location
    â””â”€â”€ Location Unknown
```

---

## 12. Cross-Referenzen

**FÃ¼r Probanden-Information:** Siehe [auxiliary_dataset_core_v5_0.md](./auxiliary_dataset_core_v5_0.md)

**FÃ¼r Session-Struktur:** Siehe [auxiliary_data_structure_v5_0.md](./auxiliary_data_structure_v5_0.md)

**FÃ¼r Klassendefinitionen:** Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)

**FÃ¼r Validierungsregeln:** Siehe core_validation_rules.md (noch nicht v5.0)

---

## Metadaten

**Datei-Version:** 5.0 (Versioniert)  
**Erstellt:** 19.01.2026 (Original)  
**Aktualisiert:** 04.02.2026 (v5.0-Versionierung)  
**Status:** Finalisiert âœ…  
**Bemerkung:** Inhaltlich unverÃ¤ndert gegenÃ¼ber v3.0. Nur Metadaten und Referenzen auf _v5_0-Dateien aktualisiert.
