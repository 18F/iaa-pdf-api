DOMAIN=https://iaa-pdf-api.18f.gov
TEST_STRING=anArbitraryStringOfText
TEST_PDF='file.pdf'
TEST_DATA_FIELDS='results.txt'

function cleanup {
  rm $TEST_PDF
  rm $TEST_DATA_FIELDS
}

curl \
  -H "Content-Type: application/json" \
  -X POST \
  -d '{"servicing_agency_tracking_number":"'$TEST_STRING'"}' \
    $DOMAIN/iaa/7600a > $TEST_PDF \

pdftk $TEST_PDF dump_data_fields > $TEST_DATA_FIELDS

if grep -q $TEST_STRING $TEST_DATA_FIELDS;
then
  echo "Tests Passed"
  cleanup
  exit 0
else
  echo "Tests Failed"
  cleanup
  exit 1
fi






