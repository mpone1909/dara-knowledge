# Migration Guide: v4.x â†’ v5.0

**Zielgruppe:** Entwickler, Forscher, DaRa-Nutzer  
**Migrationsaufwand:** Niedrig (hauptsÃ¤chlich Dateinamen-Updates)  
**Breaking Changes:** Dateinamen geÃ¤ndert, neue Dependencies

---

## ðŸ“‹ SCHNELL-ÃœBERSICHT

| Aspekt | v4.x | v5.0 | Action |
|--------|------|------|--------|
| **Dateinamen** | Ohne Suffix | Mit `_v5_0` | Update Referenzen |
| **Dateianzahl** | ~20 (variabel) | 18 (stabil) | Deprecated entfernen |
| **Struktur** | PrÃ¤fix-basiert | PrÃ¤fix-basiert | Keine Ã„nderung |
| **Neue Dateien** | - | validation_rules | Integrieren |
| **Encoding** | Teilweise Fehler | UTF-8 konsistent | - |

---

## 1. DATEINAMEN-MAPPING

### 1.1 Core-Dateien

| Alt (v4.x) | Neu (v5.0) | Ã„nderungstyp |
|------------|------------|--------------|
| `labels_207.md` | `core_labels_207_v5_0.md` | Versioniert |
| `articles_inventory.md` | `core_articles_inventory_v5_0.md` | Versioniert |
| `category_activation_matrix.md` | `core_category_activation_matrix_v5_0.md` | Versioniert |
| `ground_truth_central.md` | `core_ground_truth_central_v5_0.md` | Versioniert |
| *NEU* | `core_validation_rules_v5_0.md` | **Neu erstellt** |

---

### 1.2 Auxiliary-Dateien

| Alt (v4.x) | Neu (v5.0) | Ã„nderungstyp |
|------------|------------|--------------|
| `chunking.md` | `auxiliary_chunking_v5_0_repaired.md` | **Repaired** |
| `data_structure.md` | `auxiliary_data_structure_v5_0.md` | Versioniert |
| `dataset_core.md` | `auxiliary_dataset_core_v5_0.md` | Versioniert |
| `semantics.md` | `auxiliary_semantics_v5_0.md` | Versioniert |
| `warehouse_physical.md` | `auxiliary_warehouse_physical_v5_0.md` | Versioniert |

---

### 1.3 Processes-Dateien

| Alt (v4.x) | Neu (v5.0) | Ã„nderungstyp |
|------------|------------|--------------|
| `bpmn_validation.md` | `processes_bpmn_validation_v5_0_NEW.md` | **Neuerstellt** |
| `bpmn_validation_quickstart.md` | `processes_bpmn_validation_quickstart_v5_0.md` | Versioniert |
| `process_hierarchy.md` | `processes_process_hierarchy_v5_0_repaired.md` | **Repaired** |
| `refa_analytics.md` | `processes_refa_analytics_v5_0.md` | Versioniert |
| `mtm_codes.md` | `processes_mtm_codes_v5_0.md` | Versioniert |

---

### 1.4 Assets-Dateien

| Alt (v4.x) | Neu (v5.0) | Ã„nderungstyp |
|------------|------------|--------------|
| `bpmn_validation_report_template.md` | `assets_bpmn_validation_report_template_v5_0.md` | Versioniert |
| `query_patterns.md` | `assets_query_patterns_v5_0.md` | Versioniert |
| `scenario_report_template.md` | `assets_scenario_report_template_v5_0.md` | Versioniert |

---

## 2. CODE-UPDATES

### 2.1 Python/Jupyter Notebooks

**Vorher (v4.x):**
```python
# Lade Skill-Datei
with open('references/core/labels_207.md', 'r') as f:
    labels = parse_labels(f)

# BPMN-Validierung importieren
from bpmn_validation import validate_cc09_sequence
```

**Nachher (v5.0):**
```python
# Lade Skill-Datei (Dateiname geÃ¤ndert!)
with open('references/core/core_labels_207_v5_0.md', 'r') as f:
    labels = parse_labels(f)

# BPMN-Validierung importieren (Dateiname geÃ¤ndert!)
# Hinweis: _NEW-Suffix zeigt Neuerstellung an
from processes_bpmn_validation_v5_0_NEW import validate_cc09_sequence
```

---

### 2.2 Skill-Logik (SKILL.md)

**Vorher (v4.x):**
```python
if "Label" in query:
    view("references/core/labels_207.md")

if "Chunk" in query:
    view("references/auxiliary/chunking.md")
```

**Nachher (v5.0):**
```python
if "Label" in query:
    view("references/core/core_labels_207_v5_0.md")

if "Chunk" in query:
    # Hinweis: _repaired-Suffix zeigt Fehlerkorrektur
    view("references/auxiliary/auxiliary_chunking_v5_0_repaired.md")
```

---

### 2.3 Markdown-Referenzen

**Vorher (v4.x):**
```markdown
Siehe [chunking.md](../auxiliary/chunking.md) fÃ¼r Trigger-Details.

FÃ¼r Szenario-Definitionen: [ground_truth_central.md](../core/ground_truth_central.md)
```

**Nachher (v5.0):**
```markdown
Siehe [auxiliary_chunking_v5_0_repaired.md](../auxiliary/auxiliary_chunking_v5_0_repaired.md) fÃ¼r Trigger-Details.

FÃ¼r Szenario-Definitionen: [core_ground_truth_central_v5_0.md](../core/core_ground_truth_central_v5_0.md)
```

---

## 3. NEUE DEPENDENCIES

### 3.1 core_validation_rules_v5_0.md

**Neue zentrale Datei fÃ¼r Frame-Level Validierung**

**Wer braucht diese Datei?**
- Alle Implementierungen, die Label-Kombinationen validieren
- BPMN-Validierungs-Pipelines
- Ground Truth v3.0 Klassifikation

**Integration:**
```python
# Neu in v5.0: Zentrale Validierungsregeln
from core_validation_rules_v5_0 import (
    validate_master_slave_dependencies,
    validate_label_combinations,
    validate_multi_order_co_activation
)

# Vorher: Validierungslogik war Ã¼ber mehrere Dateien verteilt
```

**Inhalt:**
- Master-Slave-AbhÃ¤ngigkeiten (CC01 â†’ CC02-CC05)
- Label-Kombinationsregeln
- Spezielle Validierungen (Multi-Order, CL134)
- BPMN-Prozess-Mappings

---

### 3.2 Referenzen auf neue Datei

**Folgende Dateien referenzieren validation_rules:**
- `core_ground_truth_central_v5_0.md` (Szenario-Klassifikation)
- `processes_bpmn_validation_v5_0_NEW.md` (Frame-Validierung)
- `auxiliary_chunking_v5_0_repaired.md` (Trigger-Validierung)

---

## 4. BREAKING CHANGES

### 4.1 Dateinamen-Suffixe

**Problem:** v4.x verwendete inkonsistente Versionsnummerierung

```
# v4.x (FALSCH):
chunking_v5.0.md    âŒ (Punkt statt Unterstrich)
labels_207_v5.0.md  âŒ

# v5.0 (RICHTIG):
auxiliary_chunking_v5_0_repaired.md  âœ…
core_labels_207_v5_0.md              âœ…
```

**Migration:**
- Alle Referenzen mÃ¼ssen `_v5_0` statt `_v5.0` verwenden
- Automatische Suche & Ersetzen: `_v5\.0\.md` â†’ `_v5_0.md`

---

### 4.2 Spezielle Suffixe

**`_repaired`:** Datei hatte Fehler (Encoding, Format), jetzt behoben
- `auxiliary_chunking_v5_0_repaired.md`
- `processes_process_hierarchy_v5_0_repaired.md`

**`_NEW`:** Datei wurde vollstÃ¤ndig neu erstellt (>50% Ã„nderungen)
- `processes_bpmn_validation_v5_0_NEW.md`

**Warum wichtig?**
- Alte Versionen (`chunking.md`, `bpmn_validation.md`) sind **deprecated**
- Code muss auf neue Dateinamen verweisen

---

### 4.3 Deprecated Dateien

**NICHT MEHR VERWENDEN:**
- `chunking.md` â†’ Use `auxiliary_chunking_v5_0_repaired.md`
- `bpmn_validation.md` â†’ Use `processes_bpmn_validation_v5_0_NEW.md`
- `process_hierarchy.md` â†’ Use `processes_process_hierarchy_v5_0_repaired.md`
- `ground_truth_central.md` â†’ Use `core_ground_truth_central_v5_0.md`
- Alle Dateien OHNE `_v5_0`-Suffix

---

## 5. VALIDIERUNG NACH MIGRATION

### 5.1 Checkliste

```
âœ… Alle Code-Referenzen auf neue Dateinamen aktualisiert
âœ… core_validation_rules_v5_0.md integriert
âœ… Deprecated Dateien aus Repository entfernt
âœ… Markdown-Links in Dokumentation aktualisiert
âœ… Tests laufen erfolgreich mit v5.0-Dateien
âœ… SKILL.md verweist auf v5.0-Versionen
```

---

### 5.2 Automatische Validierung

**Python-Script zur ÃœberprÃ¼fung:**
```python
import os
import re

def validate_references(directory):
    """
    PrÃ¼ft, ob alle Datei-Referenzen auf v5_0-Versionen verweisen.
    """
    issues = []
    
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.md') or file.endswith('.py'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r') as f:
                    content = f.read()
                    
                    # Suche nach deprecated Referenzen
                    old_refs = re.findall(r'(chunking|bpmn_validation|process_hierarchy)\.md', content)
                    if old_refs:
                        issues.append(f"{file}: Deprecated references found: {set(old_refs)}")
                    
                    # Suche nach v5.0 statt v5_0
                    wrong_version = re.findall(r'_v5\.0\.md', content)
                    if wrong_version:
                        issues.append(f"{file}: Incorrect version format (v5.0 instead of v5_0)")
    
    return issues

# Validierung durchfÃ¼hren
issues = validate_references('/path/to/project')
if issues:
    print("âš ï¸ Migration incomplete:")
    for issue in issues:
        print(f"  - {issue}")
else:
    print("âœ… Migration successful! All references updated.")
```

---

## 6. HÃ„UFIGE PROBLEME

### Problem 1: "File not found: chunking.md"

**Ursache:** Code verweist noch auf alten Dateinamen

**LÃ¶sung:**
```python
# FALSCH:
with open('chunking.md', 'r') as f:

# RICHTIG:
with open('auxiliary_chunking_v5_0_repaired.md', 'r') as f:
```

---

### Problem 2: "Import error: bpmn_validation"

**Ursache:** Import-Statement verweist auf alte Datei

**LÃ¶sung:**
```python
# FALSCH:
from bpmn_validation import validate_cc09_sequence

# RICHTIG:
from processes_bpmn_validation_v5_0_NEW import validate_cc09_sequence
```

---

### Problem 3: "Missing dependency: validation_rules"

**Ursache:** Neue Datei `core_validation_rules_v5_0.md` nicht integriert

**LÃ¶sung:**
1. Datei aus v5.0-Release herunterladen
2. In Projekt einfÃ¼gen: `references/core/core_validation_rules_v5_0.md`
3. Importieren wie in Abschnitt 3.1 beschrieben

---

## 7. ROLLBACK-PLAN

**Falls Migration fehlschlÃ¤gt:**

### Schritt 1: Deprecated Dateien wiederherstellen
```bash
# Alte Dateien aus Backup wiederherstellen
git checkout v4.5 -- references/
```

### Schritt 2: Code auf v4.x-Referenzen zurÃ¼cksetzen
```bash
# Alle v5_0-Referenzen rÃ¼ckgÃ¤ngig machen
find . -name "*.py" -exec sed -i 's/_v5_0\.md/.md/g' {} +
```

### Schritt 3: Tests erneut durchfÃ¼hren
```bash
pytest tests/ --verbose
```

**Hinweis:** v4.x und v5.0 sind **NICHT** parallel verwendbar. WÃ¤hlen Sie eine Version.

---

## 8. SUPPORT & WEITERE RESSOURCEN

### Dokumentation
- **CHANGELOG_v5_0.md** â€” VollstÃ¤ndige Ã„nderungshistorie
- **STRUCTURE_v5_0.md** â€” Dateistruktur-Ãœbersicht
- **phase4_konsolidierungsplan_v5_0.md** â€” Detaillierte Konsolidierungsanalyse

### HÃ¤ufige Fragen
**Q: Muss ich alle 18 Dateien ersetzen?**  
A: Nein, nur die Dateien, die Sie tatsÃ¤chlich verwenden. Aber alle Referenzen mÃ¼ssen aktualisiert werden.

**Q: Was ist der Unterschied zwischen _repaired und _NEW?**  
A: `_repaired` = Fehlerkorrektur (Encoding, Format). `_NEW` = VollstÃ¤ndige Neuerstellung (>50% geÃ¤ndert).

**Q: Sind v4.x-Daten mit v5.0 kompatibel?**  
A: Ja! v5.0 ist rÃ¼ckwÃ¤rtskompatibel mit v4.x-**Daten** (CSV, Rohdaten). Nur die **Skill-Dateien** mÃ¼ssen aktualisiert werden.

---

## 9. TIMELINE & PLANUNG

### Empfohlener Migrationsplan

**Woche 1: Vorbereitung**
- Backup erstellen
- Neue v5.0-Dateien herunterladen
- Validierungs-Script testen

**Woche 2: Migration**
- Code-Referenzen aktualisieren (Abschnitt 2)
- Deprecated Dateien entfernen
- Tests durchfÃ¼hren

**Woche 3: Validierung**
- Automatische Validierung (Abschnitt 5.2)
- Manuelle Stichproben
- Dokumentation aktualisieren

**GeschÃ¤tzter Aufwand:**
- **Klein** (1-5 Dateien): 2-4 Stunden
- **Mittel** (6-15 Dateien): 1-2 Tage
- **GroÃŸ** (>15 Dateien): 3-5 Tage

---

## 10. ZUSAMMENFASSUNG

**Wichtigste Ã„nderungen:**
1. âœ… Alle Dateinamen haben `_v5_0`-Suffix
2. âœ… Neue Datei: `core_validation_rules_v5_0.md`
3. âœ… Spezielle Suffixe: `_repaired`, `_NEW`
4. âœ… Deprecated Dateien nicht mehr verwenden

**Migrationsaufwand: NIEDRIG**
- HauptsÃ¤chlich Dateinamen-Updates
- Keine Ã„nderungen an Datenformaten oder Algorithmen
- v5.0 ist rÃ¼ckwÃ¤rtskompatibel mit v4.x-Daten

**Vorteile nach Migration:**
- âœ… Konsistente Versionierung
- âœ… Behobene Encoding-Fehler
- âœ… Zentrale Validierungsregeln
- âœ… 100% ReferenzintegritÃ¤t

---

**Version:** 1.0  
**Erstellt:** 05.02.2026  
**Zielgruppe:** Entwickler, Forscher, DaRa-Nutzer  
**Status:** Production-Ready
