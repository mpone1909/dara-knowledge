# CHANGELOG — DaRa Dataset Expert Skill

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
