# DaRa Dataset – Chunking-Logik

Diese Datei beschreibt das **Chunking-System** des DaRa-Datensatzes – die Segmentierung des kontinuierlichen Frame-Stroms in semantisch stabile Einheiten.

**Quelle:** DaRa Dataset Description (Stand 20.10.2025), Teil 3

---

## 3.1 Überblick

Das Chunking im DaRa-Datensatz dient der strukturierten Segmentierung des kontinuierlichen, framebasierten Datenstroms in logisch abgegrenzte Abschnitte. Jeder Chunk repräsentiert einen konsistenten Zustand des Subjekts über alle 12 Klassenkategorien hinweg. Ein Chunk bildet eine semantisch zusammenhängende Phase ab, deren Grenzen durch definierte Trigger ausgelöst werden. Die Chunking-Logik ist strikt datengetrieben und basiert ausschließlich auf Annotationen aus den Klassendateien.

---

## 3.2 Definition Chunking-Einheit

Eine Chunking-Einheit im DaRa-Datensatz ist ein **zusammenhängender zeitlicher Abschnitt**, innerhalb dessen der vollständige Frame-Zustand eines Subjekts über alle 12 Klassenkategorien hinweg **stabil** bleibt. Das bedeutet, dass in einem Chunk keine Veränderungen der aktiven Labels innerhalb derselben Klassendatei stattfinden. Ein Chunk endet genau dann, wenn mindestens **eine Klasse** (z. B. Main Activity, Legs, Torso, Hand-Subaktivität, Order, IT, Prozess oder Location) einen Zustandswechsel aufweist.

### Eigenschaften einer Chunking-Einheit

- Ein Chunk umfasst immer **alle 12 Klassenkategorien (CC01–CC12)**.  
- Jede Chunk-Grenze wird ausschließlich durch **Trigger (T1–T10)** definiert.  
- Ein Chunk kann unterschiedlich viele Frames enthalten — abhängig davon, wie lange der Zustand stabil bleibt.  
- Ein Chunk ist **Subjekt-spezifisch**: Für jedes Subjekt innerhalb einer Session existiert ein eigenständiger Chunk-Strom.  
- Chunks stellen die kleinste durchgängige Einheit dar, in der die gesamte logistische und motorische Semantik konsistent bleibt.

### Funktion des Chunking

- Reduktion der Frame-Komplexität durch zusammenhängende Zustandssegmente.  
- Strukturierung des gesamten Datenstroms in semantische Abschnitte.  
- Ermöglicht Szenarioanalyse, Prozessanalyse sowie Training von Modellen auf Zustandsfolgen.

---

## 3.3 Struktur eines Chunks

Ein Chunk im DaRa-Datensatz besitzt eine klar definierte interne Struktur, die sicherstellt, dass jeder Chunk einen vollständigen, zusammenhängenden und eindeutig interpretierbaren Zustand beschreibt. Die Struktur ist vollständig datengetrieven und basiert auf synchronisierten Frame-Annotationen über alle Klassen hinweg.

### Bestandteile eines Chunks

Ein Chunk umfasst:

1. **Start-Frame**  
   Der erste Frame, in dem ein neuer stabiler Zustand beginnt. Dieser entsteht unmittelbar nach einem Trigger (T1–T10), der den vorherigen Chunk beendet hat.  
     
2. **End-Frame**  
   Der letzte Frame, bevor ein weiterer Trigger ausgelöst wird und ein neuer Chunk beginnt.  
     
3. **Dauer**  
   Anzahl der Frames innerhalb des Chunks. Da die Daten mit 29,97 fps aufgezeichnet und für die Modellierung auf 30 fps gerundet werden, entspricht die Dauer (Frames / 30) Sekunden.  
     
4. **Vollständige Zustandsbeschreibung**  
   Für **alle 12 Klassenkategorien (CC01–CC12)** liegt pro Chunk eine vollständige Information vor. Ein Chunk enthält daher:  
     
   - eine Hauptaktivität (CC01),  
   - Bewegungs- und Körperhaltungszustände (CC02–CC05),  
   - Kontextinformationen (CC06–CC07),  
   - Prozesszuordnungen (CC08–CC10),  
   - Standort des Subjekts und des Wagens (CC11–CC12).

5. **Labelsätze pro Klasse**  
   Jede Klasse besitzt innerhalb des Chunks genau **einen aktiven Labelzustand** (multi-label möglich, falls die Klasse es zulässt, z. B. Hände mit mehreren Objekten/Tools). Dieser Zustand bleibt vom Start-Frame bis zum End-Frame unverändert.

### Bedingungen für die Konsistenz eines Chunks

Ein Chunk bleibt gültig, solange:

- kein Labelwechsel in einer beliebigen Klasse stattfindet,  
- keine Prozessphase endet oder startet,  
- kein Positions- oder Bewegungswechsel eintritt,  
- kein Szenariowechsel erfolgt.

### Beziehungen zu anderen Ebenen

- Ein Chunk ist **feiner** als Szenarioabschnitte und Prozessphasen.  
- Ein Chunk stellt die kleinste **semantische Einheit** dar, die in der Annotation eindeutig definiert ist.  
- Prozesse (CC08–CC10) und Szenarien (S1–S8) können aus vielen Chunks bestehen.

---

## 3.4 Trigger-Mechanismen (T1–T10)

Trigger sind definierte Ereignisse oder Zustandsänderungen, die das **Ende eines Chunks** und den **Beginn eines neuen Chunks** auslösen. Ein Trigger tritt immer dann auf, wenn sich mindestens eine der 12 Klassenkategorien ändert. Das Chunking-System basiert vollständig auf diesen Triggern.

Nachfolgend werden die zehn Triggermechanismen beschrieben, die offiziell definiert wurden.

### T1 – Wechsel der Main Activity (CC01)

Ein Chunk endet sofort, wenn sich die Hauptaktivität ändert (z. B. von Walking zu Standing). Diese Änderungen sind stark semantisch relevant und definieren grundlegende Zustandswechsel.

**Beispiele:**

- CL011 (Walking) → CL012 (Standing)
- CL005 (Scanning) → CL011 (Walking)

---

### T2 – Wechsel der Beinaktivität (CC02)

Ein Übergang zwischen Zuständen wie Gait Cycle, Standing Still oder Step erzeugt einen neuen Chunk. Beinaktivität ist ein zentraler Indikator für Bewegungsphasen.

**Beispiele:**

- CL016 (Gait Cycle) → CL018 (Standing Still)
- CL017 (Step) → CL016 (Gait Cycle)

---

### T3 – Wechsel der Torsobewegung (CC03)

Änderungen zwischen No Bending, Slightly Bending oder Torso Rotation lösen einen Chunksprung aus.

**Beispiele:**

- CL024 (No Bending) → CL026 (Strongly Bending)
- CL025 (Slightly Bending) → CL024 (No Bending)

---

### T4 – Änderungen der linken Hand (CC04)

Ein neuer Chunk wird ausgelöst, wenn sich mindestens einer der Teilbereiche der linken Hand ändert:

- **Primärposition** (Upwards, Centered, Downwards)  
- **Movement Type** (z. B. Grasping, Holding)  
- **Objekt** (z. B. Large Item, Cart)  
- **Tool** (z. B. Pen, PDT, Knife)

**Beispiele:**

- Position: CL030 (Upwards) → CL032 (Downwards)
- Movement: CL034 (Reaching/Grasping) → CL036 (Holding)
- Object: CL040 (No Object) → CL043 (Small Item)
- Tool: CL052 (PDT) → CL056 (Pen)

---

### T5 – Änderungen der rechten Hand (CC05)

Wie T4, jedoch für die rechte Hand. Jede Änderung im Bewegungs-, Objekt- oder Toolstatus erzeugt einen neuen Chunk.

**Beispiele:**

- Position: CL065 (Upwards) → CL066 (Centered)
- Movement: CL069 (Reaching/Grasping) → CL071 (Holding)
- Object: CL077 (Medium Item) → CL082 (Cardboard Box)
- Tool: CL087 (PDT) → CL091 (Pen)

---

### T6 – Wechsel der Order (CC06)

Wenn ein anderes Order-Label aktiv wird (z. B. Wechsel von Order 2905 zu Order 2906), beginnt ein neuer Chunk.

**Beispiele:**

- CL100 (2904) → CL101 (2905)
- CL101 (2905) → CL102 (2906)
- CL102 (2906) → CL103 (No Order)

---

### T7 – Wechsel der Informationstechnologie (CC07)

Ein Trigger tritt auf, wenn sich der IT-Zustand ändert, z. B. Wechsel zwischen List and Pen, Portable Data Terminal oder No IT.

**Beispiele:**

- CL105 (List and Pen) → CL107 (Portable Data Terminal)
- CL107 (PDT) → CL108 (No IT)

---

### T8 – Wechsel des High-, Mid- oder Low-Level Prozesses (CC08–CC10)

Ein Wechsel eines beliebigen Prozesslabels der Kategorien CC08–CC10 erzeugt automatisch einen neuen Chunk.

**Beispiele:**

- **High-Level:** CL110 (Retrieval) → CL111 (Storage)
- **Mid-Level:** CL115 (Picking Travel Time) → CL116 (Picking Pick Time)
- **Low-Level:** CL139 (Retrieving Items) → CL137 (Moving to Next Position)

**Wichtig:** T8 ist der häufigste Trigger, da Low-Level-Prozesse sehr feingliedrig sind.

---

### T9 – Wechsel der Location Human (CC11)

Ein neuer Chunk entsteht immer dann, wenn die annotierte Position der Person wechselt:

- zwischen Bereichen (z. B. Base → Cart Area)  
- zwischen Pfaden  
- zwischen Aisle Paths oder Cross-Aisle Paths

**Beispiele:**

- CL158 (Base) → CL163 (Aisle Path)
- CL172 (Aisle 1) → CL173 (Aisle 2)
- CL162 (Cross Aisle Path) → CL163 (Aisle Path)

---

### T10 – Wechsel der Location Cart (CC12)

Analog zu T9, jedoch über den Standort des Kommissionierwagens. Jeder Standortwechsel erzeugt einen neuen Chunk.

**Beispiele:**

- CL185 (Base) → CL190 (Aisle Path)
- CL199 (Aisle 1) → CL200 (Aisle 2)
- CL181 (Transition between Areas) → CL185 (Base)

---

### Zusammenfassung Trigger

Die zehn Trigger T1–T10 decken **alle möglichen Zustandswechsel** ab. Sobald ein Trigger ausgelöst wird, endet der aktuelle Chunk und ein neuer Segmentabschnitt beginnt. Dieses System stellt sicher, dass Chunks immer **semantisch stabil**, klar getrennt und vollständig über alle 12 Klassenkategorien definiert sind.

---

## 3.5 Chronologische Chunk-Abfolge

Die chronologische Chunk-Abfolge beschreibt die tatsächliche zeitliche Struktur der Chunks innerhalb einer Session und eines Subjekts. Alle Chunks folgen einem linearen Zeitstrahl und sind strikt durch Trigger T1–T10 getrennt. Es gibt **keine Überlappungen**, **keine Lücken** und **keine parallelen Chunks**.

### Grundprinzip der Abfolge

1. Die Daten beginnen immer mit **Chunk 1**, beginnend beim ersten Frame.  
2. Ein Chunk endet ausschließlich durch einen Trigger (T1–T10).  
3. Der nächste Chunk beginnt **im unmittelbar folgenden Frame**.  
4. Alle Chunks sind in ihrer Reihenfolge eindeutig und vollständig rekonstruierbar.  
5. Jeder Chunk umfasst einen stabilen Zustand über alle 12 Klassen hinweg.

### Eigenschaften der zeitlichen Abfolge

- Die Abfolge der Chunks deckt **den gesamten Framebereich lückenlos** ab.  
- Eine Session enthält die Chunks aller drei Subjekte — jedoch **für jedes Subjekt separat**.  
- Chunks verschiedener Subjekte können gleichzeitig beginnen und enden, müssen es aber nicht.  
- Ein Subjekt kann in einem längeren Zeitraum viele oder wenige Chunks erzeugen, abhängig von seiner Aktivität.

### Beziehung zu Szenarien

- Szenarien (S1–S8) bestehen aus vielen Chunks.  
- Szenarien haben **definierte Start- und Endpunkte**, die immer mit Chunk-Grenzen übereinstimmen.  
- Szenarioübergänge erzeugen **immer** einen Trigger (T1, T8 oder andere), da sich Prozess- oder Aktivitätszustände ändern.

### Beziehung zu Prozessen

- High-Level-, Mid-Level- und Low-Level-Prozesse bestehen jeweils aus Sequenzen von Chunks.  
- Chunk-Abgrenzungen erlauben eine exakte, zeitbasierte Rekonstruktion des BPMN-Prozesses.  
- Ein Prozessabschnitt ist niemals chunkübergreifend inkonsistent.

### Konsistenzregeln für die zeitliche Ordnung

- Die Zeitlichkeit ist vollständig deterministisch durch die Annotation bestimmt.  
- Es existieren keine impliziten Regeln außerhalb der definierten Trigger.  
- Jeder Frame gehört genau zu einem Chunk.

---

## 3.6 Beziehung zu Szenarien und Prozessen

Die Chunks im DaRa-Datensatz stehen in einem klar definierten Verhältnis zu Szenarien (S1–S8) und zu den drei Prozesskategorien (High-Level, Mid-Level, Low-Level). Da Chunks die kleinstmöglichen stabilen zeitlichen Einheiten darstellen, bilden sie die Grundlage für jede höhere semantische Struktur im Datensatz.

### Beziehung zu Szenarien (S1–S8)

- Szenarien sind **übergeordnete semantische Einheiten**, die aus vielen Chunks bestehen.  
- Die vordefinierten Szenarien (z. B. S1 Standard Retrieval, S4 Storage, S7 Perfect Run) sind vollständig über die Abfolge der Chunks rekonstruierbar.  
- Ein Szenario beginnt immer **mit dem Beginn eines Chunks**. Es gibt keine Szenariostarts mitten in einem Chunk.  
- Ein Szenario endet immer **mit dem Ende eines Chunks**.  
- Szenarien bestehen aus heterogenen Prozess- und Aktivitätsfolgen, die in Form vieler Chunks modelliert werden.  
- Szenariowechsel erzeugen zwingend einen Trigger (typischerweise T1, T8 oder T9/T10), da sich mindestens ein Aktivitäts-, Prozess- oder Locationzustand verändert.

### Beziehung zu High-Level-Prozessen (CC08)

- Jeder Chunk enthält genau einen High-Level-Prozess (Retrieval, Storage, Another, Unknown).  
- High-Level-Prozesse strukturieren Chunks zu **Makroblöcken**, die den globalen Aufgabencharakter widerspiegeln.  
- Ein Wechsel des High-Level-Prozesses erzeugt zwingend einen Trigger (T8), wodurch ein neuer Chunk entsteht.

### Beziehung zu Mid-Level-Prozessen (CC09)

- Mid-Level-Prozesse sind zeitliche Phasen innerhalb eines High-Level-Prozesses.  
- Ein Wechsel zwischen Mid-Level-Prozessen (z. B. von Travel Time zu Pick Time) erzeugt immer einen neuen Chunk.  
- Chunks innerhalb eines Mid-Level-Prozesses können unterschiedlich lang sein, abhängig von Bewegungen, Kontextwechseln oder Handinteraktionen.

### Beziehung zu Low-Level-Prozessen (CC10)

- Low-Level-Prozesse definieren die atomaren Handlungsschritte.  
- Jeder Low-Level-Wechsel führt zu einem Trigger (T8) und damit zu einem neuen Chunk.  
- Die Mehrheit aller Chunk-Grenzen entsteht durch Low-Level-Wechsel, da diese die feinste prozedurale Ebene darstellen.

### Szenario-Prozess-Chunk-Hierarchie

Die Struktur lässt sich wie folgt zusammenfassen:

```
Szenario (S1–S8)
    ↓ besteht aus
High-Level-Prozess (CC08)
    ↓ besteht aus
Mid-Level-Prozess (CC09)
    ↓ besteht aus
Low-Level-Prozess (CC10)
    ↓ erzeugt
Sequenzen von Chunks
    ↓
Chunk (kleinstmögliche Einheit)
```

### Konsistenzregeln

- Chunks sind die Basis aller zeitlichen Analysen.  
- Prozess- und Szenariostrukturen lassen sich ausschließlich über Chunk-Grenzen korrekt rekonstruieren.  
- Szenario-, Prozess- und Chunkgrenzen stehen immer in einem konsistenten Verhältnis.

---

## 3.7 Eigenschaften der Chunks

Chunks im DaRa-Datensatz sind präzise definierte, logisch abgegrenzte zeitliche Einheiten. Sie entstehen ausschließlich durch Änderungen in mindestens einer der 12 Klassenkategorien. Chunks bilden die vollständige, konsistente und minimale Einheit der Beschreibung des Subjektzustands.

### Zentrale Eigenschaften

- **Stabilität des Zustands:** Ein Chunk umfasst nur Frames, in denen sich keine Labelwerte verändern.  
- **Vollständigkeit:** Jeder Chunk enthält Informationen aus allen 12 Klassenkategorien (CC01–CC12).  
- **Klar definierte Grenzen:** Ein Chunk endet nur durch Trigger T1–T10.  
- **Keine Überschneidung:** Chunks überlappen sich nie und haben keine Lücken.  
- **Variable Dauer:** Ein Chunk kann sehr kurz (wenige Frames) oder sehr lang (mehrere hundert Frames) sein.  
- **Subjekt-spezifisch:** Jeder der drei Akteure einer Session besitzt einen eigenen Chunk-Strom.  
- **Semantische Konsistenz:** Alle in einem Chunk enthaltenen Labels drücken einen gemeinsamen, stabilen Zustand aus.

### Interne Konsistenz

Innerhalb eines Chunks:

- bleibt der Prozessstatus (CC08–CC10) konstant,  
- bleibt die Bewegungs- und Körperhaltung (CC01–CC05) stabil,  
- bleiben Order- und IT-Informationen (CC06–CC07) unverändert,  
- bleibt die Position (CC11–CC12) identisch.

### Externe Konsistenz

- Chunks sind Grundlage für alle höheren Strukturen (Szenarien, Prozessphasen, Bewegungsfolgen).  
- Sie erlauben eine rekonstruierbare Analyse von komplexen Abläufen.  
- Chunks respektieren die tatsächliche zeitliche Struktur der Aufzeichnung (29,97 fps, auf 30 fps gerundet für Modellierung).

### Funktion im System

- Reduktion der komplexen Frame-Daten zu stabilen Zustandsblöcken.  
- Grundlage für Trainingsdaten, Modelle und Sequenzrekonstruktion.  
- Ermöglichen genaue Ableitung von Szenarien und Prozessen.

---

## 3.8 Zusammenfassung

Das Chunking-System des DaRa-Datensatzes bildet die grundlegende zeitliche und semantische Struktur aller annotierten Daten. Chunks sind die **kleinste stabile Einheit**, in der der Zustand eines Subjekts vollständig, konsistent und ohne innere Veränderungen beschrieben wird. Sie entstehen ausschließlich durch definierte Trigger (T1–T10), die Zustandswechsel in mindestens einer der 12 Klassenkategorien signalisieren.

### Kernelemente

- **Ein Chunk ist stabil**: Keine Änderungen in Main Activity, Sub-Activities, Order, IT, Prozessen oder Locations.  
- **Ein Chunk ist vollständig**: Alle 12 Klassen (CC01–CC12) sind enthalten.  
- **Ein Chunk ist atomar**: Kleinste semantisch kohärente Einheit des Datenstroms.  
- **Ein Chunk ist determiniert**: Entsteht ausschließlich durch definierte, explizite Trigger.  
- **Ein Chunk ist zeitlich klar abgegrenzt**: Es gibt keine Überschneidungen oder Lücken.  
- **Ein Chunk ist kontextunabhängig**: Gilt in allen Szenarien, Prozessen und Subjektströmen.

### Rolle im Gesamtsystem

Chunks dienen als:

- Grundlage zur Rekonstruktion aller Szenario-, Bewegungs- und Prozessstrukturen,  
- zentrale Auswertungseinheit für Analysen, Modellierung und Validierung,  
- Brücke zwischen Frame-Level-Daten (≈ 30 fps) und semantischen Ereignisstrukturen.

### Bedeutung für Modelle und Verarbeitung

- Reduktion hochfrequenter Frame-Daten auf interpretierbare Zustandssegmente.  
- Ermöglichung effizienter Algorithmen für Sequenzmodelle, Prozessrekonstruktion und Verhaltenserkennung.  
- Sicherstellung der semantischen Konsistenz aller abgeleiteten Strukturen.

---

## Verwendungshinweise

**Diese Datei nutzen für:**

- Verständnis der Chunk-Bildung
- Trigger-Mechanismen (T1-T10)
- Zeitliche Segmentierung von Frame-Daten
- Beziehung zwischen Chunks und Prozessen/Szenarien

**Nicht in dieser Datei:**

- Label-Definitionen → Siehe `class_hierarchy.md`
- BPMN-Prozesslogik → Siehe `dataset_core.md`
- Frame-Synchronisation → Siehe `data_structure.md`

---

**Skill-Version:** 1.1 (erweitert mit Chunking-Logik)  
**Erstellt:** 05.12.2025  
**Quelle:** DaRa Dataset Description, Teil 3 – Chunking
