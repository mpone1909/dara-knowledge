# DaRa Dataset Expert Skill – Version 4.0

**Konsolidierter Claude-Skill für Warehouse-Prozessanalyse mit optimierter Dokumentationsstruktur**

[![Version](https://img.shields.io/badge/version-4.0-blue.svg)](https://github.com/mpone1909/dara-knowledge)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Claude](https://img.shields.io/badge/Claude-Sonnet%204.5-orange.svg)](https://claude.ai)

---

## 📦 Überblick

Der **DaRa Dataset Expert Skill** ermöglicht Claude die automatisierte Analyse von Warehouse-Kommissionierungsprozessen basierend auf dem DaRa-Datensatz. Version 4.0 optimiert die Wissensbasis durch **Konsolidierung redundanter Inhalte** und **verbesserte Querverweise**.

**Kernfähigkeiten:**
- 🎯 **8 Szenarien** (S1-S8) + "Other"-Restkategorie
- 🏷️ **207 Labels** über 12 Klassenkategorien (CC01-CC12)
- 📦 **74 Artikel** mit Storage Compartment IDs (Orders 2904/2905/2906)
- 🏭 **Lagerlayout vollständig** (12,76m × 17,35m, 8 Regalkomplexe, 5 Gassen)
- 🤖 **Frame-Level-Algorithmus** mit 30 erkennungsrelevanten Labels
- ⚖️ **REFA/MTM-Zeitarten-Analytik** für arbeitswissenschaftliche Studien
- ✅ **Validierungslogik** mit 10+ formalen Regeln
- 📝 **Konsolidierte Dokumentation** ohne inhaltliche Redundanzen

---

## ✨ Neue Features v4.0 (Januar 2026)

### 📚 Optimierte Dokumentationsstruktur

**Konsolidierte Kerndokumente:**
- `dataset_core.md` – Zentrale Datensatz-Beschreibung (Probanden, Sessions, Szenarien, BPMN)
- `data_structure.md` – Frame-Struktur, Session-Organisation, Synchronisation
- `warehouse_physical.md` – Komplettes Lagerlayout mit allen Details
- `chunking.md` – Vollständige Chunking-Logik mit Trigger T1-T10
- `semantics.md` – Semantische Grundlagen und Abhängigkeiten

**Verbesserte Navigation:**
- Klare Querverweise zwischen Dateien statt Duplikation
- Präzise Verweis-Pfade (z.B. `warehouse_physical.md#section`)
- Reduzierte Dateigröße durch Vermeidung von Wiederholungen

**Keine inhaltlichen Verluste:**
- Alle Informationen aus v3.0 bleiben verfügbar
- Bessere Auffindbarkeit durch optimierte Struktur
- Konsistente Terminologie über alle Dokumente

---

## 📂 Verzeichnisstruktur (v4.0)

```
dara-dataset-expert/
├── SKILL.md                                    # Hauptdokumentation & Orchestrierung (12 KB)
├── README.md                                   # Diese Datei
├── knowledge/
│   ├── core/                                   # Zentrale Erkennungslogik
│   │   ├── ground_truth_central.md             # Ground Truth Matrix, Szenario-Profile (25 KB)
│   │   ├── labels_207.md                       # Alle 207 Labels + Systematik (24 KB)
│   │   ├── validation_rules.md                 # Validierungsregeln (20 KB)
│   │   ├── articles_inventory.md               # 74 Artikel mit Lagerorten (12 KB)
│   │   └── category_activation_matrix.md       # Label-Aktivitätsanalyse (17 KB)
│   ├── processes/                              # Prozess-Hierarchie + MTM-Codes
│   │   ├── process_hierarchy.md                # BPMN-Logik CC08-CC10 (17 KB)
│   │   ├── refa_analytics.md                   # REFA-Zeitarten & Formeln (10 KB)
│   │   └── mtm_codes.md                        # MTM-1 Codes (R, G, M, P, RL, B, W) (8 KB)
│   └── auxiliary/                              # 🆕 Konsolidierte Basisdokumente
│       ├── dataset_core.md                     # 🆕 Zentrale Datensatz-Beschreibung (15 KB)
│       ├── data_structure.md                   # 🆕 Frame-Struktur & Sessions (10 KB)
│       ├── warehouse_physical.md               # 🆕 Lagerlayout komplett (20 KB)
│       ├── chunking.md                         # 🆕 Chunking-Logik vollständig (18 KB)
│       └── semantics.md                        # 🆕 Semantische Grundlagen (19 KB)
└── templates/
    ├── query_patterns.md                       # Fragetypen & Best Practices (14 KB)
    └── scenario_report_template.md             # Szenario-Bericht-Format (5 KB)
```

**Gesamt:** 17 Dateien, ~280 KB (optimiert von ~290 KB in v3.0)  
**Neu in v4.0:** Konsolidierte auxiliary/-Dateien ersetzen fragmentierte Dokumentation

---

## 🔄 Änderungen v3.0 → v4.0

### Strukturelle Optimierungen

**Vorher (v3.0):**
- Fragmentierte Information über mehrere Dateien
- Redundante Abschnitte (z.B. Probanden-Info in 3 Dateien)
- Inkonsistente Detailtiefe

**Nachher (v4.0):**
- **dataset_core.md** = Eine zentrale Quelle für Probanden, Sessions, Szenarien
- **warehouse_physical.md** = Komplettes Lagerlayout (statt verstreut)
- **data_structure.md** = Alle Frame-Details an einem Ort
- **Klare Verweise** statt Duplikation (z.B. "Siehe warehouse_physical.md#gassen")

### Inhaltliche Verbesserungen

✅ **Keine Informationsverluste** – Alle Inhalte aus v3.0 enthalten  
✅ **Bessere Auffindbarkeit** – Präzise Querverweise  
✅ **Konsistente Terminologie** – Einheitliche Begriffe über alle Dateien  
✅ **Aktualisierte Metadaten** – Stand 19.01.2026

---

## 🚀 Installation

### Option 1: Claude.ai Skill-Upload (Empfohlen)

1. In Claude.ai → **Settings → Profile → Skills**
2. **"Add Skill"** → ZIP-Datei `dara-dataset-expert_v4.0.zip` hochladen
3. Skill aktivieren

### Option 2: Manuelles Einfügen (Lokal)

1. **ZIP-Archiv entpacken**
2. **Verzeichnisstruktur beibehalten:**
   ```
   dara-dataset-expert/
   ├── SKILL.md
   ├── README.md
   ├── knowledge/
   │   ├── core/
   │   ├── processes/
   │   └── auxiliary/  ← Neue konsolidierte Dateien
   └── templates/
   ```
3. **Skill in Claude.ai hochladen** (ZIP neu erstellen falls nötig)

---

## 📖 Schnellstart

### Beispiel-Queries (v4.0)

```python
# Datensatz-Grundlagen
"Wie viele Probanden gibt es und welche Erfahrung haben sie?"
→ dataset_core.md: 18 Probanden, Tabelle 4 mit Erfahrungslevels

"Wie sind die Frames synchronisiert?"
→ data_structure.md: 30 fps, alle 12 CC-Dateien identische Zeilenzahl

# Lagerlayout
"Wo ist der Artikel 'Palmenerde' gelagert?"
→ warehouse_physical.md: R7.3.1.A (Aisle 4, Regalkomplex 7, Ebene 1 = Bodenebene)

"Welche funktionalen Bereiche gibt es im Picking Lab?"
→ warehouse_physical.md: 9 Hauptbereiche (Office, Cart Area, Base, etc.)

# Chunking & Semantik
"Was löst Trigger T4 aus?"
→ chunking.md: Änderung in CC04 (Left Hand) – Position, Movement, Object oder Tool

"Welche semantischen Abhängigkeiten gibt es zwischen CC01 und CC03?"
→ semantics.md: Walking → Gait Cycle + No/Slightly Bending

# REFA & MTM
"Was ist MTM-Code B (Bend) und wie viele TMU hat er?"
→ mtm_codes.md: Beugen, 29,0 TMU = 1,04 Sekunden, DaRa-Labels: CL129 + CL025

"Welche DaRa-Labels entsprechen der Haupttätigkeit (t_MH)?"
→ refa_analytics.md: CC09: CL116, CL120 + CC10: CL149, CL150, CL146

# Szenarioerkennung
"Wie erkenne ich Szenario S2?"
→ ground_truth_central.md: PDT (CL107) ist 100% eindeutig
```

---

## 🎓 Anwendungsfälle

### 1. Arbeitswissenschaft & REFA

**Use Case:** Berechne Kommissionierzeit für Order 2904
```
1. Lade dataset_core.md für BPMN-Prozesslogik
2. Analysiere Artikel-Gewichte in articles_inventory.md
3. Berechne Wegstrecke anhand warehouse_physical.md (Gassen 1-5)
4. Summiere MTM-Codes aus mtm_codes.md (R + G + M + P + RL + B + W)
5. Addiere Erholungszeit für Large [L]-Artikel (refa_analytics.md)
```

### 2. Datensatz-Validierung

**Use Case:** Prüfe Konsistenz von CSV-Annotationen
```
1. Frame-by-Frame-Analyse (data_structure.md)
2. Master-Slave-Abhängigkeiten prüfen (validation_rules.md)
3. Szenario-Erkennung (ground_truth_central.md)
4. Error-Flag-Detection (CL135 in category_activation_matrix.md)
5. Validierungsreport generieren
```

### 3. Prozess-Optimierung

**Use Case:** Optimiere Kommissionier-Wegstrecke
```
1. Analysiere Artikel-Verteilung (warehouse_physical.md)
2. Identifiziere Hotspots (schwere Artikel in Aisle 4)
3. Simuliere alternative Order-Abarbeitung (dataset_core.md: BPMN)
4. Berechne Zeit-Ersparnis (mtm_codes.md + refa_analytics.md)
```

---

## 🔧 Technische Details

### Datensatz-Umfang (unverändert zu v3.0)

| Komponente | Anzahl | Beschreibung |
|------------|--------|--------------|
| Probanden | 18 | S01-S18 (14 männlich, 4 weiblich) |
| Sessions | 6 | 3 parallele Subjekte pro Session |
| Szenarien | 8 | S1-S8 (Retrieval + Storage) |
| Orders | 3 | 2904 (CL100), 2905 (CL101), 2906 (CL102) |
| Artikel | 74 | Mit Storage Compartment IDs |
| Labels | 207 | CC01-CC12 (12 Kategorien) |
| Regalkomplexe | 8 | R1-R8 |
| Gassen | 5 | Aisle 1-5 |
| Funktionsbereiche | 9 | Office, Cart Area, Base, etc. |
| MTM-Codes | 7 | R, G, M, P, RL, B, W |

### Dokumentations-Struktur (optimiert)

| Datei | Zweck | Größe | Status |
|-------|-------|-------|--------|
| `SKILL.md` | Orchestrierung + Navigation | 12 KB | Optimiert |
| `dataset_core.md` | ✨ Zentrale Datensatz-Info | 15 KB | ✨ Konsolidiert |
| `data_structure.md` | ✨ Frame-Struktur komplett | 10 KB | ✨ Konsolidiert |
| `warehouse_physical.md` | ✨ Lagerlayout vollständig | 20 KB | ✨ Konsolidiert |
| `chunking.md` | ✨ Chunking-Logik T1-T10 | 18 KB | ✨ Konsolidiert |
| `semantics.md` | ✨ Semantische Grundlagen | 19 KB | ✨ Konsolidiert |
| `ground_truth_central.md` | Szenarien S1-S8, Matrix | 25 KB | Unverändert |
| `labels_207.md` | Alle 207 Labels | 24 KB | Unverändert |
| `validation_rules.md` | Validierungslogik | 20 KB | Unverändert |
| `articles_inventory.md` | 74 Artikel | 12 KB | Unverändert |
| `category_activation_matrix.md` | Label-Aktivität | 17 KB | Unverändert |
| `process_hierarchy.md` | BPMN-Logik | 17 KB | Unverändert |
| `refa_analytics.md` | REFA-Zeitarten | 10 KB | Unverändert |
| `mtm_codes.md` | MTM-1 Codes | 8 KB | Unverändert |

✨ = Neu konsolidiert in v4.0

---

## 📞 Support & Wartung

**Skill-Version:** 4.0  
**Datensatz-Stand:** 20.10.2025 (DaRa Dataset Description)  
**Letztes Update:** 19.01.2026  

**Wartung:** Bei Aktualisierungen der DaRa Dataset Description überarbeiten

**Autor:** DaRa Expert System  
**Lizenz:** MIT  

---

## 🙏 Credits

- **DaRa Dataset:** TU Dortmund (FLW) + Fraunhofer IML
- **Hauptforscher:** Friedrich Niemann (Doktorand FLW)
- **Publikation:** "DaRa Dataset Description" (Stand 20.10.2025)
- **PDF-Quelle:** "Anatomisch-Biomechanische Bewegungsanalyse der manuellen Kommissionierung"
- **Lagerlayout-Quelle:** Fraunhofer IML Picking Lab Dokumentation

---

**Hinweis:** Dieser Skill ist für wissenschaftliche Forschungszwecke entwickelt und basiert ausschließlich auf verifizierten Quellen (DaRa Dataset Description + Lagerlayout-Dokumentation).
