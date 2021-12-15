# Promtool GitHub Actions

Promtool GitHub Actions allow you to check Prometheus configs and Alert rules within GitHub Actions.

The output of the actions can be viewed from the Actions tab in the main repository view.

This action ignores bearer token errors when checking Prometheus configs.

## Success Criteria

An exit code of `0` is considered a successful execution.

## Usage

Promtool GitHub Actions are a single GitHub Action that executes different promtool subcommands depending on the content of the GitHub Actions YAML file. Only `rules` and `config` is supported which runs `promtool check rules` and `promtool check config` for the given files.

```yaml
name: Check Prometheus Alert rules

on:
  pull_request:
    paths:
    - 'prometheus/config/*.yml'
    - 'prometheus/alert_rules/*.yml'

jobs:
  on-pull-request:
    name: On Pull Request
    runs-on: ubuntu-latest
    steps:
    - name: Checkout Repo
      uses: actions/checkout@master

    - name: Check Prometheus alert rules
      uses: DiannaBanana/promtool-gh-action@main
      with:
        promtool_actions_subcommand: 'rules'
        promtool_actions_files: 'prometheus/alert_rules/*.yml'
        promtool_actions_version: '2.14.0'

    - name: Check Prometheus configs
      uses: DiannaBanana/promtool-gh-action@main
      with:
        promtool_actions_subcommand: 'config'
        promtool_actions_files: 'prometheus/config/*.yml'
        promtool_actions_version: '2.14.0'

```

## Inputs

* `promtool_actions_subcommand` - (Required) The Promtool subcommand to execute. Valid values are `rules` and `config`.
* `promtool_actions_files` - (Required) Path to files. Can be something like `configs/*.yml` or `alert_rules/*.yml`. 
* `promtool_actions_version` - (Optional) The Promtool version to install and execute (Prometheus bundle version). The default is set to `latest` and the latest stable version will be pulled down automatically.
