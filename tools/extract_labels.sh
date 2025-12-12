#!/bin/bash
# tools/extract_labels.sh
# Generiert metadata/label_catalog.csv aus class_hierarchy.md

set -e

OUTPUT="metadata/label_catalog.csv"
HIERARCHY_FILE="dara-skill-github-repo/knowledge/class_hierarchy.md"

echo "🔍 Erstelle Label-Katalog aus $HIERARCHY_FILE..."

# Prüfe, ob Quelldatei existiert
if [ ! -f "$HIERARCHY_FILE" ]; then
    echo "❌ Fehler: $HIERARCHY_FILE nicht gefunden!"
    echo "   Stelle sicher, dass DaRa-Skill in dara-skill-github-repo/ vorhanden ist."
    exit 1
fi

# CSV Header
echo "LabelID,Name" > "$OUTPUT"

# Extrahiere Zeilen wie "**CL001** | Synchronization"
# Entfernt Fettdruck-Sternchen und ersetzt Pipe durch Komma
grep -oE "\*\*CL[0-9]{3}\*\* \| .+" "$HIERARCHY_FILE" | \
  sed 's/\*\*//g' | \
  sed 's/ | /,/g' >> "$OUTPUT"

# Zähle Zeilen
LINE_COUNT=$(wc -l < "$OUTPUT")
LABEL_COUNT=$((LINE_COUNT - 1))

echo "✅ Fertig. $LINE_COUNT Zeilen geschrieben (Header + $LABEL_COUNT Labels)."
echo "   Erwartet: 208 Zeilen (Header + 207 Labels)"

if [ "$LABEL_COUNT" -eq 207 ]; then
    echo "✅ Label-Anzahl korrekt!"
else
    echo "⚠️  Warnung: $LABEL_COUNT Labels gefunden, erwartet 207"
fi
