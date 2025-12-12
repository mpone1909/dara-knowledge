# DaRa Knowledge Base

> Git-versionierte Wissensdatenbank für DaRa-Dataset + Thesis-Literature  
> **Status:** Phase 1 abgeschlossen ✅

![Quality Check](https://github.com/DEIN-USERNAME/dara-knowledge/workflows/Knowledge%20Quality%20Check/badge.svg)

---

## 🎯 Projektziel

**Single Source of Truth** für:
1. DaRa-Dataset-Expert-Skill (207 Labels, 18 Probanden, 8 Szenarien)
2. Thesis-Literature (Paper-Extraktionen, später)
3. Methodisches Wissen (Multi-Agent-RAG, REFA, später)

**Design-Prinzipien:**
- ✅ Versionskontrolle (Git)
- ✅ LLM-optimiert (llms.txt-Standard)
- ✅ Erweiterbar (Template-System)
- ✅ Automatische Qualitätsprüfung (CI/CD)

---

## 📂 Repository-Struktur

```
dara-knowledge/
├── dara-skill-github-repo/  # DaRa-Dataset (152 KB, 10 Dateien)
│   ├── knowledge/           # 7 Core-Dateien
│   ├── templates/           # Query-Patterns
│   ├── SKILL.md             # Orchestrierung
│   └── README.md            # Installation
│
├── literature/              # Paper-Extraktionen (leer)
│   ├── _template.md         # Vorlage für neue Paper
│   └── README.md            # Anleitung
│
├── metadata/                # Maschinenlesbare Indexe
│   ├── label_catalog.csv    # 207 Labels (auto-generiert)
│   └── index.by-topic.json  # Thematische Navigation
│
├── tools/                   # Automatisierungs-Scripts
│   ├── extract_labels.sh    # Generiert CSV aus Markdown
│   └── check_integrity.sh   # Validiert Label-Anzahl
│
├── .github/workflows/       # CI/CD
│   ├── quality-check.yml    # Labels + Markdown
│   └── weekly-backup.yml    # Sonntags-Backup
│
├── AI_INSTRUCTIONS.md       # LLM-System-Prompt
└── llms.txt                 # LLM-Einstiegspunkt
```

**Hinweis:** `dara-skill-github-repo/` ist eine Kopie. Original liegt in `/mnt/skills/user/dara-dataset-expert/`

---

## 🚀 Quick Start

### Für Menschen (lokale Nutzung)

```bash
# 1. Repository klonen
git clone https://github.com/DEIN-USERNAME/dara-knowledge.git
cd dara-knowledge

# 2. Label-Katalog generieren
bash tools/extract_labels.sh

# 3. Integrität prüfen
bash tools/check_integrity.sh
```

### Für LLMs (Claude, ChatGPT)

**Einstiegspunkte:**
1. **Erste Orientierung:** Lies `llms.txt`
2. **System-Instruktionen:** Lies `AI_INSTRUCTIONS.md`
3. **Thematische Navigation:** Nutze `metadata/index.by-topic.json`

**Beispiel-Query:**
```
User: "Was ist CL115?"
→ LLM liest metadata/label_catalog.csv
→ LLM liest dara-skill/knowledge/processes.md
→ Antwort: "CL115 ist Picking – Travel Time (CC09)"
```

---

## 📊 Datensatz-Übersicht

| Komponente | Anzahl | Range | Details |
|-----------|--------|-------|---------|
| **Labels** | 207 | CL001-CL207 | In 12 Kategorien |
| **Kategorien** | 12 | CC01-CC12 | Human Movement + Context |
| **Probanden** | 18 | S01-S18 | 14M, 4F, 1 Linkshänder |
| **Szenarien** | 8 | S1-S8 | Retrieval, Storage, Packaging |
| **Trigger** | 10 | T1-T10 | Chunking-Mechanismen |

---

## 🔧 Workflows

### Neues Paper hinzufügen

1. **PDF lesen und verstehen**
2. **Template kopieren:**
   ```bash
   cp literature/_template.md literature/paper_mueller2024_rag.md
   ```
3. **Markdown ausfüllen** (Zusammenfassung, Kernaussagen)
4. **Index aktualisieren:** `metadata/index.by-topic.json`
5. **Committen:**
   ```bash
   git add literature/paper_mueller2024_rag.md metadata/index.by-topic.json
   git commit -m "feat: Add Mueller2024 RAG paper"
   git push
   ```

### Label-Katalog neu generieren

```bash
bash tools/extract_labels.sh
git add metadata/label_catalog.csv
git commit -m "chore: Update label catalog"
```

---

## 🛡️ Qualitätssicherung

### Automatisch (GitHub Actions)

- ✅ **Markdown-Linting:** Syntax-Prüfung bei jedem Push
- ✅ **Label-Validierung:** Prüft, ob alle 207 Labels vorhanden sind
- ✅ **Wöchentliche Backups:** Sonntags 3 Uhr UTC

### Manuell

```bash
# Label-Check
bash tools/check_integrity.sh

# Markdown-Lint (lokal, benötigt Node.js)
npx markdownlint-cli2 "**/*.md"
```

---

## 📚 Für Claude Desktop (MCP)

Füge in deiner `claude_desktop_config.json` hinzu:

```json
{
  "mcpServers": {
    "dara-knowledge": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/PFAD/ZU/DEINEM/dara-knowledge"
      ]
    }
  }
}
```

**Windows-Pfad-Beispiel:**
```json
"C:\\Users\\marku\\Documents\\dara-knowledge"
```

---

## 🎓 Verwendung in Masterthesis

### Zitation

```bibtex
@misc{dara_knowledge_2024,
  author = {Markus},
  title = {DaRa Knowledge Base: Git-versionierte Wissensdatenbank für Warehouse-Prozess-Analyse},
  year = {2024},
  howpublished = {GitHub Repository},
  note = {Masterthesis, TU Dortmund, FLW}
}
```

### Erwähnung im Text

> "Für die strukturierte Verwaltung des DaRa-Datensatz-Wissens wurde eine 
> Git-versionierte Knowledge Base entwickelt (siehe Anhang A), die als 
> Single Source of Truth für alle 207 Labels und deren semantische Beziehungen 
> dient. Die Knowledge Base ist LLM-optimiert und ermöglicht die automatische 
> Qualitätsprüfung mittels CI/CD-Pipelines."

---

## 🤝 Mitwirkende

**Maintainer:** Markus (TU Dortmund)  
**Betreuer:** Friedrich Niemann  
**Projekt:** Masterthesis FLW  
**Erstellt:** 11.12.2024  
**Version:** 4.0 (Hybrid-Bauplan)

---

## 📋 Changelog

### Version 4.0 (11.12.2024)
- ✅ Initial Repository Setup
- ✅ DaRa-Skill integriert (9 Dateien, 152 KB)
- ✅ CI/CD-Pipelines (Quality Check + Backup)
- ✅ LLM-Instruktionen (AI_INSTRUCTIONS.md + llms.txt)
- ✅ Template-System für Literature
- ✅ Automatische Label-Validierung

---

## 📄 Lizenz

**Private Repository** - Nur für Thesis-Zwecke  
© 2024 Markus, TU Dortmund
