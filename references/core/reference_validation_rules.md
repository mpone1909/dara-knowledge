---
version: 6.2.0
---

# Referenz: Frame-Level Validierungsregeln

**Version:** 6.2.0 (2026-03-10)
**Basis:** validation_rules v5.0 + DaRa-Dokumentation
**Änderungen v6.2.0:**
- VR-1: V-B4 Bereichskorrektur — CL028/CL029 in Pflichtmenge ergänzt
- VR-2: V-B5 Tabelle — Position-Unknown-Label (CL033/CL068) ergänzt
- VR-3: V-B7 CC11-Hierarchie — Level-2-Bereich präzisiert (CL164–CL176 fehlerhaft, jetzt korrekt)
- VR-4: V-EC2 Tool-Spalte — Fehlstellen mit Standardwert ergänzt
- VR-5: V-EC4 Storage-Phasen ergänzt (CL117, CL119, CL120 fehlten)
- VR-6: USAGE GUIDELINES — Verweise auf v5.0-Dateien als veraltet markiert
- VR-7: §6 Beziehungen — phase2_refa_analysis.md ergänzt
**Vorige Korrekturen:**
- v6.0: V-B3 CC09→CC10 Mapping entfernt (jetzt in phase4_bpmn_validation.md)
- v6.1.2: Edge-Case-Dokumentation aus v5.0 ergänzt (§5)

---

## 1. Master-Slave-Abhängigkeiten

### 1.1 CC01 (Main Activity) → Master für CC02–CC05

**Regel V-B1:** CC01 bestimmt den globalen Zustand. Sub-Aktivitäten müssen
semantisch passen.

```python
# Beispiel: Walking erfordert Gait Cycle
if CC01 == 'CL011':  # Walking
    assert CC02 == 'CL016'  # Gait Cycle (NICHT Standing Still)

# Beispiel: Standing erfordert Standing Still
if CC01 == 'CL012':  # Standing
    assert CC02 == 'CL018'  # Standing Still
```

**CC01 Prioritäts-Hierarchie (höchste → niedrigste):**

| Priorität | Label | Aktivität |
|:---------:|:------|:----------|
| 1 | CL001 | Synchronization |
| 2 | CL002 | Confirming with Pen |
| 3 | CL003 | Confirming with Screen |
| 4 | CL004 | Confirming with Button |
| 5 | CL005 | Scanning |
| 6 | CL006 | Pulling Cart |
| 7 | CL007 | Pushing Cart |
| 8 | CL008 | Handling Upwards |
| 9 | CL009 | Handling Centered |
| 10 | CL010 | Handling Downwards |
| 11 | CL011 | Walking |
| 12 | CL012 | Standing |
| 13 | CL013 | Sitting |
| 14 | CL014 | Another Main Activity |
| 15 | CL015 | Main Activity Unknown |

**Praktische Beispiele:**

| Situation | CC01 priorisiert | Begründung |
|:----------|:-----------------|:-----------|
| Gehen + Wagen schieben | CL007 (Pushing Cart) | Pushing > Walking |
| Gehen + Scannen | CL005 (Scanning) | Scanning > Walking |
| Stehen + Bestätigung am PDT | CL003 (Confirming) | Confirming > Standing |
| Greifen während Gehen | CL008/09/10 (Handling) | Handling > Walking |

---

### 1.2 CC08 → CC09 (High-Level → Mid-Level)

**Regel V-B2:**

| CC08 | Erlaubte CC09 |
|:-----|:-------------|
| CL110 Retrieval | CL114, CL115, CL116, CL118, CL121 |
| CL111 Storage | CL114, CL117, CL119, CL120, CL121 |
| CL112 Another Process | CL122 oder CL123 (nicht Retrieval/Storage-Labels) |
| CL113 Process Unknown | CL122, CL123 |

**Klarstellung v6.2.0:** CL112 erlaubt explizit nur CL122/CL123, nicht "beliebig".
CL114 und CL121 (Preparing/Finalizing) sind in CL110 und CL111 erlaubt,
aber NICHT in CL112/CL113.

CL114 (Preparing) und CL121 (Finalizing) sind in Retrieval (CL110)
und Storage (CL111) erlaubt.

---

### 1.3 CC09 → CC10 (Mid-Level → Low-Level)

**Regel V-B3:** Siehe **phase4_bpmn_validation.md §2–3** für das vollständige,
korrigierte Mapping basierend auf BPMN Figures A2–A7.

Das v5.0 Mapping war in 6/8 Phasen fehlerhaft und wurde in v6.0 entfernt.

---

## 2. Label-Kombinationsregeln

### 2.1 Single-Label-Prinzip

Diese Kategorien dürfen pro Frame nur GENAU EIN aktives Label haben:

**CC01, CC02, CC07, CC08, CC09, CC10**

### 2.2 Multi-Label-Regeln

#### CC03 (Torso) — Regel V-B4: Max 2 Labels

**Korrektur v6.2.0 (VR-1):** Die Pflichtmenge umfasst CL024–CL029 (alle 6 Labels),
nicht nur CL024–CL026. CL028 (Another) und CL029 (Unknown) sind ebenfalls
als Einzellabels gültig.

- **Pflicht:** Exakt 1 Label aus {CL024, CL025, CL026, CL028, CL029} — immer aktiv
- **Optional:** + 1 Rotationslabel (CL027) — additiv, nur kombiniert mit Beugungslabel

| Kombination | Erlaubt? |
|:------------|:---------|
| CL024 No Bending | ✅ |
| CL025 Slightly Bending + CL027 Rotation | ✅ |
| CL028 Another Torso Activity | ✅ |
| CL029 Torso Activity Unknown | ✅ |
| CL027 Rotation allein (ohne Beugungslabel) | ❌ |
| CL025 + CL026 (zwei Beugungen) | ❌ |
| CL028 + CL024 (zwei Nicht-Rotations-Labels) | ❌ |

#### CC04/CC05 (Hands) — Regel V-B5: Exakt 4 Labels

Jede Hand benötigt exakt 4 Dimensionen:

**Korrektur v6.2.0 (VR-2):** Position-Unknown-Labels (CL033/CL068) ergänzt.

| Dimension | CC04 (Left Hand) Labels | CC05 (Right Hand) Labels |
|:----------|:------------------------|:------------------------|
| Position | CL030 Up / CL031 Center / CL032 Down / **CL033 Unknown** | CL065 / CL066 / CL067 / **CL068 Unknown** |
| Movement | CL034–CL039 | CL069–CL074 |
| Object | CL040–CL051 | CL075–CL086 |
| Tool | CL052–CL064 | CL087–CL099 |

Pro Dimension exakt 1 Label. Insgesamt exakt 4 pro Hand.

#### CC06 (Order) — Regel V-B6: Szenario-abhängig

- Single-Order (S1–S6): Exakt 1 Order-Label aus {CL100, CL101, CL102}
- Multi-Order (S7/S8): Exakt CL100 + CL101 (Orders 2904+2905) — keine anderen Kombinationen
- CL103 (No Order) und CL104 (Unknown) sind exklusiv (nie mit anderen Order-Labels kombinierbar)

#### CC11 (Location Human) — Regel V-B7: Max 3 Labels

**Korrektur v6.2.0 (VR-3):** Level-2-Bereich präzisiert.

Hierarchische Struktur (aus `reference_labels.md §13`):

| Level | Labels | Beschreibung |
|:------|:-------|:-------------|
| Level 1 Main Area | CL155–CL163 | Office, Cart Area, Cardboard Box Area, Base, Packing/Sorting Area, Issuing/Receiving Area, Path, Cross Aisle Path, Aisle Path |
| Level 2 Sub-Area | CL164–CL176 | Path-Subtypen (CL164–CL167), Cross-Aisle-Segmente (CL168–CL171), Aisle-Nummern 1–5 (CL172–CL176) |
| Level 3 Position | CL177–CL178 | Front (CL177), Back (CL178) |

Max 1 Label pro Level. Gesamt max 3.

**Hinweis Level 2:** CL179 (Another Location) und CL180 (Location Unknown)
sind eigenständige Level-1-äquivalente Labels, nicht Level 2. Sie ersetzen
die gesamte Hierarchie wenn aktiv.

#### CC12 (Location Cart) — Regel V-B8: Max 4 Labels

Wie CC11, aber zusätzlich CL181 (Transition between Areas) möglich.
Struktur: Level 1 (CL182–CL190) → Level 2 → Level 3 → + optional CL181.

CL181 markiert den Zeitraum, in dem der Wagen eine Zonengrenze überquert
(erstes Rad bis letztes Rad). CL181 ist immer kombiniert mit einem Bereichs-Label
(orientiert am Bluetooth-Beacon-Standort, nicht an den Rädern).

**CL181 ist ausschließlich in CC12 vorhanden — kein Pendant in CC11.**

---

## 3. Spezielle Validierungen

### 3.1 CC09-Konsistenz (V-P1)

| Szenario-Gruppe | Erlaubte CC09 |
|:----------------|:-------------|
| S1, S2, S3, S7 (Retrieval) | CL114, CL115, CL116, CL118, CL121 |
| S4, S5, S6, S8 (Storage) | CL114, CL117, CL119, CL120, CL121 |
| Other | CL122, CL123, CL134 (als CC10-Global-Interrupt) |

**Hinweis:** CL122/CL123 sind die CC09-Labels für Other-Prozesse.
CL134 ist ein CC10-Label (kein CC09), das als Global Interrupt in allen
Szenarien erscheinen kann.

### 3.2 CL135 Aktivierung (V-E1)

CL135 (Reporting and Clarifying the Incident) ist ein aktiver CC10-Prozessschritt,
KEIN Error-Flag.

| Szenario | CL135-Erwartung | Begründung |
|:---------|:----------------|:-----------|
| S1, S3 | Erwartet | Intentional Errors geplant |
| S2 | Nicht geplant | Standard-Retrieval ohne Errors |
| S4, S6 | Nicht geplant | Standard-Storage ohne Errors |
| S5 | Möglich | CL135 in Storing-Phase möglich |
| S7, S8 | Nicht erwartet | Perfect Run |
| Other | Nicht erwartet | Organisatorische Zeit |

**Korrektur v6.2.0:** S4 und S6 nun explizit als "Nicht geplant" ausgewiesen
(vorher zusammengefasst als "S4, S5, S6 = Möglich", was für S4 und S6 zu weit war).
Nur S5 hat eine plausible CL135-Erwartung in der Storing-Phase.

CL135 tritt in Travel-Phasen auf (CL115, CL119), wenn Fehler geklärt werden.

---

## 4. Validierungs-Reihenfolge

```python
def validate_frame(frame, scenario):
    # 1. Master-Slave Dependencies
    validate_cc01_master(frame)           # V-B1
    validate_cc08_cc09_hierarchy(frame)   # V-B2

    # 2. Single-Label Prinzip
    validate_single_label(frame)          # CC01, CC02, CC07, CC08, CC09, CC10

    # 3. Multi-Label Regeln
    validate_cc03_torso(frame)            # V-B4
    validate_cc04_cc05_hands(frame)       # V-B5
    validate_cc06_orders(frame, scenario) # V-B6
    validate_cc11_location(frame)         # V-B7
    validate_cc12_location(frame)         # V-B8

    # 4. Prozess-Spezifika
    validate_cc09_consistency(scenario)   # V-P1

    # 5. Error-Handling
    validate_cl135_activation(scenario)   # V-E1

    # 6. CC09→CC10 Mapping (delegiert)
    # V-B3: Siehe phase4_bpmn_validation.md §2–3
```

**Hinweis:** validate_cc09_cc10_hierarchy (V-B3) wurde aus dieser Funktion
entfernt (v6.0) — sie ist vollständig in phase4_bpmn_validation.md implementiert.

---

## 5. Edge-Cases und Konfliktsituationen

### 5.1 CC01/CC02 Konflikte (V-EC1)

**Problem:** Was gilt, wenn CC01 und CC02 semantisch widersprüchlich annotiert sind?

| CC01 | CC02 annotiert | Korrekt? | Lösung |
|:-----|:---------------|:---------|:-------|
| CL011 Walking | CL018 Standing Still | ❌ | CC02 → CL016 (Gait Cycle) |
| CL012 Standing | CL016 Gait Cycle | ❌ | CC02 → CL018 (Standing Still) |
| CL013 Sitting | CL016 Gait Cycle | ❌ | CC02 → CL019 (Sitting) |
| CL006 Pulling Cart | CL018 Standing Still | ❌ | CC02 → CL016 (Gait Cycle) |
| CL007 Pushing Cart | CL018 Standing Still | ❌ | CC02 → CL016 (Gait Cycle) |
| CL008 Handling Up | CL016 Gait Cycle | ⚠️ | Möglich (Greifen im Gehen) |
| CL005 Scanning | CL017 Step | ⚠️ | Möglich (Scan nach Schritt) |

**Regel:** CC01 hat Vorrang. CC02 muss angepasst werden.

### 5.2 CC04/CC05 Leere-Frame-Behandlung (V-EC2)

**Problem:** Frames, in denen eine Hand-Dimension keinen sinnvollen Wert hat.

**Korrektur v6.2.0 (VR-4):** Tool-Spalte mit Standardwert ergänzt.

| Situation | Position | Movement | Object | Tool |
|:----------|:---------|:---------|:-------|:-----|
| Hand nicht sichtbar | CL033/CL068 Unknown | CL039/CL074 Unknown | CL051/CL086 Unknown | CL064/CL099 Another Tool |
| Hand inaktiv (hängt) | CL032/CL067 Downwards | CL037/CL072 No Movement | CL040/CL075 No Object | CL064/CL099 Another Tool |
| Hand am Wagen (Push) | CL031/CL066 Centered | CL036/CL071 Holding | CL045/CL080 Cart | CL064/CL099 Another Tool |

**Regel:** Unbekannt (Unknown) nur, wenn die Hand wirklich nicht identifizierbar ist.
"No Movement" + "No Object" ist der korrekte Leerlauf-Zustand. Die Tool-Dimension
muss immer befüllt sein — CL064/CL099 (Another Tool) als Fallback wenn kein
spezifisches Werkzeug aktiv ist.

### 5.3 CC11/CC12 Transition-Edges (V-EC3)

**Problem:** Person und Wagen können in verschiedenen Zonen sein.

| Situation | CC11 (Human) | CC12 (Cart) |
|:----------|:-------------|:------------|
| Person in Gasse, Wagen an Base | CL163 Aisle Path | CL185 Base |
| Person am Packtisch, Wagen in Cart Area | CL159 Packing Area | CL183 Cart Area |
| Wagen in Transition | Kein CL181 in CC11 | CL181 + Bereichs-Label |

**Regel:** CC11 und CC12 sind **unabhängig** voneinander. CL181 existiert nur in CC12,
nie in CC11. Die Beacon-Position des Wagens bestimmt das CC12-Bereichs-Label
während Transition (nicht die Rad-Position).

### 5.4 CC09-Location-Erwartungen (V-EC4)

**Plausibilitätsprüfung:** Bestimmte CC09-Phasen erwarten bestimmte Locations.

**Korrektur v6.2.0 (VR-5):** Storage-Phasen CL117, CL119, CL120 ergänzt (fehlten).

| CC09 | Erwartete CC11 Locations |
|:-----|:-------------------------|
| CL114 Preparing Order | CL155 Office, CL156 Cart Area, CL157 Cardboard Box Area |
| CL115 Picking Travel | CL161 Path, CL162 Cross Aisle, CL163 Aisle Path |
| CL116 Picking Pick | CL163 Aisle Path (+ CL172–CL176 Aisle-Nr., + CL177/CL178 Front/Back) |
| CL117 Unpacking | CL159 Packing/Sorting Area |
| CL118 Packing | CL159 Packing/Sorting Area |
| CL119 Store Travel | CL161 Path, CL162 Cross Aisle, CL163 Aisle Path |
| CL120 Store Time | CL163 Aisle Path (+ CL172–CL176 Aisle-Nr., + CL177/CL178 Front/Back) |
| CL121 Finalizing | CL155 Office, CL156 Cart Area, CL160 Issuing Area |

**Hinweis:** Dies sind Erwartungen, keine harten Constraints. Abweichungen
sind möglich (z.B. Proband geht falsch, CL135 Incident → Office).
Abweichungen werden als WARNING klassifiziert (nicht CRITICAL).

---

## 6. Beziehung zu anderen Dateien

**Korrektur v6.2.0 (VR-7):** phase2_refa_analysis.md ergänzt.

| Datei | Fokus | Frage |
|:------|:------|:------|
| **reference_validation_rules.md** (diese) | Frame-Level | Labels innerhalb eines Frames konsistent? |
| **phase1_scenario_recognition.md** | Szenario-Level | Welches Szenario hat der Frame? |
| **phase2_refa_analysis.md** | REFA-Zeitarten | V-B1, V-B4, V-P1, V-E1 als Voraussetzung |
| **phase4_bpmn_validation.md** | Prozess-Level | Passt CC09→CC10 zum BPMN-Modell? (V-B3) |

---

## 7. Veraltete Referenzen (veraltet seit v6.0)

**Korrektur v6.2.0 (VR-6):** Die folgenden Dateipfade aus der v5.0-Ära sind
in reference_labels.md §USAGE GUIDELINES noch referenziert, aber nicht mehr gültig:

| Veralteter Verweis | Ersatz |
|:-------------------|:-------|
| `references/core/category_activation_matrix_v5_0.md` | Aktivierungsregeln jetzt in `reference_activation_rules.md` |
| `references/core/validation_rules_v5_0.md` | Diese Datei (`reference_validation_rules.md` v6.x) |
| `assets/query_patterns_v5_0.md` | Nicht migriert — Inhalt in SKILL.md integriert |

Diese Verweise in `reference_labels.md §USAGE GUIDELINES` sollten auf die
aktuellen v6.x-Dateien aktualisiert werden.

<!-- VERIFICATION_TOKEN: DARA-VALRL-7J2F-v630 -->
