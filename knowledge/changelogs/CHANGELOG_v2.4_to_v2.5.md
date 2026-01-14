# Changelog: DaRa Dataset Expert Skill v2.4 → v2.5

**Version:** 2.5  
**Datum:** 05. Januar 2026  
**Kategorie:** Minor Update – Erkennungslogik-Korrektur  
**Basis:** DaRa-Paper (Tabelle 3, Abbildung 11 – BPMN)

---

## 🎯 Zusammenfassung

Version 2.5 korrigiert **kritische Inkonsistenzen** mit dem DaRa-Paper. Die Kern-Szenariodefinitionen S1-S8 bleiben identisch, aber die Erkennungslogik wurde fundamental überarbeitet.

**3 kritische Fehler behoben:**
1. ✅ CC09 (Mid-Level Process) als primäre Erkennungskategorie integriert
2. ✅ "Other"-Restkategorie aktiv erkennbar (verhindert False-Positives)
3. ✅ CC10 (Low-Level) korrekt als sekundär (nur Errors) klassifiziert

---

## 🆕 Neue Funktionen

### 1. CC09 (Mid-Level Process) als primäre Erkennungsdimension

**Zweck:** Prozess-Unterscheidung Retrieval (Picking/Packing) vs. Storage (Unpacking/Storing)

**Inhalt:**
- CC09 ist nun 4. primäre Erkennungskategorie
- 8 Labels integriert: CL114-CL121
- Hierarchie dokumentiert: CC08 → CC09 → CC10
- Validierungsregeln für Prozess-Exklusivität

**Begründung:** BPMN (Abbildung 11) zeigt klare Trennung

---

### 2. "Other"-Restkategorie aktiv erkennbar

**Zweck:** Verhinderung von False-Positives bei S1-S8

**Inhalt:**
- CL112/113 definieren "Other"
- "Other" als **Priorität 1** im Decision Tree
- Frame-Level-Erkennung

**Problem vorher:** Frames mit CL112/CL113 wurden fälschlich S1-S8 zugeordnet

**Lösung:**
```python
# ALT (v2.4): 
if CC08 == CL112: ignore()  # → Frame landet bei S1!

# NEU (v2.5):
if CC08 in [CL112, CL113]: return "Other"  # → Korrekt!
```

---

### 3. Frame-Level-Algorithmus

**Zweck:** Präzise Klassifikation jedes Frames

**Inhalt:**
- Jeder Frame wird auf **21 erkennungsrelevante Labels** geprüft
- Pseudocode in `scenario_boundary_detection.md`

**Schritte:**
1. "Other" prüfen (PRIORITÄT 1)
2. High-Level Process (CC08)
3. CC09 validieren (Mid-Level)
4. Picking Strategy (Single/Multi)
5. IT-System (CC07)
6. Order (CC06)
7. Szenario bestimmen

---

### 4. Explizite Inaktiv-Constraints

**Zweck:** Robuste Validierung durch Single-Label-Prinzip

**Inhalt:**
- "Muss 0 sein"-Bedingungen dokumentiert
- Neue Validierungsregeln V-S11 bis V-S15

**Beispiel:**
```python
IF CC08 == CL110 (Retrieval):
    ASSERT CL111 == 0  # Storage muss inaktiv sein
```

---

## 🔄 Aktualisierte Dateien

| Datei | Änderungen | Zeilen |
|-------|-----------|--------|
| `ground_truth_matrix.md` | 6 Dimensionen, Decision Tree neu, "Other" | +80 |
| `label_activity_matrix.md` | CC09 hinzugefügt, CC10 sekundär | +40 |
| `scenario_boundary_detection.md` | **Komplett neu:** Frame-Level | +300 |
| `validation_logic_extended.md` | 5 neue Regeln (V-S11 bis V-S15) | +100 |
| `SKILL.md` | Version 2.5, CC09-Quick-Reference | +15 |
| `README.md` | Version 2.5, Features | +10 |
| **NEU:** `CHANGELOG_v2.4_to_v2.5.md` | Dieses Dokument | +200 |

**Gesamt:** ~745 neue Zeilen Dokumentation

---

## ⚠️ Breaking Changes

**KEINE Breaking Changes** für Szenario-Definitionen S1-S8:
- Alle High-Level, IT, Order, Strategy-Definitionen bleiben identisch
- Ground Truth Matrix (S1-S8) unverändert

**Änderungen betreffen nur:**
- Erkennungslogik (intern)
- Validierungsregeln (erweitert)
- "Other"-Handling (neu)

---

## 📊 Vorher/Nachher-Vergleich

### Erkennungsdimensionen

**v2.4:**
```
4 Kategorien, 13 Labels:
- CC06 (Order) – 4 Labels
- CC07 (IT) – 4 Labels
- CC08 (High-Level) – 4 Labels
- CC10 (Low-Level) – 1 Label  ← FALSCH!
```

**v2.5:**
```
5 Kategorien, 21 Labels:
- CC06 (Order) – 4 Labels
- CC07 (IT) – 4 Labels
- CC08 (High-Level) – 4 Labels
- CC09 (Mid-Level) – 8 Labels  ← NEU!
- CC10 (Low-Level) – 1 Label  ← Sekundär
```

---

### Decision Tree

**v2.4:**
```
1. Check CC08 (Retrieval/Storage)
2. Check IT (CL105/106/107)
3. Check Order (CL100/101/102)
4. Check Multi-Order
5. Bestimme Szenario
```

**v2.5:**
```
1. Check "Other" (CL112/113) ← NEU! PRIORITÄT 1
2. Check CC08 (Retrieval/Storage)
3. Validate CC09 (Picking/Storing) ← NEU!
4. Check Picking Strategy
5. Check IT
6. Check Order
7. Bestimme Szenario
```

---

## 🚀 Migration von v2.4 → v2.5

### Für Claude-Nutzer:
1. Skill deinstallieren
2. Neue Dateien hochladen (`knowledge/` + `SKILL.md`)
3. Skill reinstallieren

**Zeitaufwand:** ~5 Minuten

### Für Code-Implementierungen:

```python
# ALT (v2.4):
def detect_scenario(block):
    if block['CC08'] == 'CL110':  # Retrieval
        # ... nur CC08, IT, Order prüfen

# NEU (v2.5):
def detect_scenario_or_other(frame):  # Frame-Level!
    # 1. "Other" zuerst
    if frame['CC08'] in ['CL112', 'CL113']:
        return "Other"
    
    # 2. CC09 validieren
    if frame['CC08'] == 'CL110':
        assert has_picking(frame)  # CC09-Check!
```

**Tests aktualisieren:**
- "Other"-Erkennung testen
- CC09-Validierung testen
- Frame-Level-Logik testen

**Zeitaufwand:** ~30 Minuten

---

## 📚 Verwandte Dokumentation

- **Ground Truth Matrix:** `ground_truth_matrix.md` (v2.5)
- **Frame-Level-Algorithmus:** `scenario_boundary_detection.md` (v2.5)
- **Validierungsregeln:** `validation_logic_extended.md` (v2.5)
- **Label-Aktivität:** `label_activity_matrix.md` (v2.5)

---

## 📊 Statistiken

- **Dateien gesamt:** 20 (19 aktualisiert, 1 neu)
- **Dokumentation:** ~285 KB gesamt (~21 KB neu)
- **Erkennungsrelevante Labels:** 21 (vorher: 13)
- **Neue Validierungsregeln:** 5 (V-S11 bis V-S15)
- **Erkennungsdimensionen:** 6 (vorher: 5)

---

## ✅ Review & Freigabe

**Geprüft durch:** Markus (Thesis-Autor)  
**Basis:** DaRa-Paper (Tabelle 3, Abbildung 11)  
**Freigabedatum:** 05.01.2026  
**Status:** ✅ Freigegeben für v2.5

---

**Entwickelt für Thesis:** "Wenn ChatGPT Industrieabläufe analysiert – Potenzial von KI-Agenten für die automatisierte Prozess-Erkenntnis"  
**Universität:** TU Dortmund, Fakultät Logistik  
**Betreuer:** Friedrich Niemann

---

*Ende des Changelogs*
