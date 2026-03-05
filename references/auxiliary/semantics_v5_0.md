# DaRa Dataset – Semantik

Diese Datei beschreibt die semantische Struktur des DaRa-Datensatzes – wie die Bedeutung jedes Frames aus den 12 Klassenkategorien entsteht.

Quelle: DaRa Dataset Description (Stand 20.10.2025), Teil 6

---

## 6.1 Semantische Grunddefinition

Die Semantik im DaRa-Datensatz beschreibt die vollständige inhaltliche Bedeutung jedes einzelnen Frames. Ein Frame stellt die atomare semantische Einheit dar, in der der gesamte körperliche, prozedurale und kontextuelle Zustand eines Subjekts vollständig erfasst wird. Die Semantik ergibt sich ausschließlich aus den aktiv annotierten Labels der 12 Klassenkategorien (CC01–CC12), die gemeinsam den vollständigen interpretierbaren Zustand bilden.

Die Semantik eines Frames setzt sich aus den folgenden Komponenten zusammen:

* **Motorische Aktivitäten:** Hauptaktivität, Sub-Aktivitäten der Beine, des Torsos und der Hände.
* **Kontextinformationen:** Kundenauftrag, Informationstechnologie, Prozessphasen und räumliche Position.
* **Prozedurale Einordnung:** High-Level-, Mid-Level- und Low-Level-Prozesse beschreiben, was das Subjekt im logistischen Ablauf gerade tut.

Die Bedeutung eines Frames ist vollständig durch die Kombination aller aktiven Labels bestimmt und ist damit eindeutig interpretierbar. Ein Frame enthält nie unvollständige oder widersprüchliche Informationen, da jede Klassendatei exakt ein aktives Label (oder einen aktiven Labelzustand) für jeden Zeitpunkt definiert.

---

## 6.2 Klassenkategorien und ihre Rollen

Die Semantik basiert auf 12 Klassenkategorien (CC01–CC12). Für detaillierte Definitionen jeder Kategorie und ihrer Labels (CL001–CL207) siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md).

Die Klassen lassen sich in zwei Hauptgruppen unterteilen:

### Motorische Klassen (CC01–CC05)
Beschreiben körperliche Bewegungen und Zustände: Main Activity, Legs, Torso, Left Hand, Right Hand.

### Kontextuelle Klassen (CC06–CC12)
Situieren das Verhalten in prozeduralem, technologischem und räumlichem Kontext: Order, IT-System, High-Level Process, Mid-Level Process, Low-Level Process, Location Human, Location Cart.

Die Semantik eines Frames entsteht ausschließlich durch die Kombination aller aktiven Labels aller 12 Kategorien. Keine einzelne Kategorie kann die vollständige Bedeutung eines Frames erzeugen.

---

## 6.3 Semantische Abhängigkeiten

Die Semantik im DaRa-Datensatz entsteht durch das Zusammenspiel und die gegenseitige Abhängigkeit der verschiedenen Ebenen. Die folgenden Abhängigkeiten zeigen typische Muster in den annotierten Daten:

### 1. Bewegungsabhängigkeiten (CC01–CC03)

Motorische Klassen stehen in einer engen semantischen Beziehung zueinander.

**Walking (CC01)** zeigt typischerweise:
* Gait Cycle oder Step (CC02)
* No Bending oder Slightly Bending (CC03)

**Handling-Aktivitäten (Handling Upwards/Centered/Downwards) (CC01)** zeigen häufig:
* Bending, Rotation oder Slightly Bending (CC03)

**Standing oder Sitting (CC01)** korrelieren häufig mit:
* Standing Still oder Sitting (CC02)
* Fehlender Rotations- oder Bending-Bewegung (CC03)

**Wichtig:** Diese Muster sind typisch, aber nicht deterministisch. Ausnahmen können auftreten und sind in den Validierungsregeln dokumentiert (siehe [core_validation_rules.md](../core/core_validation_rules.md)).

### 2. Handinteraktionsabhängigkeiten (CC04–CC05)

Die Handkategorien bestehen aus vier Unterdimensionen: Position, Movement, Object und Tool. Diese sind semantisch miteinander verbunden.

**Typische Muster:**

* Ein Tool (z.B. Portable Data Terminal) wird meist mit Holding oder Handling als Movement-Type annotiert.
* Bei Retrieving Items (Low-Level Process) sind häufig Handbewegungen in Form von Reaching / Grasping annotiert.
* Ein Objekt wie Cardboard Box in einer Hand korreliert oft mit Handling Centered/Downwards in CC01.

Handsemantik wirkt insbesondere auf die prozeduralen Prozesse (CC08–CC10), da bestimmte Aktionen ohne Handinteraktion nicht möglich sind.

### 3. Kontextabhängigkeiten (CC06–CC12)

Kontextkategorien ergänzen und spezifizieren die Semantik des motorischen Zustands.

**Order (CC06) und High-Level Process (CC08):**
* Retrieval: typischerweise mit Order 2904–2906 kombiniert
* Storage: kann dieselben Ordernummern umfassen, aber mit anderen Low-Level-Prozessen (CC10)
* Multi-Order (S7/S8): CL100 und CL101 sind gleichzeitig aktiv (CL102 ist in dieser Kombination ausgeschlossen)

**IT-System (CC07) und High-Level Process (CC08):**
* Retrieval nutzt CL105 (List+Pen), CL106 (Glove Scanner), oder CL107 (Portable Data Terminal)
* Storage nutzt typischerweise CL105 (List+Pen) konstant (kein Wechsel zu CL106/CL107 in S8)

**Prozess-Hierarchie (CC08, CC09, CC10):**
* High-Level (CC08): Retrieval oder Storage
* Mid-Level (CC09): Abhängig von High-Level
  - Retrieval → Travel Time, Pick Time, Packing
  - Storage → Unpacking, Storing Travel, Storing Store
* Low-Level (CC10): Atomare Handlungen, abhängig von Mid-Level

**Räumliche Semantik (CC11, CC12):**
* Location Human (CC11) und Location Cart (CC12) können unterschiedlich sein
  - Beispiel: Proband in Aisle 3, Wagen parkt in Base
* Transition between Areas (CL181) wird in CC12 annotiert, wenn Wagen Zonengrenze überquert

---

## 6.4 Praktische Semantik-Beispiele

### Beispiel 1: Einfache Retrieving-Aktivität

```
Frame 100: CC01=Walking, CC02=Gait, CC03=NoBending, CC04_Hand=Reaching, CC08=Retrieval, CC09=Travel
Semantik: "Worker walks (gait cycle) to picking location, hand reaching position, during retrieval travel phase"
```

### Beispiel 2: Picking-Aktivität mit Tool

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

## 6.5 Einschränkungen und Ambiguitäten

### Mehrdeutige Semantik

Einige Label-Kombinationen können mehrdeutig sein:

* **Handling vs. Reaching:** Beide können "Handbewegung nach oben" bedeuten, aber in unterschiedlichen Kontexten
  - Handling: Bereits ein Objekt oder Tool in Hand
  - Reaching: Noch kein Objekt in Hand, nur Armposition

* **Moving vs. Walking:** Beide bedeuten Fortbewegung
  - Walking: Ganzkörper-Laufbewegung mit Beinen
  - Moving: Generische Fortbewegung (auch manuelle Objektbewegung)

Die Validierungsregeln (siehe [core_validation_rules.md](../core/core_validation_rules.md)) klären diese Fälle.

### Szenario-spezifische Semantik

Semantische Abhängigkeiten können sich nach Szenario unterscheiden:

* **S1–S3 (Retrieval Single):** Frame-Semantik fokussiert auf Order-spezifische Aktivitäten
* **S7 (Retrieval Multi):** Zusätzliche Komplexität durch Order-Switching (T6 Trigger)
* **S4–S6 (Storage Single):** Andere Prozessphase, aber ähnliche semantische Struktur
* **S8 (Storage Multi):** Konstante IT-System-Semantik (CL105), aber Multi-Order-Komplexität

---

## Verwendungshinweise für diese Datei

**Diese Datei nutzen für:**
* Verständnis der semantischen Abhängigkeiten zwischen Klassenkategorien
* Praktische Beispiele für Frame-Semantik
* Dokumentation von Mehrdeutigkeiten und Szenarien-Unterschieden
* Kontext für Validierungsregeln

**Nicht in dieser Datei:**
* Detaillierte Label-Definitionen (CL001–CL207) → Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)
* Klassendefinitionen (CC01–CC12) → Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)
* Szenario-Erkennungslogik → Siehe [core_ground_truth_central_v5_0.md](../core/core_ground_truth_central_v5_0.md)
* Chunk-Bildung → Siehe [auxiliary_chunking_v5_0.md](./auxiliary_chunking_v5_0.md)

---

## Metadaten

**Datei-Version:** 5.0 (Konsolidiert)  
**Erstellt:** Ursprünglich vor 20.10.2025  
**Aktualisiert:** 04.02.2026 (v5.0-Konsolidierung)  
**Status:** Finalisiert ✅  
**Änderungen in v5.0:**
- Abschnitt 6.2 konsolidiert: CC01–CC12 Beschreibungen entfernt, Verweis auf core_labels_207_v5_0.md
- Fokus auf semantische ABHÄNGIGKEITEN statt Klassen-Definitionen
- Praktische Semantik-Beispiele hinzugefügt
- Mehrdeutigkeiten-Sektion ergänzt
- Alle Referenzen auf _v5_0-Dateien aktualisiert
- Reduktion von 386 auf ~250 Zeilen durch Konsolidierung
