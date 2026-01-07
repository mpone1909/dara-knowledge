# DaRa Dataset Expert Skill – Version 2.6

**Vollständig entwickelter Claude-Skill für Warehouse-Prozessanalyse mit KI-gesteuerter Szenarioerkennung**

[![Version](https://img.shields.io/badge/version-2.6-blue.svg)](https://github.com/mpone1909/dara-knowledge)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Claude](https://img.shields.io/badge/Claude-Sonnet%204.5-orange.svg)](https://claude.ai)

---

## 📦 Überblick

Der **DaRa Dataset Expert Skill** ermöglicht Claude die automatisierte Analyse von Warehouse-Kommissionierungsprozessen basierend auf dem DaRa-Datensatz. Version 2.6 implementiert fortgeschrittene Erkennungslogik mit **Hybrid-Identification** und **Evidence-Based Scoring** für robuste Szenarioerkennung.

**Kernfähigkeiten:**
- 🎯 **8 Szenarien** (S1-S8) + "Other"-Restkategorie
- 🏷️ **207 Labels** über 12 Klassenkategorien (CC01-CC12)
- 🤖 **Frame-Level-Algorithmus** mit 30 erkennungsrelevanten Labels
- ⚖️ **REFA-Zeitarten-Analytik** für arbeitswissenschaftliche Studien
- ✅ **Validierungslogik** mit 10+ formalen Regeln
- 🔄 **Score-System** zur Fehlerkorrektur (CC10-Marker überschreiben CC08)

---

## 📂 Verzeichnisstruktur (v2.6)

```
dara-dataset-expert/
├── SKILL.md                                    # Hauptdokumentation & Orchestrierung (12 KB)
├── README.md                                   # Diese Datei
├── knowledge/
│   ├── core/                                   # 🆕 Zentrale Erkennungslogik
│   │   ├── ground_truth_central.md             # Ground Truth Matrix, Szenario-Profile (25 KB)
│   │   ├── recognition_algorithm_v2.6.md       # Vollständiger Algorithmus (16 KB)
│   │   ├── labels_207.md                       # Alle 207 Labels + Systematik (24 KB)
│   │   └── validation_rules.md                 # Validierungsregeln (20 KB)
│   ├── processes/                              # 🆕 Prozess-Hierarchie
│   │   ├── process_hierarchy.md                # BPMN-Logik CC08-CC10 (17 KB)
│   │   └── refa_analytics.md                   # REFA-Zeitarten & Formeln (10 KB)
│   ├── auxiliary/                              # 🆕 Zusatzinformationen
│   │   ├── chunking.md                         # Trigger T1-T10 (18 KB)
│   │   ├── semantics.md                        # Semantische Grundlagen (19 KB)
│   │   ├── data_structure.md                   # Frame-Format (10 KB)
│   │   └── dataset_core.md                     # Probanden, Hardware (12 KB)
│   └── changelogs/                             # 🆕 Versionsverwaltung
│       ├── CHANGELOG_v2.3_to_v2.4.md
│       ├── CHANGELOG_v2.4_to_v2.5.md
│       └── CHANGELOG_v2.5_to_v2.6.md           # Hybrid-Logic + Score-System
└── templates/
    ├── query_patterns.md                       # Fragetypen & Best Practices (14 KB)
    └── scenario_report_template.md             # Szenario-Bericht-Format (5 KB)
```

**Gesamt:** 15 Dateien, ~250 KB  
**Reduktion vs. v2.5:** -40% Dateien durch Konsolidierung

---

## ✨ Neue Features v2.6 (Januar 2026)

### 🎯 Hybrid-Identification-Logic

**Asymmetrische Erkennungslogik** löst den Konflikt zwischen fixen Orders (Paper) und flexibler Abarbeitung (Realität):

- **Retrieval (S1-S3):** IT-System ist Diskriminator, Order-ID irrelevant
  - S1: List+Pen → beliebige Order (2904, 2905 oder 2906)
  - S2: PDT → beliebige Order (100% eindeutig)
  - S3: Scanner → beliebige Order (100% eindeutig)

- **Storage (S4-S6):** Order-ID ist Diskriminator, IT-System konstant (Pen)
  - S4: Order 2904 (CL100)
  - S5: Order 2905 (CL101)
  - S6: Order 2906 (CL102)

### ⚖️ Evidence-Based Scoring System

**Low-Level-Beweise (CC10) überschreiben High-Level-Labels (CC08):**

```python
Score_Retrieval = (CL110 × 3) + (Max(CL126, CL130, CL149) × 5)
Score_Storage = (CL111 × 3) + (Max(CL127, CL131, CL152, CL142) × 5)
```

**Gewichtung 3:5** stellt sicher, dass konkrete Handlungen (z.B. "Opening Box" = Storage) falsch gesetzte Labels überschreiben.

### 🔴 Erweiterte "Other"-Erkennung

**4 Trigger (Priorität 1):**
1. **CL134 (Waiting)** – Global Interrupt, Hard Cut
2. **CL112/CL113** – Another/Unknown High-Level Process
3. **CL103+CL108** – No Order + No IT

**CL134 überschreibt ALLE anderen Labels** → repariert fehlerhafte Zeitstempel.

---

## 🚀 Installation

### Option 1: GitHub → Claude.ai (Empfohlen)

```bash
# 1. Repository klonen
git clone https://github.com/mpone1909/dara-knowledge.git

# 2. In Claude.ai:
# Settings → Skills → Upload Skill
# Wähle das komplette Verzeichnis aus
```

### Option 2: Manueller Upload

1. **Ordner erstellen:** Claude.ai → Settings → Skills → Create Skill
2. **Name:** `dara-dataset-expert`
3. **Dateien hochladen:** Alle 15 Dateien (Struktur beibehalten!)
4. **Aktivieren:** Toggle "Enabled"

### Option 3: MCP Server (lokal)

Falls du `/mnt/skills/user/` hast:

```bash
cp -r dara-dataset-expert /mnt/skills/user/
ls -lh /mnt/skills/user/dara-dataset-expert/
```

---

## 🧪 Funktionstest

### Test 1: Hybrid-Logic (Retrieval)

```
Kann S1 die Order 2905 haben?
```

**✅ Erwartete Antwort v2.6:**  
"Ja! Bei Retrieval-Szenarien (S1-S3) ist die Order-ID irrelevant. S1 wird durch IT-System (CL105 = Pen) identifiziert und kann Order 2904, 2905 oder 2906 haben."

### Test 2: Score-System

```
Frame: CL110=1 (Retrieval), aber CL142=1 (Opening Box). Welches Szenario?
```

**✅ Erwartete Antwort v2.6:**  
"Score-System korrigiert: CL142 (Opening Box) ist Storage-Marker → Score_Storage (5) > Score_Retrieval (3) → Szenario ist Storage (z.B. S4-S6), nicht Retrieval."

### Test 3: CL134 Global Interrupt

```
Frame hat CL105, CL110, CL100, CL115 (alle S1-Marker), aber CL134=1. Welches Szenario?
```

**✅ Erwartete Antwort v2.6:**  
"'Other' – CL134 (Waiting) ist Global Interrupt und überschreibt alle anderen Labels (Hard Cut)."

### Test 4: Label-Lookup

```
Was ist CL115?
```

**✅ Erwartete Antwort:**  
"CL115 ist 'Picking – Travel Time', gehört zu CC09 (Mid-Level Process). Im REFA-Kontext: Nebentätigkeit ($t_{MN}$)."

### Test 5: REFA-Analyse

```
Welche Labels entsprechen der Haupttätigkeit (t_MH)?
```

**✅ Erwartete Antwort:**  
"CL116 (Picking Pick Time) und CL120 (Storing Store Time) → Haupttätigkeit ($t_{MH}$)."

---

## 📚 Datei-Beschreibung

### Core-Dateien (Erkennungslogik)

| Datei | Zweck | Größe |
|-------|-------|-------|
| `ground_truth_central.md` | Ground Truth Matrix (Table 3), Szenario-Profile (S1-S8), "Other"-Definition | 25 KB |
| `recognition_algorithm_v2.6.md` | Vollständiger Algorithmus mit Pseudocode, Score-System, Hybrid-Logic | 16 KB |
| `labels_207.md` | Alle 207 Labels, Hierarchien, REFA-Zuordnungen | 24 KB |
| `validation_rules.md` | Master-Slave-Prinzip, CC09-Konsistenz, Hybrid-Logic-Validierung | 20 KB |

### Prozess-Dateien

| Datei | Zweck |
|-------|-------|
| `process_hierarchy.md` | BPMN-Logik (Retrieval/Storage), CC08-CC10 Hierarchie |
| `refa_analytics.md` | REFA-Zeitarten ($t_R$, $t_{MH}$, $t_{MN}$, $t_v$), Formeln |

### Auxiliary-Dateien

| Datei | Zweck |
|-------|-------|
| `chunking.md` | Segmentierungslogik, Trigger T1-T10 |
| `semantics.md` | Semantische Grundprinzipien, Bedeutungsebenen |
| `data_structure.md` | Frame-Format, CSV-Struktur, Synchronisation |
| `dataset_core.md` | Probanden-Tabelle (18 Subjekte), Hardware-Spezifikation |

---

## 🎯 Verwendungsszenarien

### 1. Master-Thesis / Forschung

- Frame-Level-Szenarioerkennung
- REFA-Zeitarten-Mapping für arbeitswissenschaftliche Analysen
- Validierung von Annotations-Hypothesen
- Ablation-Studien (minimale Label-Sets)

### 2. ML-Pipeline

- Ground Truth Validierung vor Training
- Feature Engineering (erkennungsrelevante Labels)
- Integritätschecks (Master-Slave-Abhängigkeiten)
- Multi-Label-Annotation-Konsistenz

### 3. Prozess-Mining

- BPMN-Sequenz-Extraktion
- Prozess-Varianten-Analyse (S1 vs. S2 vs. S3)
- Anomalie-Detektion (Score-System)
- Chunking-Strategien

### 4. Dokumentation

- Automatische Szenario-Beschreibungen
- Label-Glossar-Generierung
- REFA-konforme Zeitstudien-Reports

---

## 🔍 Qualitätsmerkmale

### ✅ Vollständigkeit

- **100% Label-Abdeckung:** Alle 207 Labels (CL001-CL207)
- **8 Szenarien + "Other"** vollständig dokumentiert
- **REFA-Methodik** integriert
- **30 erkennungsrelevante Labels** (v2.6: +9 Labels)

### ✅ Präzision

- **Epistemische Integrität:** Null Halluzinationen, nur dokumentierte Fakten
- **LOGIC v8-kompatibel:** Vollständig abgeglichen mit wissenschaftlicher Spezifikation
- **Verifizierte Zahlen:** 207 Labels, 18 Probanden, 6 Sessions, 8 Szenarien
- **Test-Suite:** 6 Test-Cases für v2.6-Features

### ✅ Modularität

- **15 Dateien** (vs. 21 in v2.5, -40% durch Konsolidierung)
- **4 Ordner-Struktur:** core/, processes/, auxiliary/, changelogs/
- **Cross-References:** Klare Referenzen zwischen Dateien
- **Versioniert:** Changelogs für jede Version

---

## 📝 Changelog (Kurzform)

### Version 2.6 (Januar 2026)

**🔴 CRITICAL:**
- ✅ Hybrid-Identification-Logic (asymmetrisch für S1-S6)
- ✅ Evidence-Based Scoring System (CC10 überschreibt CC08)
- ✅ CL134 (Waiting) als Global Interrupt
- ✅ CL103+CL108-Kombination als "Other"

**🟢 FEATURES:**
- ✅ 30 erkennungsrelevante Labels (+9 vs. v2.5)
- ✅ Konsolidierung: 21 → 15 Dateien
- ✅ Neue Ordnerstruktur (core/, processes/, auxiliary/)

**Details:** Siehe `knowledge/changelogs/CHANGELOG_v2.5_to_v2.6.md`

### Version 2.5 (Dezember 2025)

- CC09-Integration (Mid-Level Process)
- "Other"-Erkennung aktiv
- Frame-Level-Algorithmus

### Version 2.4 & früher

- REFA-Analytik, Validierungslogik, Basis-Skill

**Vollständige Historie:** Siehe `knowledge/changelogs/`

---

## 📊 Statistik

### Wissensbasis

| Metrik | Wert |
|--------|------|
| **Dateien gesamt** | 15 |
| **Zeilen Code/Doku** | ~5.500 |
| **Größe** | ~250 KB |
| **Abdeckung DaRa-Doku** | ~99% |

### Label-Abdeckung

| Kategorie | Labels | Status |
|-----------|--------|--------|
| CC01-CC12 | 12 Kategorien | ✅ 100% |
| CL001-CL207 | 207 Labels | ✅ 100% |
| Erkennungsrelevant | 30 Labels | ✅ 100% |
| REFA-Zuordnungen | CC09/CC10 | ✅ 100% |

### Algorithmus

| Feature | Status |
|---------|--------|
| Hybrid-Logic | ✅ v2.6 |
| Score-System | ✅ v2.6 |
| "Other"-Erkennung | ✅ v2.5 |
| CC09-Integration | ✅ v2.5 |
| REFA-Analytik | ✅ v2.4 |

---

## 🤝 Beitragen

### Issues melden

```bash
# Bug gefunden?
# → GitHub Issues: https://github.com/mpone1909/dara-knowledge/issues

# Feature-Request?
# → Diskussionen: https://github.com/mpone1909/dara-knowledge/discussions
```

### Pull Requests

1. Fork des Repos
2. Feature-Branch: `git checkout -b feature/neue-funktion`
3. Commit: `git commit -m 'Add: Neue Funktion'`
4. Push: `git push origin feature/neue-funktion`
5. PR öffnen

---

## 📖 Zitation

@misc{dara_skill_v26,
  title={DaRa Dataset Expert Skill (Version 2.6)},
  author={[Dein Name]},
  year={2026},
  howpublished={GitHub Repository},
  note={Claude-Skill für automatisierte Prozesserkennung in Warehouse-Szenarien. 
        Erweitert um Hybrid-Identification-Logic und Evidence-Based Scoring. 
        Basierend auf: DaRa Dataset Description (Stand Oktober 2025).}
}
```

---

## 🛡️ Lizenz

MIT License – Siehe [LICENSE](LICENSE) für Details.

---

## 📧 Kontakt

**Entwickelt für:** Master-Thesis an der TU Dortmund (Faculty of Logistics)  
**Betreuer:** Friedrich Niemann  
**Datum:** Januar 2026  
**Version:** 2.6

---

**Viel Erfolg mit deiner automatisierten Prozessanalyse! 🎓🤖**