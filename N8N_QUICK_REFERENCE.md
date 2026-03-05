# n8n Workflow — QUICK REFERENCE CARD

---

## 🎯 DAS PROJEKT IN 60 SEKUNDEN

**Was:** Ein n8n Workflow mit 6 AI Agent Nodes, der den **DaRa Skill v5.0** automatisiert
**Warum:** Automatische Query-Beantwortung für 207 Labels, 8 Szenarien, 47 Prozesse, 13 Trigger, BPMN-Validierung
**Wie:** Webhook → Classifier → Switch (21 Routes) → File Reader → AI Processor → QA → Output

---

## 🔄 WORKFLOW FLOW (VISUAL)

```
USER
  │
  └─→ HTTP POST "Welche Labels gehören zu CC04?"
       │
       ▼
     [Webhook Node]
       │
       ▼
     [AI Agent 1: Classifier]  ← Claude: "Klassifiziere Query"
       │                           Temp: 0.2, Token: 500
       │ Output: {category: "LABEL_LOOKUP", file: "labels_207_v5_0.md"}
       │
       ▼
     [Switch Node]  ← 21 Cases (aus SKILL.md)
       │
       ├─ STRUCTURAL → dataset_core_v5_0.md
       ├─ LABEL_LOOKUP → labels_207_v5_0.md  ← (dieses Beispiel)
       ├─ SCENARIO → ground_truth_central_v5_0.md
       ├─ BPMN → bpmn_validation_v5_0.md
       ├─ VALIDATION → validation_rules_v5_0.md
       └─ [18 weitere Routes]
       │
       ▼
     [File Reader Node]
       │ Load: {{classification.routing_file}}
       │ Encoding: UTF-8
       │ Output: Complete File Content
       │
       ▼
     [Optional: AI Agent 2-5]
       │ (nur für komplexe Analysen)
       │ z.B. Label Specialist, Scenario Detector, BPMN Validator
       │
       ▼
     [AI Agent 6: QA & Formatter]  ← Claude: "Überprüfe SKILL.md Prinzipien"
       │                              Temp: 0.1, Token: 2000
       │ Output: {quality_score: 0.95, formatted_response: "..."}
       │
       ▼
     [Response Formatter Node]
       │ Format: JSON + Markdown
       │ Add: Metadata, Sources, Timestamps
       │
       ▼
     [HTTP Output]
       │
       ▼
      USER
       │
       └─ "CC04 — Sub-Activity: Left Hand
            Labels: CL016-CL032, CL141-CL148
            Source: references/core/labels_207_v5_0.md"
```

---

## 📊 NODES ÜBERSICHT (SCHRITT 1 = MINIMAL)

| # | Node Name | Type | Input | Output | Config |
|---|-----------|------|-------|--------|--------|
| 1 | HTTP Input | Webhook | POST /dara-query | {query, user_id} | Auth: optional |
| 2 | Classifier | AI (Claude) | {query} | {category, file, conf} | Temp: 0.2 |
| 3 | Router | Switch | {category} | → 21 branches | Case/Default |
| 4 | File Reader | HTTP GET | {routing_file} | {content} | UTF-8 |
| 5 | Processor | AI (Claude)* | {query, content} | {result} | Optional* |
| 6 | QA Check | AI (Claude) | {query, result} | {quality, response} | Temp: 0.1 |
| 7 | Formatter | Function | {qa_result} | {json, markdown} | Templates |
| 8 | HTTP Output | Response | {formatted} | 200 OK | JSON/MD |

**Legende:**
- `*` = Optional in Schritt 1 (wird in Schritt 2-5 hinzugefügt)
- **PHASE 1:** ~8 Nodes
- **PHASE 2:** +12 Nodes (Agents 2-5)
- **PHASE 3:** +5 Nodes (Error Handling, Logging)

---

## 🧠 AI AGENTS SPEZIFIKATION

### **Agent 1: Query Classifier** (ZENTRAL)
```
Input: {query: "Welche Labels gehören zu CC04?"}
Logic: Klassifiziere nach 21 SKILL.md Kategorien
Output: {category: "LABEL_LOOKUP", routing_file: "labels_207_v5_0.md"}
Model: Claude Sonnet
Temp: 0.2 (Low = Deterministic)
Speed: ~2-3 Sekunden
```

### **Agent 6: QA Specialist** (KRITISCH)
```
Input: {query, file_content, processor_output}
Logic: Überprüfe SKILL.md Prinzipien (Zeile 240-284)
Output: {quality_score, formatted_response, warnings}
Model: Claude Sonnet
Temp: 0.1 (Very Low = Consistent)
Speed: ~2-3 Sekunden
```

### **Agent 2: Label Specialist** (Optional, Schritt 2+)
```
Input: {query, labels_file_content}
Output: {type, result, source, confidence}
Für: Label Lookups (CL001-CL207), Category Queries (CC01-CC12)
```

### **Agent 3: Scenario Detector** (Optional, Schritt 3+)
```
Input: {query, ground_truth_content, chunking_content}
Output: {scenario, trigger_sequence, confidence, decision_path}
Für: Scenario Detection (S1-S8), Ground Truth Logic
```

### **Agent 4: BPMN Validator** (Optional, Schritt 4+)
```
Input: {query, bpmn_content, process_hierarchy_content}
Output: {process_type, bpmn_sequence, violations, confidence}
Für: BPMN Prozesse, Validierung, IST/SOLL Vergleich
```

### **Agent 5: Report Generator** (Optional, Schritt 5+)
```
Input: {query, template_content, aggregated_results}
Output: {markdown, json, metadata}
Für: Report Generierung (BPMN, Scenario)
```

---

## 📁 DIE 21 KATEGORIEN (SKILL.md Mapping)

```
1. STRUCTURAL         → dataset_core_v5_0.md
2. DATA_STRUCTURE     → data_structure_v5_0.md
3. WAREHOUSE          → warehouse_physical_v5_0.md
4. CHUNKING           → chunking_v5_0.md
5. SEMANTICS          → semantics_v5_0.md
6. LABEL_LOOKUP       → labels_207_v5_0.md
7. ARTICLES           → articles_inventory_v5_0.md
8. SCENARIO_DETECTION → ground_truth_central_v5_0.md
9. CATEGORY_MATRIX    → category_activation_matrix_v5_0.md
10. VALIDATION        → validation_rules_v5_0.md
11. REFA              → refa_analytics_v5_0.md
12. MTM               → mtm_codes_v5_0.md
13. PROCESS_HIERARCHY → process_hierarchy_v5_0.md
14. BPMN              → bpmn_validation_v5_0.md
15. BPMN_QUICKSTART   → bpmn_validation_quickstart_v5_0.md
16. QUERY_PATTERNS    → query_patterns_v5_0.md
17. REPORT_TEMPLATE   → bpmn_validation_report_template_v5_0.md
18. CHANGELOG         → CHANGELOG_v5_0.md
19. MIGRATION         → MIGRATION_v5_0.md
20. STRUCTURE         → STRUCTURE_v5_0.md
21. README            → README_v5_0.md

DEFAULT (Fallback)   → dataset_core_v5_0.md
```

---

## ⚡ PERFORMANCE TARGETS

| Metric | Target | Akzeptanz |
|--------|--------|-----------|
| Response Time | <5s | <15s |
| Query Accuracy | >95% | >85% |
| Quality Score | >0.90 | >0.70 |
| No Hallucinations | 100% | >95% |
| Uptime | 99.5% | >95% |
| Token Cost (per query) | 5K | 20K max |

---

## 🧪 TEST QUERIES

### **Test 1: Label Lookup (EASIEST)**
```
Query: "Was ist CL115?"
Expected Route: LABEL_LOOKUP → labels_207_v5_0.md
Expected Output: Label Definition JSON
Complexity: ⭐ (sehr einfach)
```

### **Test 2: Category Query**
```
Query: "Welche Labels gehören zu CC09?"
Expected Route: LABEL_LOOKUP → labels_207_v5_0.md
Expected Output: List of Labels with Hierarchy
Complexity: ⭐⭐ (einfach)
```

### **Test 3: Structural Question**
```
Query: "Wie viele Probanden gibt es?"
Expected Route: STRUCTURAL → dataset_core_v5_0.md
Expected Output: "18 Probanden (S01-S18)"
Complexity: ⭐ (sehr einfach)
```

### **Test 4: Validation Query (MEDIUM)**
```
Query: "Welche Master-Slave-Abhängigkeiten gibt es?"
Expected Route: VALIDATION → validation_rules_v5_0.md
Expected Output: Master-Slave Rules + Code Examples
Complexity: ⭐⭐⭐ (mittelschwer)
```

### **Test 5: BPMN Query (HARDEST)**
```
Query: "Erkläre den BPMN-Prozess für Retrieval"
Expected Route: BPMN → bpmn_validation_v5_0.md
Expected Output: Process Sequence, Decision Points, Violations
Complexity: ⭐⭐⭐⭐⭐ (sehr schwer)
Requires: Agent 4 (BPMN Validator)
```

---

## 🚨 SKILL.MD ANTWORT-PRINZIPIEN (KRITISCH!)

Diese Prinzipien sind in **Agent 6 (QA)** hardcoded!

### **Prinzip 1: Unterscheidung Datensatz vs. Methode**
```
❌ "CC09 ist die Haupttätigkeit"
✅ "CC09 wird im REFA-Kontext auf t_MH (Haupttätigkeit) gemappt"
```

### **Prinzip 2: Terminologie-Standard**
```
✅ Korrekt: CL115, CC09, S1-S8, T1-T13 (mit Präfix)
❌ Falsch: CL-115, c09, scenario 1, trigger 1 (ohne Präfix)
```

### **Prinzip 3: Quellenangaben**
```
✅ "Gemäß V-B1 in references/core/validation_rules_v5_0.md..."
✅ "Kapitel 4.6 in references/auxiliary/chunking_v5_0.md"
```

### **Prinzip 4: Keine Halluzinationen**
```
❌ "Ich glaube, dass...", "Vermutlich ist..."
✅ "Diese Information ist nicht dokumentiert"
✅ "Ich kann aber verwandte Informationen aus [Datei X] teilen"
```

---

## 🔧 IMPLEMENTIERUNGS-PHASEN

### **PHASE 1: MVP (3-5 Tage)**
```
✅ Webhook + Classifier + Switch + File Reader + QA + Output
✅ Coverage: ~60% (Label Lookups, Structural)
✅ Nodes: ~8
✅ AI Agents: 2 (Classifier, QA)
```

### **PHASE 2: Extended (7 Tage)**
```
+ AI Agent 2 (Label Specialist)
+ AI Agent 3 (Scenario Detector)
+ Error Handling (5 Cases)
✅ Coverage: ~85%
✅ Nodes: ~20
```

### **PHASE 3: Full Stack (14 Tage)**
```
+ AI Agent 4 (BPMN Validator)
+ AI Agent 5 (Report Generator)
+ Logging & Monitoring
+ All Edge Cases (8)
✅ Coverage: ~95%
✅ Nodes: ~25
```

---

## 📚 DOKUMENTE IM REPO

| Dokument | Zweck | Umfang |
|----------|-------|--------|
| **N8N_WORKFLOW_ABLAUFPLAN.md** | Detaillierte Architektur | 500+ Zeilen |
| **N8N_SIMPLIFIED_WORKFLOW.md** | Quick Start mit Prompts | 400+ Zeilen |
| **N8N_QUICK_REFERENCE.md** | Diese Datei | Kurzübersicht |
| **SKILL.md** | Query-Routing (Basis) | Zeile 136-227 |

---

## 🎓 BEISPIEL-IMPLEMENTATION: Test 1

```python
# PHASE 1 Minimal Workflow Test

# Input
webhook_input = {"query": "Was ist CL115?"}

# Node 1: Classifier
classifier_output = {
    "category": "LABEL_LOOKUP",
    "routing_file": "references/core/labels_207_v5_0.md",
    "confidence": 0.98
}

# Node 2: Switch (Take LABEL_LOOKUP route)
# → Load file

# Node 3: File Reader
file_content = "CL115: Picking — Travel Time ..."

# Node 4: QA Check
qa_output = {
    "quality_score": 0.95,
    "formatted_response": """
## CL115: Picking — Travel Time

**ID:** CL115
**Category:** CC09 (Mid-Level Process)
**Parent:** CL110 (Retrieval) or CL111 (Storage)
**Description:** Travel time between storage locations during picking phase

**Source:** references/core/labels_207_v5_0.md
**SKILL.md Principle:** Terminologie-Standard (✅ mit Präfix)
    """,
    "warnings": []
}

# Node 5: Output
http_response = {
    "status": 200,
    "body": qa_output.formatted_response,
    "metadata": {
        "processing_time": "2.3s",
        "nodes_executed": 5,
        "ai_agents": 2
    }
}
```

---

## 🔗 NÄCHSTE SCHRITTE

1. **Lese SKILL.md vollständig** (Zeile 136-227)
2. **Verstehe die 21 Kategorien** (Mapping)
3. **Schreibe Classifier Prompt** (Agent 1)
4. **Konfiguriere Switch Node** (21 Cases)
5. **Teste mit 5 Test Queries** (siehe oben)
6. **Implementiere QA Prompt** (Agent 6)
7. **Starte PHASE 1 Deployment**

---

## 📞 QUICK HELP

**"Wie lädt der Workflow die Datei?"**
→ Switch Node entscheidet Route → HTTP GET zum File → UTF-8 Encoding

**"Was macht Agent 1?"**
→ Klassifiziert Query in 21 Kategorien (aus SKILL.md) mit 0.2 Temp (deterministic)

**"Was macht Agent 6?"**
→ Überprüft Antwort gegen 4 SKILL.md Prinzipien + formatiert Output

**"Kann ich mit PHASE 1 starten?"**
→ JA! ~60% Coverage mit nur 8 Nodes + 2 Agents. Reicht für Label Lookups + Struktur.

**"Wie lange dauert eine Query?"**
→ 3-5 Sekunden (Classifier 2s + File I/O 1s + QA 2s)

**"Wieviel kostet es?"**
→ ~0.01 USD pro Query (5K Tokens avg @ Claude Sonnet pricing)

---

**Status:** Ready to Implement
**Difficulty:** ⭐⭐⭐ (Medium)
**Time Estimate:** 3 weeks (with testing)
**Success Rate:** >90% expected

---

*Weitere Fragen? Lies N8N_WORKFLOW_ABLAUFPLAN.md oder N8N_SIMPLIFIED_WORKFLOW.md*
