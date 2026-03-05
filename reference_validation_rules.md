# Referenz: Frame-Level Validierungsregeln

**Version:** 6.1.2 (2026-02-26)
**Basis:** validation_rules v5.0 + DaRa-Dokumentation
**Korrektur v6.0:** V-B3 CC09→CC10 Mapping entfernt (jetzt in phase4_bpmn_validation.md)
**Rückführung v6.1.2:** Edge-Case-Dokumentation aus v5.0 ergänzt (§5)

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
| CL112 Another Process | Beliebig oder CL122/CL123 |
| CL113 Process Unknown | CL122, CL123 |

CL114 (Preparing) und CL121 (Finalizing) sind in beiden Prozessen erlaubt.

---

### 1.3 CC09 → CC10 (Mid-Level → Low-Level)

**Regel V-B3:** Siehe **phase4_bpmn_validation.md** für das vollständige,
korrigierte Mapping basierend auf BPMN Figures A2–A7.

---

## 2. Label-Kombinationsregeln

### 2.1 Single-Label-Prinzip

Diese Kategorien dürfen pro Frame nur GENAU EIN aktives Label haben:

**CC01, CC02, CC07, CC08, CC09, CC10**

### 2.2 Multi-Label-Regeln

#### CC03 (Torso) — Regel V-B4: Max 2 Labels

- Exakt 1 Beugungslabel (CL024–CL026, CL028–CL029) — Pflicht
- Optional + 1 Rotationslabel (CL027) — additiv

| Kombination | Erlaubt? |
|:------------|:---------|
| CL024 No Bending | ✅ |
| CL025 Slightly Bending + CL027 Rotation | ✅ |
| CL025 + CL026 (zwei Beugungen) | ❌ |

#### CC04/CC05 (Hands) — Regel V-B5: Exakt 4 Labels

Jede Hand benötigt exakt 4 Dimensionen:

| Dimension | CC04 (Left Hand) | CC05 (Right Hand) |
|:----------|:-----------------|:------------------|
| Position | CL030–CL032 (Up/Center/Down) | CL065–CL067 |
| Movement | CL034–CL039 | CL069–CL074 |
| Object | CL040–CL051 | CL075–CL086 |
| Tool | CL052–CL064 | CL087–CL099 |

Pro Dimension exakt 1 Label. Insgesamt exakt 4 pro Hand.

#### CC06 (Order) — Regel V-B6: Szenario-abhängig

- Single-Order (S1–S6): Exakt 1 Order-Label
- Multi-Order (S7/S8): Exakt CL100 + CL101 (Orders 2904+2905)
- CL103 (No Order) und CL104 (Unknown) sind exklusiv

#### CC11 (Location Human) — Regel V-B7: Max 3 Labels

Hierarchische Struktur:

| Level | Labels | Beschreibung |
|:------|:-------|:-------------|
| Level 1 Main Area | CL155–CL163 | Office, Cart Area, Aisle, etc. |
| Level 2 Sub-Area | CL164–CL176 | Path-Subtypen, Aisle 1–5 |
| Level 3 Position | CL177–CL178 | Front, Back |

Max 1 Label pro Level. Gesamt max 3.

#### CC12 (Location Cart) — Regel V-B8: Max 4 Labels

Wie CC11, aber zusätzlich CL181 (Transition between Areas) möglich.
Normal max 3 + optional Transition = max 4.

CL181 markiert den Zeitraum, in dem der Wagen eine Zonengrenze überquert
(erstes Rad bis letztes Rad).

---

## 3. Spezielle Validierungen

### 3.1 CC09-Konsistenz (V-P1)

| Szenario-Gruppe | Erlaubte CC09 |
|:----------------|:-------------|
| S1, S2, S3, S7 (Retrieval) | CL114, CL115, CL116, CL118, CL121 |
| S4, S5, S6, S8 (Storage) | CL114, CL117, CL119, CL120, CL121 |
| Other | Beliebig |

### 3.2 CL135 Aktivierung (V-E1)

CL135 (Reporting and Clarifying the Incident) ist ein aktiver CC10-Prozessschritt,
KEIN Error-Flag.

| Szenario | CL135-Erwartung | Begründung |
|:---------|:----------------|:-----------|
| S1, S3 | Erwartet | Intentional Errors geplant |
| S2 | Nicht geplant | Standard-Retrieval ohne Errors |
| S4, S5, S6 | Möglich | Konservativ, nicht erzwungen |
| S7, S8 | Nicht erwartet | Perfect Run |
| Other | Nicht erwartet | Organisatorische Zeit |

CL135 tritt in Travel-Phasen auf (CL115, CL119), wenn Fehler geklärt werden
(Weg Büro → Klärung → Rückweg).

---

## 4. Validierungs-Reihenfolge

```python
def validate_frame(frame, scenario):
    # 1. Master-Slave Dependencies
    validate_cc01_master(frame)           # V-B1
    validate_cc08_cc09_hierarchy(frame)   # V-B2
    validate_cc09_cc10_hierarchy(frame)   # V-B3 (→ phase4_bpmn_validation.md)

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
```

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
| CL008 Handling Up | CL016 Gait Cycle | ⚠️ | Möglich (Greifen im Gehen) |
| CL005 Scanning | CL017 Step | ⚠️ | Möglich (Scan nach Schritt) |

**Regel:** CC01 hat Vorrang. CC02 muss angepasst werden.

### 5.2 CC04/CC05 Leere-Frame-Behandlung (V-EC2)

**Problem:** Frames, in denen eine Hand-Dimension keinen sinnvollen Wert hat.

| Situation | Position | Movement | Object | Tool |
|:----------|:---------|:---------|:-------|:-----|
| Hand nicht sichtbar | CL033 Unknown | CL039 Unknown | CL051 Unknown | — |
| Hand inaktiv (hängt) | CL032 Downwards | CL037 No Movement | CL040 No Object | — |
| Hand am Wagen (Push) | CL031 Centered | CL036 Holding | CL045 Cart | — |

**Regel:** Unbekannt (Unknown) nur, wenn die Hand wirklich nicht identifizierbar ist.
"No Movement" + "No Object" ist der korrekte Leerlauf-Zustand.

### 5.3 CC11/CC12 Transition-Edges (V-EC3)

**Problem:** Person und Wagen können in verschiedenen Zonen sein.

| Situation | CC11 (Human) | CC12 (Cart) |
|:----------|:-------------|:------------|
| Person in Gasse, Wagen an Base | CL163 Aisle Path | CL185 Base |
| Person am Packtisch, Wagen in Cart Area | CL159 Packing Area | CL183 Cart Area |
| Wagen in Transition | Kein CL181 | CL181 + Bereichs-Label |

**Regel:** CC11 und CC12 sind **unabhängig** voneinander. CL181 existiert nur in CC12.

### 5.4 CC09-Location-Erwartungen (V-EC4)

**Plausibilitätsprüfung:** Bestimmte CC09-Phasen erwarten bestimmte Locations.

| CC09 | Erwartete CC11 Locations |
|:-----|:-------------------------|
| CL114 Preparing Order | CL155 Office, CL156 Cart Area, CL157 Cardboard Box Area |
| CL115 Picking Travel | CL161 Path, CL162 Cross Aisle, CL163 Aisle Path |
| CL116 Picking Pick | CL163 Aisle Path (+ CL177/CL178 Front/Back) |
| CL118 Packing | CL159 Packing/Sorting Area |
| CL121 Finalizing | CL155 Office, CL156 Cart Area, CL160 Issuing Area |

**Hinweis:** Dies sind Erwartungen, keine harten Constraints. Abweichungen
sind möglich (z.B. Proband geht falsch, CL135 Incident → Office).

---

## 6. Beziehung zu anderen Dateien

| Datei | Fokus | Frage |
|:------|:------|:------|
| **reference_validation_rules.md** (diese) | Frame-Level | Labels innerhalb eines Frames konsistent? |
| **phase1_scenario_recognition.md** | Szenario-Level | Welches Szenario hat der Frame? |
| **phase4_bpmn_validation.md** | Prozess-Level | Passt CC09→CC10 zum BPMN-Modell? |
