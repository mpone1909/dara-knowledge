---
version: 5.0
status: finalisiert
created: 2026-02-04
source: "DaRa Dataset - BPMN Validation Report Template"
description: "Structured template for automated BPMN validation reports. Output format for processes_bpmn_validation.md validation engine. Includes sections for violations, IST vs SOLL comparison, error hypotheses, and recommendations."
---

# BPMN Validation Report Template

**Strukturiertes Template fÃ¼r Abweichungsberichte nach BPMN-Validierung**

**Version:** 5.0  
**Erstellt:** 04.02.2026  
**Verwendung:** Automatische Report-Generierung nach Validierung

---

## METADATA

**Subject:** {subject_id}  
**Scenario:** {scenario_id}  
**Session:** {session}  
**Total Frames:** {total_frames}  
**Total Duration:** {total_duration_seconds} seconds  
**Validation Date:** {timestamp}  
**Validator Version:** {validator_version}

---

## EXECUTIVE SUMMARY

### Violation Overview

| Severity | Count | Percentage |
|----------|-------|------------|
| **CRITICAL** | {critical_count} | {critical_percentage}% |
| **WARNING** | {warning_count} | {warning_percentage}% |
| **INFO** | {info_count} | {info_percentage}% |
| **TOTAL** | {total_violations} | 100% |

### Conformity Score

**BPMN Conformity:** {conformity_score}% ({conformity_rating})

Rating Scale:
- **90-100%:** Excellent â€“ Minimal deviations
- **75-89%:** Good â€“ Acceptable deviations
- **50-74%:** Fair â€“ Significant deviations
- **<50%:** Poor â€“ Major process deviations

### Process Phase Distribution

| CC09 Phase | Expected | Detected | Deviation |
|------------|----------|----------|-----------|
{process_phase_table}

---

## IST vs. SOLL COMPARISON

### Expected Process Sequence (SOLL)

```
{soll_sequence_visualization}
```

### Detected Process Sequence (IST)

```
{ist_sequence_visualization}
```

### Structural Differences

**Missing Nodes (in SOLL, not in IST):**
{missing_nodes_list}

**Extra Nodes (in IST, not in SOLL):**
{extra_nodes_list}

**Sequence Deviations:** {sequence_deviation_count}

---

## DETAILED VIOLATION ANALYSIS

### 1. SEQUENCE VIOLATIONS (Critical Priority)

**Total:** {sequence_violation_count}  
**Severity Distribution:** CRITICAL: {seq_critical}, WARNING: {seq_warning}, INFO: {seq_info}

#### Critical Sequence Violations

| Frame | Chunk ID | Previous CC09 | Current CC09 | Expected Transitions | Description |
|-------|----------|---------------|--------------|----------------------|-------------|
{sequence_violations_critical_table}

#### Probabilistic Sequence Analysis

| Transition | Observed Count | Expected Probability | Deviation Level |
|------------|----------------|----------------------|-----------------|
{probabilistic_sequence_table}

**Interpretation:**
{probabilistic_interpretation}

---

### 2. TOOL VIOLATIONS (Critical Priority)

**Total:** {tool_violation_count}  
**Severity:** All tool violations are CRITICAL

#### Missing Tools

| Frame | CC10 Label | Process | Required Tool | Detected Tools (Left) | Detected Tools (Right) |
|-------|------------|---------|---------------|----------------------|------------------------|
{tool_violations_table}

#### Tool Usage Statistics

| Tool | Expected Frames | Detected Frames | Compliance Rate |
|------|-----------------|-----------------|-----------------|
{tool_usage_statistics}

**Critical Findings:**
{tool_critical_findings}

---

### 3. LOCATION VIOLATIONS (Warning Priority)

**Total:** {location_violation_count}  
**Severity Distribution:** CRITICAL: {loc_critical}, WARNING: {loc_warning}

#### Invalid Location Transitions

| Frame | CC10 Label | Previous Location | Current Location | Expected Path | Severity |
|-------|------------|-------------------|------------------|---------------|----------|
{location_violations_table}

#### Teleportation Events

| Frame | Previous Location | Current Location | Distance | Severity |
|-------|-------------------|------------------|----------|----------|
{teleportation_table}

**Spatial Analysis:**
{spatial_analysis_summary}

---

### 4. MULTI-ORDER VIOLATIONS (Scenario-Specific)

**Scenario Configuration:** {scenario_config}  
**Max Co-Activation Threshold:** {max_co_activation_frames} frames  
**Multi-Order Allowed:** {multi_order_allowed}

#### Co-Activation Violations

| Frame Range | Active Orders | Co-Activation Duration | Threshold | Severity |
|-------------|---------------|------------------------|-----------|----------|
{multi_order_violations_table}

#### Order Loop Validation (S7/S8 Only)

| Expected Loops | Detected Loops | Missing Loops | Status |
|----------------|----------------|---------------|--------|
{order_loop_validation}

**Order Distribution:**
{order_distribution_chart}

---

### 5. CHUNK STABILITY VIOLATIONS (Warning Priority)

**Total:** {chunk_violation_count}

#### Unstable Chunks

| Chunk ID | Unique CC09 Count | CC09 Labels | Frame Range | Severity |
|----------|-------------------|-------------|-------------|----------|
{chunk_stability_table}

**Analysis:**
{chunk_stability_analysis}

---

### 6. TEMPORAL SMOOTHING VIOLATIONS (Warning Priority)

**Total:** {smoothing_violation_count}  
**Window Size:** {smoothing_window_size} frames

#### Noisy Transitions

| Frame Range | Unique CC09 Count | CC09 Labels | Severity |
|-------------|-------------------|-------------|----------|
{temporal_smoothing_table}

**Interpretation:**
{smoothing_interpretation}

---

### 7. CL134 (WAITING) ANALYSIS (Info Priority)

**Total Waiting Frames:** {total_waiting_frames}  
**Waiting Sequences:** {waiting_sequence_count}

#### Waiting Events

| Frame | Previous CC10 | Duration (Frames) | Post-Waiting CC09 | Expected | Severity |
|-------|---------------|-------------------|-------------------|----------|----------|
{waiting_analysis_table}

#### Global Interrupt Validation

| Frame | Active CC10 Count | Expected (CL134 only) | Status | Severity |
|-------|-------------------|----------------------|--------|----------|
{global_interrupt_table}

**Findings:**
{waiting_findings}

---

## BPMN PROCESS GRAPH

### Detected Process Flow (IST-BPMN)

**JSON Output:**
```json
{bpmn_json_output}
```

### Mermaid Visualization

**Mermaid Code:**
```mermaid
{mermaid_code}
```

**Rendered Diagram:**
{mermaid_svg_link}

### Diff Visualization (IST vs. SOLL)

**Mermaid Code:**
```mermaid
{diff_mermaid_code}
```

**Legend:**
- ðŸŸ¢ Green: Correct nodes (in SOLL, present in IST)
- ðŸŸ  Orange: Extra nodes (not in SOLL, present in IST)
- ðŸ”´ Red (dashed): Missing nodes (in SOLL, missing in IST)

---

## ERROR HYPOTHESIS GENERATION

### Automated Hypotheses

{error_hypotheses_section}

**Example Format:**
```
Violation #1: CL116 (Pick Time) â†’ CL119 (Store Travel)
Frame: 1234

Hypotheses:
1. [LIKELIHOOD: HIGH] Annotation error - Frame 1234 should be CL115 (Picking Travel)
   Evidence: Abrupt process switch without logical reason

2. [LIKELIHOOD: MEDIUM] Proband switched to Storage process unintentionally
   Evidence: Invalid transition from Retrieval to Storage

3. [LIKELIHOOD: LOW] Real process deviation - Order was cancelled mid-picking
   Evidence: Rare but possible scenario
```

---

## RECOMMENDATIONS

### Critical Actions Required

{critical_recommendations}

**Example:**
1. **Sequence Violation (Frame 1234):** Verify annotation of CC09 label. Expected CL115, detected CL119.
2. **Tool Violation (Frame 5678):** Check if Tape Dispenser was used during Sealing (CL150). If not, investigate why.

### Process Optimization Suggestions

{optimization_suggestions}

**Example:**
1. **Location Efficiency:** Multiple teleportation events detected. Review warehouse layout or improve location annotation.
2. **Chunk Stability:** 15 chunks with >2 CC09 labels. Consider refining chunk detection triggers.

### Data Quality Flags

{data_quality_flags}

**Example:**
- âš ï¸ **High Noise Level:** 23 temporal smoothing violations suggest noisy data or annotation inconsistencies.
- âš ï¸ **Tool Annotation Gaps:** 12 tool violations indicate possible under-annotation of tools in CC04/CC05.

---

## APPENDIX

### A. Full Violation List (CSV Export)

{violation_csv_export}

### B. Metadata

**Validation Parameters:**
- Chunk-Level Validation: {chunk_level_enabled}
- Frame-Level Validation: {frame_level_enabled}
- Probabilistic Scoring: {probabilistic_enabled}
- Temporal Smoothing Window: {smoothing_window}
- Location Graph Distance: {location_max_distance}

**Dataset Context:**
- Subject Metadata: {subject_metadata}
- Scenario Ground Truth: {scenario_ground_truth}
- Session Details: {session_details}

### C. Tool Reference

**Mandatory Tool Matrix:**
{tool_matrix_reference}

**Expected Location Transitions:**
{location_transition_reference}

---

## GLOSSARY

**BPMN:** Business Process Model and Notation  
**CC09:** Mid-Level Process Category (10 labels)  
**CC10:** Low-Level Process Category (31 labels)  
**CC11:** Human Location Category (26 labels)  
**FSM:** Finite State Machine  
**IST:** Actual (detected) process  
**SOLL:** Expected (ideal) process from BPMN  
**Conformity Score:** Percentage of IST sequence matching SOLL  
**Severity Levels:**
- CRITICAL: Fundamental BPMN logic violated
- WARNING: Unusual but possible
- INFO: Deviation without direct error

---

## FOOTER

**Report Generated:** {generation_timestamp}  
**Validator:** DaRa BPMN Validation Engine v{validator_version}  
**Skill Version:** {skill_version}  
**Contact:** {contact_info}

---

**End of Report**
