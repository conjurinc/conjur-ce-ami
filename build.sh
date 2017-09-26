#!/bin/bash -eux

CONJUR_VERSION="${1:-latest}"
# Default these variables to make development easier. They should be get in the environment (i.e. in the Jenkinsfile)
# when this script gets used as part of a build.
: ${INSTANCE_ID_FILE=dev-EC2.txt}
: ${AMI_ID_FILE=dev-AMI.txt}

finish() {
  if [ -f "${INSTANCE_ID_FILE}" ]; then
    ./ansible.sh ansible-playbook -v \
      -e instance_id="$(< ${INSTANCE_ID_FILE})" \
      -e instance_state=absent \
      instance.yml
  fi
}
trap finish EXIT

./ansible.sh ansible-playbook -vvv \
  -e ami_id_filename="${AMI_ID_FILE}" \
  -e instance_id_filename="${INSTANCE_ID_FILE}" \
  -e conjur_version="$CONJUR_VERSION"
  build.yml
