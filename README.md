# DaRa Dataset Expert (v6.3.0 | 2026-03-22)

Faktenbasierte Wissensbasis fuer die Analyse intralogistischer Warehouse-Prozesse im DaRa-Datensatz.
Der Skill buendelt Szenarioerkennung, REFA/MTM-Methodik, Process-Validierung (Phase 4) und standardisierte Report-Erstellung in einer 5-Phasen-Struktur.

## Kurzprofil

- Datensatzfokus: 18 Probanden, 8 Szenarien (S1-S8), 12 Kategorien (CC01-CC12), 207 Labels (CL001-CL207)
- Analysepipeline: Szenarioerkennung -> REFA/MTM -> Process-Validierung -> Bericht
- Ausrichtung: Dokumentations- und Analyse-Referenz (deskriptiv, nicht praediktiv)
- Qualitaetsprinzip: Epistemische Integritaet (nur dokumentierte Fakten, keine Annahmen)

## Repository-Struktur (aktuell)

### Kern

- SKILL.md
- docs/CHANGELOG.md
- references/processes/phase1_scenario_recognition.md
- references/processes/phase2_refa_analysis.md
- references/processes/phase3_mtm_analysis.md
- references/processes/phase4_bpmn_validation.md
- references/processes/phase5_report.md

### Referenzen

- references/core/reference_labels.md
- references/core/reference_activation_rules.md
- references/core/reference_validation_rules.md
- references/auxiliary/reference_chunking.md
- references/processes/reference_bpmn_flows.md
- references/core/reference_dataset.md
- references/core/reference_warehouse.md
- references/core/reference_articles.md

### Templates

- assets/templates/scenario_report.md
- assets/templates/bpmn_report.md

## Dateinamen und Versionsstaende

Stand: 2026-03-22 (aus den jeweiligen Dateien gelesen)

| Datei | Version |
|:------|:--------|
| SKILL.md | 6.3.0 |
| docs/CHANGELOG.md | v6.3.0 als aktueller Release-Eintrag |
| references/processes/phase1_scenario_recognition.md | 6.1.2 |
| references/processes/phase2_refa_analysis.md | 6.2.0 |
| references/processes/phase3_mtm_analysis.md | 6.2.3 |
| references/processes/phase4_bpmn_validation.md | 6.1.3 |
| references/processes/phase5_report.md | 6.2.0 |
| references/core/reference_labels.md | 6.1.3 |
| references/core/reference_activation_rules.md | keine explizite Versionszeile |
| references/core/reference_validation_rules.md | 6.2.0 |
| references/auxiliary/reference_chunking.md | 6.1.0 |
| references/processes/reference_bpmn_flows.md | 6.0 |
| references/core/reference_dataset.md | 6.1.3 |
| references/core/reference_warehouse.md | 6.1.3 |
| references/core/reference_articles.md | 6.2.0 |
| assets/templates/scenario_report.md | keine explizite Versionszeile |
| assets/templates/bpmn_report.md | keine explizite Versionszeile |

## Empfohlene Nutzung

1. Immer mit SKILL.md starten (Scope und Dateinavigation).
2. Fuer Analysen zuerst die passende Phase-Datei lesen.
3. Danach gezielt mit den reference-Dateien vertiefen.
4. Ergebnis im passenden Template strukturieren.

## Geeignete Use Cases

- Fachliche Fragen zu Szenarien, Labels, Kategorien, Regeln und Prozesslogik
- REFA/MTM-basierte methodische Einordnung
- Process-Konformitaets- und Sequenzvalidierung
- Standardisierte Berichtsausgabe

## Nicht geeignet

- Rohdatenverarbeitung grosser CSV-Batches (separate Tooling-Pipeline empfohlen)
- Modelltraining oder Vorhersage
- Bild- oder Videoanalyse

## Hinweis

Diese Wissensbasis ist fuer nachvollziehbare, quellennahe Analysen ausgelegt.
Wenn eine Information nicht in den Dateien dokumentiert ist, ist sie als nicht enthalten zu behandeln.