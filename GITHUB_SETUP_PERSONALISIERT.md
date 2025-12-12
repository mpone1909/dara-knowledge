# GitHub Setup - Personalisierte Anleitung für mpone1909

**GitHub-Username:** mpone1909  
**Repository-Name:** dara-knowledge  
**Zeitaufwand:** 15-20 Minuten

---

## ✅ Voraussetzungen (bereits erfüllt)

- [x] ZIP heruntergeladen und entpackt
- [x] Ordner: `dara-knowledge/`
- [x] GitHub-Account: mpone1909
- [x] GitHub Education Account vorhanden

---

## 🌐 Schritt 1: GitHub-Repository erstellen (5 Min)

### 1.1 Öffne GitHub

Gehe zu: **https://github.com/new**

### 1.2 Repository-Einstellungen

Fülle das Formular **EXAKT** so aus:

| Feld | Wert |
|------|------|
| **Owner** | `mpone1909` |
| **Repository name** | `dara-knowledge` ✅ |
| **Description** | `DaRa Dataset Knowledge Base - Git-versionierte Wissensdatenbank für Warehouse-Prozess-Analyse (Masterthesis TU Dortmund)` |
| **Visibility** | ⚫ **Private** ✅ WICHTIG! |
| **Initialize repository** | ☐ **NICHT ankreuzen!** ✅ |
| **Add .gitignore** | None |
| **Choose a license** | None |

### 1.3 Klicke "Create repository"

GitHub zeigt dir dann eine Setup-Seite. **IGNORIERE die Quick-Setup-Befehle** und folge dieser Anleitung weiter.

---

## 💻 Schritt 2: Lokales Repository einrichten (3 Min)

### 2.1 Öffne Terminal / PowerShell

**Windows PowerShell:**
```powershell
cd C:\Users\marku\Documents\dara-knowledge
```

**Oder:** Navigiere zu deinem entpackten Ordner

**Linux/Mac Terminal:**
```bash
cd ~/Documents/dara-knowledge
```

### 2.2 Git initialisieren

```bash
git init
git branch -m main
```

**Erwartete Ausgabe:**
```
Initialized empty Git repository in .../dara-knowledge/.git/
```

### 2.3 Git-Konfiguration (falls noch nicht gesetzt)

```bash
git config user.email "markus@tu-dortmund.de"
git config user.name "Markus"
```

### 2.4 Remote hinzufügen

**Kopiere diesen Befehl (mit DEINEM Username):**

```bash
git remote add origin https://github.com/mpone1909/dara-knowledge.git
```

### 2.5 Verifiziere Remote

```bash
git remote -v
```

**Erwartete Ausgabe:**
```
origin  https://github.com/mpone1909/dara-knowledge.git (fetch)
origin  https://github.com/mpone1909/dara-knowledge.git (push)
```

✅ Wenn das stimmt, weiter zu Schritt 3!

---

## 📤 Schritt 3: Erster Push zu GitHub (5 Min)

### 3.1 Alle Dateien stagen

```bash
git add .
```

### 3.2 Initial Commit erstellen

```bash
git commit -m "Initial commit: DaRa Knowledge Base v4.1.1

- Complete DaRa-Skill migration (152 KB, 207 labels)
- Automated validation scripts (extract_labels.sh, check_integrity.sh)
- CI/CD workflows (quality-check, weekly-backup)
- Comprehensive documentation (README, START_HERE, GITHUB_SETUP)
- Scientific documentation (WISSENSCHAFTLICHE_DOKUMENTATION.md)
- LLM navigation system (llms.txt, AI_INSTRUCTIONS.md)
- Literature template system
- Metadata indices (label_catalog.csv, index.by-topic.json)

Ready for use in Master's thesis at TU Dortmund"
```

**Erwartete Ausgabe:**
```
[main (root-commit) abc1234] Initial commit: DaRa Knowledge Base v4.1.1
 29 files changed, ~6000 insertions(+)
 create mode 100644 README.md
 create mode 100644 START_HERE.md
 ...
```

### 3.3 Push zu GitHub

```bash
git push -u origin main
```

### 3.4 GitHub-Authentifizierung

**Beim ersten Push öffnet sich ein Browser-Fenster:**

1. ✅ Melde dich bei GitHub an (falls nicht eingeloggt)
2. ✅ Klicke "Authorize Git Credential Manager"
3. ✅ Browser schließt sich automatisch
4. ✅ Push wird fortgesetzt

**Erwartete Ausgabe:**
```
Enumerating objects: 35, done.
Counting objects: 100% (35/35), done.
Delta compression using up to 8 threads
Compressing objects: 100% (29/29), done.
Writing objects: 100% (35/35), 234.56 KiB | 5.67 MiB/s, done.
Total 35 (delta 4), reused 0 (delta 0), pack-reused 0
To https://github.com/mpone1909/dara-knowledge.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

✅ **Erfolg!** Dein Repository ist jetzt auf GitHub!

---

## 🔐 Falls Authentifizierungs-Problem auftritt

### Problem: "Support for password authentication was removed"

**Lösung: Personal Access Token (PAT) erstellen**

1. Gehe zu: **https://github.com/settings/tokens**
2. Klicke **"Generate new token (classic)"**
3. Setze:
   - **Note:** `dara-knowledge-local-access`
   - **Expiration:** `90 days` (oder länger)
   - **Scopes:** ✅ `repo` (alle Sub-Optionen ankreuzen)
4. Klicke **"Generate token"**
5. **WICHTIG:** Kopiere den Token SOFORT (wird nur einmal angezeigt!)
6. Speichere ihn sicher (z.B. in Passwort-Manager)

**Token verwenden:**

Beim nächsten `git push` wirst du nach Passwort gefragt:
- **Username:** `mpone1909`
- **Password:** [Füge deinen Token ein, nicht dein GitHub-Passwort!]

---

## ✅ Schritt 4: Verifizierung (2 Min)

### 4.1 Öffne dein GitHub-Repository

**Direkt-Link:** https://github.com/mpone1909/dara-knowledge

**Du solltest sehen:**
- ✅ README.md wird angezeigt (mit Projekt-Beschreibung)
- ✅ Alle Ordner: dara-skill-github-repo/, literature/, metadata/, tools/, .github/
- ✅ Branch: main
- ✅ Private Repository (🔒 Schloss-Symbol oben rechts)
- ✅ "1 commit" (oder mehr, je nachdem)

### 4.2 Prüfe GitHub Actions

Klicke oben im Repository auf **"Actions"**

**Du solltest sehen:**
- Workflow: **"Knowledge Quality Check"**
- Status: 🟡 Läuft oder 🟢 Erfolgreich

**Falls 🔴 Fehler:**
- Klicke auf den fehlgeschlagenen Workflow
- Prüfe welcher Schritt fehlgeschlagen ist
- Häufigste Ursache: Markdown-Lint (nicht kritisch)

**Fix für Markdown-Lint-Fehler (optional):**
```bash
# Lokal ausführen
npm install -g markdownlint-cli2
markdownlint-cli2 "**/*.md" --fix
git add .
git commit -m "fix: Apply markdownlint fixes"
git push
```

---

## 🏷️ Schritt 5: README-Badge aktualisieren (2 Min)

### 5.1 Öffne README.md lokal

**Mit Editor (VS Code, Notepad++, etc.):**

Finde Zeile 5 (ca.):
```markdown
![Quality Check](https://github.com/DEIN-USERNAME/dara-knowledge/workflows/Knowledge%20Quality%20Check/badge.svg)
```

Ersetze durch:
```markdown
![Quality Check](https://github.com/mpone1909/dara-knowledge/workflows/Knowledge%20Quality%20Check/badge.svg)
```

**Oder mit sed (Linux/Mac/Git Bash):**
```bash
sed -i 's/DEIN-USERNAME/mpone1909/g' README.md
```

### 5.2 Commit und Push

```bash
git add README.md
git commit -m "docs: Update GitHub badge with correct username"
git push
```

### 5.3 Verifiziere Badge

Öffne wieder: **https://github.com/mpone1909/dara-knowledge**

**Du solltest sehen:**
- ✅ Grüner Badge: "Knowledge Quality Check - passing ✅"

Falls Badge noch nicht grün ist, warte 1-2 Minuten (GitHub Actions braucht Zeit).

---

## 🧪 Schritt 6: Test mit kleiner Änderung (3 Min)

### 6.1 Teste Workflow manuell

Öffne: **https://github.com/mpone1909/dara-knowledge/actions**

1. Klicke auf **"Knowledge Quality Check"**
2. Klicke rechts auf **"Run workflow"** → **"Run workflow"**
3. Warte ~30 Sekunden
4. ✅ Workflow sollte grün werden

### 6.2 Teste mit lokalem Commit

```bash
echo "" >> CHANGELOG.md
echo "## [Unreleased]" >> CHANGELOG.md
echo "" >> CHANGELOG.md
echo "### Notes" >> CHANGELOG.md
echo "- Repository erfolgreich auf GitHub gepusht" >> CHANGELOG.md
echo "- Username: mpone1909" >> CHANGELOG.md
echo "- Datum: $(date +%Y-%m-%d)" >> CHANGELOG.md

git add CHANGELOG.md
git commit -m "chore: Add GitHub deployment note"
git push
```

**Erwartung:**
- ✅ Push erfolgreich
- ✅ GitHub Actions startet automatisch
- ✅ Workflow läuft grün ✅

Prüfe auf: **https://github.com/mpone1909/dara-knowledge/actions**

---

## 🎯 Schritt 7: MCP-Config (Optional, für später)

**Falls du Claude Desktop mit lokalem Zugriff nutzen willst:**

### 7.1 Finde deine Config-Datei

**Windows:**
```
C:\Users\marku\AppData\Roaming\Claude\claude_desktop_config.json
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

**Windows:**
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

**Mac/Linux:**
```json
{
  "mcpServers": {
    "dara-knowledge": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/home/markus/Documents/dara-knowledge"
      ]
    }
  }
}
```

**Wichtig:** Passe den Pfad an deinen tatsächlichen Ordner an!

### 7.3 Claude Desktop neu starten

Nach dem Speichern: Claude Desktop komplett schließen und neu öffnen.

---

## 📊 Schritt 8: Repository-URLs für Notion

**Für deine Notion-Dokumentation:**

### Haupt-URLs

| Zweck | URL |
|-------|-----|
| **Repository** | https://github.com/mpone1909/dara-knowledge |
| **Actions** | https://github.com/mpone1909/dara-knowledge/actions |
| **README** | https://github.com/mpone1909/dara-knowledge/blob/main/README.md |
| **Commits** | https://github.com/mpone1909/dara-knowledge/commits/main |

### Wichtige Dateien

| Datei | URL |
|-------|-----|
| **WISSENSCHAFTLICHE_DOKUMENTATION.md** | https://github.com/mpone1909/dara-knowledge/blob/main/WISSENSCHAFTLICHE_DOKUMENTATION.md |
| **Label-Katalog** | https://github.com/mpone1909/dara-knowledge/blob/main/metadata/label_catalog.csv |
| **Class Hierarchy** | https://github.com/mpone1909/dara-knowledge/blob/main/dara-skill-github-repo/knowledge/class_hierarchy.md |

### Workflows

| Workflow | URL |
|----------|-----|
| **Quality Check** | https://github.com/mpone1909/dara-knowledge/actions/workflows/quality-check.yml |
| **Weekly Backup** | https://github.com/mpone1909/dara-knowledge/actions/workflows/weekly-backup.yml |

---

## ✅ Erfolgs-Checkliste

Nach Abschluss solltest du haben:

- [ ] GitHub-Repository erstellt: https://github.com/mpone1909/dara-knowledge
- [ ] Repository ist **Private** (🔒)
- [ ] Remote hinzugefügt (`git remote -v` zeigt mpone1909)
- [ ] Erster Push erfolgreich (alle 29 Dateien)
- [ ] README.md auf GitHub sichtbar
- [ ] GitHub Actions laufen grün ✅
- [ ] Badge im README funktioniert (grün)
- [ ] Test-Commit gepusht und validiert
- [ ] URLs in Notion dokumentiert

---

## 🎓 Für deine Masterthesis

### Zitation des Repositories

**APA-Format:**
```
[Dein Name]. (2024). DaRa Knowledge Base: Git-versionierte Wissensdatenbank 
für Warehouse-Prozess-Analyse [Software]. GitHub. 
https://github.com/mpone1909/dara-knowledge
```

**BibTeX:**
```bibtex
@software{dara_knowledge_2024,
  author = {[Dein Name]},
  title = {DaRa Knowledge Base: Git-versionierte Wissensdatenbank für Warehouse-Prozess-Analyse},
  year = {2024},
  url = {https://github.com/mpone1909/dara-knowledge},
  note = {Version 4.1.1}
}
```

### Screenshots für Thesis

**Empfohlene Screenshots:**

1. **Repository-Übersicht**
   - URL: https://github.com/mpone1909/dara-knowledge
   - Zeigt: README, Ordnerstruktur, Badge

2. **GitHub Actions**
   - URL: https://github.com/mpone1909/dara-knowledge/actions
   - Zeigt: Grüne Workflows ✅

3. **Label-Katalog**
   - URL: https://github.com/mpone1909/dara-knowledge/blob/main/metadata/label_catalog.csv
   - Zeigt: 207 validierte Labels

4. **Commit-Historie**
   - URL: https://github.com/mpone1909/dara-knowledge/commits/main
   - Zeigt: Saubere Git-Historie

5. **Wissenschaftliche Dokumentation**
   - URL: https://github.com/mpone1909/dara-knowledge/blob/main/WISSENSCHAFTLICHE_DOKUMENTATION.md
   - Zeigt: Vollständige Methodik

---

## 🔍 Troubleshooting

### Problem: "Remote already exists"

**Lösung:**
```bash
git remote remove origin
git remote add origin https://github.com/mpone1909/dara-knowledge.git
```

### Problem: "Permission denied (publickey)"

**Lösung:** Du verwendest SSH statt HTTPS. Wechsle zu HTTPS:
```bash
git remote set-url origin https://github.com/mpone1909/dara-knowledge.git
```

### Problem: "Updates were rejected"

**Lösung:** Jemand hat auf GitHub etwas geändert:
```bash
git pull --rebase origin main
git push
```

### Problem: GitHub Actions schlagen fehl

**Häufigste Ursache:** Markdown-Lint findet Style-Fehler (nicht kritisch)

**Lösung:**
```bash
npm install -g markdownlint-cli2
markdownlint-cli2 "**/*.md" --fix
git add .
git commit -m "fix: Apply markdownlint fixes"
git push
```

---

## 🚀 Nächste Schritte

### Workflow für zukünftige Änderungen

```bash
# 1. Änderungen machen (z.B. in VS Code)
# 2. Status prüfen
git status

# 3. Änderungen stagen
git add .

# 4. Commit erstellen
git commit -m "feat: Beschreibung der Änderung"

# 5. Push zu GitHub
git push

# 6. Verifizieren auf GitHub
# Öffne: https://github.com/mpone1909/dara-knowledge
```

### Branch-Strategie (für größere Änderungen)

```bash
# Neuen Branch erstellen
git checkout -b feature/neue-funktion

# Änderungen machen und committen
git add .
git commit -m "feat: Neue Funktion"

# Push Branch
git push -u origin feature/neue-funktion

# Auf GitHub: Pull Request erstellen
# Nach Merge: Branch löschen
git checkout main
git pull
git branch -d feature/neue-funktion
```

---

## 📞 Support

**Bei Problemen:**
1. Prüfe GitHub Actions: https://github.com/mpone1909/dara-knowledge/actions
2. Prüfe Commit-Historie: https://github.com/mpone1909/dara-knowledge/commits/main
3. Teste lokal: `bash tools/check_integrity.sh`

**Nützliche Git-Befehle:**
```bash
git status              # Zeige aktuellen Status
git log --oneline       # Zeige Commit-Historie
git remote -v           # Zeige Remote-URLs
git diff                # Zeige Änderungen
```

---

## ✅ Zusammenfassung

**Geschafft! Dein Repository ist jetzt:**
- ✅ Auf GitHub: https://github.com/mpone1909/dara-knowledge
- ✅ Private (sicher)
- ✅ Mit CI/CD (automatische Validierung)
- ✅ Vollständig dokumentiert
- ✅ Bereit für deine Thesis

**Gesamtzeit:** ~20 Minuten

---

**Viel Erfolg mit deiner Masterarbeit! 🎓🚀**

*Bei Fragen: Diese Anleitung ist Teil deines Repositories in `GITHUB_SETUP_PERSONALISIERT.md`*
