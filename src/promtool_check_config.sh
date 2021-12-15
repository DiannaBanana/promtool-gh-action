#!/bin/bash

function promtoolCheckConfig {
  echo "INFO: Checking if Prometheus config files are valid..."
  exitCode=0
  for configFile in ${promFiles}; do
    checkConfigOut=$(promtool check config ${configFile} 2>&1)
    if [[ ${checkConfigOut} == *"FAILED"* ]] && [[ ${checkConfigOut} != *"error checking bearer token file"* ]]; then
      promtoolExitCode=1
      exitCode=1
    else 
      promtoolExitCode=0
    fi

    # Exit code of 0 indicates success. Print the output and exit. Note: skipping bearer token errors.
    if [ ${promtoolExitCode} -eq 0 ]; then
      echo "INFO: Prometheus config file ${configFile} is valid."
      if [[ ${checkConfigOut} == *"error checking bearer token file"* ]]; then
        echo "WARN: Ignoring bearer token errors..."
      else
        echo "${checkConfigOut}"
      fi
      echo
    fi

    # Exit code of !0 indicates failure.
    if [ ${promtoolExitCode} -ne 0 ] && [[ ${checkConfigOut} != *"error checking bearer token file"* ]]; then
      echo "ERROR: Prometheus config file ${configFile} is invalid."
      echo "${checkConfigOut}"
      echo
    fi
  done

  exit ${exitCode}
}
