# DaRa Dataset – Szenarien (S1-S8)

Diese Datei beschreibt die **8 Szenarien** des DaRa-Datensatzes – die übergeordneten Arbeitsabläufe, die aus Chunks und Prozessen bestehen.

**Quelle:** DaRa Dataset Description (Stand 20.10.2025), Teil 2 & 5

---

## Überblick: Die 8 Szenarien

Der DaRa-Datensatz umfasst **8 definierte Szenarien (S1–S8)**, die verschiedene logistische Arbeitsabläufe im Warehouse-Kontext abbilden:

### Retrieval-Szenarien (Kommissionierung)


- **S1** – Standard Retrieval
- **S2** – Variant Retrieval
- **S3** – Error Retrieval
- **S7** – Multi-Order Retrieval Perfect Run

### Storage-Szenarien (Einlagerung)


- **S4** – Standard Storage (Order 2904)
- **S5** – Variant Storage (Order 2905)
- **S6** – Storage (Order 2906)
- **S8** – Multi-Order Storage Perfect Run (Orders 2904 + 2905)

---

## Szenario-Eigenschaften

### 1. Szenarien sind übergeordnete semantische Einheiten

Szenarien repräsentieren **vollständige Arbeitsabläufe**, die aus:

- vielen Chunks bestehen,
- mehrere Prozessebenen umfassen (High-Level, Mid-Level, Low-Level),
- charakteristische Bewegungs- und Interaktionsmuster aufweisen,
- klar definierte räumliche Strukturen haben.

### 2. Szenarien sind eindeutig durch Prozesse definiert

Jedes Szenario besitzt eine **charakteristische Prozessarchitektur**:

- Ein oder mehrere High-Level-Prozesse (CC08)
- Typische Sequenzen von Mid-Level-Prozessen (CC09)
- Charakteristische Low-Level-Prozessschritte (CC10)

Die Szenariozuordnung ist immer eindeutig nachvollziehbar.

### 3. Szenarien enthalten typische Bewegungs- und Tool-Muster

Jedes Szenario besitzt charakteristische Aktivitätskombinationen:

- **Retrieval** umfasst typische Pick- und Travel-Time-Muster, häufiges Bending, Scanning und Tool-Nutzung.
- **Storage** umfasst Unpacking-, Store-Time- und Transportphasen.
- **Packaging/Sorting** enthält Interaktionen mit Kartonagen, Werkzeugen (z. B. Tape Dispenser, Knife) und Sortierflächen.
- **Perfect Runs (S7/S8)** enthalten idealtypische, vollkommen fehlerfreie Bewegungs- und Prozessfolgen.

### 4. Szenarien strukturieren die räumliche Semantik

Bestimmte räumliche Bereiche sind szenariotypisch häufiger vertreten:

- **Retrieval:** häufig Aisle Paths, Racks, Base
- **Storage:** häufig die Lagerbereiche, Zonen für Unpacking und Store Time
- **Packaging/Sorting:** Stationäre Bereiche wie Tables, Packing Area

### 5. Szenarien bestehen aus Sequenzen von Chunks

Die Chunk-Struktur definiert:

- wie ein Szenario zeitlich aufgebaut ist,
- wo Szenarien beginnen und enden,
- welche Aktivitäts- und Prozesskomponenten stabil bleiben oder wechseln.

Szenarien können aus wenigen oder vielen Chunks bestehen – abhängig von der Komplexität des Ablaufs.

### 6. Szenarien sind klar voneinander abgegrenzt

Ein Szenariowechsel ist immer verbunden mit:

- Prozesswechsel (High-Level und/oder Mid-Level),
- typischen Aktivitätsmustern,
- typischen räumlichen Veränderungen,
- eindeutigen semantischen Übergängen.

Szenarien überlappen sich nicht und sind logisch, prozedural und räumlich getrennt.

---

## Szenariogrenzen und Chunk-Bezug

Die Grenzen eines Szenarios im DaRa-Datensatz sind klar und eindeutig definiert und ergeben sich vollständig aus den annotierten semantischen Strukturen.

### 1. Szenarien beginnen und enden immer an Chunk-Grenzen

Da Chunks die kleinste bedeutungsstabile Einheit darstellen, kann ein Szenario nur an einer Stelle beginnen oder enden, an der sich die semantische Struktur eindeutig ändert. Dies erfolgt immer durch einen Trigger (T1–T10), der einen Chunk-Wechsel auslöst.

Ein Szenariowechsel tritt also nur in Verbindung mit einem **Chunk-Wechsel** auf.

### 2. Chunk-Wechsel bestimmen die internen Phasen eines Szenarios

Innerhalb eines Szenarios bilden Chunks die zeitliche Mikrostruktur:

- Jeder Chunk hat eine semantische Stabilität.
- Der Wechsel eines semantischen Merkmals löst einen neuen Chunk aus.
- Szenarien bestehen aus einer Sequenz solcher stabilen Zustände.

### 3. Szenariogrenzen spiegeln semantische Änderungen wider

Ein Szenariowechsel kann sich äußern durch:

- Wechsel des High-Level-Processes (z. B. Retrieval → Storage),
- Wechsel der Mid-Level-Prozesse (z. B. Pick Time → Packing → Unpacking),
- Änderungen der Bewegungsstruktur (z. B. Walking → Stationäre Tätigkeiten),
- Wechsel des räumlichen Kontexts (z. B. Aisle Path → Packaging Area),
- vollständige Änderung der Tool-/Objekt-Semantik,
- Änderung oder Abschluss eines Orders (CC06),
- Strukturwechsel in Multi-Order-Szenarien (S7/S8).

### 4. Szenarien überlappen sich nicht

Szenarien können nicht gleichzeitig aktiv sein. Auch wenn mehrere Subjekte parallel aufgezeichnet werden, hat jedes Subjekt:

- einen eindeutigen, linearen Szenarioverlauf,
- eine eindeutige Chunk-Abfolge,
- klar definierbare Start- und Endpunkte.

### 5. Szenariogrenzen hängen nicht von zeitlichen Faktoren ab

Szenarien werden **nicht** definiert durch:

- eine bestimmte minimale oder maximale Dauer,
- ein festes Zeitfenster,
- die Anzahl der Frames.

Die Dauer eines Szenarios ergibt sich ausschließlich aus der Länge der zugehörigen Chunk-Abfolge.

**Hinweis:** Obwohl Szenarien nicht über Zeit definiert werden, weisen sie in der praktischen Aufzeichnung unterschiedliche Gesamtdauern und Framezahlen auf. Diese Unterschiede entstehen aus:

- der real beobachteten Ausführungszeit der Tätigkeit pro Proband,
- individuellen Bewegungsabläufen,
- variierenden Wegstrecken,
- unterschiedlich langen prozeduralen Schleifen (z. B. Pick Travel Time).

---

## Szenariospezifische Prozesslogik

Die Prozesslogik definiert das prozedurale Grundgerüst jedes Szenarios im DaRa-Datensatz. Sie entsteht vollständig aus den annotierten Prozessklassen (CC08 High-Level Process, CC09 Mid-Level Process, CC10 Low-Level Process).

### 1. Prozesslogik der Retrieval-Szenarien (S1, S2, S3, S7)

Alle Retrieval-Szenarien folgen dem gleichen übergeordneten Prozesspfad:

- **High-Level:** Retrieval (CL110)
- **Mid-Level:** typische Sequenzen wie Preparing Order, Picking – Travel Time, Picking – Pick Time, Finalizing Order
- **Low-Level:** atomare Schritte wie Moving to the Next Position, Retrieving Items, Scanning, Placing Items, Transportphasen

Die Retrieval-Prozesslogik umfasst typischerweise:

- Bewegungen entlang von Aisle Paths,
- Identifikation und Finden von Items am Rack,
- Scanning der Lagerkompartimente und Items,
- Confirming-Aktivitäten (Pen, Screen, Button),
- Transport des Items zurück zur Base,
- Ablegen auf dem Cart.

**Besonderheiten:**

- **S3:** Zusätzliche Fehler- und Korrekturphasen
- **S7 (Perfect Run):** Alle Schritte folgen idealtypisch, ohne Unterbrechungen oder Abweichungen

### 2. Prozesslogik der Storage-Szenarien (S4, S5, S8)

Storage-Szenarien folgen dem Storage-Pfad:

- **High-Level:** Storage (CL111)
- **Mid-Level:** Sequenzen wie Unpacking, Storing – Travel Time, Storing – Store Time
- **Low-Level:** atomare Schritte wie Opening Cardboard Box, Removing Filling Material, Placing Items on a Rack, Returning Hardware

Storage umfasst typischerweise:

- Transport der Materialien zu ihrem Einlagerungsort,
- Öffnen und Vorbereiten von Kartons,
- Einlagerung in Regalfächer,
- Sortiertätigkeiten,
- Transport zurück zur Base.

**Besonderheiten:**

- **S8 (Perfect Run):** Mehrere Orders in idealer Storage-Prozesslogik ohne Fehler

### 3. Prozesslogik von S6 (Storage mit Order 2906)

S6 ist ein Storage-Szenario mit Order 2906:

- **High-Level:** Storage (CL111)
- **Mid-Level:** Unpacking, Store Travel Time, Store Time
- **Low-Level:** Öffnen, Platzieren, Sortieren, Rückführen

S6 unterscheidet sich von S4 und S5 nur durch den Order (2906 statt 2904/2905).

### 4. Prozesskonsistenz innerhalb eines Szenarios

Für jedes Szenario gilt:

- High-Level Process bleibt stabil innerhalb eines Szenarios.
- Mid-Level Prozesse wechseln je nach Phase, aber folgen einem klaren Pfad.
- Low-Level Prozesse definieren die Feinstruktur der Tätigkeiten.

Ein Szenario ist erst abgeschlossen, wenn die logische Prozesskette vollständig durchlaufen wurde.

---

## Multi-Order-Szenarien: S7 & S8 (Perfect Runs)

Die Perfect-Run-Szenarien S7 und S8 sind besondere, umfangreiche Szenarien, die mehrere Orders innerhalb eines einzigen, fehlerfreien Ablaufs umfassen.

### Charakteristika von S7 – Multi-Order Retrieval Perfect Run

S7 bildet die perfekte Kommissionierung mehrerer Aufträge ab.

#### Prozessmerkmale


- **High-Level:** Retrieval (CL110)
- **Mid-Level:** Preparing, Travel Time, Pick Time, Finalizing
- **Low-Level:** Moving, Retrieving, Scanning, Confirming, Placing
- vollständig fehlerfrei, idealtypischer Prozessablauf

#### Bewegungs- und Objektinteraktionen


- ausgedehnte Wegstrecken (Walking, Gait Cycle)
- wiederholtes Bending beim Greifen und Scannen
- konsistente Tool-Nutzung (PDT, Scanner, Pen)
- wiederholte Item-Retrieval-Zyklen
- konsistente Bending-Muster beim Scannen (CL024–CL026)

#### Kontext- und Orderstruktur


- mehrere Orders (z. B. CL100–CL102) innerhalb eines zusammenhängenden Retrieval-Prozesses
- klare räumliche Struktur: Base → Aisle Path → Rack → Base → Rack → …
- Cart bleibt semantisch korrekt mitgeführt oder platziert (CC12)

#### Chunk-Logik


- viele kurze Chunks durch wiederkehrende Pick-Zyklen
- stabile Wiederholung typischer Retrieval-Muster
- Szenario endet erst nach finalem Abschluss aller Orders

---

### Charakteristika von S8 – Multi-Order Storage Perfect Run

S8 bildet die perfekte Einlagerung mehrerer Aufträge ab.

#### Prozessmerkmale


- **High-Level:** Storage (CL111)
- **Mid-Level:** Unpacking, Store Travel Time, Store Time
- **Low-Level:** Öffnen, Platzieren, Sortieren, Rückführen
- vollständig fehlerfrei, idealtypischer Prozessablauf

#### Bewegungs- und Objektinteraktionen


- verstärkte stationäre Phasen (Standing, Strong Bending)
- intensive Karton- und Objektmanipulation (CL047, CL082)
- Nutzung typischer Storage-Tools (Knife, Tape Dispenser)
- konsistente Sequenzen aus Öffnen → Entnehmen → Einlagern → Transportieren

#### Kontext- und Orderstruktur


- mehrere Orders in einem durchgehenden Storage-Zyklus
- klar definierte Storage-Bereiche (Cardboard Box Area, Storage Location Zones)
- geordnete Sequenzierung ohne Unterbrechung oder Prozesssprung

#### Chunk-Logik


- hohe Anzahl an Chunks aufgrund von Unpacking- und Storage-Mikroaktionen
- klar strukturierte Phasen ohne semantische Abweichungen

---

### Gemeinsame Merkmale von S7 & S8

- perfekte Szenarien ohne Fehler
- Multi-Order-Sequenzen innerhalb eines einzigen Szenarioblocks
- hohe strukturelle Konsistenz
- klare semantische Übergänge ausschließlich innerhalb desselben Prozesspfads
- umfangreiche Chunk-Sequenzen

### Bedeutung der Multi-Order-Szenarien

S7 und S8 dienen im Datensatz als:

- Referenz für ideale Prozessausführung
- Grundlage für Benchmarking von Erkennungsmodellen
- Strukturbeispiele für extrem konsistente Sequenzen
- Beispiele für lange, stabile Sessions mit hoher semantischer Dichte

Diese Szenarien sind somit zentrale Bestandteile der Datensatzqualität und bieten die vollständigsten, saubersten und am stärksten strukturierten Prozessabläufe.

---

## Grenzen der Szenariendefinition

Die Definition der Szenarien im DaRa-Datensatz ist vollständig dokumentiert, semantisch eindeutig und streng regelbasiert. Gleichzeitig weist sie klar abgegrenzte Grenzen auf.

### 1. Szenarien enthalten keine nicht annotierten Informationen

Szenarien basieren vollständig auf den annotierten Klassen CC01–CC12. Es werden keine zusätzlichen Abläufe, Bedeutungen oder Prozessanteile ergänzt, die nicht in den Annotationen enthalten sind.

### 2. Szenarien definieren keine psychologischen oder subjektiven Aspekte

Die Szenariendefinition beschreibt ausschließlich:

- Bewegungen,
- Prozesse,
- Objekt- und Tool-Interaktionen,
- räumliche Positionen,
- kontextuelle Rahmenbedingungen.

Nicht Bestandteil der Szenarien sind:

- Ziele des Subjekts,
- subjektive Intentionen,
- Effizienzüberlegungen,
- Strategien,
- hypothetische Alternativen.

### 3. Szenarien beinhalten keine modellbasierten Strukturannahmen

Es werden keine:

- statistischen Zusammenhänge,
- Übergangswahrscheinlichkeiten,
- algorithmischen Muster,
- modellierten Prozesspfade in die Szenariendefinition aufgenommen.

### 4. Szenarien enthalten keine externen Wissensinhalte

Externe Informationen über Logistikprozesse, industrielle Best Practices oder ergonomische Prinzipien fließen nicht ein. Szenarien bestehen ausschließlich aus den annotierten, beobachteten und dokumentierten Abläufen.

### 5. Szenarien gehen nicht über die definierten Prozesspfade hinaus

Die Szenarien verwenden ausschließlich die dokumentierten Prozesskategorien:

- Retrieval (CL110),
- Storage (CL111),
- Packaging/Sorting (CL118 im Mid-Level-Kontext),
- deren zugehörige Mid-Level- und Low-Level-Prozesse.

### 6. Szenarien beinhalten keine impliziten Ortswechsel ohne Annotation

Ein Wechsel des räumlichen Bereichs (z. B. Office → Aisle Path) ist nur Teil des Szenarios, wenn die entsprechenden Location-Labels gesetzt sind.

### 7. Szenarien enthalten keine künstlichen Übergänge

Ein Szenariowechsel erfolgt ausschließlich:

- durch annotierte Prozessänderungen,
- durch eindeutige Chunk-Wechsel,
- durch strukturierte Änderungen der Semantik.

Szenarien werden niemals:

- zusammengefasst,
- verkürzt,
- generalisiert,
- auf künstliche Weise reorganisiert.

### 8. Szenarien enthalten keine generierten Fehlerzustände

Wenn Fehler auftreten (z. B. in S3), dann nur, weil sie:

- real ausgeführt,
- annotiert,
- im Datensatz dokumentiert wurden.

### 9. Szenarien haben keine künstlich erzeugte Dauer

Szenarien besitzen unterschiedliche reale Dauer und Frameanzahl pro Proband. Diese Unterschiede resultieren aus realer Ausführung, nicht aus Szenariodefinition.

---

## Verwendungshinweise

**Diese Datei nutzen für:**

- Verständnis der Szenario-Struktur
- Unterschiede zwischen S1-S8
- Prozesslogik pro Szenario
- Multi-Order-Szenarien (S7, S8)

**Nicht in dieser Datei:**

- Label-Definitionen → Siehe `class_hierarchy.md`
- Chunking-Logik → Siehe `chunking.md`
- BPMN-Prozesslogik → Siehe `dataset_core.md`
- Semantik-Details → Siehe `semantics.md`

---

## Zusammenfassung: Szenario-Übersicht

| Szenario | Typ | High-Level | Order | IT | Charakteristik |
|----------|-----|------------|-------|-----|----------------|
| S1 | Retrieval | CL110 | 2904 (CL100) | Pen (CL105) | Standard-Kommissionierung |
| S2 | Retrieval | CL110 | 2905 (CL101) | **PDT (CL107)** | Variante mit PDT |
| S3 | Retrieval | CL110 | 2906 (CL102) | **Scanner (CL106)** | Fehlerhafte Kommissionierung |
| S4 | Storage | CL111 | 2904 (CL100) | Pen (CL105) | Standard-Einlagerung |
| S5 | Storage | CL111 | 2905 (CL101) | Pen (CL105) | Variante der Einlagerung |
| S6 | Storage | CL111 | 2906 (CL102) | Pen (CL105) | Einlagerung mit Order 2906 |
| S7 | Retrieval | CL110 | 2904+2905 | Pen (CL105) | **Multi-Order Perfect Run** |
| S8 | Storage | CL111 | 2904+2905 | Pen (CL105) | **Multi-Order Perfect Run** |

**Kernprinzip:** Szenarien sind vollständig durch annotierte Semantik (CC01-CC12) definiert, nicht durch Zeit, Raum oder externe Annahmen.

---

**Skill-Version:** 1.1 (erweitert mit Szenario-Details)  
**Erstellt:** 05.12.2025  
**Quelle:** DaRa Dataset Description, Teil 2 & 5 – Szenarien
