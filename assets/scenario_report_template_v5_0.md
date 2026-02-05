# DaRa Dataset â€“ Szenario-Bericht-Template

Diese Datei definiert das **standardisierte Ausgabeformat** fÃ¼r erkannte Szenarien.

**Zweck:** Einheitliche Dokumentation von Analyseergebnissen  
**Datei-Version:** 5.0 (04.02.2026)  
**Status:** Finalisiert

---

## 1. JSON-Ausgabeformat (Maschinenlesbar)

FÃ¼r jedes erkannte Szenario:

```json
{
  "scenario": "S1",
  "name": "Standard Retrieval",
  "status": "vorhanden",
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

**Frames:** 1.021 â€“ 30.689 (Dauer: 988,97 sec / 16,5 min)  
**Status:** Vorhanden

### Ground-Truth-Merkmale

| Merkmal | Erwartet | Erkannt | Status |
|---------|----------|---------|--------|
| High-Level Process | Retrieval (CL110) | CL110 | âœ“ |
| Information Technology | List + Pen (CL105) | CL105 | âœ“ |
| Customer Order | 2904 (CL100) | CL100 | âœ“ |
| Picking Strategy | Single-Order | Single-Order | âœ“ |
| Error Flag | Mit Fehlern | CL135 gefunden | âœ“ |

### Prozessstruktur (CC09)

| Prozess | Frames | Dauer (sec) | Anteil |
|---------|--------|-------------|--------|
| Preparing Order | 2.100 | 70,0 | 7,1% |
| Picking - Travel Time | 12.500 | 416,7 | 42,1% |
| Picking - Pick Time | 8.900 | 296,7 | 30,0% |
| Packing | 5.189 | 173,0 | 17,5% |
| Finalizing Order | 1.800 | 60,0 | 6,1% |

### AuffÃ¤lligkeiten

- Frame 23.450â€“23.890: CL135 (Incident Reporting) aktiv â†’ Fehlerkorrektur
- Keine Order-Wechsel (Single-Order bestÃ¤tigt)

### Validierung

âœ… **Alle Ground-Truth-Merkmale erfÃ¼llt**
```

---

## 3. Aggregierte Zusammenfassung (Pro Subjekt)

```markdown
# DaRa Subjekt S14 â€“ Szenario-Analyse Zusammenfassung

**Subjekt:** S14  
**Gesamtframes:** 279.050  
**Gesamtdauer:** 9.301,67 sec (155,03 min)  
**Analysiert:** 04.02.2026

## Erkannte Szenarien (geordnet nach chronologischem Auftreten)

| # | Szenario | Status | Frame_Start | Frame_End | Dauer (min) | IT-Modus | Orders | Bemerkung |
|---|----------|--------|-------------|-----------|------------|----------|--------|-----------|
| 1 | S1 | Vorhanden | 30.690 | 55.153 | 13,6 | Pen | 2904 | Single-Order |
| 2 | S2 | Vorhanden | 1.021 | 30.689 | 16,5 | PDT | 2905 | Single-Order |
| 3 | S3 | Vorhanden | 55.154 | 83.855 | 15,9 | Scanner | 2906 | Single-Order |
| 4 | S4 | Vorhanden | 83.856 | 130.049 | 25,7 | Pen | 2904 | Single-Order |
| 5 | S5 | Vorhanden | 130.050 | 153.746 | 13,1 | Pen | 2905 | Single-Order |
| 6 | S7 | Vorhanden | 153.747 | 243.436 | 49,8 | Pen | 2904+2905 | Multi-Order |
| 7 | S8 | Vorhanden | 243.437 | 278.642 | 19,6 | Pen | 2904+2905 | Multi-Order |
| 8 | Other | Vorhanden | 0 | 1.020 | 0,6 | Diverse | - | Ãœbergangsphasen |

## Nicht erkannte / Nicht vorhanden Szenarien

| # | Szenario | Status | Grund |
|---|----------|--------|-------|
| 9 | S6 | Nicht vorhanden | Nicht in Subjekt S14 erkannt |

## Validierungsergebnis

- **Erkannte Szenarien:** 8 (S1-S5, S7-S8, Other)
- **Nicht erkannte Szenarien:** 1 (S6)
- **Ãœbergangsphasen:** 2 (Frames 0â€“1.020 und 278.643â€“279.049)
- **Alle Ground-Truth-Regeln:** âœ… ErfÃ¼llt
```

---

## 4. Validierungsregeln fÃ¼r Output

### Pflichtfelder

Jeder Szenario-Bericht **muss** enthalten:

1. `scenario` â€“ Szenario-ID (S1-S8, Other, oder Nicht vorhanden)
2. `status` â€“ Status des Szenarios (vorhanden | nicht vorhanden | unsicher)
3. `frames.start` / `frames.end` â€“ Frame-Bereich
4. `duration_sec` â€“ Dauer in Sekunden
5. `ground_truth_validation` â€“ Alle 5 Dimensionen (falls vorhanden)
6. `validation_result` â€“ Pass/Fail mit Violations

### Optionale Felder

- `key_statistics` â€“ Detaillierte Prozess-Statistiken
- `anomalies` â€“ Erkannte AuffÃ¤lligkeiten
- `recommendations` â€“ Handlungsempfehlungen

### Status-Werte (explizit fÃ¼r KI-Verarbeitung)

| Status | Bedeutung | Frame-Range erforderlich |
|--------|-----------|--------------------------|
| `vorhanden` | Szenario wurde erkannt | Ja (Start/End) |
| `nicht vorhanden` | Szenario existiert nicht in dieser Session | Nein (use `-`) |
| `unsicher` | Erkennungsvertrauen < Threshold | Ja (mit Konfidenz-Flag) |

---

## 5. Szenario-Struktur und Reihenfolge

### Allgemeine Prinzipien

1. **Chronologische Reihenfolge:** Szenarien werden nach ihrem zeitlichen Auftreten sortiert (Frame_Start aufsteigend)
2. **Alle 9 Szenarien dokumentieren:** S1, S2, S3, S4, S5, S6, S7, S8, Other
3. **Status fÃ¼r alle:** Jedes Szenario hat einen expliziten Status (Vorhanden/Nicht vorhanden/Unsicher)
4. **Erkannte zuerst, nicht erkannte am Ende:** Erkannte Szenarien in chronologischer Reihenfolge, dann Nicht erkannte

### Frame-Struktur

- **Ein Frame = eine Zeile** in den 12 Klassendateien (CC01-CC12)
- **Jeder Frame enthÃ¤lt nur ein Szenario** pro Proband
- **Frame 1 startet in Zeile 2** (Zeile 1 = Header)
- **Frame-zu-Zeit Konvertierung:** Zeit_Sekunden = Frame_Nummer / 30

### Multi-Order vs. Single-Order Szenarien

- **S1-S5:** Typischerweise Single-Order (ein Order pro Szenario)
- **S7-S8:** Multi-Order Szenarien (mehrere Orders parallel, IT-Switch oder IT-konstant)
- **S6:** Optional, kann abhÃ¤ngig vom Datensatz vorhanden oder nicht vorhanden sein
- **Other:** Ãœbergangsphasen zwischen Szenarien

---

## 6. Verwendungshinweise

**Diese Datei nutzen fÃ¼r:**
- Standardisierte Analyse-Outputs Ã¼ber alle Probanden (S01-S18)
- Vergleichbare Ergebnisse zwischen Subjekten
- Automatisierte Validierung (KI-Verarbeitung von Status-Spalten)
- Szenario-Erkennungs-Pipelines

**Verwandte Dateien:**
- [core_ground_truth_central_v5.0.md](../references/core/core_ground_truth_central_v5.0.md) â†’ Szenario-Definitionen (S1-S8) und Ground-Truth-Merkmale
- [core_labels_207_v5.0.md](../references/core/core_labels_207_v5.0.md) â†’ Label-Definitionen (CL100, CL105, CL110, CL135-CL140)
- [core_category_activation_matrix_v5.0.md](../references/core/core_category_activation_matrix_v5.0.md) â†’ Optional: Category-Mappings fÃ¼r Szenarien
- [auxiliary_data_structure_v5.0.md](../references/auxiliary/auxiliary_data_structure_v5.0.md) â†’ Frame-Struktur und Datenformat

---

## 7. Metadaten

**Datei-Version:** 5.0  
**Status:** Finalisiert  
**Erstellt:** 30.12.2025  
**Aktualisiert:** 04.02.2026  
**Basiert auf:** Szenario-Erkennungslogik v5.0, DaRa Dataset-Struktur v5.0

---

## Changelog (v5.0 vs. v2.1)

### Added
- **Status-Spalte:** Explizite Spalte "Status" (Vorhanden/Nicht vorhanden/Unsicher) fÃ¼r KI-Verarbeitung
- **Alle 9 Szenarien:** Tabelle dokumentiert jetzt alle Szenarien (S1-S8 + Other)
- **Nicht erkannte am Ende:** Nicht vorhanden Szenarien werden separat dokumentiert
- **Frame-Struktur dokumentiert:** ErklÃ¤rung von Frame-Indizierung, chronologischer Reihenfolge
- **Referenz-Versionierung:** Alle Datei-Referenzen mit `_v5.0`-Endung

### Changed
- **Versionsnummer:** 2.0 â†’ 5.0 (Teil des v5.0 Skill-Releases)
- **Datei-Referenzen:** Korrekte Pfade, vollstÃ¤ndige Dateinamen mit `core_` PrÃ¤fix
- **Szenario-Tabelle:** Erweiterte Struktur mit Status-Spalte und chronologischer Sortierung
- **Beispiel (S14):** Szenario S6 jetzt explizit als "Nicht vorhanden" dokumentiert

### Fixed
- Kaputte Links (Pfad `../knowledge/core/` â†’ `../references/core/`)
- Fehlende Dateiname-PrÃ¤fixe (`ground_truth_central` â†’ `core_ground_truth_central`)
- Versionsdivergenz (2.0 vs. 2.1 â†’ einheitlich 5.0)
- Fehlende Referenzen zu `auxiliary_data_structure_v5.0.md`

### Removed
- Interne Chat-Referenz (29-12 HIER WEITERMACHEN)
- Mehrdeutige Versionierungskommentare

---

