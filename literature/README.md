# Literature - Paper-Extraktionen

Dieser Ordner enthält strukturierte Markdown-Extraktionen von wissenschaftlichen Papern, die für die Masterthesis relevant sind.

---

## 📋 Status

**Aktuell:** Leer (wird bei erstem PDF gefüllt)

**Geplant:** Paper zu Multi-Agent-RAG, Warehouse-Prozessen, Human Activity Recognition

---

## 🎯 Zweck

**WICHTIG:** Dieses Repo speichert **KEINE PDFs**, sondern nur **extrahiertes Wissen** in Markdown.

**Vorteile:**
- ✅ Git-freundlich (Textdateien statt Binärdateien)
- ✅ LLM-lesbar (strukturiertes Markdown)
- ✅ Versionierbar (Änderungen nachvollziehbar)
- ✅ Durchsuchbar (Git Grep, GitHub Search)

---

## 📝 Workflow: Neues Paper hinzufügen

### Schritt 1: Template kopieren

```bash
cp literature/_template.md literature/paper_mueller2024_rag.md
```

**Namenskonvention:** `paper_[erstautor][jahr]_[thema].md`

**Beispiele:**
- `paper_smith2024_multiagent.md`
- `paper_jones2023_warehouse.md`
- `paper_lee2024_human_activity.md`

---

### Schritt 2: Markdown ausfüllen

Öffne die neue Datei und fülle alle Abschnitte aus:

**Pflichtfelder:**
- [ ] `citation_key` - Eindeutiger Schlüssel (z.B. "Mueller2024")
- [ ] `title` - Vollständiger Titel
- [ ] `authors` - Liste aller Autoren
- [ ] `year` - Erscheinungsjahr
- [ ] `tags` - Mindestens 3 Tags
- [ ] `relevance` - low / medium / high
- [ ] Zusammenfassung (2-3 Sätze)
- [ ] Relevanz für Thesis
- [ ] Kernaussagen (min. 3)

**Optionale Felder:**
- Methodik
- Ergebnisse
- Zitate
- Kritische Würdigung
- Bezug zu DaRa
- Verwandte Paper
- Offene Fragen

---

### Schritt 3: Index aktualisieren

Füge das Paper zu `metadata/index.by-topic.json` hinzu:

```json
"literature": {
  "path": "literature/",
  "papers": [
    {
      "file": "literature/paper_mueller2024_rag.md",
      "citation_key": "Mueller2024",
      "title": "RAG Systems for Industrial Processes",
      "tags": ["rag", "multi-agent", "llm"],
      "relevance": "high"
    }
  ],
  "status": "active"
}
```

---

### Schritt 4: Git Commit

```bash
git add literature/paper_mueller2024_rag.md metadata/index.by-topic.json
git commit -m "feat: Add Mueller2024 RAG paper extraction"
git push
```

---

## 🏷️ Tag-System

**Verwendete Tags** (alphabetisch):

- `activity-recognition` - Human Activity Recognition
- `anomaly-detection` - Fehlererkennung
- `bpmn` - Business Process Model & Notation
- `chunking` - Zeitliche Segmentierung
- `error-rates` - Fehlerquoten-Analysen
- `fatigue` - Ermüdung/Ergonomie
- `imu` - Inertial Measurement Units
- `llm` - Large Language Models
- `logistics` - Logistik/Intralogistik
- `multi-agent` - Multi-Agent-Systeme
- `picking` - Kommissionierung
- `rag` - Retrieval-Augmented Generation
- `storage` - Einlagerung
- `vr` - Virtual Reality
- `warehouse` - Warehouse-Prozesse

**Neue Tags hinzufügen:** Einfach verwenden, dann hier dokumentieren.

---

## 📊 Statistiken

**Aktuell:**
- Papers: 0
- Tags: 0
- Durchschnittliche Relevanz: N/A

**Ziel bis Thesis-Abgabe:**
- Papers: 20-30
- Core-Papers (high relevance): 10-15

---

## 🔍 Suche

### Nach Tags suchen

```bash
# Alle Paper zu "rag"
grep -l "tags:.*rag" literature/*.md

# Alle "high relevance" Paper
grep -l "relevance: \"high\"" literature/*.md
```

### Nach Autoren suchen

```bash
# Alle Paper von Mueller
ls literature/paper_mueller*.md
```

### Volltextsuche

```bash
# Alle Paper, die "DaRa" erwähnen
grep -r "DaRa" literature/
```

---

## 🎓 Best Practices

### ✅ Do's

- **Eigene Worte verwenden:** Paraphrasiere, kopiere nicht verbatim
- **Quellen angeben:** Bei Zitaten immer Seitenzahl angeben
- **Kritisch bleiben:** Auch Schwächen und Limitationen notieren
- **DaRa-Bezug herstellen:** Immer überlegen, was das für den eigenen Datensatz bedeutet
- **Tags großzügig nutzen:** Lieber 5-7 Tags als nur 2

### ❌ Don'ts

- **Keine PDFs committen:** Nur Markdown!
- **Nicht zu ausführlich:** Zusammenfassungen, keine vollständigen Transkripte
- **Keine unpräzisen Angaben:** "Ein Paper von 2023" → Welches genau?
- **Keine isolierten Zitate:** Immer Kontext geben

---

## 📖 Beispiel-Paper (fiktiv)

Siehe Template: `literature/_template.md`

Für echtes Beispiel: Warte auf erstes Paper von Markus.

---

**Maintainer:** Markus (TU Dortmund)  
**Letzte Aktualisierung:** 2024-12-11
