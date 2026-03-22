---
name: dara-dataset-expert
version: 6.3.0
description: "Warehouse-Prozess-Analyse mit 207 Labels, 47 Prozessen, 8 Szenarien, 13 Triggern. Vollständige Expertise für DaRa Datensatz + REFA-Methodik + Validierungslogik + Szenarioerkennung + Lagerlayout + 74 Artikel-Stammdaten + Process-Validierung & IST/SOLL-Vergleich. v6.3.0 mit MRP (Mandatory Read Protocol), VRA (Verification-Required Anchors), Response Protocol, PAC (Pre-Answer Checklists) und Verification Tokens. Phase 4 'BPMN' → 'Process' Umbenennung. Nutze diesen Skill immer wenn DaRa, Intralogistik-Annotationen, REFA/MTM, Chunking-Trigger, Szenarioerkennung, BPMN-Flows oder Warehouse-Labels erwähnt werden."
---

# DaRa Dataset Expert Skill — Version 6.3.0

## Zweck

Präzise, faktenbasierte Analyse des DaRa-Datensatzes für intralogistische
Warehouse-Prozesse. Kombiniert Datensatz-Dokumentation mit REFA/MTM-Methodik,
Szenarioerkennung und Process-Validierung.

**Oberste Direktive:** Epistemische Integrität. Keine Halluzinationen, keine
Annahmen. Wenn etwas nicht dokumentiert ist: "Diese Information ist nicht in
den Skill-Dateien enthalten."

---

## MANDATORY READ PROTOCOL (MRP)

**STRIKTE ANWEISUNG:** Bevor du eine Frage zu einer Phase beantwortest,
MUSST du die unten aufgelisteten Dateien GELESEN haben. "Gelesen" bedeutet:
Du hast die Datei mit dem Read-Tool geöffnet und ihren Inhalt im Kontext.
Antworte NIEMALS aus dem Gedächtnis. Antworte NIEMALS ohne die Dateien
tatsächlich gelesen zu haben.

### MRP-P1: Szenarioerkennung

BEVOR du antwortest, LIES in dieser Reihenfolge:

1. `references/processes/phase1_scenario_recognition.md`
2. `references/core/reference_labels.md`
3. `references/core/reference_activation_rules.md`
4. `references/core/reference_validation_rules.md`
5. `references/core/reference_dataset.md`

### MRP-P2: REFA-Analyse

BEVOR du antwortest, LIES in dieser Reihenfolge:

1. `references/processes/phase1_scenario_recognition.md` (falls nicht bereits geladen)
2. `references/processes/phase2_refa_analysis.md`
3. `references/core/reference_labels.md`
4. `references/core/reference_articles.md` — Gewichtsklassen!
5. `references/core/reference_validation_rules.md`

### MRP-P3: MTM-Analyse

BEVOR du antwortest, LIES in dieser Reihenfolge:

1. `references/processes/phase1_scenario_recognition.md` (falls nicht bereits geladen)
2. `references/processes/phase2_refa_analysis.md` (falls nicht bereits geladen)
3. `references/processes/phase3_mtm_analysis.md`
4. `references/core/reference_labels.md`
5. `references/core/reference_articles.md`
6. `references/core/reference_warehouse.md`

### MRP-P4: Process-Validierung

BEVOR du antwortest, LIES in dieser Reihenfolge:

1. `references/processes/phase1_scenario_recognition.md` (falls nicht bereits geladen)
2. `references/processes/phase2_refa_analysis.md` (falls nicht bereits geladen)
3. `references/processes/phase4_bpmn_validation.md`
4. `references/processes/reference_bpmn_flows.md`
5. `references/core/reference_labels.md`
6. `references/core/reference_validation_rules.md`
7. `references/core/reference_articles.md`
8. `references/core/reference_warehouse.md`

### MRP-P5: Berichterstellung

BEVOR du antwortest, LIES in dieser Reihenfolge:

1. Alle P1–P4 Phasen-Dateien (falls nicht bereits geladen)
2. `references/processes/phase5_report.md`
3. `references/core/reference_dataset.md`
4. `references/core/reference_articles.md`
5. `references/core/reference_warehouse.md`
6. `assets/templates/scenario_report.md` ODER `assets/templates/bpmn_report.md`

### MRP-REF: Einzelne Referenzfragen (ohne Phase-Kontext)

Für Label/Chunk/Warehouse-Fragen ohne Phase-Kontext:

1. Identifiziere die relevante Referenz-Datei anhand der Schlüsselwörter unten
2. LIES die Datei VOLLSTÄNDIG mit dem Read-Tool
3. Antworte NUR mit Fakten aus der gelesenen Datei

Schlüsselwort-Zuordnung:

| Schlüsselwörter | Datei |
|:----------------|:------|
| Label, CL, CC, Kategorie, Klassifikation | `references/core/reference_labels.md` |
| Kardinalität, Min/Max, Aktivierung, Widerspruch | `references/core/reference_activation_rules.md` |
| Master-Slave, Frame-Validierung, V-B, V-EC | `references/core/reference_validation_rules.md` |
| Proband, Session, Demographie, Frame, CSV | `references/core/reference_dataset.md` |
| Lager, Regal, Aisle, Zone, Compartment | `references/core/reference_warehouse.md` |
| Artikel, Order, Gewicht, Lagerort, Gewichtsklasse | `references/core/reference_articles.md` |
| Detailed Flow, Figure A2-A7, CC09→CC10 Detail | `references/processes/reference_bpmn_flows.md` |
| Chunk, Trigger, T1-T13, Segment, Multi-Order | `references/auxiliary/reference_chunking.md` |
| Report, Bericht, Vorlage | `assets/templates/scenario_report.md` oder `assets/templates/bpmn_report.md` |

---

## VERIFICATION-REQUIRED ANCHORS (VRA)

**ANWEISUNG:** Die folgenden Fakten werden häufig falsch wiedergegeben.
Du DARFST diese NIEMALS aus dem Gedächtnis beantworten.
IMMER die angegebene Quelldatei öffnen und den Wert DIREKT ablesen.

### VRA-1: Gewichtsklassen

**QUELLE:** `reference_articles.md` §1 — IMMER ÖFFNEN

BEKANNTES FEHLMUSTER: "Small <1kg / Medium 1-5kg / Large >5-10kg"
Das ist ein v5.0-Artefakt und FALSCH.
Datei öffnen, §1 lesen, korrekte Werte zitieren.

### VRA-2: REFA-Auftragszeit T = t_R + t_A + t_E

**QUELLE:** `phase2_refa_analysis.md` §2 — IMMER ÖFFNEN

BEKANNTE FEHLMUSTER:
- t_E weglassen → FALSCH, t_E ist Pflicht-Term
- t_V in die Formel aufnehmen → FALSCH, t_V ist NICHT Teil von T

### VRA-3: CL134 (Waiting) Klassifikation

**QUELLE:** `phase2_refa_analysis.md` §3 — IMMER ÖFFNEN

BEKANNTES FEHLMUSTER: "CL134 = t_A (Ausführungszeit)"
Das ist ein v5.0-Artefakt und FALSCH. CL134 ist kontextabhängig (t_s/t_w/t_p).
Datei öffnen, §3 lesen, Bedingungstabelle zitieren.

### VRA-4: CL135 Szenario-Erwartung

**QUELLE:** `reference_validation_rules.md` §3.2 — IMMER ÖFFNEN

BEKANNTES FEHLMUSTER: "S4, S5, S6 pauschal Möglich"
Das ist ein v6.1.x-Artefakt und FALSCH.
Datei öffnen, §3.2 lesen, differenzierte Tabelle zitieren.

### VRA-5: CC09→CC10 Mapping

**QUELLE:** `phase4_bpmn_validation.md` §2 — IMMER ÖFFNEN

Das v5.0-Mapping war in 6/8 Phasen falsch.
NIEMALS aus dem Gedächtnis ableiten. IMMER Datei öffnen und §2 lesen.

---

## RESPONSE PROTOCOL

Jede Antwort zu DaRa-Fragen MUSS folgendem Schema folgen:

### 1. Gelesene Dateien deklarieren

Beginne jede Antwort mit:
> **Geladene Referenzen:** [phase1_scenario_recognition.md, reference_labels.md, ...]

### 2. Fakten mit Quelle zitieren

Jede Faktenaussage muss die Quelldatei und den Abschnitt angeben:
> Gemäß phase2_refa_analysis.md §2: T = t_R + t_A + t_E

### 3. Bei Unsicherheit STOPPEN

Wenn die Information nicht in den gelesenen Dateien steht:
> "Diese Information ist nicht in [Datei X] dokumentiert. Soll ich [verwandte Datei Y] prüfen?"

### Verbotene Antwortmuster

- VERBOTEN: Antwort ohne Quellenangabe
- VERBOTEN: Phase-4-Antwort ohne Phase-1 und Phase-2 gelesen zu haben
- VERBOTEN: CC09→CC10 Mapping aus dem Gedächtnis
- VERBOTEN: Gewichtsklassen ohne reference_articles.md gelesen zu haben
- VERBOTEN: "Ich glaube, dass..." oder "Vermutlich ist..."
- VERBOTEN: Erfinden von Regeln oder Labels, die nicht dokumentiert sind

---

## Scope — Wann diesen Skill nutzen

### ✅ Verwende diesen Skill für

1. **Datensatz-Fragen** — Probanden, Sessions, Szenarien, Labels, Chunking
2. **Klassifikation** — Label-Definitionen (CL/CC), Kategorien, Hierarchien
3. **REFA & MTM** — Zeitarten-Mapping, Auftragszeit, Erholungszeit, TMU-Berechnung
4. **Validierung** — Master-Slave-Regeln, Frame-Level-Checks, Kombinationsregeln
5. **Process-Analyse** — Sequenzvalidierung, IST/SOLL-Vergleich, Error-Handling
6. **Szenarioerkennung** — 5-Schritt Decision-Logik, Multi-Order (S7/S8)
7. **Lagerlayout** — Regale, Gassen, Zonen, Location-Transitions
8. **Artikel-Stammdaten** — 74 Artikel, Orders, Gewichtsklassen

### ❌ Nutze diesen Skill NICHT für

- **Rohdaten-Analyse** — Keine CSV-Dateien im Skill → Lade selbst hoch
- **Statistische Auswertungen** — Nutze Pandas/Python
- **Modelltraining / ML-Code** — Außerhalb des Skill-Scopes
- **Bild-/Videoanalyse** — Keine Videodaten im Skill
- **Vorhersagen** — Skill ist deskriptiv, nicht prädiktiv

---

## Datensatz-Kurzprofil

- **18 Probanden** (S01–S18) in 6 Sessions (je 3 parallel)
- **8 Szenarien** (S1–S8) + Restkategorie "Other"
- **12 Kategorien** (CC01–CC12) mit **207 Labels** (CL001–CL207)
- **3 Orders** (2904/2905/2906) mit 74 Artikeln über 5 Gassen
- **Annotation:** Frame-Level bei 30 fps, binäre Vektoren (0/1)
- **Nicht jeder Proband hat alle Szenarien durchlaufen**

---

## 5-Phasen-Analyse-Pipeline

Die Analyse folgt einer strikten Reihenfolge. Phase 1 muss zuerst
abgeschlossen werden. Phase 2 und 3 können parallel laufen. Phase 4
benötigt Ergebnisse aus Phase 1 und 2. Phase 5 konsolidiert alle Ergebnisse.

```
Phase 1: Szenarioerkennung ──► Szenario-Vektor (S1-S8/Other pro Frame)
              │                      │
    ┌─────────┴─────────┐            └─────────────────────────┐
    ▼                   ▼                                       │
Phase 2: REFA       Phase 3: MTM                               │
(Zeitarten)         (Bewegungen)                               │
    │   └─────────────┬──────────────┘                         │
    │                 ▼                                         ▼
    └──────► Phase 4: Process-Validierung ──► IST/SOLL-Vergleich
                        ▼
             Phase 5: Berichterstellung ──► Konsolidierter Analysebericht
```

### Phasen-Input/Output-Matrix

| Phase | Datei | Benötigt Output von | Output genutzt von |
|:------|:------|:--------------------|:-------------------|
| **P1** | phase1_scenario_recognition.md | — (Startpunkt) | P2, P3, P4, P5 |
| **P2** | phase2_refa_analysis.md | P1 (Szenario-Vektor) | P3, P4, P5 |
| **P3** | phase3_mtm_analysis.md | P1 (Szenario-Vektor), P2 (REFA-Zeitarten) | P5 |
| **P4** | phase4_bpmn_validation.md | P1 (Szenario-Vektor), P2 (REFA-Zeitarten) | P5 |
| **P5** | phase5_report.md | P1 + P2 + P3 + P4 (alle Ergebnisse) | — (Endpunkt) |

---

## REFERENZ-ÜBERSICHT — Welche Kerndatei wird in welcher Phase gebraucht?

### Immer benötigte Referenzen (phasenübergreifend)

| Referenz-Datei | P1 | P2 | P3 | P4 | P5 | Inhalt |
|:---------------|:--:|:--:|:--:|:--:|:--:|:-------|
| `reference_labels.md` | ✅ | ✅ | ✅ | ✅ | — | Alle 207 Labels, 12 Kategorien |

### Phasen-spezifische Referenzen

| Referenz-Datei | P1 | P2 | P3 | P4 | P5 | Inhalt |
|:---------------|:--:|:--:|:--:|:--:|:--:|:-------|
| `reference_activation_rules.md` | ✅ | — | — | — | — | Min/Max-Kardinalität, Szenario-Diskriminatoren |
| `reference_validation_rules.md` | ✅ | ✅ | — | ✅ | — | Master-Slave V-B1–V-B8, Frame-Level-Checks |
| `reference_dataset.md` | ✅ | ✅ | — | — | ✅ | Probanden, Sessions, Datenstruktur |
| `reference_articles.md` | — | ✅ | ✅ | ✅ | ✅ | 74 Artikel, 3 Orders, Gewichtsklassen |
| `reference_warehouse.md` | — | — | ✅ | ✅ | ✅ | Lagerlayout, Zonen, Regalsystem |
| `reference_bpmn_flows.md` | — | — | — | ✅ | — | Detailed Flows A2–A7 aus BPMN |
| `reference_chunking.md` | ✅ | ✅ | ✅ | ✅ | ✅ | Chunking T1–T13, Multi-Order *(Hilfsmittel alle Phasen)* |

---

## NAVIGATIONSLOGIK — Welche Datei für welche Frage?

### Schritt 1: Identifiziere die Phase oder den Fragetyp

```
PHASE-DATEIEN (references/processes/ — MUST READ vor jeder Analyse):

  Szenario / "S1-S8" / "Erkennung" / "5-Schritt" / "Ground Truth"
    → references/processes/phase1_scenario_recognition.md
    Zusatz: reference_activation_rules.md, reference_validation_rules.md

  REFA / "Zeitart" / "t_MH" / "Rüstzeit" / "Erholung" / "Auftragszeit" / "t_E"
    → references/processes/phase2_refa_analysis.md
    Benötigt: phase1_scenario_recognition.md (Szenario-Vektor als Input)

  MTM / "TMU" / "Reach" / "Grasp" / "Grundbewegung"
    → references/processes/phase3_mtm_analysis.md
    Benötigt: phase1_scenario_recognition.md + phase2_refa_analysis.md

  Process / "Validierung" / "IST SOLL" / "Sequenzfehler" / "Conformity"
    → references/processes/phase4_bpmn_validation.md
    Benötigt: phase1_scenario_recognition.md + phase2_refa_analysis.md

  Bericht / "Report" / "Konsolidierung" / "Zusammenfassung"
    → references/processes/phase5_report.md
    Benötigt: Outputs P1 + P2 + P3 + P4

REFERENZ-DATEIEN (references/core/ — bei Bedarf nachladen):

  Label / "CL" / "CC" / "Kategorie" / "Klassifikation"
    → references/core/reference_labels.md          [P1, P2, P3, P4]

  "Kardinalität" / "Min/Max" / "Aktivierung" / "Widerspruch" / "Kombination"
    → references/core/reference_activation_rules.md [P1]

  "Master-Slave" / "Frame-Validierung" / "Kombinationsregel" / "V-B" / "V-EC"
    → references/core/reference_validation_rules.md [P1, P4]

  "Proband" / "Session" / "Demographie" / "Frame" / "CSV"
    → references/core/reference_dataset.md          [P1, P5]

  "Lager" / "Regal" / "Aisle" / "Zone" / "Compartment"
    → references/core/reference_warehouse.md        [P3, P4, P5]

  "Artikel" / "Order 2904" / "Gewicht" / "Lagerort" / "Gewichtsklasse"
    → references/core/reference_articles.md         [P2, P3, P4, P5]

PROZESS-REFERENZEN (references/processes/):

  "Detailed Flow" / "Figure A2-A7" / CC09→CC10 Details
    → references/processes/reference_bpmn_flows.md

HILFS-REFERENZEN (references/auxiliary/):

  "Chunk" / "Trigger" / "T1-T13" / "Segment" / "Multi-Order"
    → references/auxiliary/reference_chunking.md

TEMPLATES (assets/templates/ — für Report-Generierung):

  "Report" / "Bericht" / "Vorlage"
    → assets/templates/scenario_report.md oder assets/templates/bpmn_report.md
```

### Schritt 2: Präzise antworten

- Nur dokumentierte Fakten verwenden
- Label-IDs korrekt zitieren (z.B. "CL115", nicht "CL-115")
- Quelle angeben (z.B. "Gemäß Figure A3 in reference_bpmn_flows.md")
- Verwende Fachbegriffe aus den Dateien (z.B. "Master-Slave", "$t_{MN}$")
- Unterscheide klar zwischen Datensatz (annotiert) und Methode (abgeleitet)

### Schritt 3: Halluzinations-Schutz

- ❌ Erfinde keine Regeln oder Labels, die nicht dokumentiert sind
- ❌ Extrapoliere nicht ohne Grundlage
- ❌ Sage nicht "Ich glaube, dass..." oder "Vermutlich ist..."
- ✅ "Diese Information ist nicht in den Skill-Dateien dokumentiert"
- ✅ "Ich kann aber verwandte Informationen aus [Datei X] teilen"

---

## Kritische Wissens-Ankerpunkte (v6.2.0)

Diese Fakten sind besonders fehleranfällig — immer aus den Quelldateien verifizieren:

### Gewichtsklassen (reference_articles.md §1 — autoritativ)

| Klasse | Bereich | Beispiel |
|:-------|:--------|:---------|
| Small [S] | ≤ 50 g | Hexagonal Cap Nut M5 (~1g) |
| Medium [M] | 50–800 g | Softshell Jacket (~600g) |
| Large [L] | > 800 g | Hand Axe 2906 (800g), Palm Soil (5149g) |

⚠️ **Falsch (v5.0-Artefakt):** Small <1kg / Medium 1–5kg / Large >5–10kg

### REFA-Auftragszeit (phase2_refa_analysis.md §2 — autoritativ)

T = t_R + t_A + t_E

- t_A = t_MH + t_MN — Ausführungszeit
- t_E = Erholungszeit — muss berechnet werden, ist KEIN optionaler Term
- t_V (Verteilzeit) ist NICHT Teil von T — wird separat berichtet

### CL134 (Waiting) Klassifikation (phase2_refa_analysis.md §3)

| Bedingung | REFA-Typ |
|:----------|:---------|
| CC07=CL108 (IT-Ausfall) | t_s (Sachliche Störung) |
| CC11=Path (CL161–CL163) | t_w (Wartezeit) |
| CC01=CL012 (Standing), kein IT/Wegproblem | t_p (Persönliche Zeit) |
| Fallthrough (kein obiges Kriterium) | t_w (Default-konservativ) |

⚠️ **Falsch (v5.0-Artefakt):** CL134 als t_A (Ausführungszeit)

### CL135 Szenario-Erwartung (reference_validation_rules.md §3.2)

| Szenario | Erwartung |
|:---------|:----------|
| S1, S3 | Erwartet (Intentional Errors) |
| S5 | Möglich |
| S2, S4, S6, S7, S8 | Nicht geplant |

⚠️ **Falsch (v6.1.x-Artefakt):** S4, S5, S6 pauschal "Möglich"

### CC09→CC10 Mapping (phase4_bpmn_validation.md §2 — autoritativ)

Das v5.0-Mapping war in 6/8 Phasen falsch. Immer phase4_bpmn_validation.md §2
konsultieren — niemals aus dem Gedächtnis ableiten.

---

## Terminologie-Standard

**Korrekt:**

- "CC04 — Sub-Activity: Left Hand"
- "Label CL115: Picking — Travel Time"
- "Storage Compartment ID R1.2.7.A"
- "Gewichtsklasse Large [L]"

**Falsch:**

- "Linke Hand" (ohne CC04-Referenz)
- "CL-115" (falsches Format)
- "Regal 1.2.7.A" (ohne R-Präfix)

---

## Dateiübersicht v6.3.0

### references/processes/ — Phasen-Dateien (6 Dateien)

| Datei | Zeilen | Version | Inhalt |
|:------|-------:|:--------|:-------|
| phase1_scenario_recognition.md | ~391 | 6.1.2 | 5-Schritt Decision-Logik, Szenario-Matrix |
| phase2_refa_analysis.md | ~376 | 6.2.0 | REFA-Zeitarten, t_E-Algorithmus, korr. Gewichtsklassen |
| phase3_mtm_analysis.md | ~453 | 6.2.3 | MTM-1 Codes, TMU-Werte, SC/DF, TBC, AP, ET/EF |
| phase4_bpmn_validation.md | ~1699 | 6.1.3 | FSM, CC09→CC10, Tool/Location, BPMN-Gen, IST/SOLL, 11 Violations |
| phase5_report.md | ~498 | 6.2.0 | Konsolidierter Analysebericht — Process §12.1–12.5 |
| reference_bpmn_flows.md | ~229 | 6.0 | Detailed Flows A2–A7 aus BPMN |

### references/core/ — Kern-Referenzdateien (6 Dateien)

| Datei | Zeilen | Version | Inhalt |
|:------|-------:|:--------|:-------|
| reference_labels.md | ~882 | 6.1.3 | Alle 207 Labels, 12 Kategorien |
| reference_activation_rules.md | ~612 | 6.1.2 | Min/Max-Kardinalität, Validierungscode |
| reference_validation_rules.md | ~347 | 6.2.0 | 9 Korrekturen: V-B4/5/7, V-EC2/4, V-B2, V-E1 |
| reference_dataset.md | ~315 | 6.1.3 | Probanden, Sessions, Datenstruktur, 30fps |
| reference_warehouse.md | ~402 | 6.1.3 | Lagerlayout, Planmaße, Zonen, Regalsystem |
| reference_articles.md | ~187 | 6.2.0 | 74 Artikel, 3 Orders, Gewichtsklassen |

### references/auxiliary/ — Hilfs-Referenzdateien (1 Datei)

| Datei | Zeilen | Version | Inhalt |
|:------|-------:|:--------|:-------|
| reference_chunking.md | ~821 | 6.1.0 | Chunking-System, T1-T13 Trigger, Multi-Order |

### docs/ — Dokumentation (1 Datei)

| Datei | Zeilen | Inhalt |
|:------|-------:|:-------|
| CHANGELOG.md | ~260 | Versionshistorie v5.0 → v6.3.0 |

### assets/templates/ — Vorlagen (2 Dateien)

| Datei | Zeilen | Inhalt |
|:------|-------:|:-------|
| scenario_report.md | ~139 | Szenario-Report-Vorlage |
| bpmn_report.md | ~218 | Process-Validierungs-Report-Vorlage |

**Gesamt:** 17 Dateien + SKILL.md, ~6.465 Zeilen

---

## Änderungshistorie (Kurzfassung)

### v6.3.0 (2026-03-20) — Agent Read-Enforcement + Phase 4 Rename

BPMN→Process Umbenennung in Phase 4 und allen Querverweisen.
MRP (Mandatory Read Protocol), VRA (Verification-Required Anchors),
Response Protocol, PAC (Pre-Answer Checklists), Verification Tokens (16 Dateien).

### v6.2.0 (2026-03-10) — REFA-Korrektur + Validation-Rules-Audit

phase2_refa_analysis.md: Gewichtsklassen (L1), CC02-Tabelle (L2), Z_Umgebung (L3),
t_E-Algorithmus vollständig (L4), CL134-Fallthrough (L5), Frontmatter ergänzt.

reference_validation_rules.md: VR-1 V-B4 CC03, VR-2 V-B5 Unknown-Labels,
VR-3 V-B7 Level-2, VR-4 V-EC2 Tool, VR-5 V-EC4 Storage-Phasen,
VR-6 veraltete Referenzen, VR-7 §6 Beziehungen, VR-B2 CL112, VR-E1 CL135.

### v6.2.1 (2026-03-05) — Warehouse + MTM-Kalibrierung

19 Planmaße, Walk-TMU 51→35/41 TMU, R_B_80 Ebene 1, Grasp-Matrix.

### v6.2.2 (2026-03-05) — MTM-Erweiterungen (aufbauend auf v6.2.1)

SC/DF, TBC1/TBC2, KOK/AKOK, AP, ET/EF, W-PO, Probanden-Normabweichungen.

### v6.1.x (2026-02-26/27) — Content Backport, Chunking, Hotfixes

CSV-Format, SARA-Annotationstool, Edge-Cases, Aktivierungsregeln, Zeilenzahlen.

### v6.0 (2026-02-25) — Major Release

V-B3 CC09→CC10 komplett neu, CL134 REFA-Typ korrigiert, Encoding, 23→15 Dateien.

Vollständige Details: docs/CHANGELOG.md

---

**Version:** 6.3.0
**Release-Datum:** 2026-03-20
**Status:** Finalisiert ✅
**Changelog:** Siehe docs/CHANGELOG.md

<!-- VERIFICATION_TOKEN: DARA-SKILL-7F3A-v630 -->
