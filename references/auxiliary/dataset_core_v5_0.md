# DaRa Dataset – Kerndokumentation

Diese Datei enthält die fundamentalen Beschreibungen des DaRa-Datensatzes aus der offiziellen Dataset Description (Stand 20.10.2025).

---

## 1.1 Zweck und Kontext des Datensatzes

### Dokumentations-Hinweis (Metadaten)

Dieses Dokument konsolidiert verifizierte Informationen aus der offiziellen Dataset Description und dient als Referenzmaterial für Datensatz-Analysen. Interpretationen oder Schlussfolgerungen werden als solche gekennzeichnet.

---

## 1.2 Physische Umgebung (OMNI Warehouse)

Die physische Laborumgebung ist vollständig in der Datei [auxiliary_warehouse_physical_v5_0.md](./auxiliary_warehouse_physical_v5_0.md) dokumentiert.

Diese umfasst:
- **Zonenaufteilung (9 Hauptbereiche):** Office, Cart Area, Cardboard Box Area, Base, Packing/Sorting Area, Issuing/Receiving Area, Path, Cross Aisle Path, Aisle Path
- **Gassen-System:** 5 Aisles mit 8 Regalkomplexen (R1-R8), Gassen 1-5
- **Regelfächer:** Standardfächer (95,5 × 39,5 × 21 cm) und Spezialfächer für verschiedene Artikel-Typen
- **Laborinfrastruktur:** Packtisch, Kommissionierwagen mit Bluetooth-Tracking, Return-Aisle-Strategie
- **Transition-Logik:** CL181 bei Zonenübergängen

**Siehe:** [auxiliary_warehouse_physical_v5_0.md](./auxiliary_warehouse_physical_v5_0.md) für vollständige technische Spezifikationen.

## 1.3 Probanden (Subjects S01–S18)

Die folgenden Angaben stammen aus der in der DaRa Dataset Description (Stand 20.10.2025) enthaltenen **Tabelle 4: Subject specifications**. Alle Daten wurden laut Quelle über einen digitalen Fragebogen der Teilnehmenden erhoben. Es werden ausschließlich die explizit aufgeführten Einzelwerte übernommen.

### Überblick über die erhobenen Attribute

- **ID** – Eindeutige Subjekt-Identifikation (S01–S18)
- **Geschlecht (Sex)** – M (Male) / F (Female)
- **Alter (Age)** – In Jahren
- **Gewicht (Weight)** – In Kilogramm
- **Größe (Height)** – In Zentimetern
- **Händigkeit (Handedness)** – R (Right) / L (Left)
- **Beschäftigungsstatus (Employment Status)** – Student / Employee / Retiree / Job seeker
- **Erfahrungswerte:** Order Picking / Packaging / Similar Studies
 *(Skala: 1 = Extensive, 6 = None)*

### Vollständige Tabelle aller Probanden

| Session | ID | Sex | Age | Weight (kg) | Height (cm) | Handedness | Employment | Exp. Picking | Exp. Packaging | Exp. Studies |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | S01 | F | 32 | 68 | 171 | R | Student | 2 | 3 | 6 |
| 1 | S02 | M | 27 | 76 | 167 | R | Student | 3 | 6 | 6 |
| 1 | S03 | M | 64 | 69 | 171 | R | Employee | 6 | 5 | 5 |
| 2 | S04 | M | 31 | 85 | 183 | L | Employee | 5 | 4 | 6 |
| 2 | S05 | M | 67 | 100 | 177 | R | Retiree | 6 | 3 | 6 |
| 2 | S06 | M | 24 | 82 | 178 | R | Student | 4 | 6 | 6 |
| 3 | S07 | M | 41 | 70 | 180 | R | Employee | 6 | 5 | 6 |
| 3 | S08 | F | 29 | 62 | 163 | R | Student | 6 | 6 | 6 |
| 3 | S09 | M | 21 | 85 | 180 | R | Student | 6 | 6 | 6 |
| 4 | S10 | M | 28 | 85 | 160 | R | Student | 3 | 3 | 6 |
| 4 | S11 | M | 59 | 85 | 178 | R | Employee | 3 | 2 | 6 |
| 4 | S12 | M | 43 | 103 | 186 | R | Job seeker | 6 | 6 | 4 |
| 5 | S13 | F | 52 | 66 | 175 | R | Employee | 5 | 4 | 6 |
| 5 | S14 | M | 32 | 80 | 176 | R | Employee | 6 | 5 | 5 |
| 5 | S15 | M | 43 | 88 | 177 | R | Employee | 6 | 5 | 6 |
| 6 | S16 | M | 29 | 100 | 175 | R | Student | 6 | 3 | 6 |
| 6 | S17 | F | 25 | 75 | 180 | R | Employee | 6 | 5 | 6 |
| 6 | S18 | M | 26 | 80 | 187 | R | Student | 6 | 6 | 6 |

### Demographische Zusammenfassung
- **Geschlechterverteilung:** 14 Männlich (M), 4 Weiblich (F)
- **Händigkeit:** 17 Rechtshändig (R), 1 Linkshändig (S04)
- **Beschäftigungsstatus:** 7 Studenten, 8 Angestellte, 1 Rentner, 1 Arbeitssuchend
- **Altersbereich:** 21 Jahre (S09) bis 67 Jahre (S05)

### Probanden-Erfahrungslevel-Analyse

**Quelle:** Tabelle 4 (Subject specifications), Spalten "Exp. in order picking", "Exp. in packaging", "Exp. in similar studies".

**Order Picking Erfahrung**
- **Level 2 (Sehr erfahren):** 1 Proband (S01)
- **Level 3 (Erfahren):** 3 Probanden (S02, S10, S11)
- **Level 4 (Gering):** 1 Proband (S06)
- **Level 5 (Kaum):** 2 Probanden (S04, S13)
- **Level 6 (Keine):** **11 Probanden** (S03, S05, S07, S08, S09, S12, S14, S15, S16, S17, S18)

**Beobachtung:** 61% der Probanden (11/18) haben keine Order-Picking-Erfahrung (Level 6). Dies kann zu höherer Varianz in Prozesszeiten und längeren Lernkurven während der Aufzeichnung führen.

**Packaging Erfahrung**
- **Level 2 (Sehr erfahren):** 1 Proband (S11)
- **Level 3 (Erfahren):** 4 Probanden (S01, S05, S10, S16)
- **Level 4 (Gering):** 2 Probanden (S04, S13)
- **Level 5 (Kaum):** 5 Probanden (S03, S07, S14, S15, S17)
- **Level 6 (Keine):** 6 Probanden (S02, S06, S08, S09, S12, S18)

**Beobachtung:** Packaging-Erfahrung ist breiter verteilt als Order-Picking-Erfahrung. 33% der Probanden (6/18) haben keine Packaging-Erfahrung.

**Similar Studies Erfahrung**
- **Level 6 (Keine):** **15 Probanden** (S01, S02, S04, S05, S06, S07, S08, S09, S10, S11, S13, S15, S16, S17, S18)

**Beobachtung:** 83% der Probanden (15/18) haben keine Erfahrung mit ähnlichen Studien (Level 6). Die Mehrheit der Probanden hat keine Vorerfahrung mit Bewegungsanalyse-Studien oder ähnlichen experimentellen Settings.

## 1.4 Sessions

Dieser Abschnitt beschreibt die expliziten, verifizierbaren Informationen aus der DaRa Dataset Description (Stand 20.10.2025) zur Struktur und Bedeutung von Sessions.

### Definition der Recording Sessions
Eine **Recording Session** ist ein aufgezeichneter Block, in dem **drei Subjekte gleichzeitig** am Prozess teilnahmen. Es fanden insgesamt 6 Sessions statt. Die Aufzeichnung erfolgte synchron für alle drei Subjekte innerhalb derselben Session.

### Szenarien innerhalb einer Session

Innerhalb einer einzelnen Session wurden **mehrere unterschiedliche Szenarien** durchlaufen. Die Szenarien-Sequenz war nicht einheitlich standardisiert: verschiedene Sessions durchliefen Szenarien in unterschiedlicher Reihenfolge (beispielsweise: manche Sessions S1→S2→S4, andere S3→S1→S7). Wiederholungen von Szenarien innerhalb einer Session waren möglich.

### Subjektbezogene Zuordnung
Jedes der drei gleichzeitig aufgezeichneten Subjekte verfügte innerhalb einer Session über einen **eigenständigen Datensatz**, der seine individuelle Durchführung der Szenarien abbildet.

### Struktur innerhalb einer Session
- **Drei parallele Subjekte** – Jede Session umfasst genau 3 Subjekte.
- **Gemeinsamer, synchroner Zeitstrahl** – Alle drei Subjekte werden zeitgleich aufgezeichnet.
- **Variable Szenario-Sequenz** – Die Reihenfolge der Szenarien innerhalb einer Session war nicht einheitlich (vgl. obige Beschreibung).

---

## 1.5 Offizielle Prozesslogik (BPMN)

Die offizielle Prozesslogik basiert ausschließlich auf dem in der Quelle dargestellten **Business Process Model and Notation (BPMN)**. Der Prozess bildet einen vollständigen Ablauf von **Start Work** bis **End Work** ab und enthält zwei alternative Hauptpfade: einen **Retrieval-Pfad** und einen **Storage-Pfad**.

### Prozessfluss-Übersicht (Textuelle Darstellung)

```text
START WORK
    ↓
Preparing Order (CL114)
    ↓
[Decision: Retrieval OR Storage?]
    ↓                    ↓
RETRIEVAL PATH        STORAGE PATH
    ↓                    ↓
Picking Travel (CL115)   Unpacking (CL117)
    ↓                    ↓
Picking Pick (CL116)     Storing Travel (CL119)
    ↓                    ↓
[All positions done?]    Storing Store (CL120)
NO → Loop back           ↓
YES ↓                    [All positions done?]
Packing (CL118)          NO → Loop back
    ↓                    YES ↓
[All positions done?]        ↓
NO → Loop back           ┌────┘
YES ↓                    ↓
    └──────────────────→ Finalizing Order (CL121)
                         ↓
                    [More orders?]
                    YES → Back to Preparing Order
                    NO ↓
                    END WORK
```

---

## 1.6 Szenarien (S1–S8) und Kategorie "Other"

Die Dokumentation definiert 8 Szenarien und eine Restkategorie.

### Definition Kategorie "Other"
Die Kategorie **Other** ist explizit definiert durch das aktive Low-Level-Label **CL134 (Waiting)**.
Sie beinhaltet ausschließlich:
- Wartezeiten (Waiting).
- Zeiten, die nicht explizit einem der Szenarien S1–S8 zugeordnet sind.
- Anlegen der Sensoren.
- Synchronisationsbewegungen.
- Vor- und Nachbereitungszeiten.

### Szenario-Übersicht

| Szenario | Typ (High-Level) | Order ID | Strategie | IT-System | Geplante Fehler |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **S1** | Retrieval | 2904 | Single | Liste & Stift | **Ja** (Falscher Ort) |
| **S2** | Retrieval | 2905 | Single | PDT | Nein |
| **S3** | Retrieval | 2906 | Single | Liste & Scanner | **Ja** (Falsche Menge) |
| **S4** | Storage | 2904 | Single | Liste & Stift | Nein |
| **S5** | Storage | 2905 | Single | Liste & Stift | Nein |
| **S6** | Storage | 2906 | Single | Liste & Stift | Nein |
| **S7** | Retrieval | 2904+05 | **Multi** | Liste & Stift | Nein |
| **S8** | Storage | 2904+05 | **Multi** | Liste & Stift | Nein |

**Fehler-Kategorien (Errors):**
- **Intentional Errors (Geplante Störungen):**
  - S1: Falsche Lagerplatzangaben auf der Papierliste.
  - S3: Mengenabweichungen (Diskrepanz zwischen System/Liste und realer Menge).
  - Zusätzlich: Fehlendes Verpackungsmaterial oder künstliche Wartezeiten an besetzten Packtischen.
  - Zweck: Simulation von Stress/Realität.
- **Unintended Errors (Unbeabsichtigte Fehler):**
  - Menschliches Versagen (z. B. Bedienfehler PDT in S2, Übersehen von Seiten in S1/S3).
  - Fehlgriffe bei Menge oder Artikeltyp.

---

### Implikationen für DaRa-Analyse

**Hohe Varianz in Prozesszeiten:**
- Unerfahrene Probanden (Level 6) können längere Haupttätigkeitszeiten zeigen.
- Höhere Fehlerrate (CL135 "Error-Reporting") möglich bei Szenarien mit geplanten Fehlern (S1, S3).

**Lernkurven-Effekt:**
- Erste Sessions können weniger effiziente Bewegungsmuster zeigen.
- Multi-Order-Szenarien (S7/S8) besonders herausfordernd für Unerfahrene.

**Anthropometrische Extremwerte:**

| Proband | Order-Picking Exp. | Größe | Gewicht | Besonderheit |
| :--- | :--- | :--- | :--- | :--- |
| **S10** | Level 3 (Erfahren) | **160cm** (kleinster) | 85kg | Erfahren trotz geringer Größe |
| **S18** | Level 6 (Keine Erfahrung) | **187cm** (größter) | 80kg | Unerfahren trotz günstiger Anthropometrie |
| **S05** | Level 6 (Keine Erfahrung) | 177cm | **100kg** | Ältester (67 Jahre), unerfahren, schwer |
| **S12** | Level 6 (Keine Erfahrung) | 186cm | **103kg** (schwerster) | Einziger mit Studie-Erfahrung (Level 4) |

---

### Verwendung in REFA-Analytik

**Erholungszeit-Kalkulation:**
- Unerfahrene Probanden (Level 6) können erhöhte Erholungszeiten zeigen.
- Beispiel: S05 (67 Jahre, 100kg, Level 6) kann deutlich erhöhte Erholungszeiten bei Large [L]-Artikeln aufweisen.

**Artikel-Zuordnung:**
- Small [S]-Artikel (z.B. M5 Muttern): Zählen erfordert Konzentration (mögliche höhere Fehlerrate bei Unerfahrenen).
- Large [L]-Artikel (z.B. Palmenerde 5149g, R7.3.1.A): Beugen zu Ebene 1 + hohe Last → kann maximale Erholungszeit erfordern.

---

## Verwendungshinweise für diese Datei

**Diese Datei nutzen für:**
- Fragen zu Probanden-Demographie (Tabelle 4).
- BPMN-Prozesslogik und Ablaufstrukturen.
- Session-Definitionen und Grundstruktur.
- Szenario-Konzepte und die Definition von "Other".
- Absicht und Strategie des DaRa-Datensatzes.

**Nicht in dieser Datei:**
- Klassendefinitionen (CC01-CC12) → Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)
- Frame-Synchronisation → Siehe [auxiliary_data_structure_v5_0.md](./auxiliary_data_structure_v5_0.md)
- Detaillierte Label-Lookups → Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)
- Physisches Laborlayout → Siehe [auxiliary_warehouse_physical_v5_0.md](./auxiliary_warehouse_physical_v5_0.md)
- Semantische Struktur → Siehe [auxiliary_semantics_v5_0.md](./auxiliary_semantics_v5_0.md)
- Szenario-Matrizen → Siehe [core_ground_truth_central_v5_0.md](../core/core_ground_truth_central_v5_0.md)

---

## Metadaten

**Datei-Version:** 5.0 (Überarbeitet)  
**Erstellt:** Ursprünglich vor 20.10.2025  
**Aktualisiert:** 04.02.2026 (v5.0-Überarbeitung)  
**Status:** Finalisiert ✅  
**Änderungen in v5.0:**
- Abschnitt 1.1 geklärt (Metadaten-Hinweis statt Wissensbasis-Deklaration)
- Abschnitt 1.4 (Sessions) präzisiert: Szenario-Sequenz-Variation dokumentiert
- Alle Referenzen auf _v5_0-Dateien aktualisiert
- Interpretationen/Beobachtungen als solche gekennzeichnet (nicht als Fakten)
