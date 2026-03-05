# n8n AI Agent Workflow Ablaufplan — DaRa Skill v5.0

**Version:** 1.0
**Datum:** 23.02.2026
**Status:** Planungsphase
**Ziel:** Automatisierte Datensatz-Analyse mit AI Agent Nodes

---

## 📋 EXECUTIVE SUMMARY

Dieser Plan beschreibt einen **5-stufigen n8n Workflow** mit **6 AI Agent Nodes** zur Automatisierung der DaRa-Datensatz-Analyse:

```
[Webhook Input]
    ↓
[AI Agent 1: Query Classification & Routing]
    ↓
[Parallel: AI Agent 2-5 nach Route]
    ├─→ [AI Agent 2: Label & Validation Lookup]
    ├─→ [AI Agent 3: Scenario Detection & Ground Truth]
    ├─→ [AI Agent 4: BPMN Process Validation]
    └─→ [AI Agent 5: Report Generation]
    ↓
[AI Agent 6: Response Formatting & Quality Check]
    ↓
[Output: JSON/Markdown Report]
```

---

## 🎯 WORKFLOW-PHASEN (KLEINSCHRITTIG)

### PHASE 1: INPUT & QUERY CLASSIFICATION (basierend auf SKILL.md)

**Trigger:** Webhook (HTTP POST) oder Form-Input
**Input-Format:**
```json
{
  "query": "Welche Labels gehören zu CC04?",
  "user_id": "user123",
  "request_type": "interactive|batch|validation",
  "context": {}
}
```

**Nodes:**
1. **Webhook Node** (Trigger)
   - URL: `/n8n-webhook/dara-query`
   - Method: POST
   - Output: $json (Query-String)

2. **AI Agent 1: Query Classifier** (Claude) — *Basierend auf SKILL.md Navigationslogik*
   - **Prompt-Template:**
     ```
     Du bist ein Query-Klassifikator für DaRa Dataset Queries.
     Nutze diese SKILL.md Navigationslogik:

     1. "Proband", "Subjekt", "S01-S18", "Session" → STRUCTURAL
     2. "Frame", "Synchronisation", "CSV", "Zeile", "Datenformat" → DATA_STRUCTURE
     3. "Lager", "Regal", "Gasse", "Aisle", "Zone", "Location" → WAREHOUSE
     4. "Chunk", "Trigger", "T1-T13", "Segment", "Multi-Order S7/S8" → CHUNKING
     5. "Semantik", "Abhängigkeit", "Bedeutung", "Zusammenhang" → SEMANTICS
     6. "Label", "CL", "CC", "Kategorie", "Klassifikation" → LABEL_LOOKUP
     7. "Artikel", "Order 2904/2905/2906", "Gewicht" → ARTICLES
     8. "Szenario", "S1-S8", "Erkennung", "Ground Truth", "5-Schritt" → SCENARIO_DETECTION
     9. "Category Activation", "Szenario-Matrix", "IT-System-Mapping" → CATEGORY_MATRIX
     10. "Master-Slave", "Label-Kombination", "Frame-Validierung", "Validierungsregel" → VALIDATION
     11. "REFA", "Zeitart", "t_MH", "Erholung", "Verteilzeit", "Auftragszeit" → REFA
     12. "MTM", "TMU", "Reach", "Grasp", "Move", "Grundbewegung" → MTM
     13. "Prozess-Hierarchie", "High/Mid/Low-Level", "CC08/CC09/CC10" → PROCESS_HIERARCHY
     14. "BPMN", "Validierung", "Abweichung", "IST SOLL", "Conformity" → BPMN
     15. "BPMN Quick Start", "BPMN Tutorial", "BPMN Anwendung" → BPMN_QUICKSTART
     16. "Query Pattern", "Wie frage ich", "Beispiel-Fragen" → QUERY_PATTERNS
     17. "Report Template", "Bericht-Vorlage", "Ausgabeformat" → REPORT_TEMPLATE
     18. "CHANGELOG", "Was ist neu", "Version 5.0" → CHANGELOG
     19. "Migration", "Upgrade", "v4" → MIGRATION
     20. "Struktur", "Dateiübersicht", "Dependencies" → STRUCTURE
     21. "README", "Quick Start", "Einstieg" → README

     Query: {{$node["Webhook"].json.query}}

     Antworte NUR mit JSON:
     {
       "category": "...",
       "confidence": 0.95,
       "routing_file": "references/.../..._v5_0.md",
       "skill_md_line": 142  // Referenz zur SKILL.md Navigationslogik
     }
     ```
   - Input: $json.query
   - Output: $json (Classification Result)

3. **Switch Node** (Route nach SKILL.md Navigationslogik)
   - Entscheidung basierend auf `classification.category`
   - 21 Routes (für 21 File-Kategorien laut SKILL.md)
   - Jede Route lädt die entsprechende Datei

---

### PHASE 2: PARALLEL DATA RETRIEVAL & PROCESSING

Nach Classification verzweigt sich der Workflow in 4 parallele Pfade:

#### **PFAD A: Label & Validation Lookup** (für LABEL_LOOKUP, CATEGORY_QUERY, VALIDATION)

**Nodes:**
1. **File Reader Node** (HTTP Request)
   - URL: `file://references/core/labels_207_v5_0.md`
   - Output: Complete File Content

2. **AI Agent 2: Label Lookup Specialist** (Claude)
   - **Prompt:**
     ```
     Du bist ein Label-Lookup Spezialist für DaRa Dataset.

     Gegeben:
     - Query: {{$node["Webhook"].json.query}}
     - Label-Datei: {{$node["File Reader"].data.content}}
     - Klassifikation: {{$node["AI Agent 1"].json.sub_type}}

     AUFGABEN je nach Query-Typ:

     1. LABEL_LOOKUP (CL-Codes):
        - Finde Label in der Datei
        - Extrahiere: ID, Name, Beschreibung, Kategorie, Trigger-Referenzen
        - Format als strukturiertes JSON

     2. CATEGORY_QUERY (CC-Kategorien):
        - Finde alle Labels gehörend zu CC-Kategorie
        - Gruppiere nach Hierarchie (High/Mid/Low-Level)
        - Zähle Anzahl Labels

     3. VALIDATION:
        - Lade auch: references/core/validation_rules_v5_0.md
        - Prüfe: Master-Slave-Abhängigkeiten, Label-Kombinationen
        - Gib Validierungsergebnis zurück

     Output JSON:
     {
       "type": "label|category|validation",
       "result": {...},
       "source_file": "references/core/labels_207_v5_0.md",
       "completeness": "100%",
       "quality_score": 0.95
     }
     ```
   - Input: $json (Query + Labels File)
   - Output: $json (Label Result)

3. **Validation Node** (If VALIDATION Query)
   - Lädt zusätzlich: `references/core/validation_rules_v5_0.md`
   - Merged Results von Label + Validation Rules

---

#### **PFAD B: Scenario Detection** (für SCENARIO_DETECTION, STRUCTURAL)

**Nodes:**
1. **Multi-File Reader**
   - `references/core/ground_truth_central_v5_0.md` (Ground Truth v3.0)
   - `references/auxiliary/chunking_v5_0.md` (Trigger T1-T13)
   - `references/core/category_activation_matrix_v5_0.md` (Szenario-Matrix)

2. **AI Agent 3: Scenario Detection Engine** (Claude)
   - **Prompt:**
     ```
     Du bist Szenario-Klassifizierer mit Ground Truth v3.0.

     Query: {{$node["Webhook"].json.query}}

     AUFGABE: Erkenne eines oder mehrere Szenarien (S1-S8) oder "Other"

     INPUT:
     - Ground Truth Definition: {{$node["File Reader 1"].data.content}}
     - Chunking Trigger: {{$node["File Reader 2"].data.content}}
     - Category Matrix: {{$node["File Reader 3"].data.content}}

     LOGIK (5-Schritt Decision):
     1. Prüfe Global Interrupts (T11-T13)?
     2. Prüfe Order-Struktur (Single vs. Multi-Order)?
     3. Prüfe Scenario-Aktivierung (S1-S8)?
     4. Prüfe Trigger-Sequenz?
     5. Klassifiziere final Scenario

     Output:
     {
       "scenario": "S1|S2|...|S8|Other",
       "confidence": 0.95,
       "trigger_sequence": ["T1", "T3", ...],
       "decision_path": ["Step1: ...", "Step2: ...", ...],
       "multi_order": false
     }
     ```
   - Input: Query + 3 Files
   - Output: $json (Scenario Result)

---

#### **PFAD C: BPMN Process Validation** (für PROCESS_LOGIC, VALIDATION)

**Nodes:**
1. **Multi-File Reader**
   - `references/processes/bpmn_validation_v5_0.md` (BPMN Logik)
   - `references/processes/process_hierarchy_v5_0.md` (Prozess-Hierarchie)
   - `references/core/validation_rules_v5_0.md` (Validierungsregeln)

2. **AI Agent 4: BPMN Validator** (Claude)
   - **Prompt:**
     ```
     Du bist BPMN-Prozess-Validator für DaRa Warehouse-Szenarien.

     Query: {{$node["Webhook"].json.query}}

     AUFGABEN je nach Sub-Type:

     1. PROZESS-ERKLÄRUNG:
        - Erkläre den Prozessfluss (Retrieval oder Storage)
        - Gib BPMN-Sequenz: CL114 → CL115/CL116 → CL118 → ...
        - Liste Entscheidungspunkte

     2. IST/SOLL-VERGLEICH (wenn Prozess-Daten gegeben):
        - Lade Probanden-Prozess-Daten
        - Vergleiche gegen SOLL-BPMN
        - Identifiziere Abweichungen (7 Kategorien)
        - Erzeuge Fehlerursachen-Hypothesen

     3. VALIDIERUNG:
        - Prüfe Sequenzvalidiät (FSM für CC09)
        - Prüfe Location-Transitions
        - Prüfe Tool-Requirements (CL145, CL150)
        - Prüfe Teleportation-Detection

     Output:
     {
       "process_type": "retrieval|storage|mixed",
       "bpmn_sequence": ["CL114", "CL115", ...],
       "decision_points": [...],
       "violations": [...],
       "hypotheses": [...],
       "conformity_score": 0.92
     }
     ```
   - Input: Query + 3 Files
   - Output: $json (BPMN Result)

---

#### **PFAD D: Report Generation** (für REPORT)

**Nodes:**
1. **File Reader**
   - `assets/bpmn_validation_report_template_v5_0.md`
   - `assets/scenario_report_template_v5_0.md`

2. **AI Agent 5: Report Generator** (Claude)
   - **Prompt:**
     ```
     Du bist Report-Generator für DaRa Dataset Analysen.

     Gegeben:
     - Query/Anfrage: {{$node["Webhook"].json.query}}
     - Report-Typ: {{$node["AI Agent 1"].json.sub_type}}
     - Template: {{$node["File Reader"].data.content}}
     - Vorherige Results: {{$context.all_results}}

     AUFGABE:
     1. Wähle korrektes Template (BPMN oder Scenario)
     2. Fülle Template mit Daten aus vorherigen Agents
     3. Formatiere als Markdown + JSON (dual-format)
     4. Addiere Metadata (timestamp, source, version)
     5. Gib strukturiertes Report zurück

     Output:
     {
       "markdown": "# DaRa Validation Report\n...",
       "json": {...},
       "metadata": {
         "generated_at": "2026-02-23T...",
         "dara_version": "v5.0",
         "sources": ["..."],
         "quality_score": 0.95
       }
     }
     ```
   - Input: Template + All Previous Results
   - Output: $json (Report)

---

### PHASE 3: PARALLEL DATA AGGREGATION

**Node: Merge Results**
- Input: Output aus allen 4 Pfaden
- Kombiniere: Label Result, Scenario Result, BPMN Result, Report
- Output: `$context.aggregated_results`

---

### PHASE 4: QUALITY CONTROL & RESPONSE FORMATTING (mit SKILL.md Prinzipien)

**AI Agent 6: Quality Assurance & Response Formatter** (Claude) — *Gemäß SKILL.md Antwort-Prinzipien*

- **Prompt:**
  ```
  Du bist QA-Expert für DaRa Dataset Analysen.
  Befolge SKILL.md Antwort-Prinzipien:

  Gegeben:
  - Original Query: {{$node["Webhook"].json.query}}
  - Classification: {{$node["AI Agent 1"].json}}
  - File Result: {{$node["File Reader"].data.content}}
  - AI Agent Result: {{$node["Content Processor"].json}}

  AUFGABEN (gemäß SKILL.md):

  1. KONSISTENZ-CHECK (Antwort-Prinzip #1 & #2)
     ❌ "CC09 ist die Haupttätigkeit"
     ✅ "CC09 'Pick Time' wird im REFA-Kontext auf t_MH gemappt"

     - Label-ID Format: CL001-CL207 (nicht "CL-001")
     - Kategorie Format: CC01-CC12, S1-S8, T1-T13 (mit Präfix)
     - Keine Halluzinationen! Nur dokumentierte Fakten

  2. QUELLENANGABEN (Antwort-Prinzip #3)
     - Zitiere Regel-IDs (V-B1, V-S1)
     - Nenne Kapitel/Abschnitte
     - Nenne BPMN-Figuren (Figure A2, A3)
     - Format: "Gemäß [Regel-ID] in [Datei]..."

  3. UNSICHERHEIT-HANDLING (Antwort-Prinzip #4)
     ❌ "Ich glaube, dass..."
     ✅ "Diese Information ist nicht in den Skill-Dateien dokumentiert"
     ✅ "Ich kann aber verwandte Informationen aus [Datei X] teilen"

  4. FALLBACK-LOGIK (SKILL.md Zeile 226)
     Falls Query nicht eindeutig:
     → Lade "references/auxiliary/dataset_core_v5_0.md"

  Output:
  {
    "quality_score": 0.95,
    "consistency_check": {
      "format_correct": true,
      "no_hallucinations": true,
      "terminology_standard": true
    },
    "sources_cited": ["V-B1", "Kapitel 4.6", "Figure A3"],
    "uncertainty_handled": false,
    "formatted_response": "# Antwort (Markdown)...",
    "confidence": "high|medium|low",
    "warnings": [],
    "requires_manual_review": false
  }
  ```
- Input: File Content + Original Query + AI Result
- Output: $json (Final Response)

---

### PHASE 5: OUTPUT & ERROR HANDLING

**Nodes:**

1. **Response Formatter Node**
   - Format: JSON oder Markdown (basierend auf `request_type`)
   - Output: Finale Antwort

2. **Error Handler Node**
   - Falls `quality_score < 0.7`: Flag für Manual Review
   - Falls File nicht gefunden: Fallback Error Message
   - Falls AI Agent Failed: Retry + Human Alert

3. **Database Logger Node** (Optional)
   - Log Query + Response
   - Für zukünftige Improvements

4. **Response Output Node**
   - HTTP Response (200 OK + Payload)
   - oder Email, Slack, etc.

---

## 🧠 AI AGENT NODES — DETAILLIERTE SPEZIFIKATION

### Agent 1: Query Classifier
- **Model:** Claude 3.5 Sonnet
- **Temperature:** 0.2 (Low, für deterministische Classification)
- **Max Tokens:** 500
- **Input Files:** Nur Query-String
- **Expected Output:** JSON (1-2 KB)

### Agent 2: Label Lookup Specialist
- **Model:** Claude 3.5 Sonnet
- **Temperature:** 0.1 (Sehr niedrig, für präzise Facts)
- **Max Tokens:** 2000
- **Input Files:** labels_207_v5_0.md, ggf. validation_rules_v5_0.md
- **Expected Output:** JSON + Markdown (3-5 KB)

### Agent 3: Scenario Detection Engine
- **Model:** Claude 3.5 Sonnet
- **Temperature:** 0.3 (Niedrig, für konsistente Logic)
- **Max Tokens:** 3000
- **Input Files:** ground_truth_central_v5_0.md, chunking_v5_0.md, category_activation_matrix_v5_0.md
- **Expected Output:** JSON + Decision Path (2-3 KB)

### Agent 4: BPMN Validator
- **Model:** Claude 3.5 Sonnet
- **Temperature:** 0.2
- **Max Tokens:** 4000
- **Input Files:** bpmn_validation_v5_0.md, process_hierarchy_v5_0.md, validation_rules_v5_0.md
- **Expected Output:** JSON + Violation Report (5-10 KB)

### Agent 5: Report Generator
- **Model:** Claude 3.5 Sonnet
- **Temperature:** 0.3
- **Max Tokens:** 5000
- **Input Files:** Report Templates + All Aggregated Results
- **Expected Output:** Markdown + JSON Report (10-20 KB)

### Agent 6: Quality Assurance
- **Model:** Claude 3.5 Sonnet
- **Temperature:** 0.1 (Sehr niedrig, für konsistente QA)
- **Max Tokens:** 2000
- **Input Files:** Keine (verarbeitet nur strukturierte Data)
- **Expected Output:** JSON + Formatted Response (5-10 KB)

---

## 📊 NODE-ÜBERSICHT & DATA FLOW

```
┌─────────────────────────────────────────────────────────────┐
│ WEBHOOK INPUT                                               │
│ POST /n8n-webhook/dara-query                               │
│ {query: string, user_id: string, request_type: string}     │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│ AI AGENT 1: Query Classifier (Claude)                       │
│ Output: {category, confidence, routing_file, ai_agent...}   │
└──────────────────┬──────────────────────────────────────────┘
                   │
        ┌──────────┼──────────┬──────────┐
        │          │          │          │
        ▼          ▼          ▼          ▼
    ┌────────┐┌────────┐┌────────┐┌────────┐
    │ PFAD A ││ PFAD B ││ PFAD C ││ PFAD D │
    │ Label  ││Scenario││ BPMN   ││ Report │
    │Lookup  ││Detect  ││Validat.││ Gen.   │
    └────────┘└────────┘└────────┘└────────┘
        │          │          │          │
        │ Agent 2  │ Agent 3  │ Agent 4  │ Agent 5
        │          │          │          │
        ▼          ▼          ▼          ▼
    ┌────────┐┌────────┐┌────────┐┌────────┐
    │ Results││Results ││Results ││Results │
    │ JSON   ││ JSON   ││ JSON   ││ JSON   │
    └────────┘└────────┘└────────┘└────────┘
        │          │          │          │
        └──────────┼──────────┼──────────┘
                   ▼
        ┌──────────────────────┐
        │ MERGE Results Node    │
        │ $context.aggregated  │
        └──────────┬───────────┘
                   ▼
        ┌──────────────────────┐
        │ AI AGENT 6:          │
        │ Quality Assurance    │
        └──────────┬───────────┘
                   ▼
        ┌──────────────────────┐
        │ Response Formatter    │
        │ JSON / Markdown      │
        └──────────┬───────────┘
                   ▼
        ┌──────────────────────┐
        │ HTTP Output Node     │
        │ 200 OK + Payload     │
        └──────────────────────┘
```

---

## 🔌 SPEZIFISCHE NODE-KONFIGURATIONEN

### Webhook Node
```
URL: /n8n-webhook/dara-query
Method: POST
Authentication: Basic / API Key
Response Mode: Last Node Output
```

### File Reader Nodes (HTTP Request)
```
Method: GET
URL Pattern: file://references/core/labels_207_v5_0.md
Headers:
  Accept: text/plain
  Encoding: UTF-8
Response Format: Text → JSON (body als content)
```

### AI Agent Nodes (Claude)
```
Provider: Anthropic (API Key)
Model: claude-3-5-sonnet-20241022
Temperature: 0.1 - 0.3 (je nach Agent)
Max Tokens: 500 - 5000 (je nach Agent)
System Prompt: [Agent-spezifisch]
```

### Switch Node (Route)
```
Expression Mode: TRUE
Condition 1: $node["AI Agent 1"].json.category === "LABEL_LOOKUP"
  → Goes to: AI Agent 2
Condition 2: $node["AI Agent 1"].json.category === "SCENARIO_DETECTION"
  → Goes to: AI Agent 3
[etc.]
```

### Merge Node
```
Input Mode: Merge by Key
Merge Mode: Combine All
```

---

## 📈 WORKFLOW-STATISTIKEN

| Metric | Wert |
|--------|------|
| Anzahl Nodes | ~20 |
| Anzahl AI Agents | 6 |
| Max Parallel Branches | 4 |
| Avg Response Time | 5-15 Sekunden |
| File I/O Operations | ~15 (abhängig von Route) |
| Token Usage (per Query) | 5.000 - 20.000 |
| Error Scenarios | 8 (siehe unten) |

---

## ⚠️ ERROR HANDLING & EDGE CASES

### Edge Case 1: File Not Found
**Trigger:** File Reader Node fails
**Action:**
```
→ Fallback Node: Return cached version
  or Manual Alert + Error Response
```

### Edge Case 2: Ambiguous Query
**Trigger:** AI Agent 1 confidence < 0.7
**Action:**
```
→ Ask User Node: Disambiguate Query
  or Route to Multiple Agents (Uncertainty Mode)
```

### Edge Case 3: AI Agent Failed / Timeout
**Trigger:** Agent Response Timeout (>30s)
**Action:**
```
→ Retry Node (max 2 retries)
  → If still failed: Manual Review Queue
  → Error Response with Fallback Info
```

### Edge Case 4: Invalid JSON Output
**Trigger:** AI Agent returns non-JSON
**Action:**
```
→ Parse Error Handler
  → Extract Text from Response
  → Convert to JSON Fallback
```

### Edge Case 5: Multiple Conflicting Results
**Trigger:** Agent 3 + Agent 4 show conflicting Scenarios
**Action:**
```
→ Conflict Resolution Agent (Agent 6+)
  → Compare Confidence Scores
  → Flag for Manual Review if both > 0.8
```

### Edge Case 6: Very Large File (>1MB)
**Trigger:** File Reader loads huge file
**Action:**
```
→ Chunking Strategy
  → Split file into 100KB chunks
  → Process in Series (not Parallel)
```

### Edge Case 7: Rate Limiting (Claude API)
**Trigger:** Too many concurrent AI Agents
**Action:**
```
→ Queue Management
  → Max 3 concurrent AI calls
  → Queue remaining requests
```

### Edge Case 8: User Requests Multiple Queries (Batch)
**Trigger:** request_type === "batch"
**Action:**
```
→ Loop Node: Iterate over Query Array
  → Execute Workflow for each Query
  → Aggregate Results
  → Single Batch Report Output
```

---

## 🚀 IMPLEMENTIERUNGS-ROADMAP

### SCHRITT 1: Core Skeleton (Woche 1)
- [ ] Webhook Node
- [ ] AI Agent 1 (Classifier)
- [ ] Switch Node
- [ ] Simple Response Output

**Test:** 3-5 sample queries

---

### SCHRITT 2: Label Path (Woche 2)
- [ ] File Reader for labels_207_v5_0.md
- [ ] AI Agent 2 (Label Specialist)
- [ ] Merge Node
- [ ] Quality Check

**Test:** Label Lookup Queries

---

### SCHRITT 3: Scenario Path (Woche 3)
- [ ] Multi-File Reader (Ground Truth + Chunking)
- [ ] AI Agent 3 (Scenario Detector)
- [ ] Merge Integration
- [ ] Test S1-S8 Detection

**Test:** Scenario Detection Queries

---

### SCHRITT 4: BPMN Path (Woche 4)
- [ ] Multi-File Reader (BPMN + Process Hierarchy)
- [ ] AI Agent 4 (BPMN Validator)
- [ ] Violation Detection Logic
- [ ] IST/SOLL Comparison

**Test:** Process Validation Queries

---

### SCHRITT 5: Report Path (Woche 5)
- [ ] Report Template Loader
- [ ] AI Agent 5 (Report Generator)
- [ ] Markdown + JSON Formatter
- [ ] Template Integration

**Test:** Report Generation

---

### SCHRITT 6: Quality & Error Handling (Woche 6)
- [ ] AI Agent 6 (QA Specialist)
- [ ] Error Handlers (8 Edge Cases)
- [ ] Logging & Monitoring
- [ ] Response Formatting

**Test:** Full Workflow mit Edge Cases

---

### SCHRITT 7: Optimization & Deployment (Woche 7)
- [ ] Performance Tuning
- [ ] Parallel Branch Optimization
- [ ] Token Usage Analysis
- [ ] Production Deployment

---

## 🎯 SUCCESS CRITERIA

| Kriterium | Target | Akzeptanz |
|-----------|--------|-----------|
| Accuracy (Queries korrekt klassifiziert) | 95% | >85% |
| Response Time | <10s | <30s |
| Quality Score (QA passed) | >0.90 | >0.70 |
| Uptime | 99.5% | >95% |
| No Hallucinations | 100% | >90% |
| Coverage (Query Types) | All 8 | ≥6 |
| Error Handling | 8/8 Cases | ≥6/8 |

---

## 📚 REFERENZIERTE DATEIEN

Die Workflow automatisiert diese DaRa v5.0 Dateien:

### CORE
- `references/core/labels_207_v5_0.md` (711 Zeilen)
- `references/core/validation_rules_v5_0.md` (798 Zeilen)
- `references/core/ground_truth_central_v5_0.md` (478 Zeilen)
- `references/core/category_activation_matrix_v5_0.md` (742 Zeilen)

### AUXILIARY
- `references/auxiliary/chunking_v5_0.md` (1.212 Zeilen)
- `references/auxiliary/dataset_core_v5_0.md` (258 Zeilen)
- `references/auxiliary/warehouse_physical_v5_0.md` (270 Zeilen)

### PROCESSES
- `references/processes/bpmn_validation_v5_0.md` (1.623 Zeilen)
- `references/processes/process_hierarchy_v5_0.md` (597 Zeilen)

### ASSETS
- `assets/bpmn_validation_report_template_v5_0.md`
- `assets/scenario_report_template_v5_0.md`
- `assets/query_patterns_v5_0.md`

---

## 🔗 NÄCHSTE SCHRITTE

1. **Workflow-Skeleton erstellen** (Schritt 1 Implementierung)
2. **Claude API Integration** testen
3. **File Loading Strategie** entscheiden (local vs. API)
4. **Prompt Engineering** für 6 AI Agents
5. **Testing Framework** aufbauen

---

**Gesamtaufwand:** ~7 Wochen (mit Testing)
**Skill-Umfang:** 18 Dateien, 9.655 Zeilen
**Automation Grade:** High (80%+ der Queries automatisiert)

---

**Version:** 1.0
**Status:** Ready für Implementation
**Nächste Phase:** Schritt 1 - Core Skeleton Development
