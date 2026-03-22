# Szenario-Report Template

**Vorlage für Phase 1: Szenarioerkennung**

---

## Header

```
═══════════════════════════════════════════════════
  DaRa Szenario-Report — Phase 1
  Proband: [SXX]
  Frames: [N]
  Datum: [YYYY-MM-DD]
  Methode: 5-Schritt Decision-Logik v3.0/v6.0
═══════════════════════════════════════════════════
```

---

## 1. Szenario-Verteilung

```
Szenario          Frames      Anteil     Zeit (s)
─────────────────────────────────────────────────
S1                [N]         [%]        [N/30]
S2                [N]         [%]        [N/30]
S3                [N]         [%]        [N/30]
S4                [N]         [%]        [N/30]
S5                [N]         [%]        [N/30]
S6                [N]         [%]        [N/30]
S7                [N]         [%]        [N/30]
S8                [N]         [%]        [N/30]
Other_Waiting     [N]         [%]        [N/30]
Other_Process     [N]         [%]        [N/30]
Other_NoData      [N]         [%]        [N/30]
─────────────────────────────────────────────────
GESAMT            [N]         100.0%     [N/30]
```

---

## 2. Validierung

```
✓ Vollständigkeit: [N] / [N] Frames klassifiziert (100.0%)
✓ Exklusivität: Jeder Frame hat exakt 1 Szenario
✓ Anomalien: [N] Frames mit Anomalie-Klassifikation
```

---

## 3. Anomalien-Report

```
Anomalie-Typ              Frames    Anteil
──────────────────────────────────────────
Retrieval_Mismatch        [N]       [%]
Storage_Mismatch          [N]       [%]
Multi_Retrieval_Anomaly   [N]       [%]
Multi_Storage_Anomaly     [N]       [%]
Storage_Unclassified      [N]       [%]
──────────────────────────────────────────
GESAMT ANOMALIEN          [N]       [%]
```

---

## 4. Szenario-Chronologie

```
Frame-Bereich     Szenario    Dauer (s)    Bemerkung
──────────────────────────────────────────────────────
0–[N]             Other       [s]          Initialisierung
[N]–[N]           S1          [s]          Retrieval, Order 2904
[N]–[N]           Other       [s]          Übergang/Warten
[N]–[N]           S2          [s]          Retrieval, Order 2905
...
```

---

## 5. Prozess-Statistik

```
Prozesstyp        Frames    Anteil    Szenarien
─────────────────────────────────────────────────
RETRIEVAL         [N]       [%]       S1, S2, S3, S7
STORAGE           [N]       [%]       S4, S5, S6, S8
OTHER             [N]       [%]       Other_*
─────────────────────────────────────────────────
```

---

## 6. Order-Aktivierung

```
Order       Frames    Anteil    Szenarien
─────────────────────────────────────────
CL100 2904  [N]       [%]       S1, S4, S7, S8
CL101 2905  [N]       [%]       S2, S5, S7, S8
CL102 2906  [N]       [%]       S3, S6
CL103 None  [N]       [%]       Other
CL104 Unkn  [N]       [%]       —
─────────────────────────────────────────
```

---

## 7. IT-System-Aktivierung (nur Retrieval)

```
IT-System       Frames    Anteil    Szenario
──────────────────────────────────────────────
CL105 List+Pen  [N]       [%]       S1, S7
CL106 Scanner   [N]       [%]       S3
CL107 PDT       [N]       [%]       S2
CL108 No IT     [N]       [%]       Other
──────────────────────────────────────────────
```

---

## 8. Bekannte Einschränkungen

- Nicht alle Szenarien S1–S8 müssen vorhanden sein
- Low-Level Fallback in ~[N]% der Frames genutzt (CL110/CL111 beide 0)
- [Probandenspezifische Bemerkungen]

---

## Footer

```
Methode: phase1_scenario_recognition.md (5-Schritt v3.0/v6.0)
Validierung: 100% Frame-Coverage, exklusive Zuordnung
Erstellt: [YYYY-MM-DD HH:MM]
```

<!-- VERIFICATION_TOKEN: DARA-SRPT-8Q7F-v630 -->
