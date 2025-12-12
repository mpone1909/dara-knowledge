#!/bin/bash
# tools/check_integrity.sh
# Validiert Label-Katalog und Repository-Integrität

set -e

CATALOG="metadata/label_catalog.csv"
EXPECTED_LABELS=207

echo "🛡️  DaRa Knowledge Base - Integrity Check"
echo "==========================================="

# Check 1: Existiert der Katalog?
echo ""
echo "Check 1: Label-Katalog-Existenz..."
if [ ! -f "$CATALOG" ]; then
    echo "❌ Fehler: $CATALOG fehlt!"
    echo "   Führe aus: bash tools/extract_labels.sh"
    exit 1
fi
echo "✅ $CATALOG gefunden"

# Check 2: Stimmt die Anzahl?
echo ""
echo "Check 2: Label-Anzahl..."
LINE_COUNT=$(wc -l < "$CATALOG" | xargs)
LABEL_COUNT=$((LINE_COUNT - 1))  # Minus Header

if [ "$LABEL_COUNT" -eq "$EXPECTED_LABELS" ]; then
    echo "✅ Label-Check: $LABEL_COUNT Labels gefunden (Korrekt)"
else
    echo "❌ Label-Check: $LABEL_COUNT Labels gefunden (Erwartet: $EXPECTED_LABELS)!"
    exit 1
fi

# Check 3: Format-Validierung
echo ""
echo "Check 3: Label-Format..."
INVALID_LABELS=$(tail -n +2 "$CATALOG" | cut -d',' -f1 | grep -v "^CL[0-9]\{3\}$" || true)

if [ -z "$INVALID_LABELS" ]; then
    echo "✅ Alle Labels haben korrektes Format (CLxxx)"
else
    echo "❌ Ungültige Label-Formate gefunden:"
    echo "$INVALID_LABELS"
    exit 1
fi

# Check 4: Duplikate
echo ""
echo "Check 4: Duplikate..."
DUPLICATES=$(tail -n +2 "$CATALOG" | cut -d',' -f1 | sort | uniq -d)

if [ -z "$DUPLICATES" ]; then
    echo "✅ Keine Duplikate gefunden"
else
    echo "❌ Duplikate gefunden:"
    echo "$DUPLICATES"
    exit 1
fi

# Check 5: DaRa-Skill vorhanden?
echo ""
echo "Check 5: DaRa-Skill-Struktur..."
if [ -d "dara-skill-github-repo/knowledge" ] && [ -f "dara-skill-github-repo/SKILL.md" ]; then
    FILE_COUNT=$(find dara-skill-github-repo/knowledge -name "*.md" | wc -l)
    echo "✅ DaRa-Skill gefunden ($FILE_COUNT Markdown-Dateien in knowledge/)"
else
    echo "⚠️  DaRa-Skill noch nicht migriert (Phase 2)"
fi

# Finale Zusammenfassung
echo ""
echo "==========================================="
echo "✅ Integrity Check abgeschlossen"
echo "   - Labels: $LABEL_COUNT / $EXPECTED_LABELS"
echo "   - Format: Valide"
echo "   - Duplikate: Keine"
