---
version: 5.0
status: finalisiert
created: 2026-02-04
---

# MTM-1 Grundbewegungen â€“ DaRa-Mapping

**Quelle:** PDF "Anatomisch-Biomechanische Bewegungsanalyse der manuellen Kommissionierung", Seite 8-9  
**Version:** 1.1 (14.01.2026, korrigiert 04.02.2026)

---

## 1. MTM-Einheit (TMU)

**Definition:**
- **1 TMU** = 0,036 Sekunden
- **1 Stunde** = 100.000 TMU
- **1 Minute** = 1.667 TMU

**Zweck:** Standardisierte Zeiteinheit fÃ¼r Methods-Time Measurement (MTM)

---

## 2. MTM-1 Grundbewegungen

| MTM-Code | Bewegung (Deutsch) | Definition | Typischer TMU-Wert | Zeit (Sekunden) |
|----------|-------------------|------------|-------------------|-----------------|
| **R** | Hinlangen (Reach) | Leere Hand zur Ware bewegen | R50B: 18,4 TMU | 0,66s |
| **G** | Greifen (Grasp) | Kontrolle Ã¼ber Objekt erlangen | G1A: 2,0 TMU | 0,07s |
| **M** | Bringen (Move) | Objekt transportieren | M40B: 15,6 TMU | 0,56s |
| **P** | FÃ¼gen (Position) | Objekt exakt platzieren | P1SE: 5,6 TMU | 0,20s |
| **RL** | Loslassen (Release) | Kontrolle aufgeben | RL1: 2,0 TMU | 0,07s |
| **B** | Beugen (Bend) | Rumpfbeugung > KniehÃ¶he | B: 29,0 TMU | 1,04s |
| **W** | Gehen (Walk) | Pro Schritt (75-85cm) | W: 15,0 TMU | 0,54s |

---

## 3. MTM â†’ DaRa-Labels Mapping

### 3.1 MTM-Code: R (Reach / Hinlangen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL139 "Retrieving Items" (beinhaltet Hinlangen)
- **CC04/CC05 (Hand):** CL034/CL069 "Reaching, Grasping, Moving, Positioning and Releasing"

**REFA-Zeitart:** $t_{MH}$ (HaupttÃ¤tigkeit)

**Beispiel:** Hinlangen zu Hexagonal Nut (R4.2.2.B, 50cm Distanz) â†’ R50B: 18,4 TMU

---

### 3.2 MTM-Code: G (Grasp / Greifen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL139 "Retrieving Items" (beinhaltet Greifen)
- **CC04/CC05 (Hand):** CL034/CL069 "Reaching, Grasping..." + Object-Labels (CL041-CL043/CL076-CL078)

**REFA-Zeitart:** $t_{MH}$ (HaupttÃ¤tigkeit)

**Biomechanischer Korrelat:** Fingerflexion, Kraftgriff

**Beispiel:** Greifen von M5 Mutter (Small [S], alleinstehend) â†’ G1A: 2,0 TMU

---

### 3.3 MTM-Code: M (Move / Bringen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL140 "Moving to a Cart", CL151 "Placing Cardboard Box/Item in a Cart"
- **CC04/CC05 (Hand):** Hand-Items wÃ¤hrend Transport

**REFA-Zeitart:** $t_{MH}$ (HaupttÃ¤tigkeit)

**Biomechanischer Korrelat:** Isometrische Muskelarbeit (Schulter/Arm)

**Beispiel:** Bringen von Softshell-Jacke zum Wagen (40cm Distanz) â†’ M40B: 15,6 TMU

---

### 3.4 MTM-Code: P (Position / FÃ¼gen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL138 "Placing Items on a Rack", CL151 "Placing Cardboard Box/Item in a Cart"

**REFA-Zeitart:** $t_{MH}$ (HaupttÃ¤tigkeit)

**Biomechanischer Korrelat:** Feinmotorik, visuelle Kontrolle

**Beispiel:** Exaktes Platzieren von Artikel auf Wagen â†’ P1SE: 5,6 TMU

---

### 3.5 MTM-Code: RL (Release / Loslassen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL138 "Placing Items on a Rack" (implizit nach Platzierung)
- **CC04/CC05 (Hand):** Wechsel zu CL040/CL075 "No Object"

**REFA-Zeitart:** $t_{MH}$ (HaupttÃ¤tigkeit)

**Biomechanischer Korrelat:** Fingerextension

**Beispiel:** Loslassen nach Ablage â†’ RL1: 2,0 TMU

---

### 3.6 MTM-Code: B (Bend / Beugen)

**DaRa-Labels:**
- **CC03 (Torso):** CL026 "Strongly Bending" (> 30Â°)
- **CC04/CC05 (Hand Position):** CL032/CL067 "Downwards"

**REFA-Zeitart:** $t_{MH}$ (HaupttÃ¤tigkeit) + **Erholungszeit!**

**Biomechanischer Korrelat:** Exzentrische Rumpfextension, LWS-Belastung

**Beispiel:** BÃ¼cken zu Palmenerde (R7.3.1.A, Ebene 1) â†’ B: 29,0 TMU + Erholungszeit

**Wichtig:** Beugen zu Bodenebene (Ebene 1) erfordert erhÃ¶hte Erholungszeit aufgrund LWS-Belastung

---

### 3.7 MTM-Code: W (Walk / Gehen)

**DaRa-Labels:**
- **CC10 (Low-Level):** CL137 "Moving to the Next Position"
- **CC02 (Legs):** CL016 "Gait Cycle"
- **CC01 (Main):** CL011 "Walking"

**REFA-Zeitart:** $t_{MN}$ (NebentÃ¤tigkeit)

**Biomechanischer Korrelat:** Zyklische Beinbewegung (Gait Cycle)

**Beispiel:** Gehen von Aisle 1 zu Aisle 5 Ã¼ber Cross Aisle Path â†’ W pro Schritt: 15,0 TMU

---

## 4. Automatisierte MTM-Generierung aus DaRa

**Workflow:**

1. **Detektion:** Neuronales Netz erkennt DaRa-Label-Sequenz
2. **Mapping:** DaRa-Labels â†’ MTM-Codes
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
- Reach + Distanz (40cm) â†’ R40B: 15,6 TMU
- Grasp (Handy Unit, alleinstehend) â†’ G1A: 2,0 TMU

Gesamt: 17,6 TMU = 0,63 Sekunden
```

---

## 5. REFA-Zeitarten-Zuordnung

| MTM-Code | REFA-Zeitart | Symbol | DaRa Mid-Level (CC09) |
|----------|--------------|--------|----------------------|
| R, G, M, P, RL | HaupttÃ¤tigkeit | $t_{MH}$ | CL116 "Picking Pick Time", CL120 "Storing Store Time" |
| W | NebentÃ¤tigkeit | $t_{MN}$ | CL115 "Picking Travel Time", CL119 "Storing Travel Time" |
| B | HaupttÃ¤tigkeit + Erholung | $t_{MH}$ + $t_E$ | CL116/CL120 + Erholungszeit-Zuschlag |

**Wichtig:** Beugen (B) erfordert zusÃ¤tzliche Erholungszeit ($t_E$), insbesondere bei schweren Lasten (Large [L]) und Bodenebene (Ebene 1).

---

## 6. Verwendung in DaRa-Analyse

### REFA-Zeitarten-Berechnung

**Formel:**
```
t_MH = Î£(R + G + M + P + RL + B) fÃ¼r alle Picking/Storing AktivitÃ¤ten
t_MN = Î£(W) fÃ¼r alle Travel Time AktivitÃ¤ten
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
+ Erholungszeit fÃ¼r B + Large [L] â†’ ~15-20 Sekunden gesamt
```

---

## Metadaten

**Datei-Version:** 1.1 (korrigierte Label-Zuordnungen, Referenz-Versionierung)  
**Erstellt:** 14.01.2026  
**Update:** 04.02.2026  
**Quelle:** PDF "Anatomisch-Biomechanische Bewegungsanalyse", Seite 8-9  
**Verwendung:** MTM-1 Codes Referenz, DaRa-Label-Mapping, REFA-Zeitarten-Berechnung

---

## Verwendungshinweise

**Diese Datei nutzen fÃ¼r:**
- MTM-1 Grundbewegungen und TMU-Werte
- DaRa-Label â†’ MTM-Code Mapping
- Zeitberechnung fÃ¼r Bewegungssequenzen

**Verwandte Dateien:**
- [refa_analytics_v5.0.md](refa_analytics_v5.0.md) â€“ REFA-Zeitarten und Erholungszeit
- [labels_207_v5.0.md](../core/labels_207_v5.0.md) â€“ VollstÃ¤ndige Label-Definitionen
- [articles_inventory_v5.0.md](../core/articles_inventory_v5.0.md) â€“ Artikel-Gewichtsklassen
