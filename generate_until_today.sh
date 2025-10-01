#!/bin/bash

# GitHub Green Generator - From Date Until Today
# Usage: ./generate_until_today.sh START_DATE MIN_COMMITS MAX_COMMITS
# Example: ./generate_until_today.sh 2025-10-01 18 24

set -e

START_DATE=${1:-"2025-10-01"}
MIN_COMMITS=${2:-18}
MAX_COMMITS=${3:-24}
TODAY=$(date +%Y-%m-%d)

git config user.name "farkhanmaul"
git config user.email "farkhanmaul@users.noreply.github.com"

messages=(
    "Update documentation" "Fix responsive layout" "Add new features"
    "Improve performance" "Update dependencies" "Fix typos in comments"
    "Add keyboard shortcuts" "Optimize database queries" "Fix accessibility issues"
    "Update styling" "Improve error handling" "Fix edge case bugs"
    "Add progress tracking" "Update translations" "Improve user experience"
    "Refactor code structure" "Add unit tests" "Update README"
    "Fix memory leaks" "Enhance security" "Add input validation"
    "Improve code readability" "Update API endpoints" "Fix cross-browser compatibility"
    "Add caching mechanism" "Optimize images" "Fix navigation issues"
    "Update color scheme" "Add error logging" "Improve form validation"
    "Fix mobile responsiveness" "Add loading states" "Update configuration"
    "Fix authentication flow" "Add analytics tracking" "Improve search functionality"
    "Fix data synchronization" "Update build process" "Add internationalization"
    "Fix timezone handling" "Improve database schema" "Add rate limiting"
    "Fix memory optimization" "Update third-party libs" "Add feature flags"
    "Improve error messages" "Fix pagination logic" "Add data export feature"
    "Update deployment scripts" "Fix session management" "Add webhook support"
)

get_random_files() {
    local num_files=$((RANDOM % 6 + 3))
    find src -type f 2>/dev/null | shuf -n "$num_files" | head -5
}

modify_file() {
    local file=$1
    echo "// Updated: $(date +%s)" >> "$file"
}

is_weekend() {
    local date=$1
    local dow=$(date -d "$date" +%u)
    [[ $dow -ge 6 ]]
}

get_commit_count() {
    local date=$1
    local base=$((RANDOM % (MAX_COMMITS - MIN_COMMITS + 1) + MIN_COMMITS))
    if is_weekend "$date"; then
        echo $((base / 2))
    else
        echo $base
    fi
}

get_random_hour() {
    local rand=$((RANDOM % 100))
    if [ $rand -lt 70 ]; then
        echo $((RANDOM % 11 + 8))
    elif [ $rand -lt 80 ]; then
        echo $((RANDOM % 2 + 6))
    elif [ $rand -lt 95 ]; then
        echo $((RANDOM % 4 + 19))
    else
        echo $(((RANDOM % 7 + 23) % 24))
    fi
}

create_commit() {
    local date=$1
    local hour=$(get_random_hour)
    local minute=$((RANDOM % 60))
    local second=$((RANDOM % 60))
    local datetime="$date $hour:$minute:$second"
    local msg="${messages[$((RANDOM % ${#messages[@]}))]}"

    local files=$(get_random_files)
    for file in $files; do
        modify_file "$file"
    done

    git add -A
    GIT_AUTHOR_DATE="$datetime" GIT_COMMITTER_DATE="$datetime" \
    git commit -m "$msg" --quiet
}

echo "=================================================="
echo "  GitHub Green Generator"
echo "=================================================="
echo "Configuration:"
echo "  - From: $START_DATE"
echo "  - To: $TODAY"
echo "  - Commits per day: $MIN_COMMITS-$MAX_COMMITS (less on weekends)"
echo "  - Files per commit: 3-8 (random)"
echo "=================================================="
echo ""

total_commits=0
current_date="$START_DATE"

while [[ "$current_date" < "$TODAY" ]] || [[ "$current_date" == "$TODAY" ]]; do
    commits_today=$(get_commit_count "$current_date")

    echo -ne "\rProcessing: $current_date - Today: $commits_today commits - Total: $total_commits"

    for ((i=0; i<commits_today; i++)); do
        create_commit "$current_date"
        total_commits=$((total_commits + 1))
    done

    current_date=$(date -d "$current_date + 1 day" +%Y-%m-%d)
done

echo ""
echo ""
echo "=================================================="
echo "  ✓ Generation Complete!"
echo "=================================================="
echo "Statistics:"
echo "  - Total commits: $(git rev-list --count HEAD)"
echo "  - Period: $START_DATE to $TODAY"
echo "=================================================="
