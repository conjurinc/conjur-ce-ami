# Overview

We use Ansible running in a Docker container to build the Conjur CE AMI. The `Jenkinsfile` describes the build pipeline.

In it, `build.sh` first builds a docker image that can run Ansible. This image is also configured so it can talk to AWS and CoreOS.

Next, it creates a container from that image, configured through environment variables set by summon.

The container uses `run-ansible.sh` to run the Ansible playbook main.yml.

The playbook starts by creating a CoreOS EC2 instance.

Then, on the instance, Ansible tasks

* Pull the Conjur CE image from quay.io
* Pull the Conjur cli5 image from DockerHub
* Install a systemd description of the Conjur service, as well as a couple of scripts that will configure it when a Conjur CE instance is launched.
* Mark the Conjur service as disabled
* Create an AMI from the EC2 instance
* Terminates the EC2 intance
