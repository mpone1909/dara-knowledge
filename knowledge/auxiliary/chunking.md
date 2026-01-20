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
     
4. **Datenstruktur und Zustandsbeschreibung**
   Die Klassenkategorien liegen in CSV-Dateien vor (Namenskonvention z. B.: `Revised_Annotation__CC03_Sub-Activity - Torso__S14.csv`), wobei `CCxx` die Kategorie und `Sxx` die Probanden-ID (S01 bis S18) bezeichnet.
   Für jeden Chunk ist das Chunking über alle **12 Klassenkategorien (CC01–CC12)**, die insgesamt **207 Labels (CL)** umfassen, gültig. Ein Chunk enthält somit den vollständigen Zustand über alle Dimensionen:
   - **Hauptaktivität:** CC01
   - **Körperliche Sub-Aktivitäten:** CC02 (Beine), CC03 (Torso), CC04 (Linke Hand), CC05 (Rechte Hand)
   - **Kontext & Auftrag:** CC06 (Auftrag), CC07 (IT-Systeme)
   - **Prozess-Ebene:** CC08 (High-Level), CC09 (Mid-Level), CC10 (Low-Level)
   - **Standort:** CC11 (Mensch), CC12 (Wagen)

5. **Labelsätze und Aktivierungsregeln pro Klasse**
   Die Klassifikation unterscheidet strikt zwischen **Single-Label**- (exklusiv) und **Multi-Label**-Kategorien (kombinierbar oder zwingend). Innerhalb eines Chunks gelten folgende Regeln:

   * **Single-Label Klassen (Exklusiv):**
       In den Kategorien **CC01, CC02, CC07, CC08, CC09, CC10** ist genau ein Label pro Frame aktiv (Min=1, Max=1).
       - *Logik:* Die Labels schließen sich gegenseitig aus.
       - *Priorität (Beispiel CC01):* Bei Gleichzeitigkeit gilt eine definierte Hierarchie: Sync > Confirming > Scanning > Cart > Handling > Walking/Standing.

   * **Multi-Label Klassen (Kombinierbar/Hierarchisch):**
       Hier können oder müssen mehrere Labels gleichzeitig aktiv sein:
       - **CC03 (Torso):** Additiv (Max 2). Ein Beugungsgrad (z. B. *Slightly Bending*) kann mit *Torso Rotation* kombiniert werden.
       - **CC04 & CC05 (Hände):** Zwingend Multi-Label (Max 4). Eine gültige Kombination besteht immer aus genau 4 Komponenten: Position + Movement + Object + Tool (z. B. Centered + Grasping + Small Item + No Tool).
       - **CC06 (Order):** Kombinierbar (Max 2). Bei Multi-Order-Szenarien können zwei Aufträge gleichzeitig aktiv sein.
       - **CC11 (Ort Mensch) & CC12 (Ort Wagen):** Hierarchisch (Max 3 bzw. 4). Kombination folgt der Logik: Main Area + Gasse + Position. Bei CC12 ist zusätzlich ein Transition-Label möglich.

### Bedingungen für die Konsistenz eines Chunks

Ein Chunk bleibt gültig, solange:

- kein Labelwechsel in einer beliebigen Klasse stattfindet,  
- keine Prozessphase endet oder startet,  
- kein Positions- oder Bewegungswechsel eintritt,  
- kein Szenariowechsel erfolgt.

### Beziehungen zu anderen Ebenen

- Ein Chunk ist **feiner** als Szenarioabschnitte und Prozessphasen.  
- Ein Chunk stellt die kleinste **semantische Einheit** dar, die in der Annotation eindeutig definiert ist.  
- Prozesse (CC08–CC10) und Szenarien (S1–S8 und other) können aus vielen Chunks bestehen.

---

## 3.4 Trigger-Mechanismen (T1–T10)

Trigger sind definierte Ereignisse oder Zustandsänderungen, die das **Ende eines Chunks** und den **Beginn eines neuen Chunks** auslösen. Ein Trigger tritt immer dann auf, wenn sich der Zustand in **mindestens einer der 12 Klassenkategorien** ändert.

Nachfolgend werden die zehn Triggermechanismen beschrieben.

### T1 – Wechsel der Main Activity (CC01) [Single-Label]

Ein Chunk endet sofort, wenn sich die Hauptaktivität ändert. Da dies eine Single-Label-Klasse ist, handelt es sich um einen exklusiven Austausch.

**Beispiele:**

- CL011 (Walking) → CL012 (Standing)
- CL005 (Scanning) → CL011 (Walking)

---

### T2 – Wechsel der Beinaktivität (CC02) [Single-Label]

Ein Übergang zwischen exklusiven Zuständen wie Gait Cycle, Standing Still oder Step erzeugt einen neuen Chunk.

**Beispiele:**

- CL016 (Gait Cycle) → CL018 (Standing Still)
- CL017 (Step) → CL016 (Gait Cycle)

---

### T3 – Änderung der Torsobewegung (CC03) [Multi-Label]

Da CC03 additiv ist, löst jede Änderung der aktiven Label-Kombination einen Trigger aus. Das beinhaltet den Wechsel des Beugungsgrades sowie das Hinzufügen/Entfernen der Rotation.

**Beispiele:**
- Wechsel: CL024 (No Bending) → CL026 (Strongly Bending)
- Addition: CL025 (Slightly Bending) → CL025 (Slightly Bending) + CL027 (Torso Rotation)

---

### T4 – Änderungen der linken Hand (CC04) [Required Multi-Label]

Ein neuer Chunk wird ausgelöst, wenn sich **mindestens eine** der vier zwingend erforderlichen Komponenten ändert (Position, Movement, Object, Tool).

**Beispiele:**

- Position: CL030 (Upwards) → CL032 (Downwards)
- Movement: CL034 (Reaching/Grasping) → CL036 (Holding)
- Object: CL040 (No Object) → CL043 (Small Item)
- Tool: CL052 (PDT) → CL056 (Pen)

---

### T5 – Änderungen der rechten Hand (CC05) [Required Multi-Label]

Analog zu T4: Jede Änderung im 4-Komponenten-Status (Position, Bewegung, Objekt, Werkzeug) der rechten Hand erzeugt einen neuen Chunk.

**Beispiele:**

- Position: CL065 (Upwards) → CL066 (Centered)
- Objekt: CL077 (Medium Item) → CL082 (Cardboard Box)

---

### T6 – Wechsel der Order (CC06) [Multi-Label]

Ein Trigger tritt auf, wenn sich die Auftragsnummer ändert oder – in Multi-Order-Szenarien – ein zweiter Auftrag hinzukommt bzw. wegfällt.

**Beispiele:**
- Wechsel: CL100 (Order 2904) → CL101 (Order 2905)
- Addition: CL100 (Order 2904) → CL100 (Order 2904) + CL101 (Order 2905)
- Ende: CL102 (Order 2906) → CL103 (No Order)

---

### T7 – Wechsel der Informationstechnologie (CC07) [Single-Label]

Ein Trigger tritt auf, wenn das genutzte IT-System gewechselt wird.

**Beispiele:**

- CL105 (List and Pen) → CL107 (Portable Data Terminal)
- CL107 (PDT) → CL108 (No IT)

---

### T8 – Wechsel des Prozesses (CC08–CC10) [Single-Label]

Ein Wechsel eines beliebigen Labels in den Prozess-Kategorien (High-, Mid- oder Low-Level) erzeugt automatisch einen neuen Chunk. Dies ist der häufigste Trigger aufgrund der Feingliedrigkeit von CC10.

**Beispiele:**
- **High-Level (CC08):** CL110 (Retrieval) → CL111 (Storage)
- **Mid-Level (CC09):** CL115 (Picking Travel Time) → CL116 (Picking Pick Time)
- **Low-Level (CC10):** CL139 (Retrieving Items) → CL137 (Moving to Next Position)

---

### T9 – Wechsel der Location Human (CC11) [Hierarchisch]

Ein neuer Chunk entsteht, wenn sich irgendein Teil der Orts-Hierarchie (Main Area, Sub-Area/Gasse oder Position) ändert.

**Beispiele:**
- Bereichswechsel: CL158 (Base) → CL163 (Aisle Path)
- Gassenwechsel: CL172 (Aisle 1) → CL173 (Aisle 2)
- Positionswechsel: CL177 (Front) → CL178 (Center)

---

### T10 – Wechsel der Location Cart (CC12) [Hierarchisch + Transition]

Analog zu T9, jedoch für den Wagen. Zusätzlich löst das Auftreten oder Verschwinden des Transition-Labels (CL181) einen Trigger aus.

**Beispiele:**
- Bereichswechsel: CL185 (Base) → CL190 (Aisle Path)
- Transition: CL190 (Aisle Path) → CL190 (Aisle Path) + CL181 (Transition between Areas)

---

### Zusammenfassung Trigger

Die zehn Trigger T1–T10 stellen sicher, dass jede Änderung im **State-Space** (definiert durch CC01–CC12) zu einer neuen Chunk-Grenze führt. Damit sind Chunks per Definition semantisch statisch: Innerhalb eines Chunks bleiben alle Labels aller Klassen unverändert.

## 3.5 Chronologische Chunk-Abfolge

Die chronologische Chunk-Abfolge beschreibt die tatsächliche zeitliche Struktur der Chunks innerhalb einer Session und eines Subjekts. Alle Chunks folgen einem linearen Zeitstrahl und sind strikt durch Trigger T1–T10 getrennt. Es gibt **keine Überlappungen**, **keine Lücken** und **keine parallelen Chunks**.

### Grundprinzip der Abfolge

1. Die Daten beginnen immer mit **Chunk 1**, beginnend beim ersten Frame in der zweiten Spalte der csv dateien.  
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

- Szenarien (S1–S8 und other) bestehen aus vielen Chunks.  
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

- Label-Definitionen → Siehe `labels_207.md`
- BPMN-Prozesslogik → Siehe `dataset_core.md`
- Frame-Synchronisation → Siehe `data_structure.md`

---

**Skill-Version:** 1.1 (erweitert mit Chunking-Logik)  
**Erstellt:** 05.12.2025
**Korrigiert:** 19.01.26  
**Quelle:** DaRa Dataset Description, Teil 3 – Chunking
