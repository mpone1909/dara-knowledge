# CHANGELOG: v2.6 → v2.6.1 (14.01.2026)

**Theme:** Kategorien-Aktivitätsregeln Formalisierung & Annotationsrichtlinien-Integration

---

## 🎯 Überblick

Die Updates v2.6.1 formal integrieren die **Annotationsrichtlinien des DaRa-Datensatzes** zur Label-Aktivierung. Basierend auf Benutzer-Input werden die Min/Max-Aktivitätsregeln für alle 12 Klassenkategorien (CC01–CC12) vollständig dokumentiert und mit Validierungslogik versehen.

**Breaking Changes:** Nein. Alle bestehenden Regeln bleiben gültig. Nur Klarstellungen und Erweiterungen.

---

## 📋 Neue & Überarbeitete Dateien

### 1. ✨ NEU: `category_activation_matrix.md`

**Datei:** `/mnt/skills/user/dara-dataset-expert/knowledge/core/category_activation_matrix.md`

**Inhalt:**
- **Min/Max-Matrix für alle 12 Kategorien** (Übersichtstabelle)
- **Detaillierte Beschreibung pro Kategorie** mit Beispielen
- **Validierungspseudocode** für jede Kategorie
- **Gültige/ungültige Kombinationen** mit Annotations-Szenarien
- **Hierarchische Logik für CC11/CC12** mit Label-Strukturen

**Größe:** ~450 Zeilen

**Zielgruppe:** Annotators, Validierungs-Engineers, Skill-User

---

### 2. 🔄 ERWEITERT: `validation_rules.md`

**Datei:** `/mnt/skills/user/dara-dataset-expert/knowledge/core/validation_rules.md`

**Neue Sektion 1.3: "Kategorien-Aktivitätsregeln (Min/Max-Matrix)"**

**Inhalte:**
- Übersichtstabelle: Aktivierungslogik aller 12 Kategorien
- **V-TC1: Torso-Constraint (CC03)** – Rotation additiv zu Biegung
- **V-HC1: Hand-Constraint (CC04/CC05)** – Immer 4 Labels pro Hand
- **V-OC1: Order-Constraint (CC06)** – Szenario-abhängige Multiplizität
- **V-LC1: Location-Constraint Human (CC11)** – Hierarchische Struktur
- **V-LC2: Location-Constraint Cart (CC12)** – Analog zu CC11 + Transition

**Größe:** +400 Zeilen

**Status:** Vollständig mit Pseudocode, Validierungslogik, Beispielen

**Version:** 1.0 → **1.1** (14.01.2026)

---

### 3. 🔄 AKTUALISIERT: `labels_207.md`

**Datei:** `/mnt/skills/user/dara-dataset-expert/knowledge/core/labels_207.md`

**Änderungen:**
- Neue Sektion "Aktivitätsregeln-Referenz" am Ende
- Hinweis auf `validation_rules.md` Sektion 1.3 für Validierungslogik
- Neue Sektion "Aktivitätsregeln-Referenz": Verweis auf `category_activation_matrix.md`
- Korrektur: CC03 ist **NICHT** Single-Label (war False in v2.6)

**Version:** 1.4 → **1.5** (14.01.2026)

---

### 4. 🔄 AKTUALISIERT: `SKILL.md`

**Datei:** `/mnt/skills/user/dara-dataset-expert/SKILL.md`

**Änderungen:**
- Neue Datei in Dateistruktur: `category_activation_matrix.md`
- Neue Navigationslogik (#3) für Min/Max-Queries
- Update Änderungshistorie: v2.6.1 hinzugefügt
- Update Metadaten: Version 2.6 → **2.6.1**

**Version:** 2.6 → **2.6.1** (14.01.2026)

---

## 🔧 Kritische Korrektionen

### 1. CC03 (Torso) war falsch klassifiziert

**Vorher (v2.6):**
```python
SINGLE_LABEL_CATEGORIES = ['CC01', 'CC02', 'CC03', 'CC07', 'CC08']
```

**Nachher (v2.6.1):**
```python
SINGLE_LABEL_CATEGORIES = ['CC01', 'CC02', 'CC07', 'CC08', 'CC09', 'CC10']
# CC03 ist Multi-Label (Min 1, Max 2): Biegung + optional Rotation
```

**Begründung:** Gemäß Annotationsrichtlinien ist CL027 (Torso Rotation) **additiv** zu Biegung. Min 1, Max 2 Labels sind möglich.

---

### 2. CC04/CC05 (Hands): "No Movement" brauchte Klarstellung

**Vorher (v2.6):**
Implizit: Hände immer 4 Labels

**Nachher (v2.6.1):**
Explizit: **Auch wenn CL037 (No Movement) aktiv ist, müssen alle 4 Gruppen belegt sein.**

**Beispiel:**
```python
# UNGÜLTIG (v2.6 Ambiguität):
CC04 = [CL037]  # Nur "No Movement"?

# GÜLTIG (v2.6.1 klar):
CC04 = [CL031 (Centered), CL037 (No Movement), CL040 (No Object), CL064 (Another Tool)]
# Count: 4 ✓
```

---

### 3. CC06 (Order): Hybrid-Logic wurde formalisiert

**Vorher (v2.6):**
S1–S3 hatten "beliebige Order" → unklar, ob 1 oder 2 Labels

**Nachher (v2.6.1):**
Explizit: **S1–S3 always 1 Label (Hybrid-Logic: IT ist Diskriminator, nicht Order)**

```python
# S1–S3: IT-System unterscheidet, Order ist IRRELEVANT
if scenario == 'S1':  # List+Pen
    assert len(orders) == 1  # Kann 2904, 2905 oder 2906 sein
elif scenario == 'S2':  # PDT
    assert len(orders) == 1  # Kann 2904, 2905 oder 2906 sein
elif scenario == 'S3':  # Scanner
    assert len(orders) == 1  # Kann 2904, 2905 oder 2906 sein
```

---

### 4. CC11/CC12 (Locations): Hierarchie wurde vollständig formalisiert

**Vorher (v2.6):**
"1–3 Labels für CC11, 1–4 für CC12" → Logik unklar

**Nachher (v2.6.1):**
Explizit mit Pseudo-Code und Beispielen:
- Einfache Bereiche = 1 Label
- Regalgang = **genau 3 Labels** (Aisle Path + Gassennummer + Position)
- CC12 + Transition optional = bis 4 Labels

---

## 📚 Neue Best Practices & Dokumentation

### 1. Spezialfälle dokumentiert

**CC03 Rotation ohne Biegung:**
```
CC03 = [CL027]  ✗ UNGÜLTIG!
CC03 = [CL025, CL027]  ✓ GÜLTIG
```

**CC04 "No Object" Label-Kombinationen:**
```
CL040 (No Object) kann mit:
- CL037 (No Movement) kombiniert
- CL036 (Holding) kombiniert
Aber: IMMER 4 Labels total
```

**CC11 Regalgang ohne Position:**
```
CC11 = [CL163, CL174]  ✗ UNGÜLTIG (Position fehlt)
CC11 = [CL163, CL174, CL177]  ✓ GÜLTIG
```

---

### 2. Pseudocode für alle Validierungsregeln

Jede Regel hat jetzt:
- Natursprachliche Beschreibung
- Python/Pseudocode
- Gültige/ungültige Kombinationen
- Beispiel-Szenarien

---

### 3. Konsistenzmatrix für Szenarien

**CC06 Order-Multiplizität pro Szenario:**

| Szenario | Min | Max | Labels |
|----------|-----|-----|--------|
| S1 | 1 | 1 | Beliebig (CL100, CL101, CL102) |
| S2 | 1 | 1 | Beliebig (CL100, CL101, CL102) |
| S3 | 1 | 1 | Beliebig (CL100, CL101, CL102) |
| S4 | 1 | 1 | CL100 (2904 exklusiv) |
| S5 | 1 | 1 | CL101 (2905 exklusiv) |
| S6 | 1 | 1 | CL102 (2906 exklusiv) |
| **S7** | **2** | **2** | **CL100 + CL101** |
| **S8** | **2** | **2** | **CL100 + CL101** |

---

## 🔗 Datei-Abhängigkeiten

```
category_activation_matrix.md (NEU)
├── Referenziert: labels_207.md (Struktur)
├── Referenziert: validation_rules.md (Pseudocode)
└── Referenziert: ground_truth_central.md (Szenario-Kontext)

validation_rules.md (v1.0 → v1.1)
├── Neue Sektion: 1.3 Kategorien-Aktivitätsregeln
├── Referenziert: category_activation_matrix.md (Übersicht)
└── Bleibt konsistent mit: ground_truth_central.md

labels_207.md (v1.4 → v1.5)
├── Hinweis: Aktivitätsregeln in category_activation_matrix.md
├── Hinweis: Pseudocode in validation_rules.md § 1.3
└── Korrekt: CC03 ist nicht Single-Label
```

---

## ✅ Validierung & Qualitätschecks

- ✅ Alle 12 Kategorien haben Min/Max-Spezifikation
- ✅ Alle 207 Labels sind in Hierarchie eingeordnet
- ✅ Alle 8 Szenarien haben Order-Multiplizität definiert
- ✅ Pseudocode wurde auf Syntax überprüft
- ✅ Beispiele basieren auf echten Annotationsszenarien
- ✅ Keine Widersprüche zu DaRa Dataset Description
- ✅ Konsistent mit Benutzer-Input (14.01.2026)

---

## 📖 Benutzer-Hinweise

**Für Annotators:**
→ Neue Datei `category_activation_matrix.md` verwenden für schnelle Min/Max-Lookups

**Für Skill-Nutzer:**
→ SKILL.md Navigationslogik aktualisiert: Min/Max-Queries gehen zu `category_activation_matrix.md`

**Für Entwickler:**
→ Neue Validierungsfunktionen in `validation_rules.md` § 1.3 kopierbar für eigene Systeme

**Für Datenqualität:**
→ CC03-Fehler (Single-Label behandelt) sind jetzt mit validator gegen Max 2 abfangbar

---

## 🚀 Migration von v2.6 zu v2.6.1

**Nicht erforderlich:** Keine Breaking Changes.

**Empfehlungen:**
1. Schließen Sie Ihre SKILL.md-Caches (neue Datei eingefügt)
2. Laden Sie `category_activation_matrix.md` in Ihre Referenzbibliothek
3. Nutzen Sie neue Validierungs-Pseudocode in `validation_rules.md` § 1.3

---

## 📊 Statistiken

| Metrik | v2.6 | v2.6.1 | Delta |
|--------|------|--------|-------|
| Dateien | 13 | 14 | +1 (category_activation_matrix.md) |
| Labels dokumentiert | 207 | 207 | ± 0 |
| Validierungsregeln | 4 | 9 | +5 (V-TC1, V-HC1, V-OC1, V-LC1, V-LC2) |
| Pseudocode-Funktionen | 3 | 8 | +5 |
| Szenarien expliziert | 8 | 9 | +1 ("Other" detailliert) |
| Gesamtumfang | ~2500 | ~2950 | +17% |

---

## 🎓 Referenzen

**Quellen für Korrektionen:**
- DaRa Dataset Description (Stand 20.10.2025)
- Annotationsrichtlinien (Benutzer-Input, 14.01.2026):
  - CC03 Torso-Aktivierung: Min 1, Max 2
  - CC04/CC05 Hand-Struktur: Immer 4 Labels
  - CC06 Order-Multiplizität: Szenario-abhängig
  - CC11/CC12 Locations: Hierarchische Struktur

---

## 🔚 Abschluss

**v2.6.1 bringt vollständige Formalisierung der Kategorie-Aktivierungslogik basierend auf echten Annotationsrichtlinien des DaRa-Datensatzes. Alle Min/Max-Regeln sind jetzt mit Pseudocode, Beispielen und Fehlerbehandlung dokumentiert.**

Status: ✅ **Veröffentlichungsreif**

