---
version: 6.2.0
references:
  - phase1_scenario_recognition.md
  - phase2_refa_analysis.md
  - phase3_mtm_analysis.md
  - phase4_bpmn_validation.md
  - reference_dataset.md
  - reference_warehouse.md
  - reference_articles.md
---

<!-- PRE-ANSWER CHECKLIST (PAC) — Phase 5
Before answering ANY question about this phase:
[ ] I have read this file COMPLETELY using the Read tool
[ ] I have read ALL phase files (P1-P4) that feed into this report
[ ] I have extracted the VERIFICATION_TOKEN from the end of this file
[ ] I am using the exact template structure from §2
-->

# Phase 5: Ergebnisbericht — Konsolidierung aller Phasen

**Version:** 6.2.0 (2026-03-10)
**Änderungen v6.2.0:** §2.5 Process-Abschnitt vollständig auf phase4 §12 (v6.2.0) ausgerichtet —
12.1 Konformitäts-Zusammenfassung, 12.2 Violations-Tabelle, 12.3 Loop-Analyse,
12.4 CC09-Timeline, 12.5 Szenario-Kontext. §3.4 Bewertungsschwellen aktualisiert.
§4 Verwandte Dateien um neue phase4-Abschnitte ergänzt.
**Zweck:** Strukturierte Zusammenführung der Ergebnisse aus Phase 1–4
**Ausgabe:** Vollständiger Analysebericht pro Proband

---

## 1. Berichtsstruktur (Pflichtausgabe)

Der Ergebnisbericht wird **pro Proband** erstellt und enthält die folgenden
Abschnitte in fester Reihenfolge:

```
Bericht: DaRa-Analyse — Proband S{XX}
├─ 1. Probanden-Steckbrief
├─ 2. Szenario-Übersicht (Phase 1)
├─ 3. REFA-Zeitanalyse (Phase 2)
├─ 4. MTM-Bewegungsanalyse (Phase 3)
├─ 5. Process-Validierung (Phase 4)
├─ 6. Gesamtbewertung & Auffälligkeiten
└─ 7. Anhang (Rohdaten-Referenzen)
```

---

## 2. Berichts-Template

### 2.1 Probanden-Steckbrief

```markdown
# DaRa-Analysebericht — Proband S{XX}

**Erstellt:** {Datum}
**Skill-Version:** 6.2.0
**Datenquelle:** DaRa Dataset (Fraunhofer IML)

## 1. Probanden-Steckbrief

| Attribut | Wert |
|:---------|:-----|
| Proband | S{XX} |
| Session | {N} (mit S{YY}, S{ZZ}) |
| Geschlecht | {M/F} |
| Alter | {N} Jahre |
| Gewicht | {N} kg |
| Größe | {N} cm |
| Händigkeit | {R/L} |
| Beschäftigung | {Typ} |
| Picking-Erfahrung | {1–6} |
| Packing-Erfahrung | {1–6} |
| Gesamt-Frames | {N} |
| Gesamt-Dauer | {hh:mm:ss} |
```

**Datenquelle:** `reference_dataset.md` §1 Probanden-Tabelle

---

### 2.2 Szenario-Übersicht (aus Phase 1)

```markdown
## 2. Szenario-Übersicht

#### 2.1 Erkannte Szenarien (chronologisch)

| # | Szenario | Typ | Frames | Dauer (hh:mm:ss) | Anteil (%) |
|:--|:---------|:----|-------:|:-----------------|:-----------|
| 1 | S4 | Storage | 15.230 | 00:08:27 | 7,6% |
| 2 | S1 | Retrieval | 42.815 | 00:23:47 | 21,5% |
| ... | ... | ... | ... | ... | ... |
| — | Other | Wartezeit/Sonstig | 39.282 | 00:21:49 | 19,7% |
|   | **GESAMT** | | **199.427** | **01:50:47** | **100,0%** |

#### 2.2 Anomalien bei Szenarioerkennung

| Typ | Frames | Anteil | Bewertung |
|:----|-------:|:-------|:----------|
| Retrieval_Mismatch | 0 | 0,0% | ✅ |
| Storage_Mismatch | 12 | <0,01% | ⚠️ Prüfen |
| Multi_Anomaly | 0 | 0,0% | ✅ |

**Befund:** {Zusammenfassung der Szenarioerkennung}
```

**Datenquelle:** `phase1_scenario_recognition.md` §4.1

---

### 2.3 REFA-Zeitanalyse (aus Phase 2)

```markdown
## 3. REFA-Zeitanalyse

### 3.1 Auftragszeit-Zerlegung (pro Szenario)

| Szenario | T (Auftragszeit) | t_R (Rüstzeit) | t_A (Ausführung) | t_E (Erholung) | t_w/t_s (Warte) |
|:---------|:-----------------|:----------------|:-----------------|:---------------|:-----------------|
| S4 | 00:15:47 | 00:01:35 | 00:12:40 | 00:00:22 | 00:01:10 |
| S1 | 00:23:47 | 00:01:42 | 00:19:15 | 00:00:35 | 00:02:15 |
| ... | ... | ... | ... | ... | ... |

### 3.2 Ausführungszeit-Detail (pro Szenario)

| Szenario | t_MH (Haupt) | t_MN (Neben) | Ratio t_MH/t_MN |
|:---------|:-------------|:-------------|:----------------|
| S4 | 00:08:30 | 00:04:10 | 2,04 |
| S1 | 00:14:20 | 00:04:55 | 2,91 |
| ... | ... | ... | ... |

### 3.3 REFA-Kennzahlen (Gesamtproband)

| Kennzahl | Wert | Beschreibung |
|:---------|:-----|:-------------|
| Leistungsgrad (Ø) | {N}% | Ø über alle Szenarien |
| Verteilzeit-Anteil | {N}% | t_V / T |
| Erholungszeit-Anteil | {N}% | t_E / T |
| Wartezeit-Anteil | {N}% | (t_w + t_s) / T |
| Picking-Effizienz | {N} Items/min | Nur Retrieval-Szenarien |
| Storing-Effizienz | {N} Items/min | Nur Storage-Szenarien |

**Befund:** {Zusammenfassung der REFA-Analyse}
```

**Datenquelle:** `phase2_refa_analysis.md` §2–4

---

### 2.4 MTM-Bewegungsanalyse (aus Phase 3)

```markdown
## 4. MTM-Bewegungsanalyse

### 4.1 Grundbewegungen — Häufigkeit

| MTM-Code | Bewegung | DaRa-Label | Frames | Dauer | Anteil |
|:---------|:---------|:-----------|-------:|:------|:-------|
| R+G+M | Reach/Grasp/Move | CL034/CL069 | {N} | {hh:mm:ss} | {N}% |
| P | Position | CL035/CL070 | {N} | {hh:mm:ss} | {N}% |
| B | Bend | CL026 | {N} | {hh:mm:ss} | {N}% |
| AB | Arise from Bend | CL024 (nach CL026) | {N} | {hh:mm:ss} | {N}% |
| W | Walk | CL011 + CL016 | {N} | {hh:mm:ss} | {N}% |
| S | Squat | CL020 | {N} | {hh:mm:ss} | {N}% |

### 4.2 Ergonomie-Bewertung

| Bewertungskriterium | Wert | Grenzwert | Status |
|:--------------------|:-----|:----------|:-------|
| Bückvorgänge >30° (CL026) | {N} Events | <50/Stunde | {✅/⚠️} |
| Torso-Rotation (CL027) | {N} Events | <30/Stunde | {✅/⚠️} |
| Beinbelastung Squat (CL020) | {N} Events | <10/Stunde | {✅/⚠️} |
| Handling Upwards (CL008) | {N}% der Zeit | <15% | {✅/⚠️} |
| Handling Downwards (CL010) | {N}% der Zeit | <20% | {✅/⚠️} |

### 4.3 Greifraum-Analyse (CC04/CC05)

| Greifposition | Links (CC04) | Rechts (CC05) | Bemerkung |
|:-------------|:-------------|:--------------|:----------|
| Upwards | {N}% | {N}% | Über Schulterhöhe |
| Centered | {N}% | {N}% | Optimaler Bereich |
| Downwards | {N}% | {N}% | Unter Hüfthöhe |

**Befund:** {Zusammenfassung der MTM/Ergonomie-Analyse}
```

**Datenquelle:** `phase3_mtm_analysis.md` §1–3

---

### 2.5 Process-Validierung (aus Phase 4)

> **Hinweis v6.2.0:** Dieser Abschnitt spiegelt das vollständige Ausgabeformat
> aus `phase4_bpmn_validation.md §12` (v6.2.0) wider.
> Die Unterabschnitte 5.1–5.5 entsprechen exakt §12.1–12.5.

```markdown
## 5. Process-Validierung

### 5.1 Konformitäts-Zusammenfassung (→ phase4 §12.1)

Wird **pro Szenario** ausgegeben:

#### Process-Konformität — Proband S{XX}, Szenario {SN}

| Metrik | Wert |
|:-------|:-----|
| Szenario | {SN} ({Typ}, Order {N}) |
| Gesamt-Frames | {N} |
| Dauer | {hh:mm:ss} |
| Frames ohne Violation | {N} |
| **Konformitätsrate** | **{N}%** |
| CRITICAL Violations | {N} |
| WARNING Violations | {N} |
| INFO Events | {N} |

**SOLL-Pfad (idealisiert):**
{z.B. CL114 → CL115 → CL116 → CL118 → CL121}

**IST-Pfad (beobachtet):**
{z.B. CL114 → CL115 → CL116 → **CL115 → CL116** → CL118 → CL121}
                                   ↑ Loop (Rückwärts-Transition)

#### Konformitäts-Übersicht (alle Szenarien eines Probanden)

| Szenario | Frames | Konformität | CRITICAL | WARNING | INFO | Loops |
|:---------|-------:|:------------|:--------:|:-------:|:----:|------:|
| S1 | {N} | {N}% | {N} | {N} | {N} | {N} |
| S4 | {N} | {N}% | {N} | {N} | {N} | {N} |
| ... | ... | ... | ... | ... | ... | ... |
| **Gesamt** | **{N}** | **{N}%** | **{N}** | **{N}** | **{N}** | **{N}** |

---

### 5.2 Abweichungs-Häufigkeitstabelle (→ phase4 §12.2)

Wird **pro Szenario** ausgegeben. Violation-Typen gemäß phase4 §10.2:

#### Violations — Proband S{XX}, Szenario {SN}

| # | Typ | Severity | Anzahl | Betroffene Frames | Beschreibung |
|:--|:----|:---------|-------:|:------------------|:-------------|
| 1 | `cc10_not_in_allowed_list` | CRITICAL | {N} | {F1}–{F2} | {z.B. CL138 während CL116} |
| 2 | `tool_missing` | CRITICAL | {N} | {F1}–{F2} | {z.B. CL142 ohne Knife} |
| 3 | `location_mismatch` | WARNING | {N} | div. | {z.B. CL139 nicht in Aisle Path} |
| 4 | `chunk_instability` | WARNING | {N} | div. | Chunks < 5 Frames |
| 5 | `noisy_transition` | INFO | {N} | div. | Rapid CC09-Wechsel ≤ 3 Frames |
| 6 | `cl134_not_prioritized` | INFO | {N} | div. | CL134 >30s am Stück |
| 7 | `teleportation` | CRITICAL | {N} | div. | Direkte Location-Sprünge ohne Pfad |
| — | `multi_order_violation` | CRITICAL | {N} | div. | S7/S8: Order-Co-Activation fehlt |
| — | `multi_order_loop_missing` | CRITICAL | {N} | div. | S7/S8: CL121→CL114-Übergang fehlt |
| — | `multi_order_incomplete` | CRITICAL | {N} | div. | S7/S8: Zweite Order-Sequenz unvollständig |
| — | `post_waiting_continuation` | WARNING | {N} | div. | Prozess nach CL134 ohne Reset |

**Vollständiger Violation-Typ-Katalog:** → `phase4_bpmn_validation.md §10.2`

---

### 5.3 Loop- und Wiederholungs-Analyse (→ phase4 §12.3)

#### Loops & Wiederholungen — Proband S{XX}, Szenario {SN}

| Loop-Typ | Beschreibung | Anzahl | Ø Dauer |
|:---------|:-------------|-------:|:--------|
| Pick-Loop | CL116→CL115→CL116 (Gateway: „Order completed?" = NO) | {N} | {hh:mm:ss} |
| Store-Loop | CL120→CL119→CL120 (Gateway: „Order completed?" = NO) | {N} | {hh:mm:ss} |
| Error-Loop Pick | CL135→CL137 (Gateway: „Items can be picked?" = NO) | {N} | {hh:mm:ss} |
| Error-Loop Store | CL135→CL137 (Gateway: „Items can be placed?" = NO) | {N} | {hh:mm:ss} |
| Packing-Loop | CL151→CL129 (Gateway: „More boxes?" = YES) | {N} | {hh:mm:ss} |
| Unpacking-Loop | CL151→CL129 (Gateway: „More boxes?" = YES) | {N} | {hh:mm:ss} |
| CL134 Events | Wartezeiten (Global Interrupt) | {N} | {hh:mm:ss} |

**Fehlerrate (CL135):**
- Geplante Fehler (S1, S3): {N} Events
- Mögliche Fehler (S5): {N} Events *(nicht erwartet, aber zulässig)*
- Ungeplante Fehler (S2, S4, S6, S7, S8): {N} Events
- **CL135 / Pick-Cycle Ratio:** {N}/{N} = {N}%

---

### 5.4 CC09-Prozess-Instanz-Timeline (→ phase4 §12.4)

Vollständige chronologische Sequenz aller CC09-Instanzen:

#### CC09-Timeline — Proband S{XX}, Szenario {SN}

| # | CC09 | Beschreibung | Start-Frame | End-Frame | Frames | Dauer | SOLL? |
|:--|:-----|:-------------|:------------|:----------|-------:|:------|:------|
| 1 | CL114 | Preparing Order | {N} | {N} | {N} | {hh:mm:ss} | ✅ |
| 2 | CL115 | Pick Travel Time | {N} | {N} | {N} | {hh:mm:ss} | ✅ |
| 3 | CL116 | Pick Time | {N} | {N} | {N} | {hh:mm:ss} | ✅ |
| 4 | CL115 | Pick Travel Time | {N} | {N} | {N} | {hh:mm:ss} | ✅ Loop |
| ... | ... | ... | ... | ... | ... | ... | ... |
| N | CL121 | Finalizing Order | {N} | {N} | {N} | {hh:mm:ss} | ✅ |

**Interpretation:** Jede Zeile entspricht einem CC09-Chunk (→ `reference_chunking.md`).
Loops sind durch identische CC09-Wiederholungen erkennbar.
Ungeplante Transitionen (SOLL? = ❌) sind CRITICAL Violations.

---

### 5.5 Szenario- und Warehouse-Kontext (→ phase4 §12.5)

#### Szenario-Kontext

| Dimension | Wert |
|:----------|:-----|
| Typ | Retrieval / Storage |
| Order | {2904/2905/2906} (CL100/CL101/CL102) |
| IT-System | {List+Pen CL105 / Scanner CL106 / PDT CL107} |
| Positionen | {N} |
| Gassen | {N} (Aisle 1–5) |
| Gewichtsbereich | {min}g – {max}g |
| Schwerstposition | {Regal-ID} {Artikel} ({Gewicht}g, {S/M/L}) |
| Geplante Fehler | Ja (S1, S3) / Möglich (S5) / Nein (S2, S4, S6, S7, S8) |

#### CL135-Szenario-Erwartung (Pflicht-Referenz)

| Szenario | Erwartung | Bewertung wenn auftritt |
|:---------|:----------|:------------------------|
| S1, S3 | Erwartet | ⚠️ Erwünscht (gemäß SOLL) |
| S5 | Möglich | ⚠️ Hinweis |
| S2, S4, S6, S7, S8 | Nicht geplant | ❌ Ungeplante Violation |

> **Quelle:** `reference_validation_rules.md §3.2` + `phase4_bpmn_validation.md §8`

#### IST/SOLL-Pfadvergleich (Kurzform)

| Szenario | SOLL-Pfad | IST-Pfad | Δ |
|:---------|:----------|:---------|:--|
| S1 | CL114→CL115→CL116→CL118→CL121 | {IST} | {Δ-Beschreibung} |
| S4 | CL114→CL117→CL119→CL120→CL121 | {IST} | {Δ-Beschreibung} |
| S7 | [CL114→CL115→CL116→CL118]×2→CL121 | {IST} | {Δ-Beschreibung} |
| S8 | [CL114→CL117→CL119→CL120]×2→CL121 | {IST} | {Δ-Beschreibung} |

**SOLL-Pfade vollständig:** → `phase4_bpmn_validation.md §12.6 SOLL_PATHS`

**Befund:** {Zusammenfassung der Process-Validierung: Konformitätsrate, dominante
Violation-Typen, auffällige Loop-Muster, CL135-Status}
```

**Datenquellen:** `phase4_bpmn_validation.md §12.1–12.5`
— §12.1 Konformitäts-Zusammenfassung, §12.2 Violations-Tabelle,
§12.3 Loop-Analyse, §12.4 CC09-Timeline, §12.5 Szenario-Kontext,
§12.6 Python-Hilfsfunktionen (`conformance_rate`, `count_loops`, `SOLL_PATHS`)

---

### 2.6 Gesamtbewertung & Auffälligkeiten

```markdown
## 6. Gesamtbewertung

### 6.1 Zusammenfassung

| Dimension | Bewertung | Begründung |
|:----------|:----------|:-----------|
| Szenario-Erkennung | ✅ / ⚠️ / ❌ | {Begründung} |
| REFA-Zeitstruktur | ✅ / ⚠️ / ❌ | {Begründung} |
| MTM-Ergonomie | ✅ / ⚠️ / ❌ | {Begründung} |
| Process-Konformität | ✅ / ⚠️ / ❌ | {Begründung} |

### 6.2 Auffälligkeiten & Empfehlungen

| # | Auffälligkeit | Phase | Severity | Empfehlung |
|:--|:--------------|:------|:---------|:-----------|
| 1 | {Beschreibung} | {1–4} | {H/M/L} | {Maßnahme} |
| 2 | {Beschreibung} | {1–4} | {H/M/L} | {Maßnahme} |

### 6.3 Probandenspezifische Besonderheiten

**Erfahrung vs. Leistung:**
- Picking-Erfahrung: {1–6} → {Einfluss auf Zeiten/Fehler}
- Anthropometrie: {Größe/Gewicht} → {Einfluss auf Ergonomie}

**Vergleich mit Kohorte:**
- Ø Konformitätsrate Kohorte: {N}% — Proband S{XX}: {N}% ({besser/schlechter})
- Ø Picking-Effizienz Kohorte: {N} Items/min — Proband S{XX}: {N} ({besser/schlechter})
```

---

### 2.7 Anhang

```markdown
## 7. Anhang

### 7.1 Datenquellen

| Phase | Datei | Version |
|:------|:------|:--------|
| Input | reference_dataset.md | 6.1.3 |
| Input | reference_warehouse.md | 6.2.1 |
| Input | reference_articles.md | 6.1.2 |
| Phase 1 | phase1_scenario_recognition.md | 6.1.2 |
| Phase 2 | phase2_refa_analysis.md | 6.2.0 |
| Phase 3 | phase3_mtm_analysis.md | 6.2.3 |
| Phase 4 | phase4_bpmn_validation.md | 6.1.3 |

### 7.2 Verwendete CSV-Dateien

| CC | Dateiname |
|:---|:----------|
| CC01 | Revised_Annotation__CC01_Main Activity__S{XX}.csv |
| CC02 | Revised_Annotation__CC02_Sub-Activity - Legs__S{XX}.csv |
| ... | ... |
| CC12 | Revised_Annotation__CC12_Location - Cart__S{XX}.csv |

### 7.3 Glossar

| Abkürzung | Bedeutung |
|:----------|:----------|
| CC | Classification Category (CC01–CC12) |
| CL | Classification Label (CL001–CL207) |
| BPMN | Business Process Model and Notation |
| REFA | Verband für Arbeitsgestaltung, Betriebsorganisation und Unternehmensentwicklung |
| MTM | Methods-Time Measurement |
| IST | Tatsächlich beobachtetes Verhalten |
| SOLL | Idealisierter Prozessablauf (BPMN-Modell) |
| fps | Frames per second (30 fps im DaRa-Datensatz) |
```

---

## 3. Generierungslogik

### 3.1 Phasen-Reihenfolge

Die Phasen **MÜSSEN** in folgender Reihenfolge ausgeführt werden,
da jede Phase auf die Ergebnisse der vorherigen aufbaut:

```text
Phase 0: Datenzugriff (CSV laden, Frame-Vektoren erstellen)
    ↓
Phase 1: Szenarioerkennung (CC06/CC07/CC08 → S1–S8/Other)
    ↓ Szenario-Vektor
Phase 2: REFA-Analyse (CC09/CC10/CC01 → t_R, t_A, t_E, t_w)
    ↓ Zeitarten pro Szenario
Phase 3: MTM-Analyse (CC01/CC02/CC03/CC04/CC05 → Grundbewegungen)
    ↓ Bewegungshäufigkeiten
Phase 4: Process-Validierung (CC09→CC10, Sequenz, Tools, Locations)
    ↓ Violations + Conformance
Phase 5: Berichtserstellung (Konsolidierung aller Ergebnisse)
    ↓ Fertigter Bericht
```

### 3.2 Input-Anforderungen pro Phase

| Phase | Benötigte CCs | Zusätzliche Inputs |
|:------|:-------------|:-------------------|
| 1 | CC06, CC07, CC08, CC10 | — |
| 2 | CC01, CC03, CC04, CC05, CC09, CC10 | Szenario-Vektor aus Phase 1 |
| 3 | CC01, CC02, CC03, CC04, CC05 | — |
| 4 | CC04, CC05, CC09, CC10, CC11 | Szenario-Vektor aus Phase 1 |
| 5 | — | Ergebnisse Phase 1–4 |

### 3.3 Bewertungsskala

| Symbol | Bedeutung | Kriterien |
|:-------|:----------|:----------|
| ✅ | Unauffällig | Konformität >95%, 0 CRITICAL Violations |
| ⚠️ | Prüfenswert | Konformität 85–95% ODER ≥1 CRITICAL ODER CL135 ungeplant ODER teleportation |
| ❌ | Auffällig | Konformität <85% ODER ≥3 CRITICAL ODER multi_order_* Violation ODER systematische chunk_instability |

**Severity-Zuordnung Violations (→ phase4 §10.2):**

| Violation-Typ | Severity | Beeinflusst ✅/⚠️/❌ |
|:--------------|:---------|:--------------------|
| `cc10_not_in_allowed_list` | CRITICAL | Ja — direkt ❌ |
| `tool_missing` | CRITICAL | Ja — direkt ❌ |
| `impossible_cc09_transition` | CRITICAL | Ja — direkt ❌ |
| `multi_order_violation` | CRITICAL | Ja — direkt ❌ |
| `teleportation` | CRITICAL | Ja — ⚠️ oder ❌ |
| `multi_order_loop_missing` | CRITICAL | Ja — direkt ❌ |
| `multi_order_incomplete` | CRITICAL | Ja — direkt ❌ |
| `location_mismatch` | WARNING | Bedingt — ⚠️ |
| `chunk_instability` | WARNING | Bedingt — ⚠️ |
| `post_waiting_continuation` | WARNING | Bedingt — ⚠️ |
| `noisy_transition` | INFO | Nein — nur dokumentieren |
| `cl134_not_prioritized` | INFO | Nein — nur dokumentieren |

---

## 4. Verwandte Dateien

| Datei | Abschnitt | Rolle im Bericht |
|:------|:----------|:-----------------|
| `reference_dataset.md` | §1 | Probanden-Steckbrief, Frame-Zahlen |
| `reference_warehouse.md` | §2–3 | Warehouse-Kontext, Distanzen |
| `reference_articles.md` | §1 | Artikel-Details, Gewichtsklassen |
| `phase1_scenario_recognition.md` | §4.1 | Szenario-Ergebnistabelle |
| `phase2_refa_analysis.md` | §2–6 | Zeitarten-Zerlegung, t_E-Algorithmus |
| `phase3_mtm_analysis.md` | §1–3 | MTM-Grundbewegungen, Ergonomie |
| `phase4_bpmn_validation.md` | **§12.1** | Process-Konformitäts-Zusammenfassung → §2.5.1 |
| `phase4_bpmn_validation.md` | **§12.2** | Violations-Häufigkeitstabelle → §2.5.2 |
| `phase4_bpmn_validation.md` | **§12.3** | Loop- und Wiederholungs-Analyse → §2.5.3 |
| `phase4_bpmn_validation.md` | **§12.4** | CC09-Prozess-Instanz-Timeline → §2.5.4 |
| `phase4_bpmn_validation.md` | **§12.5** | Szenario/Warehouse-Kontext → §2.5.5 |
| `phase4_bpmn_validation.md` | §12.6 | Python: `conformance_rate`, `count_loops`, `SOLL_PATHS` |
| `phase4_bpmn_validation.md` | §10.2 | Vollständiger Violation-Typ-Katalog (11 Typen) |
| `phase4_bpmn_validation.md` | §13–15 | BPMN-Generierung, IST/SOLL-Vergleich, Erweiterungen |
| `reference_validation_rules.md` | §3.2 | CL135-Szenario-Erwartung |
| `templates/scenario_report.md` | — | Szenario-Berichtsvorlage (optional) |
| `templates/bpmn_report.md` | — | Process-Berichtsvorlage (optional) |

<!-- VERIFICATION_TOKEN: DARA-P5RPT-8E3C-v630 -->
