---
version: 6.2.0
references:
  - reference_labels.md
  - reference_articles.md
  - reference_dataset.md
  - reference_validation_rules.md
  - phase1_scenario_recognition.md
output_used_by:
  - phase3_mtm_analysis.md
  - phase4_bpmn_validation.md
  - phase5_report.md
---

<!-- PRE-ANSWER CHECKLIST (PAC) — Phase 2
Before answering ANY question about this phase:
[ ] I have read this file COMPLETELY using the Read tool
[ ] I have read reference_labels.md
[ ] I have read reference_articles.md (for weight classes!)
[ ] I have extracted the VERIFICATION_TOKEN from the end of this file
[ ] I am citing specific label IDs (CLxxx) and section numbers
[ ] I have verified VRA-2 (t_E formula) and VRA-3 (CL134) from source
-->

# Phase 2: REFA-Analyse — Zeitarten und Auftragszeit

**Version:** 6.2.0 (2026-03-10)
**Basis:** REFA-Methodenlehre (Grundausbildung 4.0)
**Änderungen v6.2.0:**
- L1: Gewichtsklassen §4.2 korrigiert (jetzt konsistent mit reference_articles.md §1)
- L2: CC02-Erholungszuschlag-Tabelle §4.1 ergänzt
- L3: Z_Umgebung in §4.3 definiert und auf 0 gesetzt (DaRa-Kontext)
- L4: t_E vollständig in §6 Algorithmus implementiert
- L5: CL134-Fallthrough-Logik in §3 und §5 ergänzt
- Frontmatter: reference_dataset.md und reference_validation_rules.md ergänzt

---

## 1. Grundprinzip

Der DaRa-Datensatz ermöglicht direkte Ableitung von REFA-Zeitarten:

1. **CC09 (Mid-Level Process)** → Grob-Zeitart (Rüstzeit vs. Ausführungszeit)
2. **CC10 (Low-Level Process)** → Fein-Differenzierung (Wartezeit vs. Tätigkeit)
3. **CC01 (Main Activity)** → Validierung der Aktivität (V-B1)
4. **CC03 (Torso) + CC02 (Legs) + CC04/05 (Hands)** → Erholungszeit-Parameter

**Frame-Basis:** 1 Frame = 1/30 Sekunde (30 fps, technisch 29,97 fps → gerundet).
Quelle: `reference_dataset.md §3.1`

---

## 2. Auftragszeit (T)

$$T = t_R + t_A + t_E$$

- $t_R$ = Rüstzeit (Setup Time)
- $t_A$ = Ausführungszeit = $t_{MH} + t_{MN}$
- $t_E$ = Erholungszeit (Recovery Time)

**Hinweis:** $t_V$ (Verteilzeit) ist kein eigener Term in T, sondern wird parallel
erfasst und separat berichtet (Verlustzeit, nicht Auftragszeit im engeren Sinn).

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

| CC09 (Mid-Level) | CC10 (Low-Level) | REFA | Bezeichnung |
|:---|:---|:---|:---|
| CL114 Preparing | Alle | $t_R$ | Rüstzeit |
| CL121 Finalizing | Alle | $t_R$ | Rüstzeit |
| CL115 Pick Travel | CL137 Moving to Position | $t_{MN}$ | Nebentätigkeit |
| CL115 Pick Travel | CL128 Transporting Cart | $t_{MN}$ | Nebentätigkeit |
| CL116 Pick Time | CL139 Retrieving Items | $t_{MH}$ | Haupttätigkeit |
| CL116 Pick Time | CL140 Moving to a Cart | $t_{MH}$ | Haupttätigkeit |
| CL116 Pick Time | CL151 Placing in Cart | $t_{MH}$ | Haupttätigkeit |
| CL119 Store Travel | CL137 Moving to Position | $t_{MN}$ | Nebentätigkeit |
| CL119 Store Travel | CL128 Transporting Cart | $t_{MN}$ | Nebentätigkeit |
| CL120 Store Time | CL136 Removing from Cart | $t_{MH}$ | Haupttätigkeit |
| CL120 Store Time | CL140 Moving to Rack | $t_{MH}$ | Haupttätigkeit |
| CL120 Store Time | CL138 Placing on Rack | $t_{MH}$ | Haupttätigkeit |
| CL117 Unpacking | Alle | $t_{MN}$ | Nebentätigkeit |
| CL118 Packing | Alle | $t_{MN}$ | Nebentätigkeit |
| Alle | CL135 Reporting Incident | $t_s$ | Störzeit (Verteilzeit) |
| Alle | CL134 Waiting | $t_w$/$t_s$/$t_p$ | Wartezeit (kontextabhängig) |

**KORREKTUR v6.0:** CL134 (Waiting) ist korrekt $t_w$, $t_s$ oder $t_p$ (kontextabhängig),
NICHT $t_A$ wie in v5.0 fälschlich angegeben.

**CL134-Kontext-Entscheidung (vollständig):**

| Bedingung | REFA-Typ | Beispiel |
|:----------|:---------|:---------|
| CC07=No IT (CL108) | $t_s$ | Scanner-Ausfall, IT-Ausfall |
| CC11=Path (CL161ff.) | $t_w$ | Gangblockade, Warten auf freien Weg |
| CC01=Standing (CL012) AND kein IT- oder Wegproblem erkennbar | $t_p$ | Persönliche Pause |
| Keiner der obigen Fälle | $t_w$ | **Default-Fallthrough:** ablaufbedingte Wartezeit |

**Hinweis:** Der Fallthrough-Default $t_w$ ist konservativ gewählt.
Bei der Auswertung sollten undifferenzierte CL134-Frames als $t_w$ dokumentiert
und in einem separaten Bucket gehalten werden.

---

## 4. Erholungszeitermittlung ($t_E$)

### 4.1 Haltungsbedingte Belastung (CC03 Torso + CC02 Legs)

#### CC03 (Torso) — Primärquelle

| CC03 Label | Beschreibung | Zuschlag $Z_{Torso}$ |
|:---|:---|:---|
| CL024 No Bending | Aufrechte Haltung (<10°) | 0% |
| CL025 Slightly Bending | Beugung 10–30° | ~4–8% |
| CL026 Strongly Bending | Beugung >30° | ~15–20% |
| CL027 Torso Rotation | Verdrehung (additiv zu Beugung) | +5% additiv |
| CL028 Another Torso Activity | Sonstige Haltung | ~5% (Schätzwert) |
| CL029 Torso Activity Unknown | Unbekannte Haltung | 0% (konservativ) |

**Kombinationsregel:** CL027 ist immer additiv zu einem Beugungslabel (V-B4).
Beispiel: CL025 + CL027 = ~4–8% + 5% = ~9–13% gesamt.

#### CC02 (Legs) — Zusatzfaktor bei Extremhaltungen

| CC02 Label | Haltung | Zusatzzuschlag $Z_{Beine}$ |
|:---|:---|:---|
| CL016 Gait Cycle | Normales Gehen | 0% |
| CL017 Step | Einzelschritt | 0% |
| CL018 Standing Still | Ruhiges Stehen | 0% |
| CL019 Sitting | Sitzen | 0% |
| CL020 Squat | Tiefe Kniebeuge (Bodenfächer) | **+20–35% additiv** |
| CL021 Lunges | Ausfallschritt | **+10–15% additiv** |
| CL022 Another Leg Activity | Sonstige | ~5% (Schätzwert) |
| CL023 Leg Activity Unknown | Unbekannt | 0% (konservativ) |

**Wichtig:** CC02-Zuschlag nur additiv wenn CC02 ≠ CL016/CL017/CL018/CL019.
CL020 (Squat) ist diagnostisch erkennbar durch CC01=CL010 (Handling Downwards)
kombiniert mit CC03=CL026 (Strongly Bending).

### 4.2 Lastabhängige Belastung (CC04/CC05 Object)

**KORREKTUR v6.2.0:** Gewichtsklassen jetzt konsistent mit `reference_articles.md §1`.

| CC04/05 Label | Objektgröße | Gewichtsbereich (Datensatz) | Laststufe $Z_{Last}$ |
|:---|:---|:---|:---|
| CL043/CL078 Small Item | Kleinteile | ≤ 50g | ~0% (vernachlässigbar) |
| CL042/CL077 Medium Item | Schuhkarton-Größe | 50–800g | ~5–10% |
| CL041/CL076 Large Item | Großes Objekt | >800g (bis 5149g) | ~15–35% |

**Hinweis Gewichtsspanne Large:** Der schwerste Artikel im Datensatz ist
Palm Soil 5149g (Order 2904, Pos 14). Large-Items reichen von 800g (Handbeil)
bis 5149g — der Zuschlag sollte bei >2kg entsprechend erhöht werden.

**Anwendungsregel:** $Z_{Last}$ nur während Pick/Store Time aktiv
(CC09=CL116 oder CL120). Während Travel Time kein Lastzuschlag
(Wagen trägt Last, nicht Proband).

### 4.3 Berechnung

$$t_{er,i} = t_{Basis,i} \times (Z_{Torso} + Z_{Beine} + Z_{Last} + Z_{Umgebung})$$

**Definition $Z_{Umgebung}$:**
Im DaRa-Datensatz sind keine Umgebungsparameter (Temperatur, Lärm, Beleuchtung)
annotiert. $Z_{Umgebung} = 0\%$ für alle Frames. Der Term bleibt im Modell
erhalten für Erweiterungen.

**Berechnungsschritte:**

1. Bestimme $t_{Basis,i}$ = Dauer des Abschnitts (Frames × 1/30 s)
2. Ermittle $Z_{Torso}$ aus CC03
3. Ermittle $Z_{Beine}$ aus CC02 (nur wenn CL020 oder CL021 aktiv)
4. Ermittle $Z_{Last}$ aus CC04/05 Object (nur während CC09=CL116/CL120)
5. Setze $Z_{Umgebung} = 0$
6. $t_{er,i} = t_{Basis,i} \times (Z_{Torso} + Z_{Beine} + Z_{Last})$
7. Summiere über alle Abschnitte: $t_E = \sum_i t_{er,i}$

---

## 5. Verteilzeit ($t_v$)

$$t_v = t_s + t_p$$

- $t_s$ = Sachliche Verteilzeit (Störungen, Wartezeiten)
- $t_p$ = Persönliche Verteilzeit (Pause, Toilette)

**Identifikation:**

| Typ | Bedingung | REFA |
|:----|:----------|:-----|
| Explizite Störung | CC10=CL135 (Reporting Incident) | $t_s$ |
| Implizite Störung | CC10=CL134 AND CC07=No IT (CL108) | $t_s$ |
| Ablaufbedingte Wartezeit | CC10=CL134 AND CC11=Path (CL161ff.) | $t_w$ ⊂ $t_s$ |
| Persönliche Zeit | CC01=Standing (CL012) AND CC10=CL134, kein IT-/Wegproblem | $t_p$ |
| Fallthrough | CC10=CL134, keine der obigen Bedingungen | $t_w$ (Default) |

**Szenario-Abhängigkeit von CL135 (V-E1):**

| Szenario | CL135-Erwartung |
|:---------|:----------------|
| S1, S3 | Erwartet (Intentional Errors) |
| S2 | Nicht geplant |
| S4, S6 | Nicht geplant |
| S5 | Möglich |
| S7, S8 | Nicht erwartet (Perfect Run) |

---

## 6. Berechnungsalgorithmus

```python
def calculate_refa_times(frames, scenario_vector):
    """
    Berechnet REFA-Zeitarten aus Frame-Vektor.
    
    Args:
        frames: Liste von Dicts mit CC01–CC12 Labelwerten pro Frame
        scenario_vector: Liste von Szenario-Strings (S1–S8, Other_*)
        
    Returns:
        Dict mit allen REFA-Zeitarten in Sekunden
    """
    T_R  = 0.0   # Rüstzeit
    T_MH = 0.0   # Haupttätigkeit
    T_MN = 0.0   # Nebentätigkeit
    T_V  = 0.0   # Verteilzeit gesamt
    T_VS = 0.0   # Verteilzeit: Sachliche Störung (t_s)
    T_VW = 0.0   # Verteilzeit: Wartezeit (t_w)
    T_VP = 0.0   # Verteilzeit: Persönliche Zeit (t_p)
    T_E  = 0.0   # Erholungszeit

    DURATION = 1.0 / 30.0  # 30 fps → Sekunden pro Frame

    for i, frame in enumerate(frames):
        if scenario_vector[i].startswith("Other"):
            continue  # Other-Frames nicht in Auftragszeit

        cc09 = frame['CC09']
        cc10 = frame['CC10']
        cc01 = frame['CC01']
        cc02 = frame['CC02']
        cc03 = frame['CC03']  # kann Liste sein (Multi-Label)
        cc04_obj = frame.get('CC04_Object')   # Object-Subkategorie
        cc07 = frame['CC07']
        cc11 = frame['CC11']  # kann Liste sein (Hierarchical)

        # ── 1. RÜSTZEIT ──────────────────────────────────────────────────
        if cc09 in ['CL114', 'CL121']:
            T_R += DURATION
            # Erholungszeit auch in Rüstzeit (Haltungsbelastung bleibt)
            T_E += _calc_recovery(cc02, cc03, cc04_obj, cc09, DURATION)
            continue

        # ── 2. VERTEILZEIT ───────────────────────────────────────────────
        if cc10 == 'CL135':
            T_VS += DURATION
            T_V  += DURATION
            continue

        if cc10 == 'CL134':
            cc11_labels = cc11 if isinstance(cc11, list) else [cc11]
            if cc07 == 'CL108':               # IT-Ausfall → t_s
                T_VS += DURATION
            elif any(l in ['CL161', 'CL162', 'CL163'] for l in cc11_labels):  # Path → t_w
                T_VW += DURATION
            elif cc01 == 'CL012':             # Standing, kein IT/Weg-Problem → t_p
                T_VP += DURATION
            else:                              # Fallthrough → t_w (konservativ)
                T_VW += DURATION
            T_V += DURATION
            continue

        # ── 3. HAUPTTÄTIGKEIT ────────────────────────────────────────────
        if cc09 in ['CL116', 'CL120']:
            T_MH += DURATION
            T_E  += _calc_recovery(cc02, cc03, cc04_obj, cc09, DURATION)

        # ── 4. NEBENTÄTIGKEIT ────────────────────────────────────────────
        elif cc09 in ['CL115', 'CL119', 'CL117', 'CL118']:
            T_MN += DURATION
            T_E  += _calc_recovery(cc02, cc03, None, cc09, DURATION)
            # Kein Z_Last während Travel (Wagen trägt Last)

    T_A = T_MH + T_MN
    T   = T_R + T_A + T_E  # Auftragszeit nach REFA-Definition

    return {
        'Auftragszeit_T':     T,
        'Ruestzeit_tR':       T_R,
        'Ausfuehrungszeit_tA': T_A,
        'Haupttaetigkeit_tMH': T_MH,
        'Nebentaetigkeit_tMN': T_MN,
        'Erholungszeit_tE':   T_E,
        'Verteilzeit_tV':     T_V,
        'Stoerzeit_tS':       T_VS,
        'Wartezeit_tW':       T_VW,
        'PersZeit_tP':        T_VP,
    }


def _calc_recovery(cc02, cc03, cc04_obj, cc09, duration):
    """Berechnet Erholungszeit für einen Frame."""
    # CC03 kann Single-Label oder Liste sein
    cc03_labels = cc03 if isinstance(cc03, list) else [cc03]

    # Z_Torso
    z_torso = 0.0
    if 'CL026' in cc03_labels:   z_torso = 0.175   # Strongly Bending: Mittelpunkt ~17,5%
    elif 'CL025' in cc03_labels: z_torso = 0.06    # Slightly Bending: Mittelpunkt ~6%
    elif 'CL028' in cc03_labels: z_torso = 0.05    # Another Torso: Schätzwert
    if 'CL027' in cc03_labels:   z_torso += 0.05   # Rotation additiv

    # Z_Beine (CC02)
    z_beine = 0.0
    if cc02 == 'CL020':   z_beine = 0.275   # Squat: Mittelpunkt ~27,5%
    elif cc02 == 'CL021': z_beine = 0.125   # Lunges: Mittelpunkt ~12,5%
    elif cc02 == 'CL022': z_beine = 0.05    # Another: Schätzwert

    # Z_Last (nur während Pick/Store Time)
    z_last = 0.0
    if cc09 in ['CL116', 'CL120'] and cc04_obj is not None:
        if cc04_obj in ['CL041', 'CL076']:    z_last = 0.25   # Large: ~25%
        elif cc04_obj in ['CL042', 'CL077']:  z_last = 0.075  # Medium: ~7,5%
        # Small Item: z_last = 0 (vernachlässigbar)

    # Z_Umgebung = 0 (DaRa-Datensatz hat keine Umgebungsannotationen)
    z_umgebung = 0.0

    return duration * (z_torso + z_beine + z_last + z_umgebung)
```

---

## 7. Verwandte Dateien

| Datei | Inhalt | Wann nutzen |
|:------|:-------|:------------|
| `reference_labels.md` | 207 Label-Definitionen | CC09/CC10/CC01–CC05 Bedeutung |
| `reference_articles.md` | Artikel-Stammdaten (Gewichte, Klassen) | Gewichtsklassen §4.2 |
| `reference_dataset.md` | Probanden, Datenstruktur, 30fps | Frame-zu-Zeit-Umrechnung |
| `reference_validation_rules.md` | V-B1, V-B4, V-P1, V-E1 | Vor Berechnung validieren |
| `phase1_scenario_recognition.md` | scenario_vector | Input für Algorithmus §6 |
| `phase4_bpmn_validation.md` | CC09→CC10 Mapping | Validierung vor Zeitberechnung |

<!-- VERIFICATION_TOKEN: DARA-P2REF-9C1D-v630 -->
