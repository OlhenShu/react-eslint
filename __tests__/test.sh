unzip ./__tests__/src.zip -d ./

failed_count=0
tests_count=$(ls ./src/rules_* | wc -w)

if ! result1=$(npx eslint ./src/check_working.js)
then
  echo 'ESLint should be properly configured!'
  echo 'All tests failed!'
  exit 1
fi

for file in ./src/rules_*
do
  if result1=$(npx eslint $file)
  then
    failed_count=$(($failed_count + 1))
    echo 'Rules did not found the next wrong code:'
    echo '-------------------------------'
    cat $file
    echo '-------------------------------'
    echo ' '
  else
    rule=${file#./src/rules_}
    echo "A test on the rule ${rule%.js} passed"
    echo ' '
  fi  
done

echo "Result of tests:"
echo "$(($tests_count - $failed_count)) passed"
if [ $failed_count -ne 0 ]
then
  echo "$failed_count failed"
  exit 1
fi
