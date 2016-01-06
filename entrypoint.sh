#!/bin/bash
set -e

azure config mode $AZURE_CONFIG_MODE
azure login -u ${AZURE_USER} -p ${AZURE_PASSWORD}

exec "$@"
