# C0DE - GitHub Green Generator

A flexible tool for generating natural-looking GitHub contribution history with human-like patterns.

## Overview

This tool creates realistic commit patterns on GitHub's contribution graph with configurable date ranges and commit frequencies. Perfect for:
- Demonstrating consistent coding activity
- Creating visual patterns on contribution graphs
- Testing GitHub contribution features
- Portfolio demonstrations

## Features

- **Natural patterns**: Random commits with weekend reductions
- **Human-like timing**: Commit times weighted towards working hours (8-18)
- **Flexible date ranges**: Generate from any start date until today
- **Configurable frequency**: Set min/max commits per day
- **Multiple file changes**: Each commit modifies 3-8 files
- **Realistic messages**: 50+ varied commit messages

## Quick Start

### Generate from Date Until Today

```bash
# Basic usage (18-24 commits per day)
./generate_until_today.sh 2025-10-01 18 24

# Higher activity (27-34 commits per day)
./generate_until_today.sh 2025-01-01 27 34

# Lower activity (10-15 commits per day)
./generate_until_today.sh 2025-06-01 10 15
```

### Parameters

```
./generate_until_today.sh [START_DATE] [MIN_COMMITS] [MAX_COMMITS]
```

- **START_DATE**: Starting date in YYYY-MM-DD format (default: 2025-10-01)
- **MIN_COMMITS**: Minimum commits per day (default: 18)
- **MAX_COMMITS**: Maximum commits per day (default: 24)

### Future Usage

To keep your contribution graph active in the future, simply run:

```bash
# Every month, update from last commit date until today
./generate_until_today.sh 2025-11-11 18 24

# Or automate with cron (update every week)
0 0 * * 0 cd /path/to/c0dE && ./generate_until_today.sh $(date -d "7 days ago" +%Y-%m-%d) 18 24 && git push
```

## How It Works

### Commit Distribution

- **Weekdays**: MIN_COMMITS to MAX_COMMITS commits
- **Weekends**: 50% reduction (more realistic)
- **Time distribution**:
  - 70%: Working hours (8-18)
  - 10%: Early morning (6-7)
  - 15%: Evening (19-22)
  - 5%: Late night (23-5)

### File Changes

Each commit modifies 3-8 random files from the `src/` directory with timestamps and change types:
- Update
- Refactor
- Fix
- Feature
- Optimize
- Security

## Setup History

This repository contains commits from:
- **December 2024**: 820 commits (27-34/day)
- **January-September 2025**: 9 months (27-34/day each)
- **October 2025**: Lighter activity (18-24/day)
- **November 1-10, 2025**: Current period (18-24/day)

## Branch Strategy

- **clean-start**: Main development branch (default)
- **fresh-start**: Legacy branch (archived)
- **master**: Legacy branch (archived)

The `clean-start` branch was created to maintain a clean commit history without legacy artifacts.

## Configuration

### Customize Commit Messages

Edit the `messages` array in `generate_until_today.sh`:

```bash
messages=(
    "Update documentation"
    "Fix responsive layout"
    # Add your custom messages here
)
```

### Adjust Time Distribution

Modify the `get_random_hour()` function:

```bash
get_random_hour() {
    local rand=$((RANDOM % 100))
    if [ $rand -lt 70 ]; then
        echo $((RANDOM % 11 + 8))  # 70% during 8-18
    # ... customize other time ranges
}
```

### Weekend Behavior

Adjust weekend reduction in `get_commit_count()`:

```bash
if is_weekend "$date"; then
    echo $((base_commits / 2))  # Currently 50% reduction
fi
```

## Best Practices

1. **Consistent patterns**: Use similar commit ranges (e.g., 18-24) for natural appearance
2. **Weekend reduction**: Keep weekend commits lower than weekdays
3. **Regular updates**: Run monthly to maintain continuous activity
4. **Branch management**: Use `clean-start` branch and set as default
5. **Backup**: Keep local copy before force pushing

## Maintenance

### Update to Today

```bash
# Get last commit date
LAST_DATE=$(git log -1 --format=%ai | cut -d' ' -f1)

# Generate from last date until today
./generate_until_today.sh $LAST_DATE 18 24

# Push to GitHub
git push origin clean-start
```

### Clean History (if needed)

```bash
# Create new orphan branch
git checkout --orphan new-clean
git add -A
git commit -m "Initial commit"

# Push as new default
git push origin new-clean:clean-start --force
```

## Requirements

- Git
- Bash
- GNU date command (for date calculations)
- GitHub repository access

## Contributing

This is a personal project demonstrating GitHub contribution patterns. Feel free to fork and customize for your own needs.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Author

**farkhanmaul**
- GitHub: [@farkhanmaul](https://github.com/farkhanmaul)
- Repository: [C0DE](https://github.com/farkhanmaul/C0DE)

## Disclaimer

This tool is for educational and demonstration purposes. Use responsibly and in accordance with GitHub's Terms of Service. The contribution graph represents commit activity in this repository only.

---

**Last Updated**: November 10, 2025
**Current Period**: October 1, 2025 - November 10, 2025
**Default Branch**: clean-start
