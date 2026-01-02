#!/bin/bash
set -e

echo "🚀 Starte Migration auf DaRa Dataset Expert v2.4..."

# ------------------------------------------------------------------
# 1. VERZEICHNISSTRUKTUR ERSTELLEN
# ------------------------------------------------------------------
echo "📂 Erstelle Verzeichnisse..."
mkdir -p knowledge
mkdir -p templates
mkdir -p docs/analysis
mkdir -p examples
mkdir -p metadata

# ------------------------------------------------------------------
# 2. BESTEHENDE DATEIEN SICHERN/VERSCHIEBEN
# ------------------------------------------------------------------
# Falls alte Struktur existiert, verschieben wir nützliche Inhalte
if [ -d "dara-skill-github-repo/knowledge" ]; then
    echo "📦 Verschiebe existierende Knowledge-Dateien..."
    # Wir kopieren alles, überschreiben aber gleich die veralteten Dateien mit den neuen Versionen
    cp -r dara-skill-github-repo/knowledge/* knowledge/ 2>/dev/null || true
fi

# ------------------------------------------------------------------
# 3. KNOWLEDGE FILES ERSTELLEN (v2.4)
# ------------------------------------------------------------------

# --- 3.1 dataset_core.md (Mit korrigiertem Diagramm-Block) ---
echo "📝 Erstelle knowledge/dataset_core.md..."
cat << 'EOF' > knowledge/dataset_core.md
# DaRa Dataset – Kerndokumentation

Diese Datei enthält die fundamentalen Beschreibungen des DaRa-Datensatzes aus der offiziellen Dataset Description (Stand 20.10.2025).

---

## 1.1 Zweck und Kontext des Datensatzes

### Zweck der Wissensbasis
Die Wissensbasis dient als vollständig konsolidierte, technisch präzise und widerspruchsfreie Grundlage für alle weiteren Arbeiten mit dem Datensatz. Sie bildet eine zentrale und verlässliche Referenz, in der ausschließlich verifizierte und belegbare Inhalte enthalten sind.

### Verwendete Quelldokumente
Die Wissensbasis basiert auf folgenden Quellen:
- den durch dich festgelegten Korrekturen und Priorisierungsregeln,
- den relevanten Inhalten der aktuellen DaRa Dataset Description (Stand 20.10.2025).

---

## 1.4 Probanden (Subjects S01–S18)
Die folgenden Angaben stammen aus der **Tabelle 4: Subject specifications**.

| ID | Sex | Age | Weight (kg) | Height (cm) | Handedness | Employment | Exp. Order Picking |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| S01 | F | 32 | 68 | 171 | R | Student | 2 |
| S02 | M | 27 | 76 | 167 | R | Student | 3 |
| S03 | M | 64 | 69 | 171 | R | Employee | 6 |
| S04 | M | 31 | 85 | 183 | L | Employee | 5 |
| S05 | M | 67 | 100 | 177 | R | Retiree | 6 |
| S06 | M | 24 | 82 | 178 | R | Student | 4 |
| S07 | M | 41 | 70 | 180 | R | Employee | 6 |
| S08 | F | 29 | 62 | 163 | R | Student | 6 |
| S09 | M | 21 | 85 | 180 | R | Student | 6 |
| S10 | M | 28 | 85 | 160 | R | Student | 3 |
| S11 | M | 59 | 85 | 178 | R | Employee | 3 |
| S12 | M | 43 | 103 | 186 | R | Job seeker | 6 |
| S13 | F | 52 | 66 | 175 | R | Employee | 5 |
| S14 | M | 32 | 80 | 176 | R | Employee | 6 |
| S15 | M | 43 | 88 | 177 | R | Employee | 6 |
| S16 | M | 29 | 100 | 175 | R | Student | 6 |
| S17 | F | 25 | 75 | 180 | R | Employee | 6 |
| S18 | M | 26 | 80 | 187 | R | Student | 6 |

---

## 1.5 Sessions
Eine **Recording Session** ist ein aufgezeichneter Block, in dem **drei Subjekte gleichzeitig** am Prozess teilnahmen.
- **Struktur:** Drei parallele Subjekte, synchroner Zeitstrahl.
- **Szenarien:** Können mehrfach oder in variierender Reihenfolge auftreten.

---

## 1.6 Offizielle Prozesslogik (BPMN)

Der Prozess bildet einen Ablauf von **Start Work** bis **End Work** ab und enthält zwei alternative Hauptpfade: **Retrieval** und **Storage**.

### Prozessfluss-Übersicht (Textuelle Darstellung)

```text
START WORK
    ↓
Preparing Order (CL114)
    ↓
[Decision: Retrieval OR Storage?]
    ↓                    ↓
RETRIEVAL PATH        STORAGE PATH
    ↓                    ↓
Picking Travel (CL115)   Unpacking (CL117)
    ↓                    ↓
Picking Pick (CL116)     Storing Travel (CL119)
    ↓                    ↓
[All positions done?]    Storing Store (CL120)
NO → Loop back           ↓
YES ↓                    [All positions done?]
Packing (CL118)          NO → Loop back
    ↓                    YES ↓
[All positions done?]        ↓
NO → Loop back           ┌───┘
YES ↓                    ↓
    └──────────────→ Finalizing Order (CL121)
                         ↓
                    [More orders?]
                    YES → Back to Preparing Order
                    NO ↓
                    END WORK
