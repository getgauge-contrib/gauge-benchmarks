#! /bin/bash

# This file is to be used to generate a Github Flavored Markdown comment to be pushed against the PR.

table_header='Commit|CPU|Memory|Time|ExitCode\n---|---|---|---|---'

tablify () {
    printf '**%s**' $(cat $1 | sed 's/\,/\*\*\|\*\*/g')
}

export -f tablify

echo -e "### Benchmark Results\n\n\
$(find ./out -name '*.csv' -printf "echo '\`%f\`\n\n$table_header'; tail -3 docs/data/gauge/%f | tr ',' '|'; tablify %p" | bash)\n\n\
### Notes\n\n\
- The results above are generated by running against seed projects in https://github.com/getgauge/gauge-benchmark\n\
- These results are not persisted, but on merging to master the benchmark will be rerun.\n\
- These benchmark are run in Github Actions' agents, which are virtualized. Results are not to be taken as actual benchmarks.\
Rather, these are indicative numbers and make sense for comparison."