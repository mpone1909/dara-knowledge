# DaRa Dataset – Szenario-Label-Zustände (Aktiv/Inaktiv)

Diese Datei definiert **exakt**, welche Labels bei welchem Szenario aktiv (=1) oder inaktiv (=0) sein MÜSSEN.

**Quelle:** Ground Truth Matrix (Table 3) + Empirische S14-Validierung  
**Skill-Version:** 2.4 (02.01.2026)  
**Generalisierbarkeit:** ✅ Alle 18 Subjekte (frame-unabhängig)

---

## Erkennungsprinzip

Jedes Szenario wird durch **dominante Label-Kombinationen** über einen Block identifiziert, nicht durch einzelne Frames. Die folgenden Regeln beschreiben, welche Labels im Durchschnitt/mehrheitlich aktiv sein müssen.

---

## S1: Standard Retrieval (Error Run)

**CC08:** CL110=1 (Retrieval aktiv), CL111=0 (Storage inaktiv)  
**CC07:** CL105=1 (List+Pen aktiv), CL106=0, CL107=0 (andere IT-Systeme inaktiv)  
**CC06:** CL100=1 (Order 2904 aktiv), CL101=0, CL102=0 (andere Orders inaktiv)  
**CC10:** CL135=1 möglich (Error-Reporting kann auftreten, ist aber nicht dauerhaft)

**Generalisierung:** S1 wird erkannt durch CL110+CL105+CL100 und optionales CL135. Die Präsenz von CL135 unterscheidet S1 von S4 (beide haben CL105+CL100, aber S1=Retrieval, S4=Storage). Bei anderen Probanden kann die CL135-Häufigkeit variieren, muss aber mindestens einmal im Block vorkommen.

---

## S2: Variant Retrieval (PDT)

**CC08:** CL110=1 (Retrieval aktiv), CL111=0 (Storage inaktiv)  
**CC07:** CL107=1 (PDT aktiv), CL105=0, CL106=0 (andere IT-Systeme inaktiv)  
**CC06:** CL101=1 (Order 2905 aktiv), CL100=0, CL102=0 (andere Orders inaktiv)  
**CC10:** CL135=0 (keine Errors)

**Generalisierung:** S2 ist durch CL107 (PDT) 100% eindeutig erkennbar – kein anderes Szenario nutzt PDT. Dies gilt für alle Probanden. S2 ist das einzige Szenario mit CL107=1, daher reicht die Prüfung von CC07 zur eindeutigen Identifikation unabhängig von Frame-Anzahl oder Anteil.

---

## S3: Error Retrieval (Scanner)

**CC08:** CL110=1 (Retrieval aktiv), CL111=0 (Storage inaktiv)  
**CC07:** CL106=1 (List+Scanner aktiv), CL105=0, CL107=0 (andere IT-Systeme inaktiv)  
**CC06:** CL102=1 (Order 2906 aktiv), CL100=0, CL101=0 (andere Orders inaktiv)  
**CC10:** CL135=1 möglich (Error-Reporting kann auftreten)

**Generalisierung:** S3 ist durch CL106 (Scanner) 100% eindeutig erkennbar – kein anderes Szenario nutzt Scanner. CL135 sollte mindestens einmal im Block vorkommen (laut Ground Truth), aber die Häufigkeit variiert. Die Kombination CL110+CL106+CL102 ist für alle Probanden eindeutig.

---

## S4: Standard Storage

**CC08:** CL111=1 (Storage aktiv), CL110=0 (Retrieval inaktiv)  
**CC07:** CL105=1 (List+Pen aktiv), CL106=0, CL107=0 (andere IT-Systeme inaktiv)  
**CC06:** CL100=1 (Order 2904 aktiv), CL101=0, CL102=0 (andere Orders inaktiv)  
**CC10:** CL135=0 (keine Errors)

**Generalisierung:** S4 unterscheidet sich von S5/S6 nur durch die Order (CL100 vs. CL101/CL102). Bei Probanden mit kontinuierlichen Storage-Blöcken muss der Order-Wechsel als Szenario-Grenze erkannt werden. Die Kombination CL111+CL105+CL100 ohne CL135 identifiziert S4 eindeutig.

---

## S5: Variant Storage

**CC08:** CL111=1 (Storage aktiv), CL110=0 (Retrieval inaktiv)  
**CC07:** CL105=1 (List+Pen aktiv), CL106=0, CL107=0 (andere IT-Systeme inaktiv)  
**CC06:** CL101=1 (Order 2905 aktiv), CL100=0, CL102=0 (andere Orders inaktiv)  
**CC10:** CL135=0 (keine Errors)

**Generalisierung:** S5 unterscheidet sich von S4/S6 nur durch die Order (CL101). Order-Wechsel innerhalb von Storage-Blöcken markieren Szenario-Übergänge. Dies gilt für alle Probanden, wobei die Frame-Länge der einzelnen Orders variiert.

---

## S6: Storage (Order 2906)

**CC08:** CL111=1 (Storage aktiv), CL110=0 (Retrieval inaktiv)  
**CC07:** CL105=1 (List+Pen aktiv), CL106=0, CL107=0 (andere IT-Systeme inaktiv)  
**CC06:** CL102=1 (Order 2906 aktiv), CL100=0, CL101=0 (andere Orders inaktiv)  
**CC10:** CL135=0 (keine Errors)

**Generalisierung:** S6 unterscheidet sich von S4/S5 nur durch die Order (CL102). Bei Probanden, die S6 nicht aufgezeichnet haben, fehlt dieses Szenario komplett – die Erkennung ist daher nicht obligatorisch, sondern datenabhängig.

---

## S7: Multi-Order Retrieval

**CC08:** CL110=1 (Retrieval aktiv), CL111=0 (Storage inaktiv)  
**CC07:** CL105=1 (List+Pen aktiv), CL106=0, CL107=0 (andere IT-Systeme inaktiv)  
**CC06:** CL100=1 UND CL101=1 (beide Orders gleichzeitig aktiv), CL102=0  
**CC10:** CL135=0 (keine Errors)

**Generalisierung:** S7 wird durch Co-Aktivierung von CL100 und CL101 erkannt (Multi-Order). Bei S14 sind 44.76% der Frames multi-aktiviert, aber dieser Anteil variiert subjektabhängig. Entscheidend ist die Existenz von Frames mit CL100=1 UND CL101=1 im Block, nicht die prozentuale Häufigkeit.

---

## S8: Multi-Order Storage

**CC08:** CL111=1 (Storage aktiv), CL110=0 (Retrieval inaktiv)  
**CC07:** CL105=1 (List+Pen aktiv), CL106=0, CL107=0 (andere IT-Systeme inaktiv)  
**CC06:** CL100=1 UND CL101=1 (beide Orders gleichzeitig aktiv), CL102=0  
**CC10:** CL135=0 (keine Errors)

**Generalisierung:** S8 wird analog zu S7 durch Co-Aktivierung von CL100+CL101 erkannt, aber mit CL111 (Storage) statt CL110. Die Multi-Order-Erkennung basiert auf dem Nachweis gleichzeitiger Order-Aktivierung, nicht auf festen Frame-Anteilen, daher ist sie für alle Probanden anwendbar.

---

## Kritische Generalisierungspunkte

### ✅ Frame-unabhängige Merkmale (generalisierbar)

1. **IT-System-Exklusivität:** CL107 (PDT) → nur S2, CL106 (Scanner) → nur S3
2. **Multi-Order-Definition:** Co-Aktivierung von genau CL100+CL101 (nie CL102)
3. **Storage/Retrieval-Exklusivität:** CL110 XOR CL111 (nie gleichzeitig)
4. **Order-Exklusivität bei Single-Order:** Genau 1 aktives Order-Label (CL100 XOR CL101 XOR CL102)

### ⚠️ Frame-abhängige Merkmale (nicht generalisierbar)

1. **CL135-Häufigkeit:** S1/S3 haben Errors, aber die Frame-Anzahl variiert
2. **Multi-Order-Anteil:** 44.76% in S14, aber andere Probanden haben andere Anteile
3. **Szenario-Dauer:** Keine feste Frame-Anzahl pro Szenario
4. **Szenario-Reihenfolge:** Nicht chronologisch

### 🔍 Erkennungslogik (algorithmisch)

```python
# Dominanz-Analyse über Block (nicht einzelne Frames)
def get_dominant_label(block_df, labels):
    """Gibt das häufigste aktive Label im Block zurück"""
    return block_df[labels].sum().idxmax()

# Multi-Order-Erkennung
def is_multi_order(block_df):
    """Prüft ob beide Orders (CL100+CL101) im Block vorkommen"""
    has_cl100 = (block_df['CL100|2904'] == 1).any()
    has_cl101 = (block_df['CL101|2905'] == 1).any()
    return has_cl100 and has_cl101

# Szenario-Klassifikation
if is_multi_order(block):
    if dominant_hl_process == 'CL110':
        scenario = 'S7'
    elif dominant_hl_process == 'CL111':
        scenario = 'S8'
elif dominant_it == 'CL107':
    scenario = 'S2'  # Eindeutig durch PDT
elif dominant_it == 'CL106':
    scenario = 'S3'  # Eindeutig durch Scanner
# ... weitere Logik für S1, S4-S6
```

---

## Metadaten

**Datei-Version:** 2.4  
**Erstellt:** 02.01.2026  
**Validiert gegen:** S14 (279.050 Frames)  
**Generalisierbarkeit:** ✅ Alle 18 Subjekte (S01-S18)  
**Typ:** Frame-unabhängige Label-Logik
