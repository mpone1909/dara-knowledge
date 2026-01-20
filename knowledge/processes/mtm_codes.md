# MTM-1 Grundbewegungen – DaRa-Mapping

**Quelle:** PDF "Anatomisch-Biomechanische Bewegungsanalyse der manuellen Kommissionierung", Seite 8-9  
**Version:** 1.0 (14.01.2026)

---

## 1. MTM-Einheit (TMU)

**Definition:**
- **1 TMU** = 0,036 Sekunden
- **1 Stunde** = 100.000 TMU
- **1 Minute** = 1.667 TMU

**Zweck:** Standardisierte Zeiteinheit für Methods-Time Measurement (MTM)

---

## 2. MTM-1 Grundbewegungen

| MTM-Code | Bewegung (Deutsch) | Definition | Typischer TMU-Wert | Zeit (Sekunden) |
|----------|-------------------|------------|-------------------|-----------------|
| **R** | Hinlangen (Reach) | Leere Hand zur Ware bewegen | R50B: 18,4 TMU | 0,66s |
| **G** | Greifen (Grasp) | Kontrolle über Objekt erlangen | G1A: 2,0 TMU | 0,07s |
| **M** | Bringen (Move) | Objekt transportieren | M40B: 15,6 TMU | 0,56s |
| **P** | Fügen (Position) | Objekt exakt platzieren | P1SE: 5,6 TMU | 0,20s |
| **RL** | Loslassen (Release) | Kontrolle aufgeben | RL1: 2,0 TMU | 0,07s |
| **B** | Beugen (Bend) | Rumpfbeugung > Kniehöhe | B: 29,0 TMU | 1,04s |
| **W** | Gehen (Walk) | Pro Schritt (75-85cm) | W: 15,0 TMU | 0,54s |

---

## 3. MTM ↔ DaRa-Labels Mapping

### 3.1 MTM-Code: R (Reach / Hinlangen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL149 "Reaching for Items"
- **CC04/CC05 (Hand):** Arm-Bewegungen (implizit)

**REFA-Zeitart:** $t_{MH}$ (Haupttätigkeit) oder $t_{MN}$ (Nebentätigkeit)

**Beispiel:** Hinlangen zu Hexagonal Nut (R4.2.2.B, 50cm Distanz) → R50B: 18,4 TMU

---

### 3.2 MTM-Code: G (Grasp / Greifen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL150 "Grasping Items"
- **CC04/CC05 (Hand):** Hand-Items (CL036/CL071 "Handy Unit")

**REFA-Zeitart:** $t_{MH}$ (Haupttätigkeit)

**Biomechanischer Korrelat:** Fingerflexion, Kraftgriff

**Beispiel:** Greifen von M5 Mutter (Small [S], alleinstehend) → G1A: 2,0 TMU

---

### 3.3 MTM-Code: M (Move / Bringen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL146 "Placing Items"
- **CC04/CC05 (Hand):** Hand-Items während Transport

**REFA-Zeitart:** $t_{MH}$ (Haupttätigkeit)

**Biomechanischer Korrelat:** Isometrische Muskelarbeit (Schulter/Arm)

**Beispiel:** Bringen von Softshell-Jacke zum Wagen (40cm Distanz) → M40B: 15,6 TMU

---

### 3.4 MTM-Code: P (Position / Fügen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL146 "Placing Items" (implizit)

**REFA-Zeitart:** $t_{MH}$ (Haupttätigkeit)

**Biomechanischer Korrelat:** Feinmotorik, visuelle Kontrolle

**Beispiel:** Exaktes Platzieren von Artikel auf Wagen → P1SE: 5,6 TMU

---

### 3.5 MTM-Code: RL (Release / Loslassen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL146 "Placing Items" (implizit, nach Platzierung)

**REFA-Zeitart:** $t_{MH}$ (Haupttätigkeit)

**Biomechanischer Korrelat:** Fingerextension

**Beispiel:** Loslassen nach Ablage → RL1: 2,0 TMU

---

### 3.6 MTM-Code: B (Bend / Beugen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL129 "Bending"
- **CC03 (Torso):** CL025 "Downwards"

**REFA-Zeitart:** $t_{MH}$ (Haupttätigkeit) + **Erholungszeit!**

**Biomechanischer Korrelat:** Exzentrische Rumpfextension, LWS-Belastung

**Beispiel:** Bücken zu Palmenerde (R7.3.1.A, Ebene 1) → B: 29,0 TMU + Erholungszeit

**Wichtig:** Beugen zu Bodenebene (Ebene 1) erfordert erhöhte Erholungszeit aufgrund LWS-Belastung

---

### 3.7 MTM-Code: W (Walk / Gehen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL137 "Moving to Next Position"
- **CC02 (Legs):** CL022 "Walking"

**REFA-Zeitart:** $t_{MN}$ (Nebentätigkeit)

**Biomechanischer Korrelat:** Zyklische Beinbewegung (Gait Cycle)

**Beispiel:** Gehen von Aisle 1 zu Aisle 5 über Cross Aisle Path → W pro Schritt: 15,0 TMU

---

## 4. Automatisierte MTM-Generierung aus DaRa

**Workflow:**

1. **Detektion:** Neuronales Netz erkennt DaRa-Label-Sequenz
2. **Mapping:** DaRa-Labels → MTM-Codes
3. **Kalkulation:** TMU-Summe berechnen

**Beispiel:**

```
DaRa-Sequenz:
- CL020 "Standing Still" (CC02)
- CL066 "Right Hand" (CC05)
- CL027 "Centred" (CC03)
- CL149 "Reaching for Items" (CC10)
- CL071 "Handy Unit" (CC05)

MTM-Generierung:
- Reach + Distanz (40cm) → R40B: 15,6 TMU
- Grasp (Handy Unit, alleinstehend) → G1A: 2,0 TMU

Gesamt: 17,6 TMU = 0,63 Sekunden
```

---

## 5. REFA-Zeitarten-Zuordnung

| MTM-Code | REFA-Zeitart | Symbol | DaRa Mid-Level (CC09) |
|----------|--------------|--------|----------------------|
| R, G, M, P, RL | Haupttätigkeit | $t_{MH}$ | CL116 "Picking Pick Time", CL120 "Storing Store Time" |
| W | Nebentätigkeit | $t_{MN}$ | CL115 "Picking Travel Time", CL119 "Storing Travel Time" |
| B | Haupttätigkeit + Erholung | $t_{MH}$ + $t_E$ | CL116/CL120 + Erholungszeit-Zuschlag |

**Wichtig:** Beugen (B) erfordert zusätzliche Erholungszeit ($t_E$), insbesondere bei schweren Lasten (Large [L]) und Bodenebene (Ebene 1).

---

## 6. Verwendung in DaRa-Analyse

### REFA-Zeitarten-Berechnung

**Formel:**
```
t_MH = Σ(R + G + M + P + RL + B) für alle Picking/Storing Aktivitäten
t_MN = Σ(W) für alle Travel Time Aktivitäten
```

**Beispiel Order 2904, Position 14 (Palmenerde, R7.3.1.A):**
```
1. W (Walking to Aisle 4): ~200 TMU (Cross Aisle Path)
2. R50B (Reach to Ebene 1): 18,4 TMU
3. B (Bend to Bodenebene): 29,0 TMU
4. G1A (Grasp Bulky Unit): 2,0 TMU
5. M40B (Move to Cart): 15,6 TMU
6. RL1 (Release): 2,0 TMU

Gesamt: ~267 TMU = 9,6 Sekunden (ohne Erholungszeit)
+ Erholungszeit für B + Large [L] → ~15-20 Sekunden gesamt
```

---

## Metadaten

**Datei-Version:** 1.0  
**Erstellt:** 14.01.2026  
**Quelle:** PDF "Anatomisch-Biomechanische Bewegungsanalyse", Seite 8-9  
**Verwendung:** MTM-1 Codes Referenz, DaRa-Label-Mapping, REFA-Zeitarten-Berechnung
