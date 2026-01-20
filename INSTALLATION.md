# Installation & Upgrade Guide – DaRa Dataset Expert Skill v4.0

**Stand:** 19.01.2026  
**Skill-Version:** 4.0  
**Datensatz-Stand:** 20.10.2025

---

## Schnellstart

### Option 1: Claude.ai Upload (Empfohlen)

1. **ZIP-Datei herunterladen:** `dara-dataset-expert_v4.0.zip`
2. **Claude.ai öffnen:** https://claude.ai
3. **Settings → Profile → Skills**
4. **"Add Skill"** klicken
5. **ZIP-Datei hochladen**
6. **Skill aktivieren**

✅ **Fertig!** Claude kann jetzt auf die DaRa-Expertise zugreifen.

---

## Verzeichnisstruktur v4.0

```
dara-dataset-expert_v4.0.zip (84 KB)
└── dara-skill-v4.0/
    ├── SKILL.md                    (12 KB) – Hauptdokumentation & Orchestrierung
    ├── README.md                   (11 KB) – Übersicht & Features
    ├── CHANGELOG_v4.0.md           (8 KB)  – Änderungsprotokoll
    ├── knowledge/
    │   ├── core/                   (5 Dateien, 73 KB)
    │   │   ├── ground_truth_central.md         (14 KB)
    │   │   ├── labels_207.md                   (24 KB)
    │   │   ├── validation_rules.md             (11 KB)
    │   │   ├── articles_inventory.md           (7 KB)
    │   │   └── category_activation_matrix.md   (17 KB)
    │   ├── processes/              (3 Dateien, 35 KB)
    │   │   ├── process_hierarchy.md            (17 KB)
    │   │   ├── refa_analytics.md               (11 KB)
    │   │   └── mtm_codes.md                    (6 KB)
    │   └── auxiliary/              (5 Dateien, 91 KB) ⭐ NEU
    │       ├── dataset_core.md                 (13 KB)
    │       ├── data_structure.md               (10 KB)
    │       ├── warehouse_physical.md           (19 KB)
    │       ├── chunking.md                     (19 KB)
    │       └── semantics.md                    (19 KB)
    └── templates/                  (2 Dateien, 19 KB)
        ├── query_patterns.md                   (14 KB)
        └── scenario_report_template.md         (5 KB)
```

**Gesamt:**
- **18 MD-Dateien**
- **~250 KB** (unkomprimiert)
- **84 KB** (ZIP-komprimiert)

---

## Upgrade von v3.0 zu v4.0

### Was ist neu?

✅ **Konsolidierte Dokumentation** – Keine Redundanzen mehr  
✅ **5 neue auxiliary/-Dateien** – Zentrale Referenzen statt Fragmentierung  
✅ **Verbesserte Navigation** – Klare Querverweise zwischen Dateien  
✅ **Keine Breaking Changes** – Alle Queries funktionieren weiterhin  

### Upgrade-Schritte

1. **Alte v3.0 deaktivieren** (optional, Claude.ai Skill-Settings)
2. **v4.0 ZIP hochladen** (siehe "Option 1" oben)
3. **Skill aktivieren**
4. **Testen:** "Wo ist Artikel 'Palmenerde' gelagert?"
   - Erwartete Antwort: "R7.3.1.A (warehouse_physical.md)"

### Migration v3.0 → v4.0

**Dateinamen-Mapping:**

| v3.0 | v4.0 | Status |
|------|------|--------|
| knowledge/core/warehouse_layout.md | knowledge/auxiliary/warehouse_physical.md | ✨ Ersetzt + 4x Details |
| knowledge/auxiliary/dataset_core.md | knowledge/auxiliary/dataset_core.md | ✨ Aktualisiert + konsolidiert |
| knowledge/auxiliary/data_structure.md | knowledge/auxiliary/data_structure.md | ✨ Aktualisiert + erweitert |
| [nicht vorhanden] | knowledge/auxiliary/chunking.md | ✨ Neu |
| [nicht vorhanden] | knowledge/auxiliary/semantics.md | ✨ Neu |

**Alle anderen Dateien:** Unverändert (ground_truth_central.md, labels_207.md, etc.)

---

## Validierung der Installation

### Test 1: Grundlegende Abfrage

```
Query: "Wie viele Probanden gibt es im DaRa-Datensatz?"
Erwartete Antwort: "18 Probanden (S01-S18), siehe dataset_core.md Tabelle 4"
```

### Test 2: Lagerlayout

```
Query: "Welche Gassen gibt es im Picking Lab?"
Erwartete Antwort: "5 Gassen (Aisle 1-5) mit 8 Regalkomplexen (R1-R8), siehe warehouse_physical.md"
```

### Test 3: Chunking

```
Query: "Was löst Trigger T4 aus?"
Erwartete Antwort: "Änderung in CC04 (Left Hand) – Position, Movement, Object oder Tool, siehe chunking.md"
```

### Test 4: Semantik

```
Query: "Welche semantischen Abhängigkeiten gibt es zwischen CC01 und CC02?"
Erwartete Antwort: "Walking (CC01) → Gait Cycle/Step (CC02), siehe semantics.md"
```

---

## Fehlerbehebung

### Problem 1: ZIP lässt sich nicht hochladen

**Lösung:**
- Prüfe Dateigröße: ZIP sollte ~84 KB sein
- Claude.ai erlaubt max. 10 MB pro Skill
- Falls größer: Archiv neu erstellen

### Problem 2: Skill zeigt "Unknown"

**Lösung:**
- SKILL.md muss im Root-Verzeichnis sein
- Prüfe: `dara-skill-v4.0/SKILL.md` (nicht `dara-skill-v4.0/knowledge/SKILL.md`)

### Problem 3: Verweise funktionieren nicht

**Lösung:**
- Prüfe Verzeichnisstruktur:
  ```
  knowledge/
  ├── auxiliary/
  ├── core/
  └── processes/
  ```
- Alle MD-Dateien müssen in korrekten Unterordnern sein

---

## Manuelle Installation (Entwickler)

### Schritt 1: ZIP entpacken

```bash
unzip dara-dataset-expert_v4.0.zip
cd dara-skill-v4.0
```

### Schritt 2: Verzeichnisstruktur prüfen

```bash
ls -R
```

**Erwartete Ausgabe:**
```
.:
CHANGELOG_v4.0.md  knowledge  README.md  SKILL.md  templates

./knowledge:
auxiliary  core  processes

./knowledge/auxiliary:
chunking.md  data_structure.md  dataset_core.md  semantics.md  warehouse_physical.md

./knowledge/core:
articles_inventory.md  category_activation_matrix.md  ground_truth_central.md  labels_207.md  validation_rules.md

./knowledge/processes:
mtm_codes.md  process_hierarchy.md  refa_analytics.md

./templates:
query_patterns.md  scenario_report_template.md
```

### Schritt 3: ZIP neu erstellen (falls nötig)

```bash
cd ..
zip -r dara-dataset-expert_v4.0_custom.zip dara-skill-v4.0/
```

### Schritt 4: Upload zu Claude.ai

- Siehe "Option 1: Claude.ai Upload" oben

---

## Systemanforderungen

**Claude:**
- Claude Sonnet 4 (oder höher)
- Claude.ai Account (kostenlos oder Pro)

**Browser:**
- Chrome/Edge/Firefox (neueste Version)
- JavaScript aktiviert

**ZIP-Unterstützung:**
- Natives Betriebssystem-Entpacken (Windows/macOS/Linux)

---

## Support & Hilfe

### Dokumentation

- **README.md** – Übersicht & Features
- **SKILL.md** – Technische Dokumentation
- **CHANGELOG_v4.0.md** – Änderungen v3.0 → v4.0

### Häufige Fragen

**Q: Kann ich v3.0 und v4.0 parallel nutzen?**  
A: Ja, aber nicht empfohlen. v4.0 ersetzt v3.0 vollständig.

**Q: Sind meine alten Queries kompatibel?**  
A: Ja, 100% rückwärtskompatibel. Keine Breaking Changes.

**Q: Wie groß ist der Skill?**  
A: 84 KB komprimiert, ~250 KB unkomprimiert. Sehr effizient.

**Q: Benötige ich Claude Pro?**  
A: Nein, funktioniert auch mit kostenlosem Claude.ai Account.

---

## Lizenz & Credits

**Lizenz:** MIT  
**Autor:** DaRa Expert System  
**Quelle:** DaRa Dataset Description (TU Dortmund + Fraunhofer IML)  
**Hauptforscher:** Friedrich Niemann (Doktorand FLW)  

---

**Viel Erfolg mit dem DaRa Dataset Expert Skill v4.0!** 🎉
