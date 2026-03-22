# CHANGELOG — DaRa Dataset Expert Skill

## v6.3.0 (2026-03-20) — Agent Read-Enforcement + Phase 4 Rename

### SKILL.md v6.3.0

- **MRP (Mandatory Read Protocol):** Explizite Read-Anweisungen pro Phase mit exakten Dateilisten
- **VRA (Verification-Required Anchors):** 5 fehleranfällige Fakten mit Pflicht-Quellenprüfung
- **Response Protocol:** Verbotene Antwortmuster, Quellenangabe-Pflicht, Unsicherheits-Stopp
- **Phase 4 Rename:** "BPMN" → "Process" in allen Phasennamen und Querverweisen
- **Version:** 6.2.0 → 6.3.0

### PAC (Pre-Answer Checklists)

Alle 5 Phasen-Dateien + reference_bpmn_flows.md erhalten HTML-Kommentar-Checklisten
am Dateianfang, die den Agent vor der Beantwortung zur vollständigen Lektüre zwingen.

### Verification Tokens

16 Dateien erhalten eindeutige `<!-- VERIFICATION_TOKEN: DARA-{ID}-v630 -->` am Dateiende.
Agents müssen den Token zitieren, um nachzuweisen, dass die Datei vollständig gelesen wurde.

### BPMN → Process Umbenennung

| Datei | Änderungen |
|:------|:-----------|
| SKILL.md | Pipeline-Beschreibung, Phase-4-Heading, Navigationslogik, Scope |
| phase4_bpmn_validation.md | H1-Titel "Process-Validierung" |
| phase5_report.md | §2.5, §5 Headings, Report-Logik |
| bpmn_report.md | Titel, Subtitle, Header, Metrik-Name |
| reference_dataset.md | Querverweis |
| reference_chunking.md | Querverweis |

**Regel:** "BPMN" nur geändert, wo es Phase 4 benennt. Beibehalten, wo es den
BPMN-Notationsstandard referenziert (Diagramme, Flows, Methodenbeschreibungen).

---

## v6.2.0-patch1 (2026-03-10) — phase5 auf phase4 §12 ausgerichtet

**Datei:** `phase5_report.md` 356 → 498 Zeilen (version: 6.2.0)

| Abschnitt | Vorher (v6.1.3) | Nachher (v6.2.0) |
|:----------|:----------------|:-----------------|
| §2.5.1 | Einzeilige Konformitäts-Übersicht | §12.1 Vollformat: Einzel + Gesamt-Tabelle |
| §2.5.2 | Nur IST/SOLL-Pfadvergleich | §12.2 Violations-Tabelle: alle 11 Typen |
| §2.5.3 | CL135-Kurzanalyse | §12.3 Loop-Analyse: Pick/Store/Error/Packing |
| §2.5.4 | Nicht vorhanden | §12.4 CC09-Prozess-Instanz-Timeline (neu) |
| §2.5.5 | Artikel-Kontext-Kurzform | §12.5 Vollständiger Szenario-Kontext + CL135-Tabelle |
| §3.3 Bewertungsskala | 3 Zeilen | 12-Typen-Severity-Tabelle mit Violation-Mapping |
| §4 Verwandte Dateien | phase4 §12 pauschal | phase4 §12.1–12.5/§10.2/§13–15 einzeln |
| §7.1 Versionstabelle | v6.1.1/v6.1.2 veraltet | Alle Versionen aktuell |

---

## v6.2.0 (2026-03-10) — REFA-Korrektur + Validation-Rules-Vollaudit

### phase2_refa_analysis.md v6.2.0

- 🔴 **[L1] Gewichtsklassen** §4.2 korrigiert auf Datensatz-Klassen aus reference_articles.md §1:
  Small ≤50g / Medium 50–800g / Large >800g (war: <1kg / 1–5kg / >5–10kg)
- 🟠 **[L2] CC02-Erholungszuschlag-Tabelle** §4.1 vollständig ergänzt:
  CL020 Squat +20–35%, CL021 Lunges +10–15%, alle anderen 0%
- 🟠 **[L3] Z_Umgebung definiert** §4.3: = 0% mit Begründung (kein Umgebungsparameter annotiert)
- 🔴 **[L4] t_E Algorithmus** §6 vollständig implementiert:
  `_calc_recovery()`-Hilfsfunktion ergänzt; Return-Dict um Erholungszeit_tE,
  Stoerzeit_tS, Wartezeit_tW, PersZeit_tP erweitert;
  Auftragszeit_T jetzt korrekt als T_R + T_A + T_E (nicht T_R + T_MH + T_MN)
- 🟡 **[L5] CL134-Fallthrough** §3 + §5: Default-Fall (t_w) für unklare Frames ergänzt;
  Verteilzeit-Subtypen t_s / t_w / t_p vollständig dokumentiert
- **Frontmatter**: reference_dataset.md + reference_validation_rules.md ergänzt

### reference_validation_rules.md v6.2.0

- 🔴 **[VR-1] V-B4 CC03**: Pflichtmenge korrigiert — CL028 (Another) + CL029 (Unknown)
  fehlten in erlaubter Einzellabel-Menge; Tabelle zeigt jetzt alle 6 Labels
- 🟠 **[VR-2] V-B5 CC04/CC05**: Position-Unknown-Labels CL033 (Left) / CL068 (Right)
  fehlten in der Dimensionstabelle
- 🟡 **[VR-3] V-B7 CC11 Level-2**: Aufgeschlüsselt in Path-Subtypen (CL164–CL167),
  Cross-Aisle-Segmente (CL168–CL171), Aisle-Nummern 1–5 (CL172–CL176)
- 🟠 **[VR-4] V-EC2 Tool-Spalte**: Leerzeichen ("—") durch CL064/CL099 (Another Tool) ersetzt
- 🔴 **[VR-5] V-EC4 Storage-Phasen**: CL117 (Unpacking), CL119 (Store Travel),
  CL120 (Store Time) fehlten komplett in Location-Erwartungstabelle
- 🟡 **[VR-6] §7 (neu)**: Veraltete v5.0-Dateiverweise dokumentiert mit Ersatzpfaden
- 🟡 **[VR-7] §6 Beziehungen**: phase2_refa_analysis.md ergänzt (nutzt V-B1, V-B4, V-P1, V-E1)
- 🟠 **[VR-B2] V-B2 CC08→CC09**: CL112 präzisiert — nur CL122/CL123 erlaubt, nicht "beliebig"
- 🟡 **[VR-E1] V-E1 CL135**: S4/S6 differenziert — "Nicht geplant" statt pauschal "Möglich"

### SKILL.md v6.2.0

- Version auf 6.2.0 aktualisiert
- Sektion "Kritische Wissens-Ankerpunkte" neu ergänzt (Gewichtsklassen, t_E, CL134, CL135)
- Pipeline-Flow erweitert: korrekte P1-Ausgabepfeile zu P2/P3/P4
- Phasen-Input/Output-Matrix neu ergänzt (welche Phase benötigt Output von welcher)
- Referenz-Heatmap neu ergänzt (immer benötigt vs. phasen-spezifisch mit Phasen-Marker)
- Navigationslogik: Phasen-Abhängigkeiten pro Eintrag ergänzt, Phasen-Marker [P1]–[P5] bei Referenzeinträgen
- Dateiübersicht mit Versionsspalte erweitert
- Änderungshistorie aktualisiert

### Frontmatter-Korrekturen (Phasen-Dateien)

- ✅ **phase1_scenario_recognition.md** v6.1.2: `reference_activation_rules.md` + `reference_validation_rules.md` ins Frontmatter; `output_used_by: [P2, P3, P4, P5]` ergänzt
- ✅ **phase3_mtm_analysis.md** v6.2.3: `phase2_refa_analysis.md` ins Frontmatter (REFA liefert t_E-Kontext für MTM-Kalibrierung); `output_used_by: [P5]` ergänzt
- ✅ **phase4_bpmn_validation.md** v6.1.3: `phase1_scenario_recognition.md`, `phase2_refa_analysis.md`, `reference_warehouse.md`, `reference_articles.md` ins Frontmatter; `output_used_by: [P5]` ergänzt

---


## v6.2.2 (2026-03-05) — MTM-Erweiterungen: SC/DF, TBC, KOK, AP, ET/EF, Probanden

### phase3_mtm_analysis.md v6.2.2

- ✅ **Gewichtsfaktor SC+DF für Move** (§2): Korrekturtabelle für Artikel >2kg; Palm Soil ~20,3 TMU statt 14,4 TMU; Hand Axe ~16,6 TMU
- ✅ **TBC1/TBC2 Körperdrehung** (§1.2, §2, §3.2): TBC1=18,6 TMU (Aisle 2–5), TBC2=37,2 TMU (Aisle 1, 0,91m eng); CC03=CL027 Torso Rotation
- ✅ **KOK/AKOK vs. B/AB** (§1.2, §2, §3.2): KOK=69,4+76,7=146,1 TMU vs. B=60,9 TMU; diagnostisch über CC02=CL020 (Squat) erkennbar
- ✅ **Apply Pressure AP** (§1.1, §2, §5): AP=10,6 TMU für CL150 Sealing, CL148 Attaching Label; APA=16,2 TMU mit Repositionierung
- ✅ **ET/EF Eye Travel/Focus** (§1.3, §2, §5): IT-System-Overhead 25–35 TMU/Pick je CC07-Label (CL105/CL106/CL107/CL108)
- ✅ **W-PO Walk Obstructed** (§1.2, §2): 17,0 TMU/Schritt, Grenzwert >23kg, kein DaRa-Einzelartikel betroffen
- ✅ **Probanden-Normabweichungen** (§6.2, §6.3): Erfahrung, Alter, Gewicht, Händigkeit (S04 Linkshänder)
- ✅ **Packing-Beispiel** (§7): Neue Sequenz CL150 Sealing mit AP
- ✅ **TBC in Label-Sequenz-Tabelle** ergänzt (§7)
- ✅ **REFA-Tabelle** um AP, ET/EF, TBC, KOK/AKOK erweitert (§8)
- ✅ **TMU-Gesamtschätzung §9** angepasst (+SC/DF, +TBC)

---

## v6.2.1 + v6.1.3 (2026-03-05) — Warehouse-Abmessungen + MTM-Kalibrierung

### reference_warehouse.md v6.1.3

- ✅ **§2.5 Hart bestätigte Planmaße** (19 bemaßte Ketten aus Grundriss, u.a. Aisle 1=0,91m, Aisle 2–5=1,19m, Komplex-Länge=4,09m, Komplex-Breite=0,85m)
- ✅ **§3.2 Geometrische Kennwerte** (bestätigte Aisle-Breiten, Komplex-Abmessungen)
- ✅ **§3.4 Cross Aisle Strecken** mit berechneten TMU-Werten (35/41/41/41 TMU je Segment)
- ✅ **§3.5 Regalkomplexe** mit Regaltypen und genutzten Racks pro Komplex
- ✅ **§5.1/5.2 Compartment-Inventar** (40 dokumentierte IDs, max. Ebene je Komplex)
- ✅ **§6 Fachabmessungen** (Tiefe W=39,5cm; Breiten 19/22/28,5/29/32/47,5/95,5cm; Höhen H=16/21/41cm; Sonderhöhe 104cm Hängeware)
- ✅ **§6.3 Ebenen-Mittenhöhen-Tabelle** für H=21/41/16cm (MTM-Referenz)
- ✅ **§7 Infrastruktur/Sensorik** (Beacon X/Y/Z-Range, Kamera-Höhen, Sync-Fehler)
- ✅ **§2.3/2.4/2.6** Path-Subzonen, Nachbarschaften, LLM-Raumorientierung (neu)
- ✅ Semantische Zonen-Definitionen (§2.2), Return-Aisle-Prozedur (§4.2), CL181 (§8) aus v6.1.2 erhalten

### phase3_mtm_analysis.md v6.2.1

- 🔴 **Walk-TMU korrigiert**: ~51 TMU/Segment (v6.2.0) → 35 TMU (Seg 1→2) / 41 TMU (Seg 2–5) auf Basis Planmaße; Gesamt 158 TMU statt 204 TMU
- 🔴 **R_B_80 für Ebene 1** (korrigiert von R_B_50): Fachtiefe 39,5cm → Back-Artikel ~34cm Tiefe → deutlich größere Reach-Distanz
- ✅ **Front vs. Back MTM-Differenz** (CL177/CL178): Front ~R_B_40–50, Back ~R_B_50–80
- ✅ **Bend-Universalregel bestätigt**: Ebenen 1–3 = B für alle 18 Probanden (Ebene 3 Mitte 52,5cm < Knie-Min 52,8cm bei S10)
- ✅ **Grasp-Matrix nach Fachbreite × Regaltyp** (G1C3=12,9TMU für R4 Schrauben; G1A=2,0TMU für R7/R8; etc.)
- ✅ **Sonderfall Komplex 8** (H=41cm, 3 Ebenen, andere Mittenhöhen)
- ✅ Ebenen-Tabelle §3.2 mit exakten Mittenhöhen aus §6.3 ersetzt
- ✅ Anwendungsbeispiel Walk-Werte auf neue TMU-Basis korrigiert
- ✅ TMU-Gesamtschätzung §9 entsprechend angepasst (~650/638/668 statt ~696/684/714)

---

## v6.1.4 (2026-02-27) — Automatische Skill-Prüfung

### Korrekturen (automatische Skill-Prüfung)

1. **SKILL.md Titel-Version** korrigiert: "Version 6.1" → "Version 6.1.3"
2. **SKILL.md Description** erweitert: 47 Prozesse, 13 Trigger, Trigger-Keywords für besseres Skill-Auslösen ergänzt
3. **SKILL.md Zeilenzahlen-Tabelle** aktualisiert — alle Werte an tatsächliche Zeilenzahlen angepasst:
   - phase2: ~350 → ~210
   - phase3: ~250 → ~160
   - phase5: ~300 → ~359
   - ref_labels: ~850 → ~886
   - ref_activation: ~470 → ~610
   - ref_validation: ~200 → ~263
   - ref_dataset: ~230 → ~313
   - ref_chunking: ~950 → ~821
   - scenario_report: ~200 → ~139
   - bpmn_report: ~200 → ~218
   - CHANGELOG: ~120 → ~100
4. **reference_labels.md** Version von 6.0 auf 6.1.3 aktualisiert
5. **phase5_report.md** CRLF-Zeilenenden → LF konvertiert

---

## v6.1.3 (2026-02-26) — CSV-Format-Korrektur + Lücken-Schließung

### Kritische Korrekturen

- 🔴 **CSV-Spaltenformat korrigiert** in `reference_dataset.md`: Frame/Timestamp-Spalten existieren NICHT — Header enthält `CL{NNN}|{Labelname}`, Daten ab Zeile 2 = Frame 1
- 🔴 **Dateinamen-Konvention korrigiert**: Kategorie-Namen verwenden Leerzeichen/Bindestriche (z.B. `Main Activity`, `Sub-Activity - Legs`), NICHT Unterstriche

### Neue Abschnitte

- ✅ **Frame↔Zeit Umrechnung** in `reference_dataset.md` §3.1 (29,97→30fps, Umrechnungstabelle + Formeln)
- ✅ **Datensatz-Gesamtumfang** in `reference_dataset.md` §3.7 (216 Dateien, ~32h, ~1,94M Frames, ~1,15GB)
- ✅ **Semantische Abhängigkeiten** in `reference_dataset.md` §3.8 (CC01↔CC02↔CC03, CC04/CC05↔CC10, CC06↔CC08)
- ✅ **Datenfluss-Schema** in `reference_dataset.md` §3.9 (Session→Subjekt→12 CSVs→Frames)
- ✅ **Verwandte Dateien** in `reference_dataset.md` §6, `phase1_scenario_recognition.md` §7

### Cross-References ergänzt

- ✅ `reference_labels.md`: + reference_dataset.md, + reference_warehouse.md
- ✅ `phase1_scenario_recognition.md`: Neue §7 Verwandte Dateien Tabelle
- ✅ **12 CC-Dateinamen-Tabelle** in `reference_dataset.md` (vollständig mit korrekten Bezeichnungen)

---

## v6.1.2 (2026-02-26) — Content Backport aus v5.0

### Rückgeführte Inhalte (Tiefenvergleich v6.1 vs. v5.0)

- ✅ **Artikel-IDs + Mengen-Spalte** in `reference_articles.md`: 10-stellige Artikelnummern und explizite Mengen-Spalte ergänzt
- ✅ **Verwendungshinweise + Beispiel-Artikel** in `reference_articles.md`: §7 mit Querverweisen und Beispiel-Artikel-Spalte in Gassentabelle
- ✅ **CSV-Spaltenformat** in `reference_dataset.md`: Neuer §3.2 mit Spalten-Layout, Datentypen und Beispiel
- ✅ **SARA-Annotationstool** in `reference_dataset.md`: Neuer §3.5 mit mehrstufigem Annotations-Workflow und Inter-Rater-Reliability
- ✅ **Edge-Case-Dokumentation** in `reference_validation_rules.md`: Neuer §5 mit CC01/CC02-Konflikten (V-EC1), CC04/CC05 Leere-Frames (V-EC2), CC11/CC12 Transitions (V-EC3), CC09-Location-Erwartungen (V-EC4)
- ✅ **Semantische Zonen-Definitionen** in `reference_warehouse.md`: Neuer §2.1 mit detaillierten Beschreibungen aller 6 Funktionszonen
- ✅ **Bluetooth-Beacon-Details** in `reference_warehouse.md`: §8 erweitert um BLE-Typ, Montage, Funktion
- ✅ **MANDATORY_TOOLS + EXPECTED_LOCATIONS** in `phase4_bpmn_validation.md`: Neue §11.1/11.2 mit vollständigen Python-Lookup-Tabellen für Tool- und Location-Validierung

### Version-Updates

- Alle betroffenen Dateien auf v6.1.2 aktualisiert
- SKILL.md und phase4_bpmn_validation.md Frontmatter aktualisiert

---

## v6.1.1 (2026-02-26) — Vergleichs-Review v5→v6

### Ergänzungen (aus v5.0 rückgeführt)

- ✅ **Scope-Definition** in SKILL.md: „Wann nutzen / Wann nicht" (8 Use-Cases + 5 Ausschlüsse)
- ✅ **Halluzinations-Schutzregeln** erweitert: Explizite Do/Don't-Liste in SKILL.md
- ✅ **CL135 Error-Handling-Details** in phase4_bpmn_validation.md: Picking vs. Storing Fehlertypen
- ✅ **YAML-Frontmatter** in allen Phase-Dateien (war nur in SKILL.md)
- ✅ **CHANGELOG.md** erstellt (diese Datei)

### Keine inhaltlichen Änderungen

- Kernlogik (5-Schritt, FSM, V-B3 Mapping) bleibt identisch zu v6.1.0

---

## v6.1.0 (2026-02-26) — Chunking & Aktivierungsregeln

### Ergänzungen

- ✅ **reference_chunking.md** bereinigt und ergänzt
- ✅ **reference_activation_rules.md** bereinigt und ergänzt

---

## v6.0 (2026-02-25) — Major Release

### Kritische Fehlerkorrekturen

1. **V-B3 CC09→CC10 Mapping** komplett korrigiert — 6/8 Phasen waren in v5.0 fehlerhaft.
   CL120 verwies auf CL154 (Unknown) statt CL138 (Placing Items on Rack).
2. **Deprecated v2.7 Scoring** entfernt — Evidence-Based Scoring komplett gelöscht.
3. **Encoding repariert** — Alle Dateien in sauberem UTF-8 (v5.0 hatte Mojibake).
4. **Falsche Label-Beschreibungen** im MTM-Beispiel korrigiert (5 falsche Labels).
5. **CL134 in REFA** korrigiert — War fälschlich als $t_A$, jetzt korrekt als $t_w$/$t_s$.

### Strukturelle Änderungen

- 23 → 15 Dateien konsolidiert (−35%)
- ~9.600 → ~5.500 Zeilen reduziert (−43%)
- Max. Dateigröße: ~950 Zeilen (vorher: 1.623)
- Phasen-basierte Struktur statt domänen-basiert

---

## v5.0 (2026-02-05) — Vollständige Neuerstellung

- 18 finale v5_0-Dateien (~324 KB, 9.655 Zeilen)
- Ground Truth v3.0 + Multi-Order (S7/S8) + Frame-Level Validation Rules
- BPMN-Validierung mit Detailed Process Flows (Figures A2–A7)
- 7-Phasen-Analyse-Prozess abgeschlossen

---

**Vorgänger:** v4.x, v3.0, v2.7, v2.6, v2.5
