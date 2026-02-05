# DaRa Dataset â€“ Datenstruktur

Diese Datei beschreibt die vollstÃ¤ndige Datenstruktur des DaRa-Datensatzes basierend auf der offiziellen Dataset Description (Stand 20.10.2025).

---

## 5.1 Ãœberblick Ã¼ber die Datenstruktur

Die Datenstruktur des DaRa-Datensatzes basiert auf synchron aufgezeichneten Sessions, in denen jeweils drei Subjekte gleichzeitig agieren. Innerhalb jeder Session kÃ¶nnen mehrere Szenarien auftreten, und jedes Subjekt erzeugt dabei einen eigenen vollstÃ¤ndigen Datensatz mit 12 Klassendateien. Alle Klassendateien sind zeitlich vollstÃ¤ndig synchronisiert.

---

## 5.2 Sessions

### Definition
* Eine **Session** ist ein zusammenhÃ¤ngender Aufzeichnungsblock.
* In jeder Session nehmen **drei Subjekte gleichzeitig** teil.
* Innerhalb einer Session kÃ¶nnen **mehrere Szenarien** auftreten.

### Eigenschaften
* Gemeinsamer Zeitstrahl fÃ¼r alle drei Subjekte.
* Synchronisierte Frame-Indices Ã¼ber alle Klassendateien hinweg.
* Jedes Subjekt erzeugt einen eigenen Datensatz innerhalb derselben Session.

---

## 5.3 Subjekte innerhalb einer Session

### Struktur
FÃ¼r jedes der drei Subjekte gelten folgende Eigenschaften:
* Ein zusammenhÃ¤ngender Datenstrom im Rahmen derselben Session.
* Eigene Klassendateien (12 StÃ¼ck pro Subjekt).
* Identische Anzahl an Frames pro Datei (innerhalb derselben Session).

### Zuordnung
* Subjekt-ID (S01â€“S18) ist eindeutig.
* Subjekt-Daten verweisen auf eine Session-ID.
* Szenarioabschnitte innerhalb einer Session werden dem Subjekt zeitlich zugeordnet.

---

## 5.4 Szenarien innerhalb einer Session

### Eigenschaften
* Eine Session kann **mehrere unterschiedliche Szenarien** enthalten.
* Jedes Subjekt kann innerhalb derselben Session mehrere Szenarien durchlaufen.

### Szenariozuordnung
* Die Szenarien S1â€“S8 werden zeitlich anhand der Annotationen markiert.
* Szenariogrenzen ergeben sich klar aus den Labels der Prozesskategorien (CC08â€“CC10).

---

## 5.5 Klassendateien

### Allgemeiner Aufbau

Pro Subjekt gibt es **12 Klassendateien**, entsprechend den Kategorien:

* **CC01** Main Activity
* **CC02** Legs
* **CC03** Torso
* **CC04** Left Hand
* **CC05** Right Hand
* **CC06** Order
* **CC07** IT
* **CC08** High-Level Process
* **CC09** Mid-Level Process
* **CC10** Low-Level Process
* **CC11** Location Human
* **CC12** Location Cart

### Struktur jeder Klassendatei
1.  **Erste Zeile:** VollstÃ¤ndige Liste der zugehÃ¶rigen Labelnamen (Header).
2.  **Ab Zeile 2:** Pro Frame ein Satz an 0/1-Werten.
3.  **Eine Zeile entspricht exakt einem Frame.**
4.  Alle 12 Klassendateien eines Subjekts haben:
    * die gleiche Anzahl an Zeilen,
    * die gleiche zeitliche Abdeckung,
    * identische Frame-Indizes.

### Inhaltliche Eigenschaften
* Die Werte pro Zeile geben an, welche Labels im jeweiligen Frame aktiv sind.
* Multi-Label-Aktivierungen sind mÃ¶glich (z. B. mehrere Hand-Objekt-ZustÃ¤nde gleichzeitig).
* Keine zusÃ¤tzlichen Sensorstreams â€“ die Klassendateien enthalten alle notwendigen Informationen.

### Beispiel einer Klassendatei-Struktur (CC01 - Main Activity)

```csv
Header Row: Synchronization,Confirming,Pulling Cart,Walking,Standing,Sitting,Another,Unknown
Frame 1:    1,0,0,0,0,0,0,0
Frame 2:    1,0,0,0,0,0,0,0
Frame 3:    0,0,0,1,0,0,0,0
Frame 4:    0,0,0,1,0,0,0,0
...
```

**Interpretation:**

* **Frame 1-2:** Subjekt ist im Zustand "Synchronization" (CL001 aktiv).
* **Frame 3-4:** Subjekt ist im Zustand "Walking" (CL011 aktiv).

---

## 5.6 Frame-Struktur

### Frame-Definition
* Ein Frame entspricht einem Zeitpunkt der synchronen Video- und IMU-Aufzeichnung.
* Bildrate: **29,97 fps**, fÃ¼r Modellierungszwecke auf **30 fps** gerundet.

### Frame-Eigenschaften
Jeder Frame bildet einen vollstÃ¤ndigen Zustand ab:
* HauptaktivitÃ¤t (CC01)
* KÃ¶rperhaltungen und Bewegungen (CC02â€“CC05)
* Kontext (Order, IT, Location Human, Location Cart) (CC06, CC07, CC11, CC12)
* Prozesszuordnung (CC08â€“CC10)

Ein Frame enthÃ¤lt ausschlieÃŸlich **0/1-Indikatoren**:
* **0** = Label nicht aktiv in diesem Frame
* **1** = Label aktiv in diesem Frame

### Frame-Synchronisation
**Kritisch fÃ¼r das VerstÃ¤ndnis:**
* Alle 12 Klassendateien eines Subjekts haben **identische LÃ¤nge** (gleiche Anzahl Zeilen).
* **Frame N** in Klassendatei A entspricht zeitlich **exakt Frame N** in Klassendateien B-L.
* Beispiel: Frame 1000 in CC01 (Main Activity) ist der **gleiche Zeitpunkt** wie Frame 1000 in CC04 (Left Hand).

### Zeitliche AuflÃ¶sung
* **1 Frame = 1/30 Sekunde â‰ˆ 0,0333 Sekunden**
* **30 Frames = 1 Sekunde**
* **1800 Frames = 1 Minute**
* **108.000 Frames = 1 Stunde**

---

## 5.7 Zeitliche Struktur

### Gesamtumfang
* Gesamtdauer der Aufzeichnung aller Probanden ca. **32 Stunden**.
* Alle 32 Stunden gelten als Teil derselben logistischen TÃ¤tigkeit entsprechend der Zeiterfassung der Probanden in der Tabelle im Paper.

### SynchronitÃ¤t
* Drei Subjekte innerhalb einer Session sind **synchron** aufgezeichnet.
* Alle Klassendateien innerhalb eines Subjekts haben identische LÃ¤nge.
* Szenarien sind zeitlich unabhÃ¤ngig zwischen Subjekten.

### Frame-to-Time Mapping

**Umrechnung Frame â†’ Zeit:**

```text
Zeit_in_Sekunden = Frame_Nummer / 30
Zeit_in_Minuten  = Frame_Nummer / 1800
```

**Umrechnung Zeit â†’ Frame:**

```text
Frame_Nummer = Zeit_in_Sekunden * 30
```

**Beispiele:**

* Frame 900 = 30 Sekunden
* Frame 3600 = 2 Minuten
* Frame 54000 = 30 Minuten

---

## 5.8 Datensatzumfang

### GesamtÃ¼bersicht
* **18 Subjekte** (S01â€“S18)
* **6 Sessions**, jede mit 3 Subjekten
* **216 Klassendateien** (18 Subjekte Ã— 12 Klassenkategorien)
* **207 Labeltypen** Ã¼ber alle Kategorien (CL001-CL207)

### Strukturierte Zusammenfassung

| Dimension | Anzahl | Beschreibung |
| :--- | :--- | :--- |
| Probanden | 18 | S01-S18 |
| Sessions | 6 | Je 3 Subjekte parallel |
| Szenarien | 8 | S1-S8 |
| Klassenkategorien | 12 | CC01-CC12 |
| Labels gesamt | 207 | CL001-CL207 |
| Klassendateien | 216 | 18 Ã— 12 |
| Gesamtdauer | ~32h | Alle Probanden zusammen |

### Berechnungsbeispiel fÃ¼r einen Datensatz

**Annahme:** Ein Subjekt hat eine Session-Dauer von 1 Stunde.

* **Frames pro Subjekt:** ~108.000 (3600 Sekunden Ã— 30 fps)
* **Zeilen pro Klassendatei:** ~108.000 + 1 Header-Zeile = 108.001
* **Gesamtzeilen fÃ¼r alle 12 Dateien:** 12 Ã— 108.001 = 1.296.012 Zeilen

**Bei 18 Subjekten mit durchschnittlich 1,78 Stunden:**
* **GeschÃ¤tzte Gesamt-Frames:** ~1,94 Millionen Frames
* **GeschÃ¤tzte Gesamt-Zeilen:** ~23,3 Millionen Annotationszeilen

---

## 5.9 Zusammenfassung der Datenstruktur

### Kernprinzipien
1.  **Frame-basiert:** Alle Daten sind auf Frame-Ebene annotiert.
2.  **VollstÃ¤ndig synchronisiert:** Alle 12 Klassendateien pro Subjekt teilen identische Frame-Indices.
3.  **Session-organisiert:** 3 Subjekte pro Session, parallele Aufzeichnung.
4.  **Szenario-flexibel:** Mehrere Szenarien kÃ¶nnen innerhalb einer Session auftreten.
5.  **Multi-Label-fÃ¤hig:** Bestimmte Kategorien (z. B. HÃ¤nde) kÃ¶nnen mehrere aktive Labels gleichzeitig haben.

### Datenfluss-Schema

```text
Session (3 Subjekte parallel)
    â†“
Subjekt S01 (eigenstÃ¤ndiger Datensatz)
    â†“
12 Klassendateien (CC01-CC12)
    â†“
Pro Klassendatei: N Frames (Zeilen 2 bis N+1)
    â†“
Pro Frame: 0/1-Werte fÃ¼r alle Labels dieser Kategorie
```

### Wichtige Eigenschaften fÃ¼r Analysen

**FÃ¼r zeitliche Analysen:**

* Alle Frames sind Ã¤quidistant (konstante 30 fps).
* Frame-Nummer ist direkt in Zeit umrechenbar.
* Keine LÃ¼cken oder fehlende Frames.

**FÃ¼r Prozess-Analysen:**

* Prozesshierarchie ist in CC08-CC10 kodiert.
* Szenariogrenzen erkennbar durch Prozesswechsel.
* BPMN-Ablauf ist Ã¼ber Frame-Sequenzen rekonstruierbar.

**FÃ¼r AktivitÃ¤ts-Analysen:**

* KÃ¶rperaktivitÃ¤ten in CC01-CC05.
* Multi-dimensionale Beschreibung (Main + Sub-Activities).
* Hand-AktivitÃ¤ten inkl. Objekt- und Tool-Informationen.

**FÃ¼r Kontext-Analysen:**

* Order-Information in CC06.
* IT-Nutzung in CC07.
* RÃ¤umliche Position in CC11-CC12.

---

## Verwendungshinweise fÃ¼r diese Datei

**Diese Datei nutzen fÃ¼r:**
* Fragen zur Frame-Synchronisation.
* VerstÃ¤ndnis der Klassendatei-Struktur.
* Zeitliche Umrechnungen (Frame â†” Zeit).
* Session-Organisation und Subjekt-Zuordnung.
* Datensatzumfang und Statistiken.

**Nicht in dieser Datei:**
* Inhaltliche Label-Definitionen â†’ Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)
* BPMN-Prozesslogik â†’ Siehe [auxiliary_dataset_core_v5_0.md](./auxiliary_dataset_core_v5_0.md)
* Probanden-Demographie â†’ Siehe [auxiliary_dataset_core_v5_0.md](./auxiliary_dataset_core_v5_0.md)
* Physisches Laborlayout â†’ Siehe [auxiliary_warehouse_physical_v5_0.md](./auxiliary_warehouse_physical_v5_0.md)

---

## Technische Hinweise fÃ¼r Datenverarbeitung

### CSV-Format der Klassendateien

```csv
Label1,Label2,Label3,...,LabelN
0,1,0,...,0
1,0,0,...,0
0,0,1,...,0
...
```

**Wichtig:**

* Erste Zeile = Header mit Labelnamen.
* Ab Zeile 2 = Frame-Daten.
* Werte sind ausschlieÃŸlich 0 oder 1.
* Anzahl Spalten = Anzahl Labels der Kategorie.

### Frame-Index-Konsistenz prÃ¼fen

**Pseudo-Code fÃ¼r Validierung:**

```python
# Alle 12 Klassendateien eines Subjekts laden
files = [CC01, CC02, ..., CC12]

# Zeilenzahl prÃ¼fen (ohne Header)
line_counts = [len(file) - 1 for file in files]

# MÃ¼ssen alle identisch sein
assert len(set(line_counts)) == 1, "Frame-Anzahl inkonsistent!"

print(f"âœ“ Alle Dateien haben {line_counts[0]} Frames")
```

### Speicherbedarf (SchÃ¤tzung)

**Pro Subjekt (angenommen 108.000 Frames):**

* 12 Dateien Ã— ~108.000 Zeilen Ã— ~50 Bytes/Zeile = **~64 MB**

**Gesamter Datensatz (18 Subjekte):**

* 18 Ã— 64 MB = **~1,15 GB** (reine CSV-Daten, unkomprimiert)

---

## Metadaten

**Datei-Version:** 5.0 (Versioniert)  
**Erstellt:** ursprÃ¼nglich vor 20.10.2025  
**Aktualisiert:** 04.02.2026 (v5.0-Versionierung)  
**Status:** Finalisiert âœ…  
**Bemerkung:** Inhaltlich unverÃ¤ndert. Nur Referenzen auf _v5_0-Dateien aktualisiert.
