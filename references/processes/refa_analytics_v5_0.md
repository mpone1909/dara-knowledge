---
version: 5.0
status: finalisiert
created: 2026-02-04
---

# DaRa Dataset â€“ REFA-Analytik und Zeitarten

Diese Datei definiert das **analytische Framework zur Ãœbersetzung der DaRa-Klassenkategorien (CC01â€“CC12) in arbeitswissenschaftliche Zeitarten** nach REFA-Standard.

**Zweck:** ErmÃ¶glichung von Zeitstudien, Prozessanalysen und Erholungszeitermittlungen auf Basis der annotierten Frame-Daten.

**Standard-Basis:** REFA-Methodenlehre (Grundausbildung 4.0).

---

## 1. Grundprinzip der Transformation

Der DaRa-Datensatz (Data Fusion for Advanced Research in Industrial Applications) ist so strukturiert, dass er eine direkte Ableitung von REFA-Zeitarten ermÃ¶glicht. Die Transformation basiert auf einer **hierarchischen Mapping-Logik:**

1. **CC09 (Mid-Level Process)** bestimmt die Grob-Zeitart (z. B. RÃ¼stzeit vs. AusfÃ¼hrungszeit).
2. **CC10 (Low-Level Process)** bestimmt die Fein-Differenzierung (z. B. Wartezeit vs. TÃ¤tigkeitszeit).
3. **CC01 (Main Activity)** validiert die AktivitÃ¤t (z. B. ob eine Wartezeit ablaufbedingt oder persÃ¶nlich ist).
4. **CC03 (Torso)** & **CC04/05 (Hands)** liefern die Parameter fÃ¼r die Erholungszeit ($t_{er}$) (Belastungsanalyse).

---

## 2. Die Auftragszeit ($T$) im DaRa-Kontext

Die Gesamtzeit fÃ¼r einen Auftragsdurchlauf (Order Sequence) entspricht der **REFA-Auftragszeit $T$**.

**Formel:**
$$T = t_R + t_A + t_E$$

**Wobei:**

- $t_R$ = RÃ¼stzeit (Setup Time)
- $t_A$ = AusfÃ¼hrungszeit (Execution Time)
- $t_E$ = Erholungszeit (Recovery Time)

---

### 2.1 RÃ¼stzeit ($t_R$)

Die RÃ¼stzeit umfasst alle Phasen der **Vorbereitung und des Abschlusses** eines Auftrags.

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

### 2.2 AusfÃ¼hrungszeit ($t_A$)

Die AusfÃ¼hrungszeit ist die Zeit der planmÃ¤ÃŸigen DurchfÃ¼hrung der Aufgabe. Sie unterteilt sich in:

$$t_A = t_{MH} + t_{MN}$$

#### A. Beeinflussbare HaupttÃ¤tigkeit ($t_{MH}$)

Die **unmittelbare ErfÃ¼llung der Aufgabe** (WertschÃ¶pfung am Objekt).

**DaRa-Mapping:**

- **Kontext (CC09):** `CL116` | Picking â€“ Pick Time ODER `CL120` | Storing â€“ Store Time
- **AktivitÃ¤t (CC01):**
  - Handling (Upwards/Centered/Downwards) (Greifen/FÃ¼gen)
  - Scanning (Datenerfassung als Teil der Aufgabe)
  - Confirming (Abschluss der TÃ¤tigkeit)

#### B. Beeinflussbare NebentÃ¤tigkeit ($t_{MN}$)

**Mittelbare Aufgaben**, die zur DurchfÃ¼hrung notwendig sind (z. B. Wegezeiten, Orientierung).

**DaRa-Mapping:**

- **Kontext (CC09):** `CL115` | Picking â€“ Travel Time ODER `CL119` | Storing â€“ Travel Time
- **Kontext (CC09):** `CL117` | Unpacking / `CL118` | Packing (sofern nicht Hauptaufgabe)
- **AktivitÃ¤t (CC01):**
  - Walking (Wegzeit)
  - Pulling/Pushing Cart (Transport)
  - Standing (wÃ¤hrend Travel Time = Orientierung/Lesen der Liste)

---

## 3. Detaillierte Mapping-Tabelle (CC09/CC10 zu REFA)

Diese Tabelle ist die **zentrale Referenz fÃ¼r algorithmische Zeitarten-Zuweisungen**.

| DaRa CC09 (Mid-Level) | DaRa CC10 (Low-Level) | REFA-Symbol | REFA-Bezeichnung | Logik / Bedingung |
| :--- | :--- | :--- | :--- | :--- |
| `CL114 Preparing` | Alle | $t_{R}$ | RÃ¼stzeit | Vorbereitung des Auftrags |
| `CL121 Finalizing` | Alle | $t_{R}$ | RÃ¼stzeit | Abschluss des Auftrags |
| `CL115 Pick Travel` | `CL137` Moving to Position | $t_{MN}$ | NebentÃ¤tigkeit | Wegzeit zum Lagerplatz |
| `CL115 Pick Travel` | `CL134` Waiting | $t_{A}$ (bedingt) | Ablaufbed. Unterbrechen | Warten auf Wegfreigabe (Verkehr) |
| `CL116 Pick Time` | `CL139` Retrieving Items | $t_{MH}$ | HaupttÃ¤tigkeit | Entnahme (WertschÃ¶pfung) |
| `CL116 Pick Time` | `CL151` Placing in Cart | $t_{MH}$ | HaupttÃ¤tigkeit | Ablegen (WertschÃ¶pfung) |
| `CL116 Pick Time` | `CL146` Printing Label | $t_{MN}$ | NebentÃ¤tigkeit | Labeldruck am Regal |
| `CL119 Store Travel` | Alle | $t_{MN}$ | NebentÃ¤tigkeit | Wegzeit zur Einlagerung |
| `CL120 Store Time` | `CL138` Placing on Rack | $t_{MH}$ | HaupttÃ¤tigkeit | Einlagern (WertschÃ¶pfung) |
| Alle | `CL135` Reporting Incident | $t_{s}$ | StÃ¶rzeit (Verteilzeit) | Melden einer StÃ¶rung |
| Alle | `CL134` Waiting | $t_{w}$ / $t_{s}$ | Wartezeit | Kontext-Check nÃ¶tig:<br>Wenn CC07=NoIT â†’ $t_{s}$ (Systemausfall)<br>Wenn CC11=Path â†’ $t_{w}$ (Blockade) |

---

## 4. Erholungszeitermittlung ($t_{E}$)

Die Erholungszeit ist die Summe der Soll-Zeiten fÃ¼r die **Erholung des Menschen**. Im DaRa-Datensatz wird sie analytisch aus den Belastungsklassen abgeleitet.

**Basis:** EAB (Erholungszeitermittlung nach Arbeitswissenschaftlichen Biometrischen Daten).

---

### 4.1 Haltungsbedingte Belastung (Statische Arbeit)

Die primÃ¤re Quelle fÃ¼r HaltungszuschlÃ¤ge ist **CC03 (Torso)**.

| DaRa CC03 Label | Beschreibung | EAB-Kategorie (Approximation) | Zuschlagsklasse (Beispiel) |
| :--- | :--- | :--- | :--- |
| `CL024` No Bending | Aufrechte Haltung | Haltung 1 (Sitz/Steh normal) | 0 % |
| `CL025` Slightly Bending | Beugung 10-30Â° | Haltung 2 (Leichte Zwangshaltung) | ~4 - 8 % |
| `CL026` Strongly Bending | Beugung >30Â° | Haltung 3/4 (Starke Rumpfbeuge) | ~15 - 20 % |
| `CL027` Torso Rotation | Verdrehung | Zusatzfaktor "Verdrehung" | +5 % (additiv) |

**Zusatzfaktor Beine (CC02):**

- `CL020` Squat (Hocke): Gilt als extreme Zwangshaltung â†’ Hoher Zuschlag.

---

### 4.2 LastabhÃ¤ngige Belastung (Dynamische Arbeit)

Die Lastgewichte werden Ã¼ber **CC04/CC05 (Object)** geschÃ¤tzt.

| DaRa CC04/05 Label | ObjektgrÃ¶ÃŸe | GeschÃ¤tztes Gewicht (Lastklasse) |
| :--- | :--- | :--- |
| `CL043` Small Item | Kleinteile (< 1kg) | Laststufe 1 (VernachlÃ¤ssigbar) |
| `CL042` Medium Item | SchuhkartongrÃ¶ÃŸe (1-5 kg) | Laststufe 2 (Mittel) |
| `CL041` Large Item | Umzugskarton (> 5-10 kg) | Laststufe 3 (Schwer) |

---

### 4.3 Berechnungslogik fÃ¼r $t_{er}$

Die Erholungszeit fÃ¼r einen Chunk $i$ berechnet sich wie folgt:

$$t_{er, i} = t_{Basis, i} \times (Z_{Haltung} + Z_{Last} + Z_{Umgebung})$$

**Schritte:**
1. Bestimme Dauer $t_{Basis, i}$ des Chunks.
2. Ermittle $Z_{Haltung}$ basierend auf CC03 des Chunks.
3. Ermittle $Z_{Last}$ basierend auf CC04/05 Object (nur wÃ¤hrend Picking/Storing).
4. Summiere $t_{er}$ Ã¼ber alle Chunks eines Auftrags.

---

## 5. Verteilzeit ($t_v$)

Verteilzeiten sind Zeiten, die durch **StÃ¶rungen oder persÃ¶nliche Unterbrechungen** entstehen.

**Formel:**
$$t_v = t_s + t_p$$

**Wobei:**

- $t_s$ = Sachliche Verteilzeit (StÃ¶rungen)
- $t_p$ = PersÃ¶nliche Verteilzeit (Pause, Toilette, GesprÃ¤ch)

---

### 5.1 Identifikation im Datensatz

**1. Explizite StÃ¶rungen ($t_s$):**

- Wenn CC10 = `CL135` Reporting and Clarifying Incident.
- Wenn CC13 (falls vorh.) oder Metadaten = Picking Error (Korrekturaufwand).

**2. Implizite StÃ¶rungen ($t_s$):**

- Wenn CC10 = `CL134` Waiting UND CC07 = No IT (Hinweis auf Scanner-Ausfall/Reboot).

**3. PersÃ¶nliche Zeiten ($t_p$):**

- Wenn CC01 = Standing oder Another Main Activity UND CC10 = Waiting OHNE erkennbaren operativen Grund (z. B. im leeren Gang, keine ProzessaktivitÃ¤t).
- Oft schwer automatisch zu trennen; im Standard-DaRa-Szenario ("Perfect Run") ist $t_p \approx 0$.

---

## 6. Formales Berechnungsmodell (Algorithmus)

Um die Gesamtauftragszeit fÃ¼r einen Probanden $P$ in Szenario $S$ zu berechnen:

```python
def calculate_refa_times(chunks):
    T_R = 0.0   # RÃ¼stzeit
    T_MH = 0.0  # HaupttÃ¤tigkeit
    T_MN = 0.0  # NebentÃ¤tigkeit
    T_V = 0.0   # Verteilzeit
    
    for chunk in chunks:
        duration = chunk.duration_seconds
        cc09 = chunk.labels['CC09']
        cc10 = chunk.labels['CC10']
        cc01 = chunk.labels['CC01']
        
        # 1. RÃ¼stzeit-Check
        if cc09 in ['CL114', 'CL121']:
            T_R += duration
            continue
            
        # 2. Verteilzeit-Check (StÃ¶rung)
        if cc10 == 'CL135':
            T_V += duration
            continue
            
        # 3. Prozesszeiten (AusfÃ¼hrung)
        if cc09 in ['CL116', 'CL120']: # Pick/Store Time
            if cc01 in ['Handling', 'Scanning', 'Confirming']:
                T_MH += duration
            else:
                # z.B. kurzes Warten oder Orientieren wÃ¤hrend Pick Time
                T_MN += duration
                
        elif cc09 in ['CL115', 'CL119']: # Travel Time
            # Wegezeit ist klassische NebentÃ¤tigkeit
            T_MN += duration
            
        else:
            # Fallback fÃ¼r Unpacking/Packing etc.
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

**Diese Datei nutzen fÃ¼r:**

- Berechnung von REFA-Zeitarten aus DaRa-Daten.
- Analyse von WertschÃ¶pfungsanteilen (Value Added vs. Non-Value Added).
- Ergonomische Bewertungen (Erholungszeit).
- Prozessoptimierung (Identifikation von $t_{MN}$-Treibern).

**Nicht in dieser Datei:**

- Label-Definitionen â†’ [labels_207_v5.0.md](../core/labels_207_v5.0.md)
- Chunking-Grundlagen â†’ [chunking_v5.0.md](../auxiliary/chunking_v5.0.md)
- Prozess-Hierarchie â†’ [process_hierarchy_v5.0.md](process_hierarchy_v5.0.md)
- Artikel-Gewichtsklassen â†’ [articles_inventory_v5.0.md](../core/articles_inventory_v5.0.md)

**Erstellt:** 23.12.2025  
**Update:** 04.02.2026 (Label-Nummern korrigiert, Referenz-Versionierung)  
**Basis:** DaRa Dataset Description & REFA-Kompendium Arbeitsorganisation

---

## 7. MTM-1 Grundbewegungen (siehe mtm_codes_v5.0.md)

**VollstÃ¤ndige Dokumentation:** `knowledge/processes/mtm_codes_v5.0.md`

### Kurzreferenz: MTM â†’ DaRa-Labels

| MTM-Code | Bewegung | TMU-Wert | DaRa-Label (CC10) | REFA-Zeitart |
|----------|----------|----------|-------------------|--------------|
| R | Reach | R50B: 18,4 | CL139 "Retrieving Items" | $t_{MN}$ |
| G | Grasp | G1A: 2,0 | CL139 "Retrieving Items" | $t_{MH}$ |
| M | Move | M40B: 15,6 | CL140 "Moving to a Cart" | $t_{MH}$ |
| P | Position | P1SE: 5,6 | CL138 "Placing Items on Rack" | $t_{MH}$ |
| RL | Release | RL1: 2,0 | CL138 "Placing Items on Rack" | $t_{MH}$ |
| B | Bend | B: 29,0 | CL026 "Strongly Bending" + CL032/CL067 "Downwards" | $t_{MH}$ + $t_E$ |
| W | Walk | W: 15,0 | CL137 "Moving to the Next Position" + CL011 "Walking" | $t_{MN}$ |

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
+ Erholungszeit fÃ¼r B + Large [L] â†’ ~15-20 Sekunden gesamt
```

**Siehe:** `mtm_codes_v5.0.md` fÃ¼r vollstÃ¤ndige TMU-Tabellen und Berechnungsbeispiele
