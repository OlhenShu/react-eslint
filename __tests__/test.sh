#!/usr/bin/env bash
set -euo pipefail

eslint_cmd=(npx --no-install eslint)

rm -rf ./src
unzip -o ./__tests__/src.zip -d ./

shopt -s nullglob
files=(./src/rules_*.js)
tests_count=${#files[@]}
failed_count=0

if [ "$tests_count" -eq 0 ]; then
  echo 'No test fixtures found!'
  exit 1
fi

if ! command -v npx >/dev/null 2>&1; then
  echo 'npx is required to run the tests. Install Node.js and npm.'
  exit 1
fi

echo 'Checking that valid code passes ESLint...'
if ! check_output=$("${eslint_cmd[@]}" ./src/check_working.js 2>&1); then
  echo 'ESLint should be properly configured!'
  echo 'Valid file ./src/check_working.js must not produce errors:'
  echo "$check_output"
  echo 'All tests failed!'
  exit 1
fi
echo 'Valid code passed'
echo

for file in "${files[@]}"
do
  rule=${file#./src/rules_}
  rule=${rule%.js}

  stylish_output=$("${eslint_cmd[@]}" "$file" 2>&1 || true)
  json_output=$("${eslint_cmd[@]}" -f json "$file" 2>/dev/null || true)

  if ! printf '%s' "$json_output" | node ./__tests__/assert-rule.js "$rule"
  then
    failed_count=$((failed_count + 1))
    echo "A test on the rule ${rule} failed"
    echo 'Wrong code:'
    echo '-------------------------------'
    cat "$file"
    echo '-------------------------------'
    echo 'ESLint output:'
    echo "$stylish_output"
    echo
  else
    echo "A test on the rule ${rule} passed"
    echo
  fi
done

echo 'Result of tests:'
echo "$((tests_count - failed_count)) passed"
if [ "$failed_count" -ne 0 ]
then
  echo "$failed_count failed"
  exit 1
fi
