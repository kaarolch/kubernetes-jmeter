if [ "$ONE_SHOT" = "true" ]; then
  until [ $(find ${TESTS_DIR}/ -type f | wc -l) -ne 0 ]; do
    sleep 20
  done
  if [ -z ${SLAVE_IP_STRING} ]; then
  SLAVE_IP_STRING=`getent ahostsv4 ${SLAVE_SVC_NAME} |awk '!($1 in a){a[$1];printf "%s%s",t,$1; t=","}'`
  fi
  for file in ${TESTS_DIR}/*.jmx ; do
    jmeter -n -t ${file} -Jserver.rmi.ssl.disable=${SSL_DISABLED} -R ${SLAVE_IP_STRING}
  done
else
  echo "Wait for manual run."
  while true ; do
    sleep 60
  done
fi
