---
version: 6.0
---

<!-- PRE-ANSWER CHECKLIST (PAC) — BPMN Flows Reference
Before answering ANY question about BPMN flows:
[ ] I have read this file COMPLETELY using the Read tool
[ ] I have read phase4_bpmn_validation.md §2 for the CC09→CC10 mapping
[ ] I have extracted the VERIFICATION_TOKEN from the end of this file
[ ] I am citing specific Figure references (A2-A7)
-->

# BPMN Detailed Process Flows — Figures A2–A7

**Version:** 6.0 (2026-02-25)
**Quelle:** BPMN_PROZESSE_DARA.pdf (Figures A2–A7) + NotebookLM

---

## CL114 | Preparing Order (Figure A2)

```
Start Preparing Order
  ↓
Collecting Order and Hardware (CL124)
  ↓
[GATEWAY 1: "Does the subject already have a cart?"]
  ├─ YES: weiter zu Gateway 2
  └─ NO: Collecting Cart (CL125) → weiter zu Gateway 2
  ↓
[GATEWAY 2: "Retrieval or Storage?"]
  ├─ Retrieval: Collecting Empty Cardboard Boxes (CL126)
  └─ Storage: Collecting Packed Cardboard Boxes (CL127)
  ↓
End Preparing Order
```

**CC10 Labels:** CL124, CL125 (optional), CL126 (Retrieval), CL127 (Storage)

---

## CL115/CL116 | Picking — Travel & Pick Time (Figure A3)

```
Start Picking
  ↓
[GATEWAY 1: "Is the cart on the base?"]
  ├─ YES: weiter
  └─ NO: Transporting a Cart to the Base (CL128)
  ↓
Moving to the Next Position (CL137)           ← TRAVEL TIME (CL115)
  ↓
[GATEWAY 2: "Information on the next position complete?"]
  ├─ YES: weiter
  └─ NO: Reporting and Clarifying (CL135) → Loop zu CL137
  ↓
[GATEWAY 3: "Items can be picked?"]
  ├─ YES: weiter zu Pick Time
  └─ NO: Reporting and Clarifying (CL135) → Loop zu CL137
  ↓
Retrieving Items (CL139)                      ← PICK TIME (CL116)
  ↓
Moving to a Cart (CL140)
  ↓
Placing Cardboard Box/Item in a Cart (CL151)
  ↓
[GATEWAY 4: "Has the order been completed?"]
  ├─ YES: End Picking
  └─ NO: Loop → CL137
```

**Travel Time (CL115):** CL128, CL137, CL135
**Pick Time (CL116):** CL139, CL140, CL151

**Error-Handling (CL135):**
- Auslöser 1: "Information incomplete?" = NO (Listenfehler)
- Auslöser 2: "Items can be picked?" = NO (fehlt/beschädigt)
- Übersprungene Aktivitäten: CL139, CL140, CL151
- Loop-Ziel: CL137

---

## CL118 | Packing (Figure A4)

```
Start Packing
  ↓
Transporting to Packaging/Sorting Area (CL129)
  ↓
Placing Cardboard Box/Item on a Table (CL141)
  ↓
Removing Elastic Band (CL149)
  ↓
Sorting (CL144)
  ↓
Filling Cardboard Box with Filling Material (CL145)
  ↓
Printing Shipping Label and Return Slip (CL146)
  ↓
Preparing or Adding Return Label (CL147)
  ↓
Attaching Shipping Label (CL148)
  ↓
Sealing Cardboard Box (CL150)
  ↓
Placing Cardboard Box/Item in a Cart (CL151)
  ↓
[GATEWAY: "More unpacked boxes?"]
  ├─ YES: Loop → CL129
  └─ NO: End Packing
```

**CC10 Labels:** CL129, CL141, CL149, CL144, CL145, CL146, CL147, CL148, CL150, CL151

**Keine Error-Handling-Gateways** (anders als Picking/Storing).

---

## CL117 | Unpacking (Figure A5)

```
Start Unpacking
  ↓
Transporting to Packaging/Sorting Area (CL129)
  ↓
Placing Cardboard Box/Item on a Table (CL141)
  ↓
Opening Cardboard Box (CL142)
  ↓
Disposing of Filling Material or Shipping Label (CL143)
  ↓
Sorting (CL144)
  ↓
Tying Elastic Band Around Cardboard (CL152)
  ↓
Placing Cardboard Box/Item in a Cart (CL151)
  ↓
[GATEWAY: "More unpacked boxes?"]
  ├─ YES: Loop → CL129
  └─ NO: End Unpacking
```

**CC10 Labels:** CL129, CL141, CL142, CL143, CL144, CL152, CL151

**Reverse-Struktur zu Packing:**
- Packing: Removing Elastic Band (CL149) → Filling (CL145) → Sealing (CL150)
- Unpacking: Opening (CL142) → Disposing (CL143) → Tying Elastic Band (CL152)

---

## CL119/CL120 | Storing — Travel & Store Time (Figure A6)

```
Start Storing
  ↓
[GATEWAY 1: "Is the cart on the base?"]
  ├─ YES: weiter
  └─ NO: Transporting a Cart to the Base (CL128)
  ↓
Moving to the Next Position (CL137)           ← TRAVEL TIME (CL119)
  ↓
[GATEWAY 2: "Information on the next position complete?"]
  ├─ YES: weiter
  └─ NO: Reporting and Clarifying (CL135) → Loop
  ↓
Removing Cardboard Box/Item from Cart (CL136) ← STORE TIME (CL120)
  ↓
Moving to a Cart (CL140)  [generisch: Bewegung zum Regal]
  ↓
Placing Items on a Rack (CL138)
  ↓
[GATEWAY 3: "Items can be placed?"]
  ├─ YES: weiter
  └─ NO: Reporting and Clarifying (CL135) → Loop
  ↓
[GATEWAY 4: "Has the order been completed?"]
  ├─ YES: End Storing
  └─ NO: Loop → CL137
```

**Travel Time (CL119):** CL128, CL137, CL135
**Store Time (CL120):** CL136, CL140, CL138

**Error-Handling vs. Picking:**

| Aspekt | Picking (A3) | Storing (A6) |
|:-------|:-------------|:-------------|
| Gateway-Text | "Items can be picked?" | "Items can be placed?" |
| Fehlertyp | Missing Item / Damaged | Regal-Problem / Position-Problem |
| Fehler verhindert | Retrieving (CL139) | Placing (CL138) |
| Loop-Ziel | CL137 | CL137 |

**Semantische Ambiguität CL140:** In Picking = Bewegung VOM Regal ZUM Wagen.
In Storing = Bewegung VOM Wagen ZUM Regal. Generisches Label.

---

## CL121 | Finalizing Order (Figure A7)

```
Start Finalizing Order
  ↓
[GATEWAY: "Retrieval or Storage?"]
  ├─ Retrieval: Handing Over Packed Cardboard Boxes (CL130)
  └─ Storage: Returning Empty Cardboard Boxes (CL131)
  ↓
Returning Cart (CL132)
  ↓
Returning Hardware (CL133)
  ↓
End Finalizing Order
```

**CC10 Labels:** CL130 (Retrieval), CL131 (Storage), CL132, CL133

---

## Cross-Process Consistency

### Identische Activities (gleiche Semantik in Picking und Storing)

| Label | Aktivität | Picking (A3) | Storing (A6) |
|:------|:----------|:-------------|:-------------|
| CL128 | Transporting Cart to Base | ✅ | ✅ |
| CL137 | Moving to Next Position | ✅ | ✅ |
| CL135 | Reporting Incident | ✅ | ✅ |

### Gegenstück-Aktivitäten (logische Umkehrungen)

| Packing (CL118) | Unpacking (CL117) | Relation |
|:-----------------|:-------------------|:---------|
| Removing Elastic Band (CL149) | Tying Elastic Band (CL152) | REVERSE |
| Filling Cardboard Box (CL145) | Disposing of Material (CL143) | REVERSE |
| Sealing Cardboard Box (CL150) | Opening Cardboard Box (CL142) | REVERSE |
| Printing Label (CL146) | [Kein Gegenstück] | Einseitig |
| Attaching Label (CL148) | [Label wird entfernt in CL143] | Einseitig |

### Kontextabhängige Activities

- **CL144 (Sorting):** In Packing = Outbound-Sortierung; in Unpacking = Inbound-Sortierung
- **CL129 (Transporting):** In Packing = von Picking-Station; in Unpacking = von Wareneingang

<!-- VERIFICATION_TOKEN: DARA-BFLOW-1F7A-v630 -->
