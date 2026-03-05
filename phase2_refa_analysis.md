---
version: 6.2.0
status: finalisiert
created: 2026-02-25
updated: 2026-02-26
references:
  - reference_labels.md
  - reference_articles.md
---

# Phase 2: REFA-Analyse — Zeitarten und Auftragszeit

**Version:** 6.2.0 (2026-03-04)
**Basis:** REFA-Methodenlehre (Grundausbildung 4.0)
**Korrektur v6.0:** CL134 korrekt als t_w/t_s (nicht t_A)
**Neu in 6.2.0:** §7 Abgeleitete Kennzahlen (η, q_s, q_E, E_Pick/Store), §8 Richtwerte, §3 t_MN-Subtypen

---

## 1. Grundprinzip

Der DaRa-Datensatz ermöglicht direkte Ableitung von REFA-Zeitarten:

1. **CC09 (Mid-Level Process)** → Grob-Zeitart (Rüstzeit vs. Ausführungszeit)
2. **CC10 (Low-Level Process)** → Fein-Differenzierung (Wartezeit vs. Tätigkeit)
3. **CC01 (Main Activity)** → Validierung der Aktivität
4. **CC03 (Torso) + CC04/05 (Hands)** → Erholungszeit-Parameter

---

## 2. Auftragszeit (T)

$$T = t_R + t_A + t_E$$

- $t_R$ = Rüstzeit (Setup Time)
- $t_A$ = Ausführungszeit = $t_{MH} + t_{MN}$
- $t_E$ = Erholungszeit (Recovery Time)

---

### 2.1 Rüstzeit ($t_R$)

**CC09-Labels:** CL114 (Preparing Order), CL121 (Finalizing Order)

**CC10-Komponenten:**

- CL124: Collecting Order and Hardware
- CL125: Collecting Cart
- CL126: Collecting Empty Cardboard Boxes (Retrieval)
- CL127: Collecting Packed Cardboard Boxes (Storage)
- CL130: Handing Over Packed Cardboard Boxes (Retrieval)
- CL131: Returning Empty Cardboard Boxes (Storage)
- CL132: Returning Cart
- CL133: Returning Hardware

**Logik:** Alle Frames mit CC09 = CL114 oder CL121 → summieren zu $t_R$.

---

### 2.2 Ausführungszeit ($t_A$)

$$t_A = t_{MH} + t_{MN}$$

#### Haupttätigkeit ($t_{MH}$)

Unmittelbare Aufgabenerfüllung (Wertschöpfung).

**CC09-Kontext:** CL116 (Pick Time) oder CL120 (Store Time)

**CC01-Aktivitäten:** Handling (CL008/CL009/CL010), Scanning (CL005),
Confirming (CL002/CL003/CL004)

#### Nebentätigkeit ($t_{MN}$)

Mittelbare Aufgaben (Wegezeiten, Orientierung).

**CC09-Kontext:** CL115 (Pick Travel), CL119 (Store Travel),
CL117 (Unpacking), CL118 (Packing)

**CC01-Aktivitäten:** Walking (CL011), Pulling/Pushing Cart (CL006/CL007),
Standing während Travel Time (CL012)

---

## 3. Zentrale Mapping-Tabelle (CC09/CC10 → REFA)

| CC09 (Mid-Level) | CC10 (Low-Level) | REFA | Bezeichnung | t_MN-Subtyp |
|:---|:---|:---|:---|:---|
| CL114 Preparing | Alle | $t_R$ | Rüstzeit | — |
| CL121 Finalizing | Alle | $t_R$ | Rüstzeit | — |
| CL115 Pick Travel | CL137 Moving to Position | $t_{MN}$ | Nebentätigkeit | **t_MN_travel** |
| CL115 Pick Travel | CL128 Transporting Cart | $t_{MN}$ | Nebentätigkeit | **t_MN_travel** |
| CL116 Pick Time | CL139 Retrieving Items | $t_{MH}$ | Haupttätigkeit | — |
| CL116 Pick Time | CL140 Moving to a Cart | $t_{MH}$ | Haupttätigkeit | — |
| CL116 Pick Time | CL151 Placing in Cart | $t_{MH}$ | Haupttätigkeit | — |
| CL119 Store Travel | CL137 Moving to Position | $t_{MN}$ | Nebentätigkeit | **t_MN_travel** |
| CL119 Store Travel | CL128 Transporting Cart | $t_{MN}$ | Nebentätigkeit | **t_MN_travel** |
| CL120 Store Time | CL136 Removing from Cart | $t_{MH}$ | Haupttätigkeit | — |
| CL120 Store Time | CL140 Moving to Rack | $t_{MH}$ | Haupttätigkeit | — |
| CL120 Store Time | CL138 Placing on Rack | $t_{MH}$ | Haupttätigkeit | — |
| CL117 Unpacking | Alle | $t_{MN}$ | Nebentätigkeit | **t_MN_handling** |
| CL118 Packing | Alle | $t_{MN}$ | Nebentätigkeit | **t_MN_handling** |
| Alle | CL135 Reporting Incident | $t_s$ | Störzeit (Verteilzeit) | — |
| Alle | CL134 Waiting | $t_w$/$t_s$ | Wartezeit (kontextabhängig) | — |

**t_MN-Subtypen:**
- **t_MN_travel** = reine Wegezeit (Gassenlaufen, Kartentransport) → CC09=CL115 oder CL119
- **t_MN_handling** = mittelbare Handhabung (Aus-/Einpacken) → CC09=CL117 oder CL118
- Trennbarkeit im DaRa-Datensatz: eindeutig über CC09-Label

**KORREKTUR v6.0:** CL134 (Waiting) ist korrekt $t_w$ oder $t_s$ (kontextabhängig),
NICHT $t_A$ wie in v5.0 refa_analytics fälschlich angegeben.

**CL134-Kontext-Entscheidung:**

- CC07=No IT (CL108) → $t_s$ (sachliche Störung, z.B. Scanner-Ausfall)
- CC11=Path (CL161ff.) → $t_w$ (ablaufbedingte Wartezeit, z.B. Gangblockade)

---

## 4. Erholungszeitermittlung ($t_E$)

### 4.1 Haltungsbedingte Belastung (CC03 Torso)

| CC03 Label | Beschreibung | Zuschlagsklasse |
|:---|:---|:---|
| CL024 No Bending | Aufrechte Haltung | 0% |
| CL025 Slightly Bending | Beugung 10–30° | ~4–8% |
| CL026 Strongly Bending | Beugung >30° | ~15–20% |
| CL027 Torso Rotation | Verdrehung | +5% (additiv) |

**Zusatzfaktor Beine (CC02):** CL020 Squat = extreme Zwangshaltung → hoher Zuschlag.

### 4.2 Lastabhängige Belastung (CC04/CC05 Object)

| CC04/05 Label | Objektgröße | Geschätztes Gewicht |
|:---|:---|:---|
| CL043/CL078 Small Item | Kleinteile (<1kg) | Laststufe 1 (vernachlässigbar) |
| CL042/CL077 Medium Item | Schuhkartongröße (1-5kg) | Laststufe 2 (mittel) |
| CL041/CL076 Large Item | Umzugskarton (>5-10kg) | Laststufe 3 (schwer) |

### 4.3 Berechnung

$$t_{er,i} = t_{Basis,i} \times (Z_{Haltung} + Z_{Last} + Z_{Umgebung})$$

1. Bestimme Dauer $t_{Basis,i}$ des Abschnitts
2. Ermittle $Z_{Haltung}$ aus CC03
3. Ermittle $Z_{Last}$ aus CC04/05 Object (nur während Pick/Store Time)
4. Summiere über alle Abschnitte

---

## 5. Verteilzeit ($t_v$)

$$t_v = t_s + t_p$$

- $t_s$ = Sachliche Verteilzeit (Störungen)
- $t_p$ = Persönliche Verteilzeit (Pause, Toilette)

**Identifikation:**

| Typ | Bedingung | REFA |
|:----|:----------|:-----|
| Explizite Störung | CC10=CL135 (Reporting Incident) | $t_s$ |
| Implizite Störung | CC10=CL134 AND CC07=No IT (CL108) | $t_s$ |
| Ablaufbedingte Wartezeit | CC10=CL134 AND CC11=Path | $t_w$ |
| Persönliche Zeit | CC01=Standing/Another AND CC10=CL134, kein operativer Grund | $t_p$ |

---

## 6. Berechnungsalgorithmus

```python
def calculate_refa_times(frames, scenario_vector):
    T_R = 0.0   # Rüstzeit
    T_MH = 0.0  # Haupttätigkeit
    T_MN = 0.0  # Nebentätigkeit
    T_V = 0.0   # Verteilzeit

    for i, frame in enumerate(frames):
        if scenario_vector[i].startswith("Other"):
            continue  # Other-Frames nicht in Auftragszeit

        duration = 1.0 / 30.0  # 30 fps → Sekunden pro Frame
        cc09 = frame['CC09']
        cc10 = frame['CC10']

        # 1. Rüstzeit
        if cc09 in ['CL114', 'CL121']:
            T_R += duration
            continue

        # 2. Verteilzeit (Störung/Warten)
        if cc10 == 'CL135':
            T_V += duration
            continue
        if cc10 == 'CL134':
            T_V += duration
            continue

        # 3. Haupttätigkeit
        if cc09 in ['CL116', 'CL120']:
            T_MH += duration

        # 4. Nebentätigkeit
        elif cc09 in ['CL115', 'CL119', 'CL117', 'CL118']:
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

## 7. Abgeleitete REFA-Kennzahlen

Diese Kennzahlen werden aus den Basiszeitarten berechnet und sind
**nicht direkt im Datensatz annotiert** — sie sind methodische Ableitungen.
Richtwerte siehe §8.

### 7.1 Nutzungsgrad (Wertschöpfungsquote)

$$\eta = \frac{t_{MH}}{T} \times 100$$

- **Bezugsgröße:** T_total (Auftragszeit)
- **Richtwert Kommissionierung:** η > 55% (siehe §8)
- **Interpretation:** Anteil echter wertschöpfender Tätigkeit an der Gesamtauftragszeit
- **DaRa-Quelle:** t_MH aus CC09=CL116 (Pick Time) oder CL120 (Store Time)

---

### 7.2 Störungsquote

$$q_s = \frac{t_s + t_w}{T} \times 100$$

- **Bezugsgröße:** T_total
- **Richtwert:** q_s < 5% (siehe §8)
- **Komponenten:**
    - t_s = sachliche Störzeit (CC10=CL135 oder CC10=CL134 AND CC07=CL108)
    - t_w = ablaufbedingte Wartezeit (CC10=CL134 AND CC11=CL161ff.)
- **Hinweis:** t_w und t_s separat ausweisen — verschiedene Ursachenkategorien

---

### 7.3 Erholungszeitquote (Belastungsindikator)

$$q_E = \frac{t_E}{t_A} \times 100$$

- **Bezugsgröße:** t_A (Ausführungszeit), NICHT T_total
- **Richtwert:** q_E > 20% = hohe körperliche Belastung (siehe §8)
- **Interpretation:** Erholungsbedarf relativ zur produktiven Tätigkeit
- **ACHTUNG:** Bezugsgröße ist t_A — abweichend von η und q_s

---

### 7.4 Wegezeit-Anteil

$$\eta_{Weg} = \frac{t_{MN,travel}}{t_A} \times 100$$

- **Bezugsgröße:** t_A
- **t_MN_travel** = nur CC09=CL115 (Pick Travel) + CL119 (Store Travel)
- **t_MN_handling** = CC09=CL117 (Unpacking) + CL118 (Packing)
- **Hinweis:** t_MN enthält beide Komponenten — für Wegezeit-Analyse trennen
- **DaRa-Trennbarkeit:** Ja, über CC09-Label eindeutig möglich (siehe §3)
- **Richtwert:** η_Weg < 30% (siehe §8)

---

### 7.5 Picking/Storing-Effizienz

$$E_{Pick} = \frac{N_{Positionen}}{t_{MH,Retrieval}} \times 60 \quad [\text{Picks/min}]$$

$$E_{Store} = \frac{N_{Positionen}}{t_{MH,Storage}} \times 60 \quad [\text{Stores/min}]$$

- **N_Positionen:** Aus reference_articles.md — je Order 15 Positionen (S1–S3, S4–S6), 30 Positionen (S7/S8)
- **Bezugsgröße:** Nur t_MH des jeweiligen Prozesstyps (Retrieval oder Storage)
- **Voraussetzung:** Szenario-aufgelöste Zeitarten (scenario_times)

| Szenario | Order | N_Positionen | t_MH-Basis |
|:---------|:------|:-------------|:-----------|
| S1, S2, S3 | 2904, 2905, 2906 | 15 | scenario_times[S1/S2/S3].t_MH |
| S4, S5, S6 | 2904, 2905, 2906 | 15 | scenario_times[S4/S5/S6].t_MH |
| S7 | 2904+2905 | 30 | scenario_times[S7].t_MH |
| S8 | 2904+2905 | 30 | scenario_times[S8].t_MH |

- **Hinweis:** Falls ein Szenario beim Probanden nicht vorkommt (scenario_times enthält es nicht),
    Effizienz als "nicht berechenbar — Szenario nicht beobachtet" ausweisen.

---

## 8. Richtwerte und Interpretationsrahmen

Diese Richtwerte sind der REFA-Methodenliteratur entnommen und dienen als
Orientierung. Sie sind **keine harten Grenzwerte des DaRa-Datensatzes** und
müssen im Berichtstext als Orientierungswerte gekennzeichnet werden.

| Kennzahl | Formel | Bezugsgröße | Richtwert | Quelle |
|:---------|:-------|:------------|:----------|:-------|
| Nutzungsgrad η | t_MH / T | T_total | > 55% | REFA-Grundausbildung 4.0 |
| Störungsquote q_s | (t_s+t_w) / T | T_total | < 5% | REFA-Methodenlehre |
| Erholungszeitquote q_E | t_E / t_A | t_A | < 20% | REFA-Grundausbildung 4.0 |
| Verteilzeit-Anteil | t_v / T | T_total | < 8% | REFA-Praxiswerte Lager |
| Wegezeit-Anteil η_Weg | t_MN_travel / t_A | t_A | < 30% | REFA Lager/Kommissionierung |

**Interpretationsregeln:**
- Richtwert-Überschreitungen als Beobachtung formulieren, nicht als Fehler
- Vergleich immer mit Szenariotyp (Retrieval vs. Storage vs. Multi-Order)
- Richtwerte gelten für den Gesamtproband, nicht für einzelne Szenarien isoliert
- Bei fehlendem t_MN_travel (nicht separat berechnet): expliziten Hinweis ausgeben
- Alle abgeleiteten Kennzahlen als "berechnet aus deterministischen Feldern" kennzeichnen
