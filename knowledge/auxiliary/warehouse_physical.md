# DaRa Dataset – Physische Umgebung & Laboraufbau

**Zentrale Referenz für das Fraunhofer IML Picking Lab Layout**

**Quellen:** DaRa Dataset Description (Stand 20.10.2025) + Lagerlayout-Dokumentation  
**Version:** 3.0 (19.01.2026)

---

## 1. Überblick: OMNI Warehouse (Fraunhofer IML Picking Lab)

Das Labor ("Picking Lab") am Fraunhofer IML bildet ein realitätsnahes Lagerumfeld für die "Person-zur-Ware"-Kommissionierung ab. Das Layout ist in spezifische Zonen unterteilt, um einen vollständigen Materialfluss von der Auftragsannahme bis zum Versand zu simulieren.

### Gesamtabmessungen

- **Gesamtlänge Regalbereich:** 12,76 m
- **Gesamtlänge Bereich vor Hallentor:** 17,35 m
- **Breite Hallentor:** 3,29 m
- **Breite Regalblock (Gassen):** 4,09 m

---

## 2. Neun Hauptbereiche (Funktionale Zonen)

Die Zonenaufteilung ist **farblich codiert** und durch **Bodenmarkierungen** (Klebeband und Absperrständer) definiert.

| Zone | Funktion | DaRa-Label (CC11 Human) | DaRa-Label (CC12 Cart) |
|------|----------|------------------------|----------------------|
| **Office** | Auftragsannahme, Rückgabe der Technik | CL155 | CL182 |
| **Cart Area** | Abstell- und Bereitstellungsbereich | CL156 | CL183 |
| **Cardboard Box Area** | Lagerort für leere Kartons | CL157 | CL184 |
| **Base** | Zentraler Parkbereich während Pick-Prozess | CL158 | CL185 |
| **Packing/Sorting Area** | Verpacken und Sortieren | CL159 | CL186 |
| **Issuing/Receiving Area** | Wareneingang und Warenausgang | CL160 | CL187 |
| **Path** | Verbindungswege zwischen Funktionsbereichen | CL161 | CL188 |
| **Cross Aisle Path** | Quergang vor den Regalgassen | CL162 | CL189 |
| **Aisle Path** | Kommissioniergassen innerhalb der Regalanlage | CL163 | CL190 |

### Zonengrenzen-Definition

- **Physische Abgrenzung:** Absperrständer mit Gurtbändern
- **Konzeptionelle Abgrenzung:** Bodenmarkierungen (Klebeband)

---

## 3. Regalsystem: 5 Aisles mit 8 Regalkomplexen

Das Lager besteht aus **acht Regalkomplexen**, die **fünf Gassen (Aisles)** bilden. Die Gassen sind von links nach rechts durchnummeriert.

### Gassen-Übersicht

| Gasse | Regalkomplexe | DaRa-Label (CC11) | DaRa-Label (CC12) | Artikel-Typen |
|-------|---------------|-------------------|-------------------|---------------|
| **Aisle 1** | R1 | CL172 | CL199 | Kleinteile (Muttern, Schrauben, Unterlegscheiben) |
| **Aisle 2** | R2, R3 | CL173 | CL200 | Textilien (Jacken, Handschuhe, Hoodies) |
| **Aisle 3** | R4, R5 | CL174 | CL201 | Werkzeuge (Bits, Eiskratzer, Drohnen) |
| **Aisle 4** | R6, R7 | CL175 | CL202 | Schwere Güter (Bügelsäge, Handbeile, Palmenerde) |
| **Aisle 5** | R8 | CL176 | CL203 | Abschlussbereich (Handbeile, Sportgetränke) |

### Gassen-Definitionen (textlich)

- **Aisle 1:** Zwischen Wand/Freifläche und Regal 1.
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

**Zweck:** Präzise Positionierung während der Kommissionierung

---

## 5. Cross Aisle Path – Abschnitte

Der **Quergang (Cross Aisle Path)** verbindet alle Gassen miteinander. Er ist in vier Abschnitte unterteilt, die den Übergängen zwischen benachbarten Gassen entsprechen.

| Abschnitt | DaRa-Label (CC11 Human) | DaRa-Label (CC12 Cart) | Verbindung |
|-----------|-------------------------|------------------------|------------|
| **1-2** | CL168 | CL195 | Quergang zwischen Aisle 1 und Aisle 2 |
| **2-3** | CL169 | CL196 | Quergang zwischen Aisle 2 und Aisle 3 |
| **3-4** | CL170 | CL197 | Quergang zwischen Aisle 3 und Aisle 4 |
| **4-5** | CL171 | CL198 | Quergang zwischen Aisle 4 und Aisle 5 |

---

## 6. Regalsystem & Regalfächer (Compartments)

### Regaltypen

- **Fachbodenregale:** Mit Sichtlagerkästen (Grün/Blau), z.B. Regalkomplex 6
- **Durchlaufregale:** Flow Channels für schnelle Entnahme (z.B. Regalkomplex 3)
- **Kleiderstangen:** Für hängende Ware (Textilien, z.B. Regalkomplex 2)
- **Offene Fächer:** Lose Artikel ohne Behältnis

### Standardfächer (Haupttyp)

| Maß | Wert | Verwendung |
|-----|------|-----------|
| **Länge** | 95,5 cm | Großteile |
| **Breite (W)** | 39,5 cm | Standardtiefe |
| **Höhe** | 21 cm | Standardhöhe |

**Typische Artikel:** Kleine Teile (Schrauben, Muttern, Unterlegscheiben, Bits)

### Spezialfächer (Varianten)

| Typ | Höhe | Breite | Verwendung |
|-----|------|--------|-----------|
| **Textilien-Fächer** | 104 cm | 39,5 cm | Hängende Kleidung (Jacken, Hoodies) |
| **Schwere-Güter-Fächer** | 41 cm | 39,5 cm | Handbeile, schwere Werkzeuge |
| **Flache-Kartons-Fächer** | 16 cm | 39,5 cm | Flache Lagergüter |
| **Schmale-Fächer** | 21 cm | 19-22 cm | Bits, Schreibwaren |

---

## 7. Storage Compartment ID – Hierarchische Kodierung

Die Identifikation von Lagerfächern folgt einem hierarchischen System: `R<Komplex>.<Regal>.<Ebene>.<Fach>`

### Format-Beispiel: R1.2.7.A

| Komponente | Bedeutung | Beispiel-Wert | Bereich |
|------------|-----------|---------------|---------|
| **R1** | Regalkomplex | 1 (aus Gasse 1) | R1–R8 |
| **2** | Regalnummer innerhalb des Komplexes | 2. Regal | 1–3 pro Komplex |
| **7** | Ebene (vom Boden nach oben gezählt) | 7. Ebene | 1+ (1 = Boden) |
| **A** | Fach (von links nach rechts) | Linkstes Fach | A, B, C, ... |

### Konventionen

- **Ebene 1 = Bodenebene** (bestätigt durch Artikel wie Palmenerde R7.3.1.A mit 5149g)
- **Buchstabe A = Erstes Fach von links**
- **Zählrichtung Ebenen:** Von unten nach oben (1, 2, 3, ...)
- **Zählrichtung Fächer:** Von links nach rechts (A, B, C, ...)

### Analogie zur Veranschaulichung

| Komponente | Analogie | Beispiel |
|------------|----------|----------|
| Gasse | Straße | "Musterstraße" |
| Regalkomplex | Gebäude | "Haus Nr. 7" |
| Ebene | Stockwerk | "3. Stock" |
| Fach | Wohnungstür | "Tür A (links)" |

**Beispiel-Interpretation:** R7.3.1.A = "Gasse 4 (oder 5), Haus 7, Erdgeschoss, Tür A"

---

## 8. Lagereinheiten (Storage Media)

Das Labor nutzt verschiedene **Lagersysteme**, um reale Lagerbedingungen abzubilden:

- **Kleinladungsträger:** Für Kleinteile und strukturierte Bestände
- **Sichtlagerkästen:** Farblich gekennzeichnet (Grün, Blau), z.B. in Regalkomplex 6
- **Fächer ohne Behälter:** Lose Artikel in offenen Fächern
- **Kartons:** Verpackte Güter auf Paletten oder frei
- **Kleiderstangen mit Kleiderbügeln:** Für Textilien (Regalkomplex 2)
- **Durchlaufkanäle:** Für lose Artikel mit Durchlaufprinzip (Regalkomplex 3)

**Zweck:** Realitätsnahe Abbildung unterschiedlicher Lagersysteme und Handhabungsvarianten

---

## 9. Packtisch und Infrastruktur

### Packtisch (Packing/Sorting Area)

- **Material:** Holz
- **Standort:** Packing/Sorting Area (CL159 / CL186), hellblau markiert
- **Ausstattung:**
  - Klebebandabroller (mehrfach)
  - Computer mit Drucker
  - Füllmaterial-Vorräte (Polstermaterial, Papier)
  - Schreibutensilien

**Funktion:** Zentrale Verpackungs- und Sortierstelle für alle Szenarien

### Kommissionierwagen (Picking Cart)

- **Konstruktion:** Metallischer Gitterwagen (Rollbehälter)
- **Tragfähigkeit:** Mehrere Ebenen für Kartons
- **Tracking:** Ausgestattet mit Bluetooth-Beacons (Nr. 55–57) zur separaten Ortung
- **Verwendung in S7/S8:** Zwei Kartons befinden sich gleichzeitig auf dem Wagen (Multi-Order)

**Funktion:** Sammelstelle für Kartons während des Pick-Prozesses

---

## 10. Operationale Strategien

### Return-Aisle-Strategie

Die **Return-Aisle-Strategie** ist das Standardvorgehen:

1. Proband parkt den Wagen an der **Base** (CL158)
2. Proband betritt die **Gasse (Aisle)** zu Fuß **ohne Wagen**
3. Proband entnimmt die Ware
4. Proband kehrt zur **Base** zurück
5. Proband greift Wagen und fährt zur nächsten Gasse

**Vorteile:** Reduzierte Wendemanöver, bessere Platznutzung in engen Gassen

### Transition between Areas (CL181)

Der Status **"Transition between Areas"** wird in **CC12 (Location Cart)** erfasst, wenn:

- Der Wagen eine Zonengrenze überquert
- Der Wagen die Basisposition verlässt
- Der Wagen eine neue Gasse ansteuert

**DaRa-Label:** CL181 (zusätzlich zu Haupt-Location in CC12)

---

## 11. Zonenlogik und Datendefinitionen

### Zone-ID Mapping (Mensch vs. Wagen)

Jede Zone hat zwei separate Label-Sets:
- **CC11 (Location Human):** Wo sich die **Person** befindet
- **CC12 (Location Cart):** Wo sich der **Wagen** befindet

Diese können **unterschiedlich sein** (z.B. Proband in Aisle 3, Wagen in Base).

### Hierarchische Struktur der Location-Labels

```
Location (Human/Cart)
├── Hauptbereich (Office, Base, Aisle, etc.)
│   ├── Cross Aisle Abschnitte (1-2, 2-3, etc.)
│   ├── Aisle-Nummer (1, 2, 3, 4, 5)
│   └── Position (Front, Back)
└── Spezial-Labels
    ├── Another Location
    └── Location Unknown
```

---

## 12. Cross-Referenzen

**Für Probanden-Information:** Siehe [dataset_core.md](dataset_core.md#14-probanden-subjects-s01-s18)

**Für Session-Struktur:** Siehe [data_structure.md](data_structure.md#52-sessions)

**Für Klassendefinitionen:** Siehe [labels_207.md](../core/labels_207.md)

**Für Validierungsregeln:** Siehe [validation_rules.md](../core/validation_rules.md)

---

## Metadaten

**Datei-Version:** 1.0 (Konsolidiert)  
**Erstellt:** 19.01.2026  
**Status:** Finale Version ✅  
**Ersetzt:** Kapitel 1.2–1.3 aus dataset_core.md, warehouse_layout.md (technische Details)
