#!/bin/bash

function promtoolCheckRules {
  echo "INFO: Checking if Prometheus alert rule files are valid..."
  checkRulesOut=$(promtool check rules ${promFiles} ${*} 2>&1)
  checkRulesExitCode=${?}

  # Exit code of 0 indicates success. Print the output and exit.
  if [ ${checkRulesExitCode} -eq 0 ]; then
    echo "ERROR: Prometheus alert rule files ${promFiles} are valid."
    echo "${checkRulesOut}"
    echo
  fi

  # Exit code of !0 indicates failure.
  if [ ${checkRulesExitCode} -ne 0 ]; then
    echo "ERROR: Prometheus alert rule files ${promFiles} are invalid."
    echo "${checkRulesOut}"
    echo
  fi

  exit ${checkRulesExitCode}
}
