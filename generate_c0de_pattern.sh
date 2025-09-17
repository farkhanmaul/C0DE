#!/bin/bash

# Script to create GitHub contribution pattern spelling "C0DE"
# Clean pattern: Monday-Friday only, 1 week gap between letters
# Time period: December 2024 to April 2025

# Array of realistic commit messages
messages=(
    "Update documentation"
    "Fix responsive layout"
    "Add new features"
    "Improve performance"
    "Update dependencies"
    "Fix typos"
    "Add keyboard shortcuts"
    "Optimize code"
    "Fix accessibility"
    "Update styling"
    "Improve UI"
    "Fix bugs"
    "Add progress tracking"
    "Update translations"
    "Improve user experience"
    "Refactor code structure"
    "Add unit tests"
    "Update README"
    "Fix memory leaks"
    "Enhance security"
)

# Set git author info
git config user.name "farkhanmaul"
git config user.email "farkhanmaul@users.noreply.github.com"

# Function to create commit on specific date
create_commit() {
    local date=$1
    local hour=$((9 + RANDOM % 10))  # Between 9-18 (working hours)
    local minute=$((RANDOM % 60))
    local commit_datetime="$date $hour:$minute:00"

    # Random message
    local msg_index=$((RANDOM % ${#messages[@]}))
    local commit_msg="${messages[$msg_index]}"

    echo "Creating commit for $commit_datetime: $commit_msg"

    # Make small change to README
    case $((RANDOM % 4)) in
        0) echo "" >> README.md ;;
        1) echo "<!-- Updated: $date -->" >> README.md ;;
        2) echo "<!-- Progress: $(date +%s) -->" >> README.md ;;
        3) echo "<!-- Version: 1.0.$(date +%j) -->" >> README.md ;;
    esac

    git add README.md

    # Commit with specific date
    GIT_AUTHOR_DATE="$commit_datetime" GIT_COMMITTER_DATE="$commit_datetime" \
    git commit -m "$commit_msg"
}

echo "Creating clean C0DE pattern (Monday-Friday only, 1 week gaps)..."

# GitHub contribution grid: 7 rows (Sun-Sat), multiple weeks
# Pattern: Each letter is 5 weeks wide (Mon-Fri), 7 rows tall
# Gap: 1 week between letters

# Letter C (Week 1-5: Dec 2-6, Dec 9-13, Dec 16-20, Dec 23-27, Dec 30-Jan 3)
echo "Creating letter C..."
c_pattern=(
    # Top horizontal line (Week 1: Dec 2-6, 2024)
    "2024-12-02" "2024-12-03" "2024-12-04" "2024-12-05" "2024-12-06"
    # Left vertical (Week 2: Dec 9-13)
    "2024-12-09"
    # Left vertical (Week 3: Dec 16-20)
    "2024-12-16"
    # Left vertical (Week 4: Dec 23-27)
    "2024-12-23"
    # Bottom horizontal line (Week 5: Dec 30-Jan 3, 2025)
    "2024-12-30" "2024-12-31" "2025-01-01" "2025-01-02" "2025-01-03"
)

# 1 week gap

# Letter 0 (Week 7-11: Jan 13-17, Jan 20-24, Jan 27-31, Feb 3-7, Feb 10-14)
echo "Creating letter 0..."
zero_pattern=(
    # Top horizontal line (Week 7: Jan 13-17, 2025)
    "2025-01-13" "2025-01-14" "2025-01-15" "2025-01-16" "2025-01-17"
    # Left and right vertical (Week 8: Jan 20-24)
    "2025-01-20" "2025-01-24"
    # Left and right vertical with diagonal (Week 9: Jan 27-31)
    "2025-01-27" "2025-01-29" "2025-01-31"
    # Left and right vertical (Week 10: Feb 3-7)
    "2025-02-03" "2025-02-07"
    # Bottom horizontal line (Week 11: Feb 10-14)
    "2025-02-10" "2025-02-11" "2025-02-12" "2025-02-13" "2025-02-14"
)

# 1 week gap

# Letter D (Week 13-17: Feb 24-28, Mar 3-7, Mar 10-14, Mar 17-21, Mar 24-28)
echo "Creating letter D..."
d_pattern=(
    # Top horizontal line (Week 13: Feb 24-28, 2025)
    "2025-02-24" "2025-02-25" "2025-02-26" "2025-02-27" "2025-02-28"
    # Left vertical and right curve (Week 14: Mar 3-7)
    "2025-03-03" "2025-03-07"
    # Left vertical and right curve (Week 15: Mar 10-14)
    "2025-03-10" "2025-03-14"
    # Left vertical and right curve (Week 16: Mar 17-21)
    "2025-03-17" "2025-03-21"
    # Bottom horizontal line (Week 17: Mar 24-28)
    "2025-03-24" "2025-03-25" "2025-03-26" "2025-03-27" "2025-03-28"
)

# 1 week gap

# Letter E (Week 19-23: Apr 7-11, Apr 14-18, Apr 21-25, Apr 28-May 2, May 5-9)
echo "Creating letter E..."
e_pattern=(
    # Top horizontal line (Week 19: Apr 7-11, 2025)
    "2025-04-07" "2025-04-08" "2025-04-09" "2025-04-10" "2025-04-11"
    # Left vertical (Week 20: Apr 14-18)
    "2025-04-14"
    # Middle horizontal line (Week 21: Apr 21-25)
    "2025-04-21" "2025-04-22" "2025-04-23"
    # Left vertical (Week 22: Apr 28-May 2)
    "2025-04-28"
    # Bottom horizontal line (Week 23: May 5-9)
    "2025-05-05" "2025-05-06" "2025-05-07" "2025-05-08" "2025-05-09"
)

# Create commits for each letter
for date in "${c_pattern[@]}"; do
    create_commit "$date"
done

for date in "${zero_pattern[@]}"; do
    create_commit "$date"
done

for date in "${d_pattern[@]}"; do
    create_commit "$date"
done

for date in "${e_pattern[@]}"; do
    create_commit "$date"
done

echo ""
echo "C0DE pattern created successfully!"
echo "Pattern details:"
echo "- Letter C: Dec 2-Jan 3 (5 weeks)"
echo "- Gap: 1 week"
echo "- Letter 0: Jan 13-Feb 14 (5 weeks)"
echo "- Gap: 1 week"
echo "- Letter D: Feb 24-Mar 28 (5 weeks)"
echo "- Gap: 1 week"
echo "- Letter E: Apr 7-May 9 (5 weeks)"
echo "- Only Monday-Friday commits"
echo ""
echo "Total commits: $(git rev-list --count HEAD)"
echo "Ready to push: git push --force-with-lease origin master"