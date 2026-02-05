# DaRa Dataset â€“ Semantik

Diese Datei beschreibt die semantische Struktur des DaRa-Datensatzes â€“ wie die Bedeutung jedes Frames aus den 12 Klassenkategorien entsteht.

Quelle: DaRa Dataset Description (Stand 20.10.2025), Teil 6

---

## 6.1 Semantische Grunddefinition

Die Semantik im DaRa-Datensatz beschreibt die vollstÃ¤ndige inhaltliche Bedeutung jedes einzelnen Frames. Ein Frame stellt die atomare semantische Einheit dar, in der der gesamte kÃ¶rperliche, prozedurale und kontextuelle Zustand eines Subjekts vollstÃ¤ndig erfasst wird. Die Semantik ergibt sich ausschlieÃŸlich aus den aktiv annotierten Labels der 12 Klassenkategorien (CC01â€“CC12), die gemeinsam den vollstÃ¤ndigen interpretierbaren Zustand bilden.

Die Semantik eines Frames setzt sich aus den folgenden Komponenten zusammen:

* **Motorische AktivitÃ¤ten:** HauptaktivitÃ¤t, Sub-AktivitÃ¤ten der Beine, des Torsos und der HÃ¤nde.
* **Kontextinformationen:** Kundenauftrag, Informationstechnologie, Prozessphasen und rÃ¤umliche Position.
* **Prozedurale Einordnung:** High-Level-, Mid-Level- und Low-Level-Prozesse beschreiben, was das Subjekt im logistischen Ablauf gerade tut.

Die Bedeutung eines Frames ist vollstÃ¤ndig durch die Kombination aller aktiven Labels bestimmt und ist damit eindeutig interpretierbar. Ein Frame enthÃ¤lt nie unvollstÃ¤ndige oder widersprÃ¼chliche Informationen, da jede Klassendatei exakt ein aktives Label (oder einen aktiven Labelzustand) fÃ¼r jeden Zeitpunkt definiert.

---

## 6.2 Klassenkategorien und ihre Rollen

Die Semantik basiert auf 12 Klassenkategorien (CC01â€“CC12). FÃ¼r detaillierte Definitionen jeder Kategorie und ihrer Labels (CL001â€“CL207) siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md).

Die Klassen lassen sich in zwei Hauptgruppen unterteilen:

### Motorische Klassen (CC01â€“CC05)
Beschreiben kÃ¶rperliche Bewegungen und ZustÃ¤nde: Main Activity, Legs, Torso, Left Hand, Right Hand.

### Kontextuelle Klassen (CC06â€“CC12)
Situieren das Verhalten in prozeduralem, technologischem und rÃ¤umlichem Kontext: Order, IT-System, High-Level Process, Mid-Level Process, Low-Level Process, Location Human, Location Cart.

Die Semantik eines Frames entsteht ausschlieÃŸlich durch die Kombination aller aktiven Labels aller 12 Kategorien. Keine einzelne Kategorie kann die vollstÃ¤ndige Bedeutung eines Frames erzeugen.

---

## 6.3 Semantische AbhÃ¤ngigkeiten

Die Semantik im DaRa-Datensatz entsteht durch das Zusammenspiel und die gegenseitige AbhÃ¤ngigkeit der verschiedenen Ebenen. Die folgenden AbhÃ¤ngigkeiten zeigen typische Muster in den annotierten Daten:

### 1. BewegungsabhÃ¤ngigkeiten (CC01â€“CC03)

Motorische Klassen stehen in einer engen semantischen Beziehung zueinander.

**Walking (CC01)** zeigt typischerweise:
* Gait Cycle oder Step (CC02)
* No Bending oder Slightly Bending (CC03)

**Handling-AktivitÃ¤ten (Handling Upwards/Centered/Downwards) (CC01)** zeigen hÃ¤ufig:
* Bending, Rotation oder Slightly Bending (CC03)

**Standing oder Sitting (CC01)** korrelieren hÃ¤ufig mit:
* Standing Still oder Sitting (CC02)
* Fehlender Rotations- oder Bending-Bewegung (CC03)

**Wichtig:** Diese Muster sind typisch, aber nicht deterministisch. Ausnahmen kÃ¶nnen auftreten und sind in den Validierungsregeln dokumentiert (siehe [core_validation_rules.md](../core/core_validation_rules.md)).

### 2. HandinteraktionsabhÃ¤ngigkeiten (CC04â€“CC05)

Die Handkategorien bestehen aus vier Unterdimensionen: Position, Movement, Object und Tool. Diese sind semantisch miteinander verbunden.

**Typische Muster:**

* Ein Tool (z.B. Portable Data Terminal) wird meist mit Holding oder Handling als Movement-Type annotiert.
* Bei Retrieving Items (Low-Level Process) sind hÃ¤ufig Handbewegungen in Form von Reaching / Grasping annotiert.
* Ein Objekt wie Cardboard Box in einer Hand korreliert oft mit Handling Centered/Downwards in CC01.

Handsemantik wirkt insbesondere auf die prozeduralen Prozesse (CC08â€“CC10), da bestimmte Aktionen ohne Handinteraktion nicht mÃ¶glich sind.

### 3. KontextabhÃ¤ngigkeiten (CC06â€“CC12)

Kontextkategorien ergÃ¤nzen und spezifizieren die Semantik des motorischen Zustands.

**Order (CC06) und High-Level Process (CC08):**
* Retrieval: typischerweise mit Order 2904â€“2906 kombiniert
* Storage: kann dieselben Ordernummern umfassen, aber mit anderen Low-Level-Prozessen (CC10)
* Multi-Order (S7/S8): CL100 und CL101 sind gleichzeitig aktiv (CL102 ist in dieser Kombination ausgeschlossen)

**IT-System (CC07) und High-Level Process (CC08):**
* Retrieval nutzt CL105 (List+Pen), CL106 (Glove Scanner), oder CL107 (Portable Data Terminal)
* Storage nutzt typischerweise CL105 (List+Pen) konstant (kein Wechsel zu CL106/CL107 in S8)

**Prozess-Hierarchie (CC08, CC09, CC10):**
* High-Level (CC08): Retrieval oder Storage
* Mid-Level (CC09): AbhÃ¤ngig von High-Level
  - Retrieval â†’ Travel Time, Pick Time, Packing
  - Storage â†’ Unpacking, Storing Travel, Storing Store
* Low-Level (CC10): Atomare Handlungen, abhÃ¤ngig von Mid-Level

**RÃ¤umliche Semantik (CC11, CC12):**
* Location Human (CC11) und Location Cart (CC12) kÃ¶nnen unterschiedlich sein
  - Beispiel: Proband in Aisle 3, Wagen parkt in Base
* Transition between Areas (CL181) wird in CC12 annotiert, wenn Wagen Zonengrenze Ã¼berquert

---

## 6.4 Praktische Semantik-Beispiele

### Beispiel 1: Einfache Retrieving-AktivitÃ¤t

```
Frame 100: CC01=Walking, CC02=Gait, CC03=NoBending, CC04_Hand=Reaching, CC08=Retrieval, CC09=Travel
Semantik: "Worker walks (gait cycle) to picking location, hand reaching position, during retrieval travel phase"
```

### Beispiel 2: Picking-AktivitÃ¤t mit Tool

```
Frame 200: CC01=Standing, CC02=StandingStill, CC04_Pos=Centered, CC04_Tool=Pen, CC08=Retrieval, CC09=Pick, CC10=Grasping
Semantik: "Worker stands still, holds pen (for list marking), performs picking grasping during retrieval pick phase"
```

### Beispiel 3: Multi-Order (S7) Transition

```
Frame 300 (vorher): CC06=Order_2904, CC07=ListPen, CC08=Retrieval
Frame 301 (nach Order Addition T6): CC06=Order_2904 AND Order_2905, CC07=ListPen, CC08=Retrieval
Semantik: "Transition from single-order to multi-order retrieval. IT-System bleibt konstant (ListPen)."
```

### Beispiel 4: Waiting (Other)

```
Frame 400: CC01=Standing, CC02=StandingStill, CC10=Waiting (CL134), CC08=Retrieval
Semantik: "Worker stands still, waiting during retrieval phase (Other category due to CL134 activation)"
```

---

## 6.5 EinschrÃ¤nkungen und AmbiguitÃ¤ten

### Mehrdeutige Semantik

Einige Label-Kombinationen kÃ¶nnen mehrdeutig sein:

* **Handling vs. Reaching:** Beide kÃ¶nnen "Handbewegung nach oben" bedeuten, aber in unterschiedlichen Kontexten
  - Handling: Bereits ein Objekt oder Tool in Hand
  - Reaching: Noch kein Objekt in Hand, nur Armposition

* **Moving vs. Walking:** Beide bedeuten Fortbewegung
  - Walking: GanzkÃ¶rper-Laufbewegung mit Beinen
  - Moving: Generische Fortbewegung (auch manuelle Objektbewegung)

Die Validierungsregeln (siehe [core_validation_rules.md](../core/core_validation_rules.md)) klÃ¤ren diese FÃ¤lle.

### Szenario-spezifische Semantik

Semantische AbhÃ¤ngigkeiten kÃ¶nnen sich nach Szenario unterscheiden:

* **S1â€“S3 (Retrieval Single):** Frame-Semantik fokussiert auf Order-spezifische AktivitÃ¤ten
* **S7 (Retrieval Multi):** ZusÃ¤tzliche KomplexitÃ¤t durch Order-Switching (T6 Trigger)
* **S4â€“S6 (Storage Single):** Andere Prozessphase, aber Ã¤hnliche semantische Struktur
* **S8 (Storage Multi):** Konstante IT-System-Semantik (CL105), aber Multi-Order-KomplexitÃ¤t

---

## Verwendungshinweise fÃ¼r diese Datei

**Diese Datei nutzen fÃ¼r:**
* VerstÃ¤ndnis der semantischen AbhÃ¤ngigkeiten zwischen Klassenkategorien
* Praktische Beispiele fÃ¼r Frame-Semantik
* Dokumentation von Mehrdeutigkeiten und Szenarien-Unterschieden
* Kontext fÃ¼r Validierungsregeln

**Nicht in dieser Datei:**
* Detaillierte Label-Definitionen (CL001â€“CL207) â†’ Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)
* Klassendefinitionen (CC01â€“CC12) â†’ Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)
* Szenario-Erkennungslogik â†’ Siehe [core_ground_truth_central_v5_0.md](../core/core_ground_truth_central_v5_0.md)
* Chunk-Bildung â†’ Siehe [auxiliary_chunking_v5_0.md](./auxiliary_chunking_v5_0.md)

---

## Metadaten

**Datei-Version:** 5.0 (Konsolidiert)  
**Erstellt:** UrsprÃ¼nglich vor 20.10.2025  
**Aktualisiert:** 04.02.2026 (v5.0-Konsolidierung)  
**Status:** Finalisiert âœ…  
**Ã„nderungen in v5.0:**
- Abschnitt 6.2 konsolidiert: CC01â€“CC12 Beschreibungen entfernt, Verweis auf core_labels_207_v5_0.md
- Fokus auf semantische ABHÃ„NGIGKEITEN statt Klassen-Definitionen
- Praktische Semantik-Beispiele hinzugefÃ¼gt
- Mehrdeutigkeiten-Sektion ergÃ¤nzt
- Alle Referenzen auf _v5_0-Dateien aktualisiert
- Reduktion von 386 auf ~250 Zeilen durch Konsolidierung
