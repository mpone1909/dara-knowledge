# n8n Workflow — VEREINFACHTE ÜBERSICHT

**Basierend auf:** SKILL.md Navigationslogik (21 Kategorien)
**Status:** Quick Start Implementierung

---

## 📊 WORKFLOW-STRUKTUR (SIMPLIFIED)

```
┌─────────────────────────────────────────┐
│ WEBHOOK INPUT                           │
│ POST /dara-query                        │
│ {query: string}                         │
└──────────────┬──────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│ SKILL.md Query Classifier (Claude)      │
│ Output: category + routing_file         │
└──────────────┬──────────────────────────┘
               │
        ┌──────┴──────┐
        │             │
        ▼             ▼
   ┌────────┐    ┌────────┐
   │ File   │    │ AI     │
   │ Reader │    │ Agent  │
   │        │    │ (nach  │
   │        │    │ Datei) │
   └────┬───┘    └───┬────┘
        │            │
        └────┬───────┘
             ▼
      ┌─────────────┐
      │ QA & Format │
      │ (Agent 6)   │
      └──────┬──────┘
             ▼
      ┌─────────────┐
      │ HTTP Output │
      └─────────────┘
```

---

## 🎯 DIE 21 QUERY-KATEGORIEN (aus SKILL.md Zeile 141-227)

### **KATEGORIE-MAPPING für Switch Node:**

```
Query Keywords                          → Route-File
─────────────────────────────────────────────────────────────────

1. "Proband", "S01-S18", "Session"      → dataset_core_v5_0.md
2. "Frame", "CSV", "Datenformat"        → data_structure_v5_0.md
3. "Lager", "Aisle", "Zone", "Location" → warehouse_physical_v5_0.md
4. "Chunk", "Trigger", "T1-T13"         → chunking_v5_0.md
5. "Semantik", "Abhängigkeit"           → semantics_v5_0.md
6. "Label", "CL", "CC"                  → labels_207_v5_0.md
7. "Artikel", "Order 2904/2905/2906"    → articles_inventory_v5_0.md
8. "Szenario", "S1-S8", "Ground Truth"  → ground_truth_central_v5_0.md
9. "Category Activation", "Matrix"      → category_activation_matrix_v5_0.md
10. "Master-Slave", "Frame-Validierung" → validation_rules_v5_0.md
11. "REFA", "Zeitart", "t_MH"           → refa_analytics_v5_0.md
12. "MTM", "TMU", "Grasp"               → mtm_codes_v5_0.md
13. "Prozess-Hierarchie", "CC08/09/10"  → process_hierarchy_v5_0.md
14. "BPMN", "Validierung", "IST SOLL"   → bpmn_validation_v5_0.md
15. "BPMN Quick Start", "Tutorial"      → bpmn_validation_quickstart_v5_0.md
16. "Query Pattern", "Beispiel-Fragen"  → query_patterns_v5_0.md
17. "Report Template", "Bericht"        → bpmn_validation_report_template_v5_0.md
                                        OR scenario_report_template_v5_0.md
18. "CHANGELOG", "Was ist neu"          → CHANGELOG_v5_0.md
19. "Migration", "Upgrade"              → MIGRATION_v5_0.md
20. "Struktur", "Dependencies"          → STRUCTURE_v5_0.md
21. "README", "Quick Start"             → README_v5_0.md

DEFAULT (Fallback)                      → dataset_core_v5_0.md
```

---

## 🔌 MINIMAL VIABLE WORKFLOW (für Schritt 1)

### **NODES:**

1. **Webhook** (Trigger)
   ```
   URL: /n8n-webhook/dara-query
   Method: POST
   ```

2. **AI Agent 1 — Classifier**
   ```
   Model: Claude Sonnet
   Temp: 0.2
   Token: 500
   Prompt: "Klassifiziere Query nach 21 SKILL.md Kategorien"
   Output: {category, routing_file, confidence}
   ```

3. **Switch Node**
   ```
   Logic: category === "..."
   Routes: 21 branches (+ default)
   ```

4. **File Reader** (in jeder Branch)
   ```
   Load: {{classification.routing_file}}
   Format: Markdown → Text
   ```

5. **AI Agent 2-5** (Optional, nur für komplexe Kategorien)
   ```
   LABEL_LOOKUP → Agent für Label-Extraktion
   SCENARIO → Agent für Ground Truth Logic
   BPMN → Agent für Prozessvalidierung
   REPORT → Agent für Report-Generation
   ```

6. **AI Agent 6 — QA**
   ```
   Model: Claude Sonnet
   Temp: 0.1
   Prompt: "Überprüfe Antwort nach SKILL.md Prinzipien"
   Output: {quality_score, formatted_response, warnings}
   ```

7. **Response Node**
   ```
   Format: JSON + Markdown
   Output: HTTP 200 OK
   ```

---

## 💡 IMPLEMENTIERUNGS-STRATEGY

### **PHASE 1 — Absolute Minimum (3 Tage)**
```json
Webhook → Classifier → Switch → File Reader → QA → Output
```
- Keine speziellen AI Agents pro Kategorie
- Nur File laden + QA Check
- ~7 Nodes total
- Coverage: ~60% Queries

### **PHASE 2 — Erweitert (7 Tage)**
```json
+ AI Agent 2 (Label Specialist)
+ AI Agent 3 (Scenario Detector)
+ AI Agent 4 (BPMN Validator)
+ Error Handling für 5 Edge Cases
```
- Jetzt auch komplexe Analysen
- Coverage: ~85% Queries
- ~20 Nodes total

### **PHASE 3 — Full Stack (14 Tage)**
```json
+ AI Agent 5 (Report Generator)
+ Logging & Monitoring
+ Batch Processing
+ All 8 Edge Cases
```
- Production-ready
- Coverage: ~95% Queries
- ~25 Nodes total

---

## 🧠 PROMPT TEMPLATES FÜR DIE 6 AGENTS

### **Agent 1: Classifier** (Verwendet SKILL.md)
```markdown
Du bist ein Query-Klassifikator.

Kategorisiere diese Query anhand der SKILL.md Navigationslogik
(Zeile 141-227) in GENAU EINE der 21 Kategorien:

KATEGORIEN:
1. STRUCTURAL (Proband, Session, S01-S18)
2. DATA_STRUCTURE (Frame, CSV, Synchronisation)
3. WAREHOUSE (Lager, Aisle, Zone, Location)
4. CHUNKING (Chunk, Trigger, T1-T13)
5. SEMANTICS (Semantik, Abhängigkeit)
6. LABEL_LOOKUP (Label, CL, CC)
7. ARTICLES (Artikel, Order 2904/2905/2906)
8. SCENARIO_DETECTION (Szenario, S1-S8, Ground Truth)
9. CATEGORY_MATRIX (Category Activation, Matrix)
10. VALIDATION (Master-Slave, Frame-Validierung)
11. REFA (REFA, Zeitart, t_MH)
12. MTM (MTM, TMU, Grasp)
13. PROCESS_HIERARCHY (Prozess-Hierarchie, CC08/09/10)
14. BPMN (BPMN, Validierung, IST SOLL)
15. BPMN_QUICKSTART (BPMN Tutorial)
16. QUERY_PATTERNS (Query Pattern, Beispiele)
17. REPORT_TEMPLATE (Report Template)
18. CHANGELOG (CHANGELOG, Was ist neu)
19. MIGRATION (Migration, Upgrade)
20. STRUCTURE (Struktur, Dependencies)
21. README (README, Quick Start)

Query: "{{$json.query}}"

Antworte NUR mit JSON:
{
  "category": "LABEL_LOOKUP",
  "routing_file": "references/core/labels_207_v5_0.md",
  "confidence": 0.95
}
```

### **Agent 2: Label Specialist** (Präzise Facts)
```markdown
Du bist ein Label-Lookup Spezialist für DaRa Dataset.

Gegeben:
- Query: "{{$json.query}}"
- Label-Datei: {{$node["File Reader"].data.content}}

AUFGABE:
- Finde das Label oder die Kategorie in der Datei
- Extrahiere: ID, Name, Kategorie, Beschreibung, Hierarchie
- Format als strukturiertes JSON
- NUR dokumentierte Fakten verwenden!

Output JSON:
{
  "type": "label|category",
  "result": {...},
  "source": "references/core/labels_207_v5_0.md",
  "confidence": 0.95
}
```

### **Agent 3: Scenario Detector** (Ground Truth Logic)
```markdown
Du bist Szenario-Klassifizierer mit Ground Truth v3.0.

Gegeben:
- Query: "{{$json.query}}"
- Ground Truth: {{$node["File Reader 1"].data.content}}
- Chunking: {{$node["File Reader 2"].data.content}}

AUFGABE:
- Erkenne Szenario (S1-S8) oder "Other"
- Folge 5-Schritt Decision Logic (Ground Truth)
- Identifiziere Trigger-Sequenz (T1-T13)

Output JSON:
{
  "scenario": "S1|S2|...|Other",
  "trigger_sequence": ["T1", "T3", ...],
  "confidence": 0.95,
  "decision_path": ["Step 1: ...", "Step 2: ..."]
}
```

### **Agent 4: BPMN Validator** (Prozesslogik)
```markdown
Du bist BPMN-Prozess-Validator für DaRa.

Gegeben:
- Query: "{{$json.query}}"
- BPMN Logik: {{$node["File Reader 1"].data.content}}
- Process Hierarchy: {{$node["File Reader 2"].data.content}}

AUFGABE:
- Erkläre Prozessfluss (Retrieval oder Storage)
- Gib BPMN-Sequenz (CL114 → CL115 → ...)
- Identifiziere Entscheidungspunkte
- Prüfe Validierungsregeln

Output JSON:
{
  "process_type": "retrieval|storage|mixed",
  "bpmn_sequence": ["CL114", "CL115", ...],
  "violations": [...],
  "confidence": 0.92
}
```

### **Agent 5: Report Generator** (Ausgabe-Formatierung)
```markdown
Du bist Report-Generator für DaRa Dataset.

Gegeben:
- Query: "{{$json.query}}"
- Template: {{$node["Template Reader"].data.content}}
- Results von Agents 2-4: {{$context.results}}

AUFGABE:
- Wähle korrektes Template (BPMN oder Scenario)
- Fülle mit Daten
- Formatiere Markdown + JSON
- Addiere Metadata + Quellen

Output:
{
  "markdown": "# Report\n...",
  "json": {...},
  "metadata": {...}
}
```

### **Agent 6: QA Specialist** (SKILL.md Prinzipien)
```markdown
Du bist QA-Expert für DaRa Dataset.

Befolge SKILL.md Antwort-Prinzipien (Zeile 240-284):

1. UNTERSCHEIDUNG Datensatz vs. Methode
   ✅ "CC09 wird im REFA-Kontext auf t_MH gemappt"
   ❌ "CC09 ist die Haupttätigkeit"

2. TERMINOLOGIE-STANDARD
   ✅ "CL115", "CC09", "S1-S8", "T1-T13" (mit Präfix)
   ❌ "CL-115", "c09", "scenario 1", "trigger 1"

3. QUELLENANGABEN
   ✅ "Gemäß V-B1 in references/core/validation_rules_v5_0.md"
   ✅ "Kapitel 4.6 in references/auxiliary/chunking_v5_0.md"

4. KEINE HALLUZINATIONEN
   ✅ "Diese Information ist nicht dokumentiert"
   ❌ "Ich glaube, dass..." / "Vermutlich..."

Gegeben:
- Original Query: "{{$json.query}}"
- File Content: {{$node["File Reader"].data.content}}
- Vorherige Result: {{$node["Content Processor"].json}}

AUFGABE: QA Check + Format

Output JSON:
{
  "quality_score": 0.95,
  "consistency_passed": true,
  "sources_cited": ["V-B1", "Kapitel 4.6"],
  "formatted_response": "# Antwort\n...",
  "warnings": []
}
```

---

## 🚀 QUICK START: SCHRITT 1 (3 Tage)

### **Was wird implementiert:**
1. ✅ Webhook Input
2. ✅ AI Classifier (Agent 1)
3. ✅ Switch Node (21 Routes)
4. ✅ File Reader
5. ✅ QA Check (Agent 6)
6. ✅ HTTP Output

### **Was wird NICHT implementiert (später):**
- Agents 2-5 (für komplexe Analysen)
- Error Handling (Edge Cases)
- Logging & Monitoring
- Batch Processing

### **Erwartete Coverage:**
- Simple Label Lookups: 90%
- Structural Questions: 85%
- BPMN Questions: 0% (kein Analyst)
- Reports: 0% (kein Generator)
- **Overall: ~60%**

---

## 🎓 EXAMPLE QUERIES & WORKFLOWS

### **Query 1: Label Lookup**
```
Query: "Was ist CL115?"
↓
Classifier: LABEL_LOOKUP → labels_207_v5_0.md
↓
File Reader: Load labels File
↓
QA: Extract CL115 Definition
↓
Output: JSON + Markdown
```

### **Query 2: Szenario Frage**
```
Query: "Wie unterscheiden sich S1 und S7?"
↓
Classifier: SCENARIO_DETECTION → ground_truth_central_v5_0.md
↓
File Reader: Load Ground Truth
↓
QA: Compare S1 vs S7
↓
Output: Structured Comparison
```

### **Query 3: BPMN Frage**
```
Query: "Was ist die BPMN-Sequenz für Retrieval?"
↓
Classifier: BPMN → bpmn_validation_v5_0.md
↓
File Reader: Load BPMN Logik
↓
QA: Extract Sequence + Format
↓
Output: BPMN Diagram + Text
```

---

## ⚙️ KONFIGURATION

### **Webhook:**
```
URL: /n8n-webhook/dara-query
Method: POST
Body: {query: string}
Auth: (optional) API Key
Response: Last Node Output
```

### **Classifier Prompt Settings:**
```
Model: claude-3-5-sonnet-20241022
Temperature: 0.2 (Deterministic)
Max Tokens: 500
Response Mode: JSON
```

### **File Reader:**
```
Method: HTTP GET
URL: file://references/core/labels_207_v5_0.md
Headers: {Accept: text/plain, Encoding: UTF-8}
Response: Text
```

### **QA Settings:**
```
Model: claude-3-5-sonnet-20241022
Temperature: 0.1 (Very Low)
Max Tokens: 2000
Response Mode: JSON
```

---

## 📋 CHECKLIST FÜR SCHRITT 1

- [ ] Webhook Node erstellen
- [ ] Classifier Prompt schreiben & testen
- [ ] 21 Switch Cases konfigurieren
- [ ] File Reader Nodes für alle 21 Routes
- [ ] QA Prompt schreiben
- [ ] Output Formatter
- [ ] 5 Test Queries durchlaufen
- [ ] Error Handling (basic)
- [ ] Dokumentation aktualisieren

---

**Geschätzter Aufwand:** 3-5 Tage
**Nodes (PHASE 1):** ~12
**AI Agents (PHASE 1):** 2 (Classifier + QA)
**Success Criteria:** >85% Label Lookups correct, <5s response time
