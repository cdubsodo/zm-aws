#cloud-config
output:
  all: '| tee -a /var/log/cloud-init-output.log'

${ssh_authorized_keys}

runcmd:
  - sudo systemctl stop docker.service

write_files:
  - path: /etc/profile.d/tfenv.sh
    permissions: "0755"
    content: |
      # environment variables managed by Terraform
      export TF_ENV=${environment}
      export TF_PROJECT=${project}
      export TF_ROLE=${role}
      export TERM_NORMAL="\033[0m"
      export TERM_RED="\033[0;31m"
      [ $$TF_ENV == "prod" ] && export TERM_COLOR=$$TERM_RED || export TERM_COLOR=$$TERM_NORMAL
      export PS1="\[$${TERM_COLOR}\][$${TF_ROLE} \W]$$ \[$${TERM_NORMAL}\]"
  - path: /etc/docker/daemon.json
    content: |
      {
        "hosts": [
          "tcp://0.0.0.0:2375",
          "unix:///var/run/docker.sock"
        ],
        "labels": [
          "role=ldap"
        ]
      }

runcmd:
  - sudo systemctl start docker.service
