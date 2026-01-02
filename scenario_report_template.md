# DaRa Dataset – Szenario-Bericht-Template

Diese Datei definiert das **standardisierte Ausgabeformat** für erkannte Szenarien.

**Zweck:** Einheitliche Dokumentation von Analyseergebnissen  
**Skill-Version:** 2.0 (30.12.2025)

---

## 1. JSON-Ausgabeformat (Maschinenlesbar)

Für jedes erkannte Szenario:

```json
{
  "scenario": "S1",
  "name": "Standard Retrieval",
  "frames": {
    "start": 1021,
    "end": 30689
  },
  "duration_sec": 988.97,
  "ground_truth_validation": {
    "high_level_process": {
      "expected": "CL110",
      "detected": "CL110",
      "valid": true
    },
    "information_technology": {
      "expected": "CL105",
      "detected": "CL105",
      "valid": true
    },
    "customer_order": {
      "expected": "CL100",
      "detected": "CL100",
      "valid": true
    },
    "picking_strategy": {
      "expected": "single_order",
      "detected": "single_order",
      "valid": true
    },
    "error_flag": {
      "expected": true,
      "cl135_found": true,
      "valid": true
    }
  },
  "key_statistics": {
    "preparing_frames": 2100,
    "travel_time_frames": 12500,
    "pick_time_frames": 8900,
    "finalizing_frames": 1800,
    "dominant_cc10_processes": ["CL137", "CL139", "CL140"],
    "order_transitions": 0,
    "incident_reporting_frames": 450
  },
  "validation_result": {
    "all_rules_passed": true,
    "violations": []
  }
}
```

---

## 2. Markdown-Ausgabeformat (Human-readable)

### Szenario-Bericht Template

```markdown
## Szenario S1: Standard Retrieval

**Frames:** 1.021 – 30.689 (Dauer: 988,97 sec / 16,5 min)

### Ground-Truth-Merkmale

| Merkmal | Erwartet | Erkannt | Status |
|---------|----------|---------|--------|
| High-Level Process | Retrieval (CL110) | CL110 | ✓ |
| Information Technology | List + Pen (CL105) | CL105 | ✓ |
| Customer Order | 2904 (CL100) | CL100 | ✓ |
| Picking Strategy | Single-Order | Single-Order | ✓ |
| Error Flag | Mit Fehlern | CL135 gefunden | ✓ |

### Prozessstruktur (CC09)

| Prozess | Frames | Dauer (sec) | Anteil |
|---------|--------|-------------|--------|
| Preparing Order | 2.100 | 70,0 | 7,1% |
| Picking - Travel Time | 12.500 | 416,7 | 42,1% |
| Picking - Pick Time | 8.900 | 296,7 | 30,0% |
| Packing | 5.189 | 173,0 | 17,5% |
| Finalizing Order | 1.800 | 60,0 | 6,1% |

### Auffälligkeiten

- Frame 23.450–23.890: CL135 (Incident Reporting) aktiv → Fehlerkorrektur
- Keine Order-Wechsel (Single-Order bestätigt)

### Validierung

✅ **Alle Ground-Truth-Merkmale erfüllt**
```

---

## 3. Aggregierte Zusammenfassung (Pro Subjekt)

```markdown
# DaRa S14 – Szenario-Analyse Zusammenfassung

**Subjekt:** S14  
**Gesamtframes:** 279.050  
**Gesamtdauer:** 9.301,67 sec (155,03 min)  
**Analysiert:** 30.12.2025

## Erkannte Szenarien

| # | Szenario | Start | Ende | Dauer | IT | Orders | Multi-Order |
|---|----------|-------|------|-------|----|----|-------------|
| 1 | S2 | 1.021 | 30.689 | 16,5 min | PDT | 2905 | ❌ |
| 2 | S1 | 30.690 | 55.153 | 13,6 min | Pen | 2904 | ❌ |
| 3 | S3 | 55.154 | 83.855 | 15,9 min | Scanner | 2906 | ❌ |
| 4 | S4 | 83.856 | 130.049 | 25,7 min | Pen | 2904 | ❌ |
| 5 | S5 | 130.050 | 153.746 | 13,1 min | Pen | 2905 | ❌ |
| 6 | S7 | 153.747 | 243.436 | 49,8 min | Pen | 2904+2905 | ✅ |
| 7 | S8 | 243.437 | 278.642 | 19,6 min | Pen | 2904+2905 | ✅ |

## Validierungsergebnis

- **Szenario-Anzahl:** 7 (Beispiel, variiert je Subjekt)
- **Übergangsphasen:** 2 (Frames 0–1.020 und 278.643–279.049)
- **Alle Ground-Truth-Regeln:** ✅ Erfüllt
```

---

## 4. Validierungsregeln für Output

### Pflichtfelder

Jeder Szenario-Bericht **muss** enthalten:

1. `scenario` – Szenario-ID (S1-S8)
2. `frames.start` / `frames.end` – Frame-Bereich
3. `duration_sec` – Dauer in Sekunden
4. `ground_truth_validation` – Alle 5 Dimensionen
5. `validation_result` – Pass/Fail mit Violations

### Optionale Felder

- `key_statistics` – Detaillierte Prozess-Statistiken
- `anomalies` – Erkannte Auffälligkeiten
- `recommendations` – Handlungsempfehlungen

---

## 5. Verwendungshinweise

**Diese Datei nutzen für:**
- Standardisierte Analyse-Outputs
- Vergleichbare Ergebnisse über Subjekte hinweg
- Automatisierte Validierung

**Verwandte Dateien:**
- `scenario_boundary_detection.md` → Erkennungsalgorithmus
- `validation_logic_extended.md` → Validierungsregeln
- `ground_truth_matrix.md` → Referenzwerte

---

## Metadaten

**Datei-Version:** 2.0  
**Erstellt:** 30.12.2025  
**Basiert auf:** Chat "29-12 HIER WEITERMACHEN skill erweiterung mit szenarioerkennung"
