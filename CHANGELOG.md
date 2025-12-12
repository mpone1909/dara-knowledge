# Changelog

Alle wichtigen Änderungen an diesem Projekt werden in dieser Datei dokumentiert.

Das Format basiert auf [Keep a Changelog](https://keepachangelog.com/de/1.0.0/),
und dieses Projekt folgt [Semantic Versioning](https://semver.org/lang/de/).

---

## [4.1.1] - 2024-12-11

### Changed (Klarstellung)
- ✅ Ordner umbenannt: `dara-skill/` → `dara-skill-github-repo/`
- ✅ Alle Referenzen aktualisiert in:
  - AI_INSTRUCTIONS.md
  - llms.txt
  - README.md
  - metadata/index.by-topic.json
  - tools/extract_labels.sh
  - tools/check_integrity.sh

**Grund:** Klarstellung, dass dies die GitHub-Kopie ist. Original bleibt in `/mnt/skills/user/dara-dataset-expert/`

---

## [4.1.0] - 2024-12-11

### Added (Phase 2)
- ✅ DaRa-Skill vollständig migriert (10 Dateien, 152 KB)
  - `dara-skill/SKILL.md` - Orchestrierung und Workflow-Logik
  - `dara-skill/README.md` - Installation und Übersicht
  - `dara-skill/knowledge/` - 7 Core-Dateien:
    - `dataset_core.md` (12 KB) - Probanden, BPMN, Sessions
    - `class_hierarchy.md` (19 KB) - Alle 207 Labels
    - `chunking.md` (18 KB) - Trigger T1-T10
    - `scenarios.md` (15 KB) - Szenarien S1-S8
    - `processes.md` (17 KB) - Prozess-Details CC08-CC10
    - `semantics.md` (19 KB) - Semantische Struktur
    - `data_structure.md` (9.4 KB) - Frame-Synchronisation
  - `dara-skill/templates/query_patterns.md` (14 KB)
- ✅ `metadata/label_catalog.csv` - Automatisch generiert (207 Labels)

### Validated
- ✅ Label-Anzahl: 207 / 207 korrekt
- ✅ Label-Format: Alle CLxxx valide
- ✅ Keine Duplikate gefunden
- ✅ Skill-Struktur vollständig

### Statistics
- **Dateien:** 10 Markdown-Dateien
- **Größe:** 152 KB (111 KB knowledge + 18 KB templates + 23 KB docs)
- **Labels:** 207 (CL001-CL207)
- **Kategorien:** 12 (CC01-CC12)

---

## [4.0.0] - 2024-12-11

### Added
- ✅ Initial Repository Setup (Hybrid-Bauplan)
- ✅ DaRa-Skill vollständig integriert (9 Dateien, 152 KB)
- ✅ `AI_INSTRUCTIONS.md` - LLM-System-Prompt
- ✅ `llms.txt` - Anthropic-Standard für LLM-Einstieg
- ✅ `metadata/index.by-topic.json` - Thematische Navigation
- ✅ `metadata/label_catalog.csv` - Auto-generierter Label-Index
- ✅ `tools/extract_labels.sh` - CSV-Generierung aus Markdown
- ✅ `tools/check_integrity.sh` - Label-Validierung
- ✅ `.github/workflows/quality-check.yml` - CI/CD für Qualitätsprüfung
- ✅ `.github/workflows/weekly-backup.yml` - Automatisches Backup
- ✅ `literature/_template.md` - Vorlage für Paper-Extraktionen
- ✅ `.gitignore` - Git-Ausschlüsse (PDFs, System-Dateien)
- ✅ `.llmignore` - LLM-Filter (optional)
- ✅ `.markdownlint.json` - Markdown-Linting-Regeln

### Documentation
- ✅ `README.md` - Umfassende Projekt-Dokumentation
- ✅ `llms.txt` - LLM-spezifische Anleitung
- ✅ `AI_INSTRUCTIONS.md` - System-Prompt für LLMs

### Infrastructure
- ✅ Git Repository initialisiert
- ✅ GitHub Actions Workflows konfiguriert
- ✅ Automatisierungs-Scripts bereitgestellt

---

## [Unreleased]

### Geplant (Phase 3)
- [ ] GitHub Remote hinzufügen
- [ ] Erster Push zu GitHub
- [ ] Workflow-Verifikation

### Zukünftig (Phase 4+)
- [ ] Erstes Paper-Extraktion
- [ ] MCP-Integration dokumentieren
- [ ] ChatGPT GitHub Connector testen
- [ ] Google Drive Sync (optional)

---

## Versionierungs-Schema

- **Major (X.0.0):** Grundlegende Architektur-Änderungen
- **Minor (x.X.0):** Neue Features oder größere Erweiterungen
- **Patch (x.x.X):** Bugfixes oder kleine Verbesserungen

---

**Maintainer:** Markus (TU Dortmund)  
**Letzte Aktualisierung:** 2024-12-11
