#!/bin/bash

# GitHub Green Generator v2.1
# Creates 365 days with 27-34 random commits per day
# Realistic commits with varied changes
# Author: farkhanmaul

set -e

# Configuration
DAYS=365
MIN_COMMITS=27
MAX_COMMITS=34
START_DATE=$(date -d "365 days ago" +%Y-%m-%d)

# Set git author info
git config user.name "farkhanmaul"
git config user.email "farkhanmaul@users.noreply.github.com"

# Array of realistic commit messages (100+ variations)
messages=(
    "Update documentation"
    "Fix responsive layout"
    "Add new features"
    "Improve performance"
    "Update dependencies"
    "Fix typos in comments"
    "Add keyboard shortcuts"
    "Optimize database queries"
    "Fix accessibility issues"
    "Update styling"
    "Improve error handling"
    "Fix edge case bugs"
    "Add progress tracking"
    "Update translations"
    "Improve user experience"
    "Refactor code structure"
    "Add unit tests"
    "Update README"
    "Fix memory leaks"
    "Enhance security"
    "Add input validation"
    "Improve code readability"
    "Update API endpoints"
    "Fix cross-browser compatibility"
    "Add caching mechanism"
    "Optimize images"
    "Fix navigation issues"
    "Update color scheme"
    "Add error logging"
    "Improve form validation"
    "Fix mobile responsiveness"
    "Add loading states"
    "Update configuration"
    "Fix authentication flow"
    "Add analytics tracking"
    "Improve search functionality"
    "Fix data synchronization"
    "Update build process"
    "Add internationalization"
    "Fix timezone handling"
    "Improve database schema"
    "Add rate limiting"
    "Fix memory optimization"
    "Update third-party libs"
    "Add feature flags"
    "Improve error messages"
    "Fix pagination logic"
    "Add data export feature"
    "Update deployment scripts"
    "Fix session management"
    "Add webhook support"
    "Improve API documentation"
    "Fix race conditions"
    "Update environment variables"
    "Add backup system"
    "Improve test coverage"
    "Fix SQL injection vulnerability"
    "Update CORS policy"
    "Add request throttling"
    "Improve logging system"
    "Fix XSS vulnerability"
    "Update SSL configuration"
    "Add health check endpoint"
    "Improve monitoring"
    "Fix file upload handling"
    "Update password hashing"
    "Add two-factor authentication"
    "Improve session storage"
    "Fix CSRF protection"
    "Update API versioning"
    "Add request validation"
    "Improve error tracking"
    "Fix database indexing"
    "Update cache strategy"
    "Add performance metrics"
    "Improve code coverage"
    "Fix linting errors"
    "Update ESLint rules"
    "Add pre-commit hooks"
    "Improve CI/CD pipeline"
    "Fix Docker configuration"
    "Update nginx settings"
    "Add load balancing"
    "Improve scalability"
    "Fix memory usage"
    "Update TypeScript config"
    "Add GraphQL support"
    "Improve REST endpoints"
    "Fix WebSocket connection"
    "Update middleware"
    "Add request logging"
    "Improve response time"
    "Fix timeout issues"
    "Update retry logic"
    "Add circuit breaker"
    "Improve fault tolerance"
    "Fix connection pooling"
)

# File types and their content generators
declare -A file_types=(
    ["js"]="// JavaScript utility function"
    ["py"]="# Python helper module"
    ["md"]="# Documentation"
    ["json"]="{\"config\": true}"
    ["yaml"]="config: true"
    ["css"]="/* Styles */"
    ["html"]="<!-- Component -->"
    ["sh"]="#!/bin/bash"
    ["txt"]="Notes and references"
    ["sql"]="-- Database query"
)

# Function to create or update a file
create_file_change() {
    local file_index=$((RANDOM % 20 + 1))
    local ext_array=(js py md json yaml css html sh txt sql)
    local ext=${ext_array[$((RANDOM % ${#ext_array[@]}))]}
    local filename="src/module_${file_index}.${ext}"

    # Create directory if needed
    mkdir -p src

    # Create or append to file
    if [ ! -f "$filename" ]; then
        echo "${file_types[$ext]}" > "$filename"
        echo "// Created: $(date +%s)" >> "$filename"
    fi

    # Make varied changes
    case $((RANDOM % 8)) in
        0) echo "// Updated: $(date +%s)" >> "$filename" ;;
        1) echo "// Refactor: $(date +%s)" >> "$filename" ;;
        2) echo "// Fix: $(date +%s)" >> "$filename" ;;
        3) echo "// Feature: $(date +%s)" >> "$filename" ;;
        4) echo "// Optimize: $(date +%s)" >> "$filename" ;;
        5) echo "// Security: $(date +%s)" >> "$filename" ;;
        6) echo "// Performance: $(date +%s)" >> "$filename" ;;
        7) echo "// Cleanup: $(date +%s)" >> "$filename" ;;
    esac

    echo "$filename"
}

# Function to create commit
create_commit() {
    local date=$1
    local commit_num=$2
    local total_commits=$3

    # Spread commits throughout the day (0-23 hours)
    local hour=$((commit_num * 24 / total_commits))
    local minute=$((RANDOM % 60))
    local second=$((RANDOM % 60))
    local commit_datetime="$date $hour:$minute:$second"

    # Random message
    local msg_index=$((RANDOM % ${#messages[@]}))
    local commit_msg="${messages[$msg_index]}"

    # Create file changes (1-3 files per commit)
    local num_files=$((RANDOM % 3 + 1))
    for ((i=0; i<num_files; i++)); do
        create_file_change > /dev/null
    done

    # Also occasionally update README
    if [ $((RANDOM % 10)) -eq 0 ]; then
        echo "<!-- Stats: $(date +%s) -->" >> README.md
    fi

    # Stage changes
    git add -A

    # Commit with specific date
    GIT_AUTHOR_DATE="$commit_datetime" GIT_COMMITTER_DATE="$commit_datetime" \
    git commit -m "$commit_msg" --quiet
}

# Main execution
echo "=================================================="
echo "  GitHub Green Generator v2.1"
echo "=================================================="
echo "Configuration:"
echo "  - Days: $DAYS"
echo "  - Commits per day: $MIN_COMMITS-$MAX_COMMITS (random)"
echo "  - Start date: $START_DATE"
echo "=================================================="
echo ""

total_commits=0

# Generate commits for each day
for ((day=0; day<DAYS; day++)); do
    # Calculate date
    current_date=$(date -d "$START_DATE + $day days" +%Y-%m-%d)

    # Random commits for this day (27-34)
    commits_today=$((RANDOM % (MAX_COMMITS - MIN_COMMITS + 1) + MIN_COMMITS))

    echo -ne "\\rProgress: Day $((day+1))/$DAYS ($current_date) - Today: $commits_today commits - Total: $total_commits"

    # Create commits for this day
    for ((commit=0; commit<commits_today; commit++)); do
        create_commit "$current_date" "$commit" "$commits_today"
        total_commits=$((total_commits + 1))
    done
done

echo ""
echo ""
echo "=================================================="
echo "  ✓ Generation Complete!"
echo "=================================================="
echo "Statistics:"
echo "  - Total commits created: $(git rev-list --count HEAD)"
echo "  - Files created: $(find src -type f 2>/dev/null | wc -l)"
echo "  - Date range: $START_DATE to $(date +%Y-%m-%d)"
echo "  - Average commits per day: $((total_commits / DAYS))"
echo "=================================================="
echo ""
echo "Next steps:"
echo "  1. Review changes: git log --oneline -20"
echo "  2. Push to GitHub: git push --force origin master"
echo ""
echo "⚠️  Warning: This will rewrite git history!"
echo "    Make sure this is what you want before pushing."
echo ""
