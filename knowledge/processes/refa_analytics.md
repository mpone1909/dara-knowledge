# DaRa Dataset – REFA-Analytik und Zeitarten

Diese Datei definiert das **analytische Framework zur Übersetzung der DaRa-Klassenkategorien (CC01–CC12) in arbeitswissenschaftliche Zeitarten** nach REFA-Standard.

**Zweck:** Ermöglichung von Zeitstudien, Prozessanalysen und Erholungszeitermittlungen auf Basis der annotierten Frame-Daten.

**Standard-Basis:** REFA-Methodenlehre (Grundausbildung 4.0).

---

## 1. Grundprinzip der Transformation

Der DaRa-Datensatz (Data Fusion for Advanced Research in Industrial Applications) ist so strukturiert, dass er eine direkte Ableitung von REFA-Zeitarten ermöglicht. Die Transformation basiert auf einer **hierarchischen Mapping-Logik:**

1. **CC09 (Mid-Level Process)** bestimmt die Grob-Zeitart (z. B. Rüstzeit vs. Ausführungszeit).
2. **CC10 (Low-Level Process)** bestimmt die Fein-Differenzierung (z. B. Wartezeit vs. Tätigkeitszeit).
3. **CC01 (Main Activity)** validiert die Aktivität (z. B. ob eine Wartezeit ablaufbedingt oder persönlich ist).
4. **CC03 (Torso)** & **CC04/05 (Hands)** liefern die Parameter für die Erholungszeit ($t_{er}$) (Belastungsanalyse).

---

## 2. Die Auftragszeit ($T$) im DaRa-Kontext

Die Gesamtzeit für einen Auftragsdurchlauf (Order Sequence) entspricht der **REFA-Auftragszeit $T$**.

**Formel:**
$$T = t_R + t_A + t_E$$

**Wobei:**

- $t_R$ = Rüstzeit (Setup Time)
- $t_A$ = Ausführungszeit (Execution Time)
- $t_E$ = Erholungszeit (Recovery Time)

---

### 2.1 Rüstzeit ($t_R$)

Die Rüstzeit umfasst alle Phasen der **Vorbereitung und des Abschlusses** eines Auftrags.

**DaRa-Mapping:**

- **Quelle:** CC09 (Mid-Level Process)
- **Relevante Labels:**
  - `CL114` | Preparing Order
  - `CL121` | Finalizing Order

- **Komponenten (CC10):**
  - `CL124` | Collecting Order and Hardware
  - `CL125` | Collecting Cart
  - `CL133` | Returning Hardware
  - `CL132` | Returning Cart

**Logik:**
Alle Frames, in denen CC09 = `CL114` oder `CL121` ist, werden zur Summe $t_R$ addiert.

---

### 2.2 Ausführungszeit ($t_A$)

Die Ausführungszeit ist die Zeit der planmäßigen Durchführung der Aufgabe. Sie unterteilt sich in:

$$t_A = t_{MH} + t_{MN}$$

#### A. Beeinflussbare Haupttätigkeit ($t_{MH}$)

Die **unmittelbare Erfüllung der Aufgabe** (Wertschöpfung am Objekt).

**DaRa-Mapping:**

- **Kontext (CC09):** `CL116` | Picking – Pick Time ODER `CL120` | Storing – Store Time
- **Aktivität (CC01):**
  - Handling (Upwards/Centered/Downwards) (Greifen/Fügen)
  - Scanning (Datenerfassung als Teil der Aufgabe)
  - Confirming (Abschluss der Tätigkeit)

#### B. Beeinflussbare Nebentätigkeit ($t_{MN}$)

**Mittelbare Aufgaben**, die zur Durchführung notwendig sind (z. B. Wegezeiten, Orientierung).

**DaRa-Mapping:**

- **Kontext (CC09):** `CL115` | Picking – Travel Time ODER `CL119` | Storing – Travel Time
- **Kontext (CC09):** `CL117` | Unpacking / `CL118` | Packing (sofern nicht Hauptaufgabe)
- **Aktivität (CC01):**
  - Walking (Wegzeit)
  - Pulling/Pushing Cart (Transport)
  - Standing (während Travel Time = Orientierung/Lesen der Liste)

---

## 3. Detaillierte Mapping-Tabelle (CC09/CC10 zu REFA)

Diese Tabelle ist die **zentrale Referenz für algorithmische Zeitarten-Zuweisungen**.

| DaRa CC09 (Mid-Level) | DaRa CC10 (Low-Level) | REFA-Symbol | REFA-Bezeichnung | Logik / Bedingung |
| :--- | :--- | :--- | :--- | :--- |
| `CL114 Preparing` | Alle | $t_{R}$ | Rüstzeit | Vorbereitung des Auftrags |
| `CL121 Finalizing` | Alle | $t_{R}$ | Rüstzeit | Abschluss des Auftrags |
| `CL115 Pick Travel` | `CL137` Moving to Position | $t_{MN}$ | Nebentätigkeit | Wegzeit zum Lagerplatz |
| `CL115 Pick Travel` | `CL134` Waiting | $t_{A}$ (bedingt) | Ablaufbed. Unterbrechen | Warten auf Wegfreigabe (Verkehr) |
| `CL116 Pick Time` | `CL139` Retrieving Items | $t_{MH}$ | Haupttätigkeit | Entnahme (Wertschöpfung) |
| `CL116 Pick Time` | `CL151` Placing in Cart | $t_{MH}$ | Haupttätigkeit | Ablegen (Wertschöpfung) |
| `CL116 Pick Time` | `CL146` Printing Label | $t_{MN}$ | Nebentätigkeit | Labeldruck am Regal |
| `CL119 Store Travel` | Alle | $t_{MN}$ | Nebentätigkeit | Wegzeit zur Einlagerung |
| `CL120 Store Time` | `CL138` Placing on Rack | $t_{MH}$ | Haupttätigkeit | Einlagern (Wertschöpfung) |
| Alle | `CL135` Reporting Incident | $t_{s}$ | Störzeit (Verteilzeit) | Melden einer Störung |
| Alle | `CL134` Waiting | $t_{w}$ / $t_{s}$ | Wartezeit | Kontext-Check nötig:<br>Wenn CC07=NoIT → $t_{s}$ (Systemausfall)<br>Wenn CC11=Path → $t_{w}$ (Blockade) |

---

## 4. Erholungszeitermittlung ($t_{E}$)

Die Erholungszeit ist die Summe der Soll-Zeiten für die **Erholung des Menschen**. Im DaRa-Datensatz wird sie analytisch aus den Belastungsklassen abgeleitet.

**Basis:** EAB (Erholungszeitermittlung nach Arbeitswissenschaftlichen Biometrischen Daten).

---

### 4.1 Haltungsbedingte Belastung (Statische Arbeit)

Die primäre Quelle für Haltungszuschläge ist **CC03 (Torso)**.

| DaRa CC03 Label | Beschreibung | EAB-Kategorie (Approximation) | Zuschlagsklasse (Beispiel) |
| :--- | :--- | :--- | :--- |
| `CL024` No Bending | Aufrechte Haltung | Haltung 1 (Sitz/Steh normal) | 0 % |
| `CL025` Slightly Bending | Beugung 10-30° | Haltung 2 (Leichte Zwangshaltung) | ~4 - 8 % |
| `CL026` Strongly Bending | Beugung >30° | Haltung 3/4 (Starke Rumpfbeuge) | ~15 - 20 % |
| `CL027` Torso Rotation | Verdrehung | Zusatzfaktor "Verdrehung" | +5 % (additiv) |

**Zusatzfaktor Beine (CC02):**

- `CL020` Squat (Hocke): Gilt als extreme Zwangshaltung → Hoher Zuschlag.

---

### 4.2 Lastabhängige Belastung (Dynamische Arbeit)

Die Lastgewichte werden über **CC04/CC05 (Object)** geschätzt.

| DaRa CC04/05 Label | Objektgröße | Geschätztes Gewicht (Lastklasse) |
| :--- | :--- | :--- |
| `CL043` Small Item | Kleinteile (< 1kg) | Laststufe 1 (Vernachlässigbar) |
| `CL042` Medium Item | Schuhkartongröße (1-5 kg) | Laststufe 2 (Mittel) |
| `CL041` Large Item | Umzugskarton (> 5-10 kg) | Laststufe 3 (Schwer) |

---

### 4.3 Berechnungslogik für $t_{er}$

Die Erholungszeit für einen Chunk $i$ berechnet sich wie folgt:

$$t_{er, i} = t_{Basis, i} \times (Z_{Haltung} + Z_{Last} + Z_{Umgebung})$$

**Schritte:**
1. Bestimme Dauer $t_{Basis, i}$ des Chunks.
2. Ermittle $Z_{Haltung}$ basierend auf CC03 des Chunks.
3. Ermittle $Z_{Last}$ basierend auf CC04/05 Object (nur während Picking/Storing).
4. Summiere $t_{er}$ über alle Chunks eines Auftrags.

---

## 5. Verteilzeit ($t_v$)

Verteilzeiten sind Zeiten, die durch **Störungen oder persönliche Unterbrechungen** entstehen.

**Formel:**
$$t_v = t_s + t_p$$

**Wobei:**

- $t_s$ = Sachliche Verteilzeit (Störungen)
- $t_p$ = Persönliche Verteilzeit (Pause, Toilette, Gespräch)

---

### 5.1 Identifikation im Datensatz

**1. Explizite Störungen ($t_s$):**

- Wenn CC10 = `CL135` Reporting and Clarifying Incident.
- Wenn CC13 (falls vorh.) oder Metadaten = Picking Error (Korrekturaufwand).

**2. Implizite Störungen ($t_s$):**

- Wenn CC10 = `CL134` Waiting UND CC07 = No IT (Hinweis auf Scanner-Ausfall/Reboot).

**3. Persönliche Zeiten ($t_p$):**

- Wenn CC01 = Standing oder Another Main Activity UND CC10 = Waiting OHNE erkennbaren operativen Grund (z. B. im leeren Gang, keine Prozessaktivität).
- Oft schwer automatisch zu trennen; im Standard-DaRa-Szenario ("Perfect Run") ist $t_p \approx 0$.

---

## 6. Formales Berechnungsmodell (Algorithmus)

Um die Gesamtauftragszeit für einen Probanden $P$ in Szenario $S$ zu berechnen:

```python
def calculate_refa_times(chunks):
    T_R = 0.0   # Rüstzeit
    T_MH = 0.0  # Haupttätigkeit
    T_MN = 0.0  # Nebentätigkeit
    T_V = 0.0   # Verteilzeit
    
    for chunk in chunks:
        duration = chunk.duration_seconds
        cc09 = chunk.labels['CC09']
        cc10 = chunk.labels['CC10']
        cc01 = chunk.labels['CC01']
        
        # 1. Rüstzeit-Check
        if cc09 in ['CL114', 'CL121']:
            T_R += duration
            continue
            
        # 2. Verteilzeit-Check (Störung)
        if cc10 == 'CL135':
            T_V += duration
            continue
            
        # 3. Prozesszeiten (Ausführung)
        if cc09 in ['CL116', 'CL120']: # Pick/Store Time
            if cc01 in ['Handling', 'Scanning', 'Confirming']:
                T_MH += duration
            else:
                # z.B. kurzes Warten oder Orientieren während Pick Time
                T_MN += duration
                
        elif cc09 in ['CL115', 'CL119']: # Travel Time
            # Wegezeit ist klassische Nebentätigkeit
            T_MN += duration
            
        else:
            # Fallback für Unpacking/Packing etc.
            T_MN += duration
            
    return {
        'Auftragszeit': T_R + T_MH + T_MN + T_V,
        'Ruestzeit': T_R,
        'Haupttaetigkeit': T_MH,
        'Nebentaetigkeit': T_MN,
        'Verteilzeit': T_V
    }
```

---

## Verwendungshinweise

**Diese Datei nutzen für:**

- Berechnung von REFA-Zeitarten aus DaRa-Daten.
- Analyse von Wertschöpfungsanteilen (Value Added vs. Non-Value Added).
- Ergonomische Bewertungen (Erholungszeit).
- Prozessoptimierung (Identifikation von $t_{MN}$-Treibern).

**Nicht in dieser Datei:**

- Definition der Labels selbst → `class_hierarchy.md`.
- Chunking-Grundlagen → `chunking.md`.

**Erstellt:** 23.12.2025
**Basis:** DaRa Dataset Description & REFA-Kompendium Arbeitsorganisation

---

## 7. MTM-1 Grundbewegungen (siehe mtm_codes.md)

**Vollständige Dokumentation:** `knowledge/processes/mtm_codes.md`

### Kurzreferenz: MTM ↔ DaRa-Labels

| MTM-Code | Bewegung | TMU-Wert | DaRa-Label (CC10) | REFA-Zeitart |
|----------|----------|----------|-------------------|--------------|
| R | Reach | R50B: 18,4 | CL149 "Reaching for Items" | $t_{MN}$ |
| G | Grasp | G1A: 2,0 | CL150 "Grasping Items" | $t_{MH}$ |
| M | Move | M40B: 15,6 | CL146 "Placing Items" | $t_{MH}$ |
| P | Position | P1SE: 5,6 | CL146 (implizit) | $t_{MH}$ |
| RL | Release | RL1: 2,0 | CL146 (implizit) | $t_{MH}$ |
| B | Bend | B: 29,0 | CL129 "Bending" + CL025 "Downwards" | $t_{MH}$ + $t_E$ |
| W | Walk | W: 15,0 | CL137 "Moving" + CL022 "Walking" | $t_{MN}$ |

**TMU-Einheit:** 1 TMU = 0,036 Sekunden

### Anwendungsbeispiel: Order 2904, Position 14 (Palmenerde)

```
Artikel: Palm Soil (5149g, Large [L])
Lagerort: R7.3.1.A (Aisle 4, Regalkomplex 7, Ebene 1 = Bodenebene)

MTM-Sequenz:
1. W (Walking to Aisle 4): ~200 TMU
2. R50B (Reach to Ebene 1): 18,4 TMU
3. B (Bend to Bodenebene): 29,0 TMU
4. G1A (Grasp Bulky Unit): 2,0 TMU
5. M40B (Move to Cart): 15,6 TMU
6. RL1 (Release): 2,0 TMU

Gesamt: ~267 TMU = 9,6 Sekunden (ohne Erholungszeit)
+ Erholungszeit für B + Large [L] → ~15-20 Sekunden gesamt
```

**Siehe:** `mtm_codes.md` für vollständige TMU-Tabellen und Berechnungsbeispiele
