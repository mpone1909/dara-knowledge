---
version: 6.1.3
status: finalisiert
created: 2026-02-26
updated: 2026-02-26
references:
  - phase1_scenario_recognition.md
  - phase2_refa_analysis.md
  - phase3_mtm_analysis.md
  - phase4_bpmn_validation.md
  - reference_dataset.md
  - reference_warehouse.md
  - reference_articles.md
---

# Phase 5: Ergebnisbericht — Konsolidierung aller Phasen

**Version:** 6.1.3 (2026-02-26)
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
├─ 5. BPMN-Prozessvalidierung (Phase 4)
├─ 6. Gesamtbewertung & Auffälligkeiten
└─ 7. Anhang (Rohdaten-Referenzen)
```

---

## 2. Berichts-Template

### 2.1 Probanden-Steckbrief

```markdown
# DaRa-Analysebericht — Proband S{XX}

**Erstellt:** {Datum}
**Skill-Version:** 6.1.3
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

### 2.1 Erkannte Szenarien (chronologisch)

| # | Szenario | Typ | Frames | Dauer (hh:mm:ss) | Anteil (%) |
|:--|:---------|:----|-------:|:-----------------|:-----------|
| 1 | S4 | Storage | 15.230 | 00:08:27 | 7,6% |
| 2 | S1 | Retrieval | 42.815 | 00:23:47 | 21,5% |
| ... | ... | ... | ... | ... | ... |
| — | Other | Wartezeit/Sonstig | 39.282 | 00:21:49 | 19,7% |
|   | **GESAMT** | | **199.427** | **01:50:47** | **100,0%** |

### 2.2 Anomalien bei Szenarioerkennung

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

### 2.5 BPMN-Prozessvalidierung (aus Phase 4)

```markdown
## 5. BPMN-Prozessvalidierung

### 5.1 Konformitäts-Übersicht (alle Szenarien)

| Szenario | Frames | Konformität | CRITICAL | WARNING | INFO | Loops |
|:---------|-------:|:------------|:---------|:--------|:-----|:------|
| S4 | 15.230 | 98,2% | 0 | 3 | 5 | 12 |
| S1 | 42.815 | 95,1% | 2 | 8 | 15 | 14 |
| S2 | 38.100 | 99,5% | 0 | 1 | 3 | 13 |
| ... | ... | ... | ... | ... | ... | ... |
| **Gesamt** | **{N}** | **{N}%** | **{N}** | **{N}** | **{N}** | **{N}** |

### 5.2 IST/SOLL-Pfadvergleich (pro Szenario)

| Szenario | SOLL-Pfad | IST-Pfad | Abweichungen |
|:---------|:----------|:---------|:-------------|
| S4 | CL114→CL117→CL119→CL120→CL121 | CL114→CL117→CL119→CL120→CL121 | Keine |
| S1 | CL114→CL115→CL116→CL118→CL121 | CL114→CL115→CL116→**CL115→CL116**→CL118→CL121 | 1 Extra-Loop |

### 5.3 Fehlerhäufigkeit (CL135-Analyse)

| Szenario | Geplante Fehler? | CL135-Events | CL135/Cycle-Ratio | Bewertung |
|:---------|:-----------------|:-------------|:-------------------|:----------|
| S1 | Ja | 3 | 21,4% | ⚠️ Erwünscht |
| S2 | Nein | 0 | 0,0% | ✅ Korrekt |
| S7 | Nein (Perfect Run) | 1 | 7,1% | ❌ Ungeplant |

### 5.4 Kontext: Warehouse & Artikel

| Szenario | Order | Positionen | Gassen | Schwerster Artikel | Gewichtsbereich |
|:---------|:------|:-----------|:-------|:-------------------|:----------------|
| S1 | 2904 | 15 | 5 | Palm Soil (5.149g) | 0,4g – 5.149g |
| S2 | 2905 | 15 | 5 | Hand Axe (1.000g) | 0,4g – 1.000g |

**Befund:** {Zusammenfassung der BPMN-Validierung}
```

**Datenquelle:** `phase4_bpmn_validation.md` §12

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
| BPMN-Konformität | ✅ / ⚠️ / ❌ | {Begründung} |

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
| Input | reference_warehouse.md | 6.1.2 |
| Input | reference_articles.md | 6.1.2 |
| Phase 1 | phase1_scenario_recognition.md | 6.1.1 |
| Phase 2 | phase2_refa_analysis.md | 6.1.1 |
| Phase 3 | phase3_mtm_analysis.md | 6.1.1 |
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
Phase 4: BPMN-Validierung (CC09→CC10, Sequenz, Tools, Locations)
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
| ✅ | Unauffällig | Konformität >95%, keine CRITICAL Violations |
| ⚠️ | Prüfenswert | Konformität 85–95% ODER ≥1 CRITICAL, ODER Anomalien |
| ❌ | Auffällig | Konformität <85% ODER ≥3 CRITICAL ODER systematische Fehler |

---

## 4. Verwandte Dateien

| Datei | Rolle im Bericht |
|:------|:-----------------|
| `reference_dataset.md` | Probanden-Steckbrief, Frame-Zahlen |
| `reference_warehouse.md` | Warehouse-Kontext, Distanzen |
| `reference_articles.md` | Artikel-Details, Gewichtsklassen |
| `phase1_scenario_recognition.md` | §4.1 Szenario-Ergebnistabelle |
| `phase2_refa_analysis.md` | Zeitarten-Zerlegung |
| `phase3_mtm_analysis.md` | MTM-Grundbewegungen |
| `phase4_bpmn_validation.md` | §12 Konformitäts-Ausgabe |
| `templates/scenario_report.md` | Szenario-Berichtsvorlage (optional) |
| `templates/bpmn_report.md` | BPMN-Berichtsvorlage (optional) |
