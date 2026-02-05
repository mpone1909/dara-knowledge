# DaRa Dataset â€“ Kerndokumentation

Diese Datei enthÃ¤lt die fundamentalen Beschreibungen des DaRa-Datensatzes aus der offiziellen Dataset Description (Stand 20.10.2025).

---

## 1.1 Zweck und Kontext des Datensatzes

### Dokumentations-Hinweis (Metadaten)

Dieses Dokument konsolidiert verifizierte Informationen aus der offiziellen Dataset Description und dient als Referenzmaterial fÃ¼r Datensatz-Analysen. Interpretationen oder Schlussfolgerungen werden als solche gekennzeichnet.

---

## 1.2 Physische Umgebung (OMNI Warehouse)

Die physische Laborumgebung ist vollstÃ¤ndig in der Datei [auxiliary_warehouse_physical_v5_0.md](./auxiliary_warehouse_physical_v5_0.md) dokumentiert.

Diese umfasst:
- **Zonenaufteilung (9 Hauptbereiche):** Office, Cart Area, Cardboard Box Area, Base, Packing/Sorting Area, Issuing/Receiving Area, Path, Cross Aisle Path, Aisle Path
- **Gassen-System:** 5 Aisles mit 8 Regalkomplexen (R1-R8), Gassen 1-5
- **RegelfÃ¤cher:** StandardfÃ¤cher (95,5 Ã— 39,5 Ã— 21 cm) und SpezialfÃ¤cher fÃ¼r verschiedene Artikel-Typen
- **Laborinfrastruktur:** Packtisch, Kommissionierwagen mit Bluetooth-Tracking, Return-Aisle-Strategie
- **Transition-Logik:** CL181 bei ZonenÃ¼bergÃ¤ngen

**Siehe:** [auxiliary_warehouse_physical_v5_0.md](./auxiliary_warehouse_physical_v5_0.md) fÃ¼r vollstÃ¤ndige technische Spezifikationen.

## 1.3 Probanden (Subjects S01â€“S18)

Die folgenden Angaben stammen aus der in der DaRa Dataset Description (Stand 20.10.2025) enthaltenen **Tabelle 4: Subject specifications**. Alle Daten wurden laut Quelle Ã¼ber einen digitalen Fragebogen der Teilnehmenden erhoben. Es werden ausschlieÃŸlich die explizit aufgefÃ¼hrten Einzelwerte Ã¼bernommen.

### Ãœberblick Ã¼ber die erhobenen Attribute

- **ID** â€“ Eindeutige Subjekt-Identifikation (S01â€“S18)
- **Geschlecht (Sex)** â€“ M (Male) / F (Female)
- **Alter (Age)** â€“ In Jahren
- **Gewicht (Weight)** â€“ In Kilogramm
- **GrÃ¶ÃŸe (Height)** â€“ In Zentimetern
- **HÃ¤ndigkeit (Handedness)** â€“ R (Right) / L (Left)
- **BeschÃ¤ftigungsstatus (Employment Status)** â€“ Student / Employee / Retiree / Job seeker
- **Erfahrungswerte:** Order Picking / Packaging / Similar Studies
 *(Skala: 1 = Extensive, 6 = None)*

### VollstÃ¤ndige Tabelle aller Probanden

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
- **Geschlechterverteilung:** 14 MÃ¤nnlich (M), 4 Weiblich (F)
- **HÃ¤ndigkeit:** 17 RechtshÃ¤ndig (R), 1 LinkshÃ¤ndig (S04)
- **BeschÃ¤ftigungsstatus:** 7 Studenten, 8 Angestellte, 1 Rentner, 1 Arbeitssuchend
- **Altersbereich:** 21 Jahre (S09) bis 67 Jahre (S05)

### Probanden-Erfahrungslevel-Analyse

**Quelle:** Tabelle 4 (Subject specifications), Spalten "Exp. in order picking", "Exp. in packaging", "Exp. in similar studies".

**Order Picking Erfahrung**
- **Level 2 (Sehr erfahren):** 1 Proband (S01)
- **Level 3 (Erfahren):** 3 Probanden (S02, S10, S11)
- **Level 4 (Gering):** 1 Proband (S06)
- **Level 5 (Kaum):** 2 Probanden (S04, S13)
- **Level 6 (Keine):** **11 Probanden** (S03, S05, S07, S08, S09, S12, S14, S15, S16, S17, S18)

**Beobachtung:** 61% der Probanden (11/18) haben keine Order-Picking-Erfahrung (Level 6). Dies kann zu hÃ¶herer Varianz in Prozesszeiten und lÃ¤ngeren Lernkurven wÃ¤hrend der Aufzeichnung fÃ¼hren.

**Packaging Erfahrung**
- **Level 2 (Sehr erfahren):** 1 Proband (S11)
- **Level 3 (Erfahren):** 4 Probanden (S01, S05, S10, S16)
- **Level 4 (Gering):** 2 Probanden (S04, S13)
- **Level 5 (Kaum):** 5 Probanden (S03, S07, S14, S15, S17)
- **Level 6 (Keine):** 6 Probanden (S02, S06, S08, S09, S12, S18)

**Beobachtung:** Packaging-Erfahrung ist breiter verteilt als Order-Picking-Erfahrung. 33% der Probanden (6/18) haben keine Packaging-Erfahrung.

**Similar Studies Erfahrung**
- **Level 6 (Keine):** **15 Probanden** (S01, S02, S04, S05, S06, S07, S08, S09, S10, S11, S13, S15, S16, S17, S18)

**Beobachtung:** 83% der Probanden (15/18) haben keine Erfahrung mit Ã¤hnlichen Studien (Level 6). Die Mehrheit der Probanden hat keine Vorerfahrung mit Bewegungsanalyse-Studien oder Ã¤hnlichen experimentellen Settings.

## 1.4 Sessions

Dieser Abschnitt beschreibt die expliziten, verifizierbaren Informationen aus der DaRa Dataset Description (Stand 20.10.2025) zur Struktur und Bedeutung von Sessions.

### Definition der Recording Sessions
Eine **Recording Session** ist ein aufgezeichneter Block, in dem **drei Subjekte gleichzeitig** am Prozess teilnahmen. Es fanden insgesamt 6 Sessions statt. Die Aufzeichnung erfolgte synchron fÃ¼r alle drei Subjekte innerhalb derselben Session.

### Szenarien innerhalb einer Session

Innerhalb einer einzelnen Session wurden **mehrere unterschiedliche Szenarien** durchlaufen. Die Szenarien-Sequenz war nicht einheitlich standardisiert: verschiedene Sessions durchliefen Szenarien in unterschiedlicher Reihenfolge (beispielsweise: manche Sessions S1â†’S2â†’S4, andere S3â†’S1â†’S7). Wiederholungen von Szenarien innerhalb einer Session waren mÃ¶glich.

### Subjektbezogene Zuordnung
Jedes der drei gleichzeitig aufgezeichneten Subjekte verfÃ¼gte innerhalb einer Session Ã¼ber einen **eigenstÃ¤ndigen Datensatz**, der seine individuelle DurchfÃ¼hrung der Szenarien abbildet.

### Struktur innerhalb einer Session
- **Drei parallele Subjekte** â€“ Jede Session umfasst genau 3 Subjekte.
- **Gemeinsamer, synchroner Zeitstrahl** â€“ Alle drei Subjekte werden zeitgleich aufgezeichnet.
- **Variable Szenario-Sequenz** â€“ Die Reihenfolge der Szenarien innerhalb einer Session war nicht einheitlich (vgl. obige Beschreibung).

---

## 1.5 Offizielle Prozesslogik (BPMN)

Die offizielle Prozesslogik basiert ausschlieÃŸlich auf dem in der Quelle dargestellten **Business Process Model and Notation (BPMN)**. Der Prozess bildet einen vollstÃ¤ndigen Ablauf von **Start Work** bis **End Work** ab und enthÃ¤lt zwei alternative Hauptpfade: einen **Retrieval-Pfad** und einen **Storage-Pfad**.

### Prozessfluss-Ãœbersicht (Textuelle Darstellung)

```text
START WORK
    â†“
Preparing Order (CL114)
    â†“
[Decision: Retrieval OR Storage?]
    â†“                    â†“
RETRIEVAL PATH        STORAGE PATH
    â†“                    â†“
Picking Travel (CL115)   Unpacking (CL117)
    â†“                    â†“
Picking Pick (CL116)     Storing Travel (CL119)
    â†“                    â†“
[All positions done?]    Storing Store (CL120)
NO â†’ Loop back           â†“
YES â†“                    [All positions done?]
Packing (CL118)          NO â†’ Loop back
    â†“                    YES â†“
[All positions done?]        â†“
NO â†’ Loop back           â”Œâ”€â”€â”€â”€â”˜
YES â†“                    â†“
    â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â†’ Finalizing Order (CL121)
                         â†“
                    [More orders?]
                    YES â†’ Back to Preparing Order
                    NO â†“
                    END WORK
```

---

## 1.6 Szenarien (S1â€“S8) und Kategorie "Other"

Die Dokumentation definiert 8 Szenarien und eine Restkategorie.

### Definition Kategorie "Other"
Die Kategorie **Other** ist explizit definiert durch das aktive Low-Level-Label **CL134 (Waiting)**.
Sie beinhaltet ausschlieÃŸlich:
- Wartezeiten (Waiting).
- Zeiten, die nicht explizit einem der Szenarien S1â€“S8 zugeordnet sind.
- Anlegen der Sensoren.
- Synchronisationsbewegungen.
- Vor- und Nachbereitungszeiten.

### Szenario-Ãœbersicht

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
- **Intentional Errors (Geplante StÃ¶rungen):**
  - S1: Falsche Lagerplatzangaben auf der Papierliste.
  - S3: Mengenabweichungen (Diskrepanz zwischen System/Liste und realer Menge).
  - ZusÃ¤tzlich: Fehlendes Verpackungsmaterial oder kÃ¼nstliche Wartezeiten an besetzten Packtischen.
  - Zweck: Simulation von Stress/RealitÃ¤t.
- **Unintended Errors (Unbeabsichtigte Fehler):**
  - Menschliches Versagen (z. B. Bedienfehler PDT in S2, Ãœbersehen von Seiten in S1/S3).
  - Fehlgriffe bei Menge oder Artikeltyp.

---

### Implikationen fÃ¼r DaRa-Analyse

**Hohe Varianz in Prozesszeiten:**
- Unerfahrene Probanden (Level 6) kÃ¶nnen lÃ¤ngere HaupttÃ¤tigkeitszeiten zeigen.
- HÃ¶here Fehlerrate (CL135 "Error-Reporting") mÃ¶glich bei Szenarien mit geplanten Fehlern (S1, S3).

**Lernkurven-Effekt:**
- Erste Sessions kÃ¶nnen weniger effiziente Bewegungsmuster zeigen.
- Multi-Order-Szenarien (S7/S8) besonders herausfordernd fÃ¼r Unerfahrene.

**Anthropometrische Extremwerte:**

| Proband | Order-Picking Exp. | GrÃ¶ÃŸe | Gewicht | Besonderheit |
| :--- | :--- | :--- | :--- | :--- |
| **S10** | Level 3 (Erfahren) | **160cm** (kleinster) | 85kg | Erfahren trotz geringer GrÃ¶ÃŸe |
| **S18** | Level 6 (Keine Erfahrung) | **187cm** (grÃ¶ÃŸter) | 80kg | Unerfahren trotz gÃ¼nstiger Anthropometrie |
| **S05** | Level 6 (Keine Erfahrung) | 177cm | **100kg** | Ã„ltester (67 Jahre), unerfahren, schwer |
| **S12** | Level 6 (Keine Erfahrung) | 186cm | **103kg** (schwerster) | Einziger mit Studie-Erfahrung (Level 4) |

---

### Verwendung in REFA-Analytik

**Erholungszeit-Kalkulation:**
- Unerfahrene Probanden (Level 6) kÃ¶nnen erhÃ¶hte Erholungszeiten zeigen.
- Beispiel: S05 (67 Jahre, 100kg, Level 6) kann deutlich erhÃ¶hte Erholungszeiten bei Large [L]-Artikeln aufweisen.

**Artikel-Zuordnung:**
- Small [S]-Artikel (z.B. M5 Muttern): ZÃ¤hlen erfordert Konzentration (mÃ¶gliche hÃ¶here Fehlerrate bei Unerfahrenen).
- Large [L]-Artikel (z.B. Palmenerde 5149g, R7.3.1.A): Beugen zu Ebene 1 + hohe Last â†’ kann maximale Erholungszeit erfordern.

---

## Verwendungshinweise fÃ¼r diese Datei

**Diese Datei nutzen fÃ¼r:**
- Fragen zu Probanden-Demographie (Tabelle 4).
- BPMN-Prozesslogik und Ablaufstrukturen.
- Session-Definitionen und Grundstruktur.
- Szenario-Konzepte und die Definition von "Other".
- Absicht und Strategie des DaRa-Datensatzes.

**Nicht in dieser Datei:**
- Klassendefinitionen (CC01-CC12) â†’ Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)
- Frame-Synchronisation â†’ Siehe [auxiliary_data_structure_v5_0.md](./auxiliary_data_structure_v5_0.md)
- Detaillierte Label-Lookups â†’ Siehe [core_labels_207_v5_0.md](../core/core_labels_207_v5_0.md)
- Physisches Laborlayout â†’ Siehe [auxiliary_warehouse_physical_v5_0.md](./auxiliary_warehouse_physical_v5_0.md)
- Semantische Struktur â†’ Siehe [auxiliary_semantics_v5_0.md](./auxiliary_semantics_v5_0.md)
- Szenario-Matrizen â†’ Siehe [core_ground_truth_central_v5_0.md](../core/core_ground_truth_central_v5_0.md)

---

## Metadaten

**Datei-Version:** 5.0 (Ãœberarbeitet)  
**Erstellt:** UrsprÃ¼nglich vor 20.10.2025  
**Aktualisiert:** 04.02.2026 (v5.0-Ãœberarbeitung)  
**Status:** Finalisiert âœ…  
**Ã„nderungen in v5.0:**
- Abschnitt 1.1 geklÃ¤rt (Metadaten-Hinweis statt Wissensbasis-Deklaration)
- Abschnitt 1.4 (Sessions) prÃ¤zisiert: Szenario-Sequenz-Variation dokumentiert
- Alle Referenzen auf _v5_0-Dateien aktualisiert
- Interpretationen/Beobachtungen als solche gekennzeichnet (nicht als Fakten)
