# Process-Validierungs-Report Template

**Vorlage für Phase 4: Process IST/SOLL-Vergleich**

---

## Header

```
═══════════════════════════════════════════════════
  DaRa Process-Validierungs-Report — Phase 4
  Proband: [SXX]
  Szenario: [S1–S8]
  Frames: [N] (Szenario-spezifisch)
  Datum: [YYYY-MM-DD]
  Methode: FSM + CC09→CC10 Mapping v6.0
═══════════════════════════════════════════════════
```

---

## 1. CC09 Sequenz-Analyse

### 1.1 SOLL-Sequenz (aus Szenario-Routing)

```
Szenario [SX]:
  CL114 (Preparing) → [CL115 (Pick Travel) → CL116 (Pick Time)]* →
  CL118 (Packing) → CL121 (Finalizing)
```

### 1.2 IST-Sequenz (aus Daten)

```
Frame-Bereich     CC09              Dauer (s)    Status
──────────────────────────────────────────────────────────
[N]–[N]           CL114 Preparing   [s]          ✅ SOLL
[N]–[N]           CL115 Pick Travel [s]          ✅ SOLL
[N]–[N]           CL116 Pick Time   [s]          ✅ SOLL
[N]–[N]           CL115 Pick Travel [s]          ✅ Loop
...
[N]–[N]           CL121 Finalizing  [s]          ✅ SOLL
```

### 1.3 Sequenz-Bewertung

```
Transitions gesamt:        [N]
Transitions BPMN-konform:  [N] ([%])
Transitions ABWEICHEND:    [N] ([%])
```

---

## 2. CC09 → CC10 Mapping-Validierung (V-B3)

### 2.1 Zusammenfassung

```
Frames geprüft:            [N]
Frames V-B3 konform:       [N] ([%])
Frames V-B3 Verletzung:    [N] ([%])
```

### 2.2 Verletzungen (Details)

```
Frame     CC09              CC10 (IST)           CC10 (Erlaubt)           Severity
──────────────────────────────────────────────────────────────────────────────────
[N]       CL116 Pick Time   CL138 Placing Rack   CL139,CL140,CL151,CL134  CRITICAL
[N]       CL120 Store Time  CL154 Unknown        CL136,CL140,CL138,CL134  CRITICAL
...
```

### 2.3 Häufigste Verletzungstypen

```
CC09 → CC10 (falsch)                    Häufigkeit    Severity
──────────────────────────────────────────────────────────────
CL116 → CL138 (Store-Label in Pick)     [N]           CRITICAL
CL120 → CL154 (Unknown statt CL138)     [N]           CRITICAL
CL115 → CL139 (Pick in Travel)          [N]           CRITICAL
...
```

---

## 3. Tool-Validierung

### 3.1 Zusammenfassung

```
Tool-pflichtige Frames:     [N]
Tool korrekt vorhanden:     [N] ([%])
Tool FEHLEND:               [N] ([%])
```

### 3.2 Verletzungen

```
Frame     CC10                      Pflicht-Tool         CC04 (LH)    CC05 (RH)    Status
─────────────────────────────────────────────────────────────────────────────────────────
[N]       CL142 Opening Box         Knife (CL061/096)    CL040        CL075        ❌ FEHLT
[N]       CL150 Sealing Box         Tape (CL060/095)     CL040        CL075        ❌ FEHLT
...
```

---

## 4. Location-Validierung

### 4.1 Zusammenfassung

```
Location-geprüfte Frames:  [N]
Location plausibel:         [N] ([%])
Location ABWEICHEND:        [N] ([%])
```

### 4.2 Auffälligkeiten

```
Frame     CC10                      CC11 (IST)           CC11 (Erwartet)       Status
──────────────────────────────────────────────────────────────────────────────────────
[N]       CL139 Retrieving Items    CL159 Packing Area   CL163 Aisle Path      ⚠️ WARNING
[N]       CL124 Collecting HW       CL161 Path           CL155 Office           ⚠️ WARNING
...
```

---

## 5. CL134 (Waiting) Analyse

```
Waiting-Episoden gesamt:    [N]
Gesamtdauer Waiting:        [s] ([%] des Szenarios)
Längste Episode:            [s] (Frame [N]–[N])
Durchschnittliche Episode:  [s]
```

### Verteilung nach CC09-Phase

```
CC09 Phase          Waiting-Frames    Anteil an Phase
──────────────────────────────────────────────────────
CL114 Preparing     [N]               [%]
CL115 Pick Travel   [N]               [%]
CL116 Pick Time     [N]               [%]
CL118 Packing       [N]               [%]
CL121 Finalizing    [N]               [%]
```

---

## 6. CL135 (Incident) Analyse

```
CL135-Episoden gesamt:      [N]
Gesamtdauer CL135:          [s]
```

### Erwartung vs. Realität

```
Szenario    CL135 erwartet?    CL135 gefunden?    Bewertung
──────────────────────────────────────────────────────────────
S1          Ja (Errors)        [Ja/Nein]           [✅/⚠️]
S2          Nein               [Ja/Nein]           [✅/⚠️]
S3          Ja (Errors)        [Ja/Nein]           [✅/⚠️]
S7          Nein (Perfect)     [Ja/Nein]           [✅/⚠️]
...
```

---

## 7. Gesamtbewertung

```
═══════════════════════════════════════════════════
  Process-Konformitätsbewertung
═══════════════════════════════════════════════════

  CC09 Sequenz:        [%] konform
  CC09→CC10 Mapping:   [%] konform (V-B3)
  Tool-Validierung:    [%] konform
  Location-Validierung:[%] plausibel
  ─────────────────────────────────────
  Gesamt-Konformität:  [%]

  Severity-Verteilung:
    CRITICAL:  [N] Verletzungen
    WARNING:   [N] Auffälligkeiten
    INFO:      [N] Hinweise
═══════════════════════════════════════════════════
```

---

## 8. Empfehlungen

```
[Basierend auf gefundenen Abweichungen:]

1. [Empfehlung zu häufigster Verletzung]
2. [Empfehlung zu Tool-Fehlern]
3. [Empfehlung zu Location-Abweichungen]
```

---

## Footer

```
Methode: phase4_bpmn_validation.md (FSM + V-B3 korrigiert v6.0)
Quellen: BPMN Figures A2–A7
Szenario-Vektor: phase1_scenario_recognition.md
Erstellt: [YYYY-MM-DD HH:MM]
```

<!-- VERIFICATION_TOKEN: DARA-BRPT-1P5E-v630 -->
