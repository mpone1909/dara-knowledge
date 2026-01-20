# Changelog Version 4.0 (19.01.2026)

## Hauptänderungen

### 📚 Strukturelle Konsolidierung (Breaking Change)

**Problem (v3.0):**
- Fragmentierte Information über multiple Dateien
- Redundante Inhalte (z.B. Probanden-Info in dataset_core.md, warehouse_layout.md und SKILL.md)
- Inkonsistente Detailtiefe
- Verstreute Lagerlayout-Informationen

**Lösung (v4.0):**
- **Konsolidierte Auxiliary-Dateien** als zentrale Referenzen
- **Klare Verweise** statt Duplikation
- **Optimierte Dateigröße** (290 KB → 280 KB)
- **Keine Informationsverluste**

---

## Neue Dateien (auxiliary/)

### 1. dataset_core.md (15 KB)

**Zentrale Datensatz-Beschreibung:**
- Zweck und Kontext des Datensatzes
- ~~Physische Umgebung~~ → Verweis auf `warehouse_physical.md`
- **Probanden-Tabelle 4** (18 Subjekte mit Erfahrungslevels)
- Session-Definitionen (6 Sessions à 3 Subjekte)
- BPMN-Prozesslogik (Retrieval + Storage Pfade)
- Szenarien S1-S8 + "Other"-Kategorie

**Ersetzt:**
- Teile der alten dataset_core.md
- Redundante Probanden-Info aus mehreren Dateien
- Szenario-Übersichten ohne Ground Truth Details

---

### 2. data_structure.md (10 KB)

**Frame-Struktur & Session-Organisation:**
- Session-Struktur (3 parallele Subjekte)
- Subjekte innerhalb Sessions
- Szenarien innerhalb Sessions
- **Klassendateien-Struktur** (12 CC-Dateien à 207 Labels)
- **Frame-Synchronisation** (29,97 fps → 30 fps)
- Frame-to-Time Mapping
- Datensatzumfang (216 Klassendateien, ~1,94M Frames)

**Ersetzt:**
- Fragmentierte Frame-Erklärungen
- Verstreute Session-Details

---

### 3. warehouse_physical.md (20 KB)

**Komplettes Lagerlayout:**
- **OMNI Warehouse Übersicht** (12,76m × 17,35m)
- **9 Hauptbereiche** mit DaRa-Labels (Office, Cart Area, Base, etc.)
- **5 Gassen (Aisles)** mit 8 Regalkomplexen (R1-R8)
- **Gassen-Positionen** (Front/Back)
- **Cross Aisle Path** (4 Abschnitte)
- **Regalsystem & Compartments** (Standard 95,5 × 39,5 × 21 cm)
- **Storage Compartment ID Logik** (R<Komplex>.<Regal>.<Ebene>.<Fach>)
- **Lagereinheiten** (KLT, Sichtlagerkästen, Kartons, Kleiderstangen)
- **Packtisch & Kommissionierwagen**
- **Return-Aisle-Strategie**
- **Zonenlogik & Transition (CL181)**

**Ersetzt:**
- warehouse_layout.md (v3.0, 5,5 KB → jetzt 20 KB komplett)
- Verstreute Layout-Info in SKILL.md

---

### 4. chunking.md (18 KB)

**Chunking-Logik vollständig:**
- Definition Chunking-Einheit
- Struktur eines Chunks (Start/End-Frame, Dauer, Zustandsbeschreibung)
- **Trigger T1-T10** (vollständig dokumentiert)
- Single-Label vs. Multi-Label Klassen
- Beziehung zu Szenarien & Prozessen
- Chunk-Eigenschaften (Stabilität, Vollständigkeit, Konsistenz)

**Ersetzt:**
- Fragmentierte Chunking-Erklärungen in altem auxiliary/

---

### 5. semantics.md (19 KB)

**Semantische Grundlagen:**
- Semantische Grunddefinition (Frame = atomare Einheit)
- **Semantische Struktur CC01-CC12**
  - Motorische Semantik (CC01-CC05)
  - Kontextuelle Semantik (CC06-CC12)
- **Semantische Abhängigkeiten**
  - Bewegungsabhängigkeiten (CC01-CC03)
  - Handinteraktionsabhängigkeiten (CC04-CC05)
  - Kontextabhängigkeiten (CC06-CC12)
  - Prozesssemantik (CC08-CC10)
- **Master-Slave-Beziehungen**
- **Hierarchische Abhängigkeiten**
- **Konsistenzregeln**

**Ersetzt:**
- Verstreute Semantik-Erklärungen
- Fragmentierte Abhängigkeits-Dokumentation

---

## Entfernte Dateien

### ❌ knowledge/core/warehouse_layout.md (5,5 KB)

**Grund:** Ersetzt durch `warehouse_physical.md` (20 KB) mit 4x mehr Details

**Migrationspfad:**
- Alle Inhalte aus warehouse_layout.md sind in warehouse_physical.md enthalten
- Zusätzlich: 9 Hauptbereiche, Cross Aisle Path Details, Zonenlogik

---

## Aktualisierte Dateien

### SKILL.md

**Änderungen:**
- Version 4.0 Header
- Aktualisierte Navigationslogik (neue auxiliary/-Dateien)
- Optimierte Verweise (z.B. `warehouse_physical.md` statt `warehouse_layout.md`)
- Changelog-Eintrag v4.0
- Metadaten-Update (19.01.2026)

---

### README.md

**Änderungen:**
- Version 4.0 Header
- Neue Features v4.0 Sektion
- Verzeichnisstruktur aktualisiert (5 neue auxiliary/-Dateien)
- Änderungen v3.0 → v4.0 dokumentiert
- Dokumentations-Struktur-Tabelle (Status: Konsolidiert vs. Unverändert)
- Beispiel-Queries mit neuen Verweisen

---

## Unveränderte Dateien (weiterhin vorhanden)

### knowledge/core/
- ✅ ground_truth_central.md (25 KB)
- ✅ labels_207.md (24 KB)
- ✅ validation_rules.md (20 KB)
- ✅ articles_inventory.md (12 KB)
- ✅ category_activation_matrix.md (17 KB)

### knowledge/processes/
- ✅ process_hierarchy.md (17 KB)
- ✅ refa_analytics.md (10 KB)
- ✅ mtm_codes.md (8 KB)

### templates/
- ✅ query_patterns.md (14 KB)
- ✅ scenario_report_template.md (5 KB)

---

## Verbesserungen in v4.0

### 1. Reduzierte Redundanz

**Vorher:**
- Probanden-Info in 3 Dateien (dataset_core.md, SKILL.md, warehouse_layout.md)
- Lagerlayout fragmentiert (SKILL.md, warehouse_layout.md, articles_inventory.md)

**Nachher:**
- Probanden-Info nur in dataset_core.md
- Lagerlayout vollständig in warehouse_physical.md
- Klare Verweise statt Duplikation

---

### 2. Verbesserte Navigation

**Vorher:**
- Unklare Verweis-Pfade
- Inkonsistente Dateinamen

**Nachher:**
- Präzise Querverweise (z.B. `warehouse_physical.md#gassen`)
- Konsistente Namenskonvention (dataset_core.md, data_structure.md)

---

### 3. Vollständigkeit ohne Fragmentierung

**Vorher:**
- Chunking-Trigger T1-T10 verstreut
- Semantik-Abhängigkeiten implizit

**Nachher:**
- chunking.md: Alle Trigger an einem Ort
- semantics.md: Explizite Abhängigkeiten dokumentiert

---

## Migration v3.0 → v4.0

### Für Nutzer

**Keine Aktion erforderlich:**
- Alle Queries funktionieren weiterhin
- Keine Breaking Changes in API/Skill-Interface

**Empfohlen:**
- Neue auxiliary/-Dateien nutzen für präzisere Antworten
- Verweis auf `warehouse_physical.md` statt `warehouse_layout.md`

---

### Für Entwickler

**Dateinamen-Mapping:**
```
v3.0 → v4.0
knowledge/auxiliary/dataset_core.md → knowledge/auxiliary/dataset_core.md (aktualisiert)
knowledge/auxiliary/data_structure.md → knowledge/auxiliary/data_structure.md (aktualisiert)
knowledge/core/warehouse_layout.md → knowledge/auxiliary/warehouse_physical.md (ersetzt + erweitert)
[neu] → knowledge/auxiliary/chunking.md
[neu] → knowledge/auxiliary/semantics.md
```

---

## Dateigrößen-Vergleich

| Datei | v3.0 | v4.0 | Änderung |
|-------|------|------|----------|
| SKILL.md | 15 KB | 12 KB | -20% (Redundanz entfernt) |
| dataset_core.md | 12 KB | 15 KB | +25% (konsolidiert) |
| warehouse_layout.md | 5,5 KB | - | Ersetzt |
| warehouse_physical.md | - | 20 KB | Neu (4x Details) |
| chunking.md | - | 18 KB | Neu |
| semantics.md | - | 19 KB | Neu |
| **Gesamt** | **~290 KB** | **~280 KB** | **-3,4%** |

---

## Keine Breaking Changes

✅ Alle Labels (CL001-CL207) unverändert  
✅ Alle Kategorien (CC01-CC12) unverändert  
✅ Alle Szenarien (S1-S8) unverändert  
✅ Alle Artikel (74 Stück) unverändert  
✅ Alle REFA/MTM-Codes unverändert  
✅ Skill-API unverändert  

---

## Zusammenfassung

Version 4.0 ist eine **strukturelle Optimierung** ohne inhaltliche Verluste:

- ✅ **Konsolidierte Dokumentation** statt Fragmentierung
- ✅ **Klare Verweise** statt Redundanz
- ✅ **Vollständige Abdeckung** (warehouse_physical.md 4x Details)
- ✅ **Optimierte Dateigröße** (-3,4%)
- ✅ **Keine Breaking Changes**

**Empfehlung:** Upgrade auf v4.0 für bessere Navigation und präzisere Antworten.

---

**Erstellt:** 19.01.2026  
**Skill-Version:** 4.0  
**Datensatz-Stand:** 20.10.2025 (unverändert)
