# DaRa Dataset – Datenstruktur

Diese Datei beschreibt die vollständige Datenstruktur des DaRa-Datensatzes basierend auf der offiziellen Dataset Description (Stand 20.10.2025).

---

## 5.1 Überblick über die Datenstruktur

Die Datenstruktur des DaRa-Datensatzes basiert auf synchron aufgezeichneten Sessions, in denen jeweils drei Subjekte gleichzeitig agieren. Innerhalb jeder Session können mehrere Szenarien auftreten, und jedes Subjekt erzeugt dabei einen eigenen vollständigen Datensatz mit 12 Klassendateien. Alle Klassendateien sind zeitlich vollständig synchronisiert.

---

## 5.2 Sessions

### Definition

- Eine **Session** ist ein zusammenhängender Aufzeichnungsblock.  
- In jeder Session nehmen **drei Subjekte gleichzeitig** teil.  
- Innerhalb einer Session können **mehrere Szenarien** auftreten.

### Eigenschaften

- Gemeinsamer Zeitstrahl für alle drei Subjekte.  
- Synchronisierte Frame-Indices über alle Klassendateien hinweg.  
- Jedes Subjekt erzeugt einen eigenen Datensatz innerhalb derselben Session.

---

## 5.3 Subjekte innerhalb einer Session

### Struktur

Für jedes der drei Subjekte gelten folgende Eigenschaften:

- Ein zusammenhängender Datenstrom im Rahmen derselben Session.  
- Eigene Klassendateien (12 Stück pro Subjekt).  
- Identische Anzahl an Frames pro Datei (innerhalb derselben Session).

### Zuordnung

- Subjekt-ID (S01–S18) ist eindeutig.  
- Subjekt-Daten verweisen auf eine Session-ID.  
- Szenarioabschnitte innerhalb einer Session werden dem Subjekt zeitlich zugeordnet.

---

## 5.4 Szenarien innerhalb einer Session

### Eigenschaften

- Eine Session kann **mehrere unterschiedliche Szenarien** enthalten.  
- Szenarien werden in zeitlicher Reihenfolge nacheinander ausgeführt.  
- Jedes Subjekt kann innerhalb derselben Session mehrere Szenarien durchlaufen.

### Szenariozuordnung

- Die Szenarien S1–S8 werden zeitlich anhand der Annotationen markiert.  
- Szenariogrenzen ergeben sich klar aus den Labels der Prozesskategorien (CC08–CC10).

---

## 5.5 Klassendateien

### Allgemeiner Aufbau

Pro Subjekt gibt es **12 Klassendateien**, entsprechend den Kategorien:

- **CC01** Main Activity  
- **CC02** Legs  
- **CC03** Torso  
- **CC04** Left Hand  
- **CC05** Right Hand  
- **CC06** Order  
- **CC07** IT  
- **CC08** High-Level Process  
- **CC09** Mid-Level Process  
- **CC10** Low-Level Process  
- **CC11** Location Human  
- **CC12** Location Cart

### Struktur jeder Klassendatei

1. **Erste Zeile:** vollständige Liste der zugehörigen Labelnamen.  
2. **Ab Zeile 2:** pro Frame ein Satz an 0/1-Werten.  
3. **Eine Zeile entspricht exakt einem Frame.**  
4. Alle 12 Klassendateien eines Subjekts haben:  
   - die gleiche Anzahl an Zeilen,  
   - die gleiche zeitliche Abdeckung,  
   - identische Frame-Indizes.

### Inhaltliche Eigenschaften

- Die Werte pro Zeile geben an, welche Labels im jeweiligen Frame aktiv sind.  
- Multi-Label-Aktivierungen sind möglich (z. B. mehrere Hand-Objekt-Zustände gleichzeitig).  
- Keine zusätzlichen Sensorstreams — die Klassendateien enthalten alle notwendigen Informationen.

### Beispiel einer Klassendatei-Struktur (CC01 - Main Activity)

```
Header Row:    Idle,Walking,Picking,Unpacking,Packing,Storing,Another Main Activity,Main Activity Unknown
Frame 1:       1,0,0,0,0,0,0,0
Frame 2:       1,0,0,0,0,0,0,0
Frame 3:       0,1,0,0,0,0,0,0
Frame 4:       0,1,0,0,0,0,0,0
...
```

**Interpretation:**
- Frame 1-2: Subjekt ist im Zustand "Idle" (CL001 aktiv)
- Frame 3-4: Subjekt ist im Zustand "Walking" (CL002 aktiv)

---

## 5.6 Frame-Struktur

### Frame-Definition

- Ein Frame entspricht einem Zeitpunkt der synchronen Video- und IMU-Aufzeichnung.  
- Bildrate: **29,97 fps**, für Modellierungszwecke auf **30 fps** gerundet.

### Frame-Eigenschaften

- Jeder Frame bildet einen vollständigen Zustand ab:  
  - Hauptaktivität (CC01)  
  - Körperhaltungen und Bewegungen (CC02–CC05)  
  - Kontext (Order, IT, Location Human, Location Cart) (**CC06**, **CC07**, **CC11**, **CC12**)   
  - Prozesszuordnung (CC08–CC10)  
- Ein Frame enthält ausschließlich **0/1-Indikatoren**:
  - **0** = Label nicht aktiv in diesem Frame
  - **1** = Label aktiv in diesem Frame

### Frame-Synchronisation

**Kritisch für das Verständnis:**
- Alle 12 Klassendateien eines Subjekts haben **identische Länge** (gleiche Anzahl Zeilen)
- **Frame N** in Klassendatei A entspricht zeitlich **exakt Frame N** in Klassendateien B-L
- Beispiel: Frame 1000 in CC01 (Main Activity) ist der **gleiche Zeitpunkt** wie Frame 1000 in CC04 (Left Hand)

### Zeitliche Auflösung

- **1 Frame = 1/30 Sekunde ≈ 0,0333 Sekunden**
- **30 Frames = 1 Sekunde**
- **1800 Frames = 1 Minute**
- **108.000 Frames = 1 Stunde**

---

## 5.7 Zeitliche Struktur

### Gesamtumfang

- Gesamtdauer der Aufzeichnung aller Probanden ca. **32 Stunden**.  
- Alle 32 Stunden gelten als Teil derselben logistischen Tätigkeit entsprechend der Zeiterfassung der Probanden in der Tabelle im Paper.

### Synchronität

- Drei Subjekte innerhalb einer Session sind **synchron** aufgezeichnet.  
- Alle Klassendateien innerhalb eines Subjekts haben identische Länge.  
- Szenarien sind zeitlich unabhängig zwischen Subjekten.

### Frame-to-Time Mapping

**Umrechnung Frame → Zeit:**
```
Zeit_in_Sekunden = Frame_Nummer / 30
Zeit_in_Minuten = Frame_Nummer / 1800
```

**Umrechnung Zeit → Frame:**
```
Frame_Nummer = Zeit_in_Sekunden * 30
```

**Beispiele:**
- Frame 900 = 30 Sekunden
- Frame 3600 = 2 Minuten
- Frame 54000 = 30 Minuten

---

## 5.8 Datensatzumfang

### Gesamtübersicht

- **18 Subjekte** (S01–S18)  
- **6 Sessions**, jede mit 3 Subjekten  
- **216 Klassendateien** (18 Subjekte × 12 Klassenkategorien)  
- **207 Labeltypen** über alle Kategorien (CL001-CL207)

### Strukturierte Zusammenfassung

| Dimension | Anzahl | Beschreibung |
|-----------|--------|--------------|
| Probanden | 18 | S01-S18 |
| Sessions | 6 | Je 3 Subjekte parallel |
| Szenarien | 8 | S1-S8 |
| Klassenkategorien | 12 | CC01-CC12 |
| Labels gesamt | 207 | CL001-CL207 |
| Klassendateien | 216 | 18 × 12 |
| Gesamtdauer | ~32h | Alle Probanden zusammen |

### Berechnungsbeispiel für einen Datensatz

**Annahme:** Ein Subjekt hat eine Session-Dauer von 1 Stunde

- **Frames pro Subjekt:** ~108.000 (3600 Sekunden × 30 fps)
- **Zeilen pro Klassendatei:** ~108.000 + 1 Header-Zeile = 108.001
- **Gesamtzeilen für alle 12 Dateien:** 12 × 108.001 = 1.296.012 Zeilen

**Bei 18 Subjekten mit durchschnittlich 1,78 Stunden:**
- **Geschätzte Gesamt-Frames:** ~1,94 Millionen Frames
- **Geschätzte Gesamt-Zeilen:** ~23,3 Millionen Annotationszeilen

---

## 5.9 Zusammenfassung der Datenstruktur

### Kernprinzipien

1. **Frame-basiert:** Alle Daten sind auf Frame-Ebene annotiert
2. **Vollständig synchronisiert:** Alle 12 Klassendateien pro Subjekt teilen identische Frame-Indices
3. **Session-organisiert:** 3 Subjekte pro Session, parallele Aufzeichnung
4. **Szenario-flexibel:** Mehrere Szenarien können innerhalb einer Session auftreten
5. **Multi-Label-fähig:** Bestimmte Kategorien (z.B. Hände) können mehrere aktive Labels gleichzeitig haben

### Datenfluss-Schema

```
Session (3 Subjekte parallel)
    ↓
Subjekt S01 (eigenständiger Datensatz)
    ↓
12 Klassendateien (CC01-CC12)
    ↓
Pro Klassendatei: N Frames (Zeilen 2 bis N+1)
    ↓
Pro Frame: 0/1-Werte für alle Labels dieser Kategorie
```

### Wichtige Eigenschaften für Analysen

**Für zeitliche Analysen:**
- Alle Frames sind äquidistant (konstante 30 fps)
- Frame-Nummer ist direkt in Zeit umrechenbar
- Keine Lücken oder fehlende Frames

**Für Prozess-Analysen:**
- Prozesshierarchie ist in CC08-CC10 kodiert
- Szenariogrenzen erkennbar durch Prozesswechsel
- BPMN-Ablauf ist über Frame-Sequenzen rekonstruierbar

**Für Aktivitäts-Analysen:**
- Körperaktivitäten in CC01-CC05
- Multi-dimensionale Beschreibung (Main + Sub-Activities)
- Hand-Aktivitäten inkl. Objekt- und Tool-Informationen

**Für Kontext-Analysen:**
- Order-Information in CC06
- IT-Nutzung in CC07
- Räumliche Position in CC11-CC12

---

## Verwendungshinweise für diese Datei

**Diese Datei nutzen für:**
- Fragen zur Frame-Synchronisation
- Verständnis der Klassendatei-Struktur
- Zeitliche Umrechnungen (Frame ↔ Zeit)
- Session-Organisation und Subjekt-Zuordnung
- Datensatzumfang und Statistiken

**Nicht in dieser Datei:**
- Inhaltliche Label-Definitionen → Siehe `class_hierarchy.md`
- BPMN-Prozesslogik → Siehe `dataset_core.md`
- Probanden-Demographie → Siehe `dataset_core.md`

---

## Technische Hinweise für Datenverarbeitung

### CSV-Format der Klassendateien

```csv
Label1,Label2,Label3,...,LabelN
0,1,0,...,0
1,0,0,...,0
0,0,1,...,0
...
```

**Wichtig:**
- Erste Zeile = Header mit Labelnamen
- Ab Zeile 2 = Frame-Daten
- Werte sind ausschließlich 0 oder 1
- Anzahl Spalten = Anzahl Labels der Kategorie

### Frame-Index-Konsistenz prüfen

**Pseudo-Code für Validierung:**
```python
# Alle 12 Klassendateien eines Subjekts laden
files = [CC01, CC02, ..., CC12]

# Zeilenzahl prüfen (ohne Header)
line_counts = [len(file) - 1 for file in files]

# Müssen alle identisch sein
assert len(set(line_counts)) == 1, "Frame-Anzahl inkonsistent!"

print(f"✓ Alle Dateien haben {line_counts[0]} Frames")
```

### Speicherbedarf (Schätzung)

**Pro Subjekt (angenommen 108.000 Frames):**
- 12 Dateien × ~108.000 Zeilen × ~50 Bytes/Zeile = **~64 MB**

**Gesamter Datensatz (18 Subjekte):**
- 18 × 64 MB = **~1,15 GB** (reine CSV-Daten, unkomprimiert)
