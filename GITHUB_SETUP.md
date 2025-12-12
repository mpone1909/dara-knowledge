# GitHub Setup - Schritt-für-Schritt-Anleitung

**Status:** Phase 3 - GitHub Remote einrichten

**Zeitaufwand:** 15-20 Minuten

---

## ✅ Voraussetzungen (bereits erfüllt)

- [x] Lokales Git-Repository initialisiert
- [x] 3 Commits vorhanden (Phase 1, Phase 2, Umbenennung)
- [x] GitHub Education Account vorhanden
- [x] Alle Dateien committed und clean

---

## 🌐 Schritt 1: GitHub-Repository erstellen

### 1.1 Öffne GitHub

Gehe zu: https://github.com/new

### 1.2 Repository-Einstellungen

Fülle das Formular wie folgt aus:

| Feld | Wert | Wichtig |
|------|------|---------|
| **Owner** | `DEIN-GITHUB-USERNAME` | Dein Account |
| **Repository name** | `dara-knowledge` | ✅ Genau so |
| **Description** | `DaRa Dataset Knowledge Base - Git-versionierte Wissensdatenbank für Warehouse-Prozess-Analyse (Masterthesis TU Dortmund)` | Optional |
| **Visibility** | ⚫ **Private** | ✅ WICHTIG |
| **Initialize repository** | ☐ Nicht ankreuzen | ✅ WICHTIG |
| **Add .gitignore** | None | Bereits vorhanden |
| **Choose a license** | None | Private Thesis |

### 1.3 Klicke "Create repository"

**Wichtig:** GitHub zeigt dir dann eine Setup-Seite. **NICHT** die Quick-Setup-Befehle ausführen, sondern folge dieser Anleitung weiter.

---

## 💻 Schritt 2: Remote hinzufügen (Lokal ausführen)

### 2.1 Öffne VS Code oder Terminal

**Windows PowerShell:**
```powershell
cd C:\Users\marku\OneDrive\Masterarbeit_FLW_KI_DATENANALYSE\dara-knowledge
# ODER navigiere zu deinem lokalen Ordner
```

**Linux/Mac Terminal:**
```bash
cd ~/Documents/dara-knowledge
# ODER navigiere zu deinem lokalen Ordner
```

### 2.2 Füge GitHub Remote hinzu

**Ersetze `DEIN-GITHUB-USERNAME` mit deinem echten Username:**

```bash
git remote add origin https://github.com/DEIN-GITHUB-USERNAME/dara-knowledge.git
```

**Beispiel (wenn dein Username "markus-thesis" ist):**
```bash
git remote add origin https://github.com/markus-thesis/dara-knowledge.git
```

### 2.3 Verifiziere Remote

```bash
git remote -v
```

**Erwartete Ausgabe:**
```
origin  https://github.com/DEIN-USERNAME/dara-knowledge.git (fetch)
origin  https://github.com/DEIN-USERNAME/dara-knowledge.git (push)
```

---

## 📤 Schritt 3: Erster Push zu GitHub

### 3.1 Push durchführen

```bash
git push -u origin main
```

### 3.2 GitHub-Authentifizierung

**Beim ersten Push öffnet sich ein Browser-Fenster:**

1. ✅ Melde dich bei GitHub an (falls nicht eingeloggt)
2. ✅ Klicke "Authorize Git Credential Manager"
3. ✅ Browser schließt sich automatisch
4. ✅ Push wird fortgesetzt

**Falls Fehler "Support for password authentication was removed":**

Du musst einen **Personal Access Token (PAT)** erstellen:

1. Gehe zu: https://github.com/settings/tokens
2. Klicke "Generate new token (classic)"
3. Setze:
   - Note: `dara-knowledge-local-access`
   - Expiration: `90 days` (oder länger)
   - Scopes: ✅ `repo` (alle Sub-Optionen)
4. Klicke "Generate token"
5. **WICHTIG:** Kopiere den Token SOFORT (wird nur einmal angezeigt)
6. Verwende den Token als Passwort beim Push

---

## ✅ Schritt 4: Verifizierung

### 4.1 Prüfe GitHub-Webseite

Öffne: `https://github.com/DEIN-USERNAME/dara-knowledge`

**Du solltest sehen:**
- ✅ 3 Commits
- ✅ README.md wird angezeigt
- ✅ Ordnerstruktur: dara-skill-github-repo/, literature/, metadata/, tools/, .github/
- ✅ Branch: main
- ✅ Private Repository (Schloss-Symbol 🔒)

### 4.2 Prüfe GitHub Actions

Klicke oben auf **"Actions"**

**Erwartung:**
- Workflow "Knowledge Quality Check" sollte automatisch laufen
- Status: 🟡 Läuft oder 🟢 Erfolgreich

**Falls 🔴 Fehler:**
- Klicke auf den Workflow-Run
- Prüfe welcher Schritt fehlgeschlagen ist
- Häufigste Ursache: Markdown-Lint findet kleine Fehler (nicht kritisch)

---

## 🏷️ Schritt 5: README-Badge aktualisieren

### 5.1 Kopiere Workflow-Badge-URL

Gehe zu: `https://github.com/DEIN-USERNAME/dara-knowledge/actions`

Klicke auf "Knowledge Quality Check" Workflow

Klicke oben rechts auf **"..."** → **"Create status badge"**

Kopiere den Markdown-Code, z.B.:
```markdown
![Quality Check](https://github.com/DEIN-USERNAME/dara-knowledge/workflows/Knowledge%20Quality%20Check/badge.svg)
```

### 5.2 Update README.md lokal

**Option A: Mit VS Code**
1. Öffne `README.md`
2. Zeile 5 finden: `![Quality Check](https://github.com/DEIN-USERNAME/...)`
3. Ersetze `DEIN-USERNAME` mit deinem echten Username
4. Speichern

**Option B: Mit sed (Linux/Mac/Git Bash)**
```bash
sed -i 's/DEIN-USERNAME/ECHTER-USERNAME/g' README.md
```

### 5.3 Commit und Push

```bash
git add README.md
git commit -m "docs: Update GitHub badge with correct username"
git push
```

---

## 🧪 Schritt 6: Workflows testen

### 6.1 Teste Quality-Check manuell

Gehe zu: `https://github.com/DEIN-USERNAME/dara-knowledge/actions`

Klicke auf "Knowledge Quality Check"

Klicke rechts auf "Run workflow" → "Run workflow"

**Erwartung:** Workflow läuft grün ✅

### 6.2 Teste mit kleiner Änderung

Lokal eine kleine Änderung machen:

```bash
echo "" >> CHANGELOG.md
echo "## [Unreleased]" >> CHANGELOG.md
echo "" >> CHANGELOG.md
echo "Bereit für Phase 3 Testing" >> CHANGELOG.md

git add CHANGELOG.md
git commit -m "chore: Add phase 3 test marker"
git push
```

**Erwartung:** 
- Push erfolgreich
- GitHub Actions startet automatisch
- Workflow läuft grün ✅

---

## 🎯 Schritt 7: MCP-Config (Optional, für später)

**Falls du Claude Desktop nutzen willst:**

### 7.1 Finde deine Config-Datei

**Windows:**
```
C:\Users\DEIN-NAME\AppData\Roaming\Claude\claude_desktop_config.json
```

**Mac:**
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Linux:**
```
~/.config/Claude/claude_desktop_config.json
```

### 7.2 Füge MCP-Server hinzu

Öffne die Datei und füge hinzu:

```json
{
  "mcpServers": {
    "dara-knowledge": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "C:\\Users\\marku\\Documents\\dara-knowledge"
      ]
    }
  }
}
```

**Wichtig:** Passe den Pfad an deinen lokalen Ordner an!

**Linux/Mac-Pfad-Format:**
```json
"/home/markus/Documents/dara-knowledge"
```

### 7.3 Claude Desktop neu starten

Nach dem Speichern: Claude Desktop schließen und neu öffnen.

---

## 🔍 Troubleshooting

### Problem: "Permission denied (publickey)"

**Ursache:** SSH-Authentifizierung fehlgeschlagen

**Lösung:** Verwende HTTPS statt SSH:
```bash
git remote set-url origin https://github.com/DEIN-USERNAME/dara-knowledge.git
```

### Problem: "Support for password authentication was removed"

**Ursache:** GitHub akzeptiert keine Passwörter mehr

**Lösung:** Verwende Personal Access Token (siehe Schritt 3.2)

### Problem: GitHub Actions schlagen fehl

**Ursache:** Markdown-Lint findet Style-Fehler

**Lösung:** Prüfe welche Datei betroffen ist:
```bash
npx markdownlint-cli2 "**/*.md"
```

Oft sind es nur kleine Formatierungen, die nicht kritisch sind.

### Problem: "Repository not found"

**Ursache:** Falsche URL oder fehlende Berechtigungen

**Lösung:** 
1. Prüfe URL: `git remote -v`
2. Prüfe GitHub-Repository existiert
3. Prüfe du bist eingeloggt

---

## ✅ Erfolgs-Checkliste

Nach Abschluss solltest du haben:

- [ ] GitHub-Repository erstellt (Private)
- [ ] Remote hinzugefügt (`git remote -v` zeigt URL)
- [ ] Erster Push erfolgreich (3 Commits auf GitHub)
- [ ] README.md auf GitHub sichtbar
- [ ] GitHub Actions laufen grün ✅
- [ ] Badge im README zeigt Status
- [ ] Workflow manuell getestet
- [ ] Test-Commit gepusht und validiert

---

## 📊 Erwartete GitHub-Struktur

Nach erfolgreichem Setup sollte dein Repository so aussehen:

```
github.com/DEIN-USERNAME/dara-knowledge/
├── 📁 .github/workflows/        # CI/CD (2 Workflows)
├── 📁 dara-skill-github-repo/   # 152 KB, 10 Dateien
├── 📁 literature/               # Template + README
├── 📁 metadata/                 # CSV + JSON
├── 📁 tools/                    # 2 Shell-Scripts
├── 📄 AI_INSTRUCTIONS.md
├── 📄 CHANGELOG.md
├── 📄 README.md                 # Mit grünem Badge ✅
├── 📄 llms.txt
└── 📄 .gitignore

3 Commits:
- b38a193 chore: Initialize repository structure (Phase 1)
- 591ae7c feat: Add complete DaRa dataset skill (Phase 2)
- 831793d refactor: Rename dara-skill to dara-skill-github-repo
```

---

## 🎓 Für die Thesis

**Wichtig für Dokumentation:**

1. **Repository-Link:** `https://github.com/DEIN-USERNAME/dara-knowledge`
2. **Commit-Hash (Latest):** `831793d` (oder aktueller)
3. **Zitation:** Siehe README.md Abschnitt "Für Masterthesis"

**Screenshot-Empfehlungen:**
- GitHub-Repository-Übersicht (mit Badge)
- GitHub Actions erfolgreich (grüner Haken)
- Ordnerstruktur auf GitHub

---

**Viel Erfolg! 🚀**

Bei Problemen: Konsultiere Troubleshooting-Abschnitt oder melde dich.
