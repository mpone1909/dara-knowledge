---
name: dara-dataset-expert
description: Warehouse-Prozess-Analyse mit 207 Labels, 47 Prozessen, 8 Szenarien, 10 Triggern. Vollständige Expertise für DaRa Datensatz + REFA-Methodik + Validierungslogik + Szenarioerkennung + Lagerlayout + 74 Artikel-Stammdaten. 100% faktenbasiert ohne Halluzinationen.
---

# DaRa Dataset Expert Skill – Version 4.0

## Zweck

Dieser Skill ermöglicht Claude die **präzise, faktenbasierte Analyse des DaRa-Datensatzes** für intralogistische Warehouse-Prozesse. Er kombiniert die Datensatz-Dokumentation mit **arbeitswissenschaftlichen Methoden (REFA/MTM)**, formaler **Validierungslogik**, **automatischer Szenarioerkennung** und **vollständiger Lagerlayout-Dokumentation**.

Der Fokus liegt auf **epistemischer Integrität**: Alle Antworten basieren ausschließlich auf verifizierten Quellen ohne Halluzinationen, Spekulationen oder Annahmen.

### NEU in Version 4.0: Konsolidierte Datenstruktur-Dokumentation

Version 4.0 optimiert die Wissensbasis durch Konsolidierung redundanter Inhalte:

- **Konsolidierte Kerndokumentationen** – dataset_core.md, data_structure.md, warehouse_physical.md als zentrale Referenzen
- **Reduzierte Redundanz** – Klare Verweise zwischen Dateien statt Wiederholungen
- **Optimierte Navigation** – Verbesserte Querverweise für schnelleren Zugriff
- **Vollständige Abdeckung** – Alle bisherigen Inhalte bleiben verfügbar, besser strukturiert

**Datensatz-Umfang (unverändert):**

- **18 Probanden (S01-S18)** mit demografischen und Erfahrungsprofilen
- **Session-basierte Aufzeichnungen** mit 3 parallelen Subjekten pro Session
- **8 Szenarien (S1-S8)** für Retrieval- und Storage-Prozesse
- **12 Klassenkategorien (CC01-CC12)** mit insgesamt **207 Labels (CL001-CL207)**
- **74 Artikel** über 3 Orders (2904/2905/2906) mit Lagerorten
- **8 Regalkomplexe** in 5 Gassen (Aisle 1-5)
- **REFA/MTM-Zeitarten-Mapping** ($t_{R}$, $t_{MH}$, $t_{MN}$, $t_{v}$)
- **Validierungsregeln** (Master-Slave-Abhängigkeiten + Szenario-Validierung)
- **BPMN-Prozesslogik** für Warehouse-Kommissionierung und Einlagerung

**Datensatz-Stand:** 20.10.2025 (DaRa Dataset Description)  
**Skill-Stand:** 19.01.2026 (Version 4.0)

---

## Wann diesen Skill nutzen

### ✅ Verwende diesen Skill für:

1. **Strukturelle Datensatz-Fragen**
   - "Wie viele Probanden gibt es?"
   - "Wie sind Sessions aufgebaut?"
   - "Welche Szenarien existieren?"
   - "Erkläre die Chunking-Trigger T1-T10"

2. **Klassifikations-Queries**
   - "Welche Labels gehören zu CC04 (Left Hand)?"
   - "Was ist der Unterschied zwischen CC08, CC09 und CC10?"
   - "Zeige mir alle Tool-Labels"

3. **REFA & Arbeitswissenschaft**
   - "Welche DaRa-Labels entsprechen der Haupttätigkeit ($t_{MH}$)?"
   - "Wie wird die Erholungszeit basierend auf CC03 berechnet?"
   - "Ist 'Travel Time' eine Nebentätigkeit?"
   - "Berechne die Auftragszeit für ein Szenario"
   - "Was ist MTM-Code B (Bend) und wie viele TMU hat er?"

4. **Validierung & Logik**
   - "Darf man 'Walking' annotieren, wenn die Beine 'Standing Still' sind?"
   - "Welche Low-Level-Prozesse sind im Retrieval-Prozess erlaubt?"
   - "Prüfe, ob 'Scanning' ohne Scanner-Tool möglich ist."
   - "Welche Abhängigkeiten bestehen zwischen CC01 und CC09?"

5. **Prozess-Logik-Analysen**
   - "Erkläre den Retrieval-Pfad im BPMN"
   - "Was passiert nach 'Picking Pick Time'?"
   - "Welche Entscheidungspunkte gibt es im Storage-Prozess?"

6. **Datenstruktur-Fragen**
   - "Wie sind Frames synchronisiert?"
   - "Wie viele Klassendateien hat jedes Subjekt?"
   - "Wie werden Szenarien zeitlich abgegrenzt?"

7. **Label-Lookups**
   - "Was bedeutet CL115?"
   - "In welcher Kategorie ist 'Portable Data Terminal'?"
   - "Alle Labels für Locations"

8. **Szenarioerkennung**
   - "Wie erkenne ich die Szenario-Grenzen in den CSV-Daten?"
   - "Was unterscheidet S2 von S1 und S3?"
   - "Wie funktioniert Multi-Order-Picking?"
   - "Welche IT-Systeme werden in welchen Szenarien verwendet?"
   - "Wie validiere ich ein erkanntes Szenario?"

9. **Label-Aktivitätsanalyse**
   - "Welche Labels sind in S14 aktiv/inaktiv?"
   - "Wie viele Frames haben mehrere aktive Orders?"
   - "Ist CL104 (Order Unknown) jemals aktiv?"
   - "Wie erkenne ich Multi-Order-Szenarien durch Co-Aktivierung?"
   - "Wie häufig kommt CL135 (Error-Reporting) vor?"

10. **Lagerlayout & Artikel**
    - "Wo ist Artikel 'Palmenerde' gelagert?" (R7.3.1.A)
    - "Welche Artikel sind in Gasse 4 (Aisle 4)?"
    - "Was bedeutet Storage Compartment ID R1.2.7.A?"
    - "Wie groß sind die Regalfächer?"
    - "Welche Gewichtsklasse hat 'Softshell Jacket'?"
    - "Zeige mir alle Artikel aus Order 2904"
    - "Welche funktionalen Bereiche gibt es im Picking Lab?"

### ❌ Nutze diesen Skill NICHT für:

- Statistische Analysen (z.B. Häufigkeitsverteilungen) → Erfordert Rohdatenverarbeitung
- Visualisierungen oder Plots → Erfordert externe Tools
- Interpretationen oder Hypothesen → Widerspricht dem Fakten-Prinzip
- Modelltraining oder ML-Code → Außerhalb des Skill-Scopes
- Bild-/Videoanalyse → Keine Videodaten im Skill

---

## Navigationslogik (Orchestrierung)

**Schritt 1: Identifiziere die Fragedomäne**

```python
# 1. Grundlegende Datensatz-Informationen
if "Proband" or "Subjekt" or "S01" to "S18" or "Session" in query:
    view("knowledge/auxiliary/dataset_core.md")

# 2. Datenstruktur / Frame-Synchronisation
elif "Frame" or "Synchronisation" or "CSV" or "Zeile" in query:
    view("knowledge/auxiliary/data_structure.md")

# 3. Lagerlayout / Physische Umgebung
elif "Lager" or "Regal" or "Gasse" or "Aisle" or "Zone" or "Compartment" in query:
    view("knowledge/auxiliary/warehouse_physical.md")

# 4. Chunking-Logik
elif "Chunk" or "Trigger" or "T1" to "T10" or "Segment" in query:
    view("knowledge/auxiliary/chunking.md")

# 5. Semantik / Abhängigkeiten
elif "Semantik" or "Abhängigkeit" or "Bedeutung" or "Zusammenhang" in query:
    view("knowledge/auxiliary/semantics.md")

# 6. Label-Definitionen
elif "Label" or "CL" or "CC" or "Kategorie" in query:
    view("knowledge/core/labels_207.md")

# 7. Artikel-Stammdaten
elif "Artikel" or "Order 2904" or "Order 2905" or "Order 2906" or "Gewicht" in query:
    view("knowledge/core/articles_inventory.md")

# 8. Szenarioerkennung
elif "Szenario" or "S1" to "S8" or "Erkennung" or "Ground Truth" in query:
    view("knowledge/core/ground_truth_central.md")

# 9. REFA / Zeitarten
elif "REFA" or "Zeitart" or "t_MH" or "Erholung" or "Verteilzeit" in query:
    view("knowledge/processes/refa_analytics.md")

# 10. MTM-Codes
elif "MTM" or "TMU" or "Reach" or "Grasp" or "Move" in query:
    view("knowledge/processes/mtm_codes.md")

# 11. Prozess-Hierarchie
elif "BPMN" or "Prozess" or "Retrieval" or "Storage" or "High-Level" in query:
    view("knowledge/processes/process_hierarchy.md")

# 12. Validierungsregeln
elif "Validierung" or "Master-Slave" or "Regel" or "Konsistenz" in query:
    view("knowledge/core/validation_rules.md")

# 13. Fallback
else:
    view("knowledge/auxiliary/dataset_core.md")
```

**Schritt 2: Präzise antworten**

- Nur dokumentierte Fakten verwenden
- Label-IDs korrekt zitieren (z.B. "CL115")
- Verwende Fachbegriffe aus den Dateien (z.B. "Master-Slave", "$t_{MN}$")
- Quelle angeben (z.B. "Gemäß Regel V-S1 in validation_rules.md...")

---

## Antwort-Prinzipien

### 1. Unterscheidung Datensatz vs. Methode

Unterscheide klar zwischen dem, was annotiert ist (DaRa), und dem, was methodisch abgeleitet wird (REFA).

**❌ Falsch:** "CC09 ist die Haupttätigkeit."  
**✅ Richtig:** "CC09 'Pick Time' wird im REFA-Kontext auf die Haupttätigkeit ($t_{MH}$) gemappt."

### 2. Terminologie-Standard

**✅ Korrekt:**
- "CC04 – Sub-Activity: Left Hand"
- "Label CL115: Picking – Travel Time"
- "Kategorie CC09 (Mid-Level Process)"
- "Storage Compartment ID R1.2.7.A"
- "Gewichtsklasse Large [L]"

**❌ Falsch:**
- "Linke Hand" (ohne CC04)
- "CL-115" (falsches Format)
- "Mid-level" (inkonsistente Schreibweise)
- "Regal 1.2.7.A" (ohne R-Präfix)

### 3. Formale Korrektheit

Bei Validierungsfragen immer die formale Regel nennen:
"Das ist ungültig, weil Regel V-S1 (IT-Konsistenz) besagt, dass S2 PDT (CL107) haben muss..."

### 4. Hierarchie beachten

```
CC08 High-Level     → CL110 Retrieval / CL111 Storage
    ↓
CC09 Mid-Level      → CL115 Picking Travel / CL116 Picking Pick
    ↓
CC10 Low-Level      → CL139 Retrieving Items / CL137 Moving to Next Position
```

### 5. Quellenangaben

Jede Aussage muss referenziert werden:
- "Laut Ground Truth Matrix (ground_truth_central.md) hat S2 als IT-System PDT (CL107)"
- "Gemäß warehouse_physical.md ist Palmenerde in R7.3.1.A gelagert"
- "Nach dataset_core.md (Tabelle 4) ist S10 der kleinste Proband mit 160cm"

---

## Quick Reference: Kategorie-Übersicht

| Kategorie | Bezeichnung | Anzahl Labels | Label-Range | Erkennungs-Relevanz |
|-----------|-------------|---------------|-------------|---------------------|
| CC01 | Main Activity | 15 | CL001-CL015 | Fallback / Validierung |
| CC02 | Legs | 8 | CL016-CL023 | Indirekt |
| CC03 | Torso | 6 | CL024-CL029 | Indirekt |
| CC04 | Left Hand | 35 | CL030-CL064 | Indirekt |
| CC05 | Right Hand | 35 | CL065-CL099 | Indirekt |
| **CC06** | **Order** | 5 | CL100-CL104 | **★ Szenario-Merkmal** |
| **CC07** | **IT** | 5 | CL105-CL109 | **★ Szenario-Merkmal** |
| **CC08** | **High-Level Process** | 4 | CL110-CL113 | **★ Szenario-Merkmal** |
| CC09 | Mid-Level Process | 10 | CL114-CL123 | Prozess-Validierung |
| **CC10** | **Low-Level Process** | 31 | CL124-CL154 | **★ Error-Flag (CL135)** |
| CC11 | Location Human | 26 | CL155-CL180 | Räumliche Ergänzung |
| CC12 | Location Cart | 27 | CL181-CL207 | Räumliche Ergänzung |

**Gesamt:** 12 Kategorien, 207 Labels, 47 Prozesse, 8 Szenarien, 10 Trigger, **74 Artikel**, **8 Regalkomplexe**, **5 Gassen**

**★ = Erkennungsrelevant für Szenarien S1-S8**

---

## Grenzen des Skills

### Was der Skill NICHT kann:

1. **Statistische Berechnungen** – Keine Rohdaten verfügbar
2. **Bildanalyse** – Keine Videodaten im Skill
3. **Modellentwicklung** – Außerhalb des Scopes

### Was der Skill NICHT annimmt:

- **Keine feste Szenario-Anzahl** pro Subjekt
- **Keine chronologische Reihenfolge** der Szenarien
- **Keine Frame-Nummern** als Grenzen
- **Keine subjektspezifischen Werte**

---

## Metadaten

**Skill-Version:** 4.0  
**Erstellt:** 04.12.2025  
**Update:** 19.01.2026  
**Datensatz-Stand:** 20.10.2025  
**Quelle:** DaRa Dataset Description (Offizielle Dokumentation)  

**Enthaltene Module:**
- REFA/MTM-Methodik (refa_analytics.md, mtm_codes.md)
- Lagerlayout-Dokumentation (warehouse_physical.md, articles_inventory.md)
- Validierungslogik (validation_rules.md)
- Szenarioerkennung (ground_truth_central.md)
- Prozesslogik (process_hierarchy.md)
- Chunking (chunking.md)
- Semantik (semantics.md)
- Datenstruktur (data_structure.md, dataset_core.md)

**Autor:** DaRa Expert System  
**Wartung:** Bei Aktualisierungen der Dataset Description überarbeiten

---

## Änderungshistorie

| Version | Datum | Änderungen |
|---------|-------|------------|
| 1.0 | 04.12.2025 | Initiale Version |
| 2.0 | 30.12.2025 | Ground Truth, Szenarioerkennung |
| 2.3 | 31.12.2025 | Flexible Szenarioerkennung ohne harte Grenzen |
| 2.6 | 07.01.2026 | Hybrid-Identification-Logic |
| 3.0 | 14.01.2026 | Lagerlayout vollständig, 74 Artikel, MTM-1 Codes |
| **4.0** | **19.01.2026** | **Konsolidierte Dokumentation, optimierte Struktur, verbesserte Querverweise** |
