# DaRa Dataset – Label-Aktivitätsmatrix

Diese Datei dokumentiert den **Status aller erkennungsrelevanten Labels** für die Szenarioerkennung, basierend auf empirischer Analyse des S14-Datensatzes.

**Quelle:** Empirische Analyse von S14 (279.050 Frames)  
**Skill-Version:** 2.4 (02.01.2026)

---

## 1. Zweck dieser Dokumentation

Die **Label-Aktivitätsmatrix** dient zur:

1. **Optimierung der Erkennungsalgorithmen** – inaktive Labels können ignoriert werden
2. **Validierung der Ground Truth** – Überprüfung, ob theoretische Labels praktisch vorkommen
3. **Debugging von Erkennungsfehlern** – Identifikation fehlender oder unerwarteter Label-Aktivierungen
4. **Generalisierung auf alle Subjekte** – Annahmen über Label-Verfügbarkeit

---

## 2. Erkennungsrelevante Kategorien

Für die Szenarioerkennung S1-S8 sind **4 Kategorien** mit **13 Labels** relevant:

| Kategorie | Labels gesamt | Erkennungsrelevant | Zweck |
|-----------|---------------|-------------------|-------|
| **CC06 - Order** | 5 | 4 (CL100-CL103) | Auftragsnummer + No-Order-State |
| **CC07 - IT** | 5 | 4 (CL105-CL108) | IT-System + No-IT-State |
| **CC08 - High-Level** | 4 | 4 (CL110-CL113) | Prozesstyp + Übergangsphasen |
| **CC10 - Low-Level** | 31 | 1 (CL135) | Error-Detection |

---

## 3. CC06 – Order (Auftragsnummer)

### Label-Status in S14

| Label | Beschreibung | Status | Frames | Anteil | Rolle |
|-------|--------------|--------|--------|--------|-------|
| **CL100** | 2904 | ✅ AKTIV | 219.251 | 78.57% | **Order für S1, S4, S7, S8** |
| **CL101** | 2905 | ✅ AKTIV | 154.565 | 55.39% | **Order für S2, S5, S7, S8** |
| **CL102** | 2906 | ✅ AKTIV | 28.702 | 10.29% | **Order für S3, S6** |
| **CL103** | No Order | ✅ AKTIV | 1.428 | 0.51% | Übergangsphasen (z.B. CL112) |
| **CL104** | Order Unknown | ❌ INAKTIV | 0 | 0.00% | Nicht in S14 vorhanden |

### Multi-Label-Verhalten

```
Frames mit 2+ gleichzeitig aktiven Order-Labels: 124.896 (44.76%)
→ Multi-Order-Szenarien S7/S8 erkennbar
```

**Wichtig:** Bei **Single-Order-Szenarien** (S1-S6) ist jeweils **genau 1 Order-Label aktiv** (außer in Übergangsphasen mit CL103). Bei **Multi-Order-Szenarien** (S7, S8) sind **exakt 2 Order-Labels gleichzeitig aktiv**: CL100 + CL101.

### Erkennungslogik

```python
# Single-Order-Erkennung
order_labels = ['CL100|2904', 'CL101|2905', 'CL102|2906']
active_orders = [label for label in order_labels if df[label] == 1]

if len(active_orders) == 1:
    order = active_orders[0].split('|')[0]  # z.B. "CL100"
elif len(active_orders) == 2:
    order_set = frozenset([label.split('|')[0] for label in active_orders])
    # Für S7/S8: order_set == {'CL100', 'CL101'}
```

---

## 4. CC07 – Information Technology (IT-System)

### Label-Status in S14

| Label | Beschreibung | Status | Frames | Anteil | Rolle |
|-------|--------------|--------|--------|--------|-------|
| **CL105** | List and Pen | ✅ AKTIV | 219.251 | 78.57% | **Standard-IT für S1, S4-S8** |
| **CL106** | List + Glove Scanner | ✅ AKTIV | 28.702 | 10.29% | **Eindeutig für S3** |
| **CL107** | Portable Data Terminal | ✅ AKTIV | 29.669 | 10.63% | **Eindeutig für S2** |
| **CL108** | No IT | ✅ AKTIV | 1.428 | 0.51% | Übergangsphasen |
| **CL109** | IT Unknown | ❌ INAKTIV | 0 | 0.00% | Nicht in S14 vorhanden |

### Erkennungslogik

```python
# IT-System-Erkennung (exklusiv – genau 1 Label aktiv außer in Übergängen)
if df['CL107|Portable Data Terminal'] == 1:
    it_system = 'PDT'  # → S2 eindeutig
elif df['CL106|List and Glove Scanner'] == 1:
    it_system = 'Scanner'  # → S3 eindeutig
elif df['CL105|List and Pen'] == 1:
    it_system = 'Pen'  # → S1, S4-S8
```

**Kritisch:** CL107 (PDT) und CL106 (Scanner) sind **100% eindeutige Identifikatoren** für S2 bzw. S3.

---

## 5. CC08 – High-Level Process (Prozesstyp)

### Label-Status in S14

| Label | Beschreibung | Status | Frames | Anteil | Rolle |
|-------|--------------|--------|--------|--------|-------|
| **CL110** | Retrieval | ✅ AKTIV | 172.525 | 61.83% | **Retrieval-Szenarien S1-S3, S7** |
| **CL111** | Storage | ✅ AKTIV | 105.097 | 37.66% | **Storage-Szenarien S4-S6, S8** |
| **CL112** | Another HL Process | ✅ AKTIV | 1.428 | 0.51% | **Übergangsphasen – KEIN Szenario** |
| **CL113** | HL Process Unknown | ❌ INAKTIV | 0 | 0.00% | Nicht in S14 vorhanden |

### Erkennungslogik

```python
# High-Level-Process-Erkennung (exklusiv)
if df['CL110|Retrieval'] == 1:
    hl_process = 'Retrieval'  # → S1-S3, S7
elif df['CL111|Storage'] == 1:
    hl_process = 'Storage'  # → S4-S6, S8
elif df['CL112|Another High-Level Process'] == 1:
    hl_process = 'Transition'  # → IGNORIEREN für Szenario-Zählung
```

**Kritisch:** CL112-Frames sind **Übergangsphasen** zwischen Szenarien und müssen von der Szenario-Erkennung **ausgeschlossen** werden.

---

## 6. CC10 – Low-Level Process (nur CL135 relevant)

### Label-Status in S14

| Label | Beschreibung | Status | Frames | Anteil | Rolle |
|-------|--------------|--------|--------|--------|-------|
| **CL135** | Reporting and Clarifying Incident | ✅ AKTIV | 7.876 | 2.82% | **Error-Flag für S1, S3** |

**Alle anderen CC10-Labels (CL124-CL134, CL136-CL154):** Nicht erkennungsrelevant für Szenarien.

### Erkennungslogik

```python
# Error-Detection
has_errors = (df['CL135|Reporting and Clarifying the Incident'] == 1).any()

# Anwendung auf Szenarien:
# S1: Retrieval + Pen + CL100 + Errors → CL135 sollte vorhanden sein
# S3: Retrieval + Scanner + CL102 + Errors → CL135 sollte vorhanden sein
```

**Hinweis:** CL135 ist **nicht in allen Szenarien aktiv**, sondern nur in **S1 und S3** (laut Ground Truth).

---

## 7. Gesamtübersicht: Aktive vs. Inaktive Labels

### Erkennungsrelevante Labels (11 von 13)

| Kategorie | Aktive Labels | Inaktive Labels |
|-----------|---------------|-----------------|
| **CC06** | CL100, CL101, CL102, CL103 | CL104 |
| **CC07** | CL105, CL106, CL107, CL108 | CL109 |
| **CC08** | CL110, CL111, CL112 | CL113 |
| **CC10** | CL135 | - |

### Zusammenfassung

```
✅ AKTIV (11 Labels):
   CC06: CL100, CL101, CL102, CL103
   CC07: CL105, CL106, CL107, CL108
   CC08: CL110, CL111, CL112
   CC10: CL135

❌ INAKTIV (3 Labels – können ignoriert werden):
   CC06: CL104 (Order Unknown)
   CC07: CL109 (IT Unknown)
   CC08: CL113 (HL Process Unknown)
```

---

## 8. Implikationen für die Szenarioerkennung

### 8.1 Vereinfachungen durch inaktive Labels

Da CL104, CL109 und CL113 in S14 **nie aktiv** sind, können Erkennungsalgorithmen:

- **CL104 ignorieren** → keine Validierung auf "Order Unknown" notwendig
- **CL109 ignorieren** → keine Validierung auf "IT Unknown" notwendig
- **CL113 ignorieren** → keine Validierung auf "HL Process Unknown" notwendig

### 8.2 CL112 als Ausschlusskriterium

Frames mit **CL112 (Another High-Level Process)** sind:

- **Keine Szenarien** → bei Szenario-Zählung ausschließen
- **Übergangsphasen** zwischen echten Szenarien
- **1.428 Frames** (0.51%) in S14

**Algorithmus:**

```python
# ALLE Frames mit CL112=1 filtern
work_phases = df[df['CL112|Another High-Level Process'] == 0]
```

### 8.3 Multi-Order-Erkennung durch Co-Aktivierung

**124.896 Frames (44.76%)** haben **2+ gleichzeitig aktive Order-Labels** → eindeutige Erkennung von S7/S8.

**Algorithmus:**

```python
order_labels = ['CL100|2904', 'CL101|2905', 'CL102|2906']
active_order_count = df[order_labels].sum(axis=1)

# Single-Order: active_order_count == 1
# Multi-Order: active_order_count == 2
```

### 8.4 Fehler-Erkennung durch CL135-Präsenz

**7.876 Frames (2.82%)** mit CL135 → Error-Detection für S1 und S3.

**Algorithmus:**

```python
# Pro Szenario-Block prüfen
block_has_errors = (block_df['CL135|Reporting and Clarifying the Incident'] == 1).any()

# Anwendung:
if hl_process == 'Retrieval' and it_system == 'Pen' and order == 'CL100':
    if block_has_errors:
        scenario = 'S1'  # Error Run
    else:
        # Konflikt: S1 erfordert Errors, aber keine vorhanden
```

---

## 9. Validierung gegen Ground Truth

### Erwartete Label-Aktivierungen pro Szenario

| Szenario | CC08 | CC07 | CC06 | CL135 | Erwartung |
|----------|------|------|------|-------|-----------|
| **S1** | CL110 | CL105 | CL100 | ✅ Ja | Sollte CL135 haben |
| **S2** | CL110 | CL107 | CL101 | ❌ Nein | PDT-Szenario, keine Fehler |
| **S3** | CL110 | CL106 | CL102 | ✅ Ja | Sollte CL135 haben |
| **S4** | CL111 | CL105 | CL100 | ❌ Nein | Storage, keine Fehler |
| **S5** | CL111 | CL105 | CL101 | ❌ Nein | Storage, keine Fehler |
| **S6** | CL111 | CL105 | CL102 | ❌ Nein | Storage, keine Fehler |
| **S7** | CL110 | CL105 | CL100+CL101 | ❌ Nein | Multi-Order, keine Fehler |
| **S8** | CL111 | CL105 | CL100+CL101 | ❌ Nein | Multi-Order, keine Fehler |

---

## 10. Subjektübergreifende Generalisierung

### 10.1 Annahmen für S14

Die obige Analyse basiert auf **S14** (279.050 Frames). Folgende Annahmen können **nicht** auf alle 18 Subjekte übertragen werden:

| Annahme | S14-spezifisch? | Generalisierbar? |
|---------|-----------------|------------------|
| CL104, CL109, CL113 sind inaktiv | ✅ Ja | ❓ Unklar – andere Subjekte könnten diese Labels haben |
| Multi-Order-Frames: 44.76% | ✅ Ja | ❌ Nein – Anteil variiert je Subjekt |
| CL135-Frames: 2.82% | ✅ Ja | ❌ Nein – Fehleranzahl variiert |
| CL112-Frames: 0.51% | ✅ Ja | ❌ Nein – Übergangsdauer variiert |

### 10.2 Sichere Generalisierungen

Folgende Eigenschaften sind **für alle Subjekte gültig**:

1. **CL106 (Scanner) → S3** – 100% eindeutig
2. **CL107 (PDT) → S2** – 100% eindeutig
3. **Multi-Order = 2 Orders (CL100 + CL101)** – nie CL102 in Multi-Order
4. **CL112 ist keine Szenario** – immer Übergangsphase
5. **Single-Order = 1 aktives Order-Label** – nie 2+ außer Multi-Order

---

## 11. Verwendungshinweise

### Wann diese Datei nutzen?

- **Vor Implementierung von Erkennungsalgorithmen** → Label-Verfügbarkeit prüfen
- **Bei Debugging von Erkennungsfehlern** → Erwartete vs. tatsächliche Label-Aktivierung
- **Zur Validierung gegen Ground Truth** → Konsistenz der Label-Kombinationen
- **Für subjektübergreifende Verallgemeinerung** → Annahmen explizit machen

### Verwandte Dateien

- `ground_truth_matrix.md` → Theoretische Szenario-Definitionen
- `scenario_boundary_detection.md` → Praktische Erkennungsalgorithmen
- `validation_logic_extended.md` → Validierungsregeln für erkannte Szenarien

---

## Metadaten

**Datei-Version:** 2.4  
**Erstellt:** 02.01.2026  
**Quelle:** Empirische Analyse von S14 (279.050 Frames)  
**Status:** Freigegeben  
**Klassifikation:** Technische Dokumentation
