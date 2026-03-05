# DaRa Dataset Expert (v6.1)

Faktenbasierte Wissensbasis für die Analyse intralogistischer Warehouse-Prozesse im DaRa-Datensatz.
Der Skill bündelt **Szenarioerkennung**, **REFA/MTM-Methodik**, **BPMN-Validierung** und **standardisierte Report-Erstellung** in einer klaren 5-Phasen-Struktur.

## Kurzprofil

- **Datensatzfokus:** 18 Probanden, 8 Szenarien (S1–S8), 12 Kategorien (CC01–CC12), 207 Labels (CL001–CL207)
- **Analysepipeline:** Szenarioerkennung → REFA/MTM → BPMN-Validierung → Bericht
- **Ausrichtung:** Dokumentations- und Analyse-Referenz (deskriptiv, nicht prädiktiv)
- **Qualitätsprinzip:** Epistemische Integrität (nur dokumentierte Fakten, keine Annahmen)

## Repository-Struktur

### Kern-Dateien

- `SKILL.md` — zentrale Skill-Definition, Scope, Navigationslogik
- `CHANGELOG.md` — Versionshistorie und Änderungen
- `phase1_scenario_recognition.md` — Szenarioerkennung (S1–S8, Decision-Logik)
- `phase2_refa_analysis.md` — REFA-Zeitarten, Kennzahlen, Mapping
- `phase3_mtm_analysis.md` — MTM-Codes, TMU, Bewegungsanalyse
- `phase4_bpmn_validation.md` — IST/SOLL-Validierung, Fehlerlogik, BPMN-Flows
- `phase5_report.md` — konsolidierte Berichtserstellung

### Referenz-Dateien

- `reference_labels.md` — Label-Katalog (CL001–CL207)
- `reference_activation_rules.md` — Aktivierungs- und Kardinalitätsregeln
- `reference_validation_rules.md` — Master-Slave- und Kombinationsregeln
- `reference_chunking.md` — Trigger/Chunking-Logik
- `reference_bpmn_flows.md` — detaillierte Prozessflüsse
- `reference_dataset.md` — Datensatzstruktur und CSV-Konventionen
- `reference_warehouse.md` — Lagerlayout und Zonen
- `reference_articles.md` — Artikel-/Order-Referenzen

### Templates

- `templates/scenario_report.md` — Vorlage für Szenario-Analysen
- `templates/bpmn_report.md` — Vorlage für BPMN-Validierungsberichte

## Empfohlene Nutzung

1. **Immer mit `SKILL.md` starten** (Scope + Dateinavigation)
2. Für Analysen zuerst die passende **Phase-Datei** lesen
3. Danach gezielt mit den **reference_*.md**-Dateien vertiefen
4. Ergebnis im passenden **Template** strukturieren

## Für welchen Use Case geeignet?

### Geeignet

- Fachliche Fragen zu Szenarien, Labels, Kategorien, Regeln und Prozesslogik
- REFA-/MTM-basierte methodische Einordnung
- BPMN-Konformitäts- und Sequenzvalidierung
- Standardisierte Berichtsausgabe

### Nicht geeignet

- Rohdatenverarbeitung großer CSV-Batches (separate Tooling-Pipeline empfohlen)
- Modelltraining / Vorhersage
- Bild-/Videoanalyse

## Versionierung

- Aktueller Hauptstand: **v6.1.x**
- Historie und Detailänderungen: siehe `CHANGELOG.md`

## Hinweis

Diese Wissensbasis ist für **nachvollziehbare, quellennahe Analysen** ausgelegt. Wenn eine Information nicht in den Dateien dokumentiert ist, sollte sie als „nicht enthalten“ behandelt werden.