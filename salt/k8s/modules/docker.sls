# -*- coding: utf-8 -*-
#******************************************
# Author:       iokubernetes
# Email:        yang-li@live.cn
# Organization: iokubernetes.github.io
# Description:  Docker Install
#******************************************

include:
  - k8s.modules.base-dir
docker-install:
  cmd.run:
    - name: yum install -y yum-utils device-mapper-persistent-data lvm2 && yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
  pkg.installed:
    - name: docker-ce
    - version: 3:19.03.8-3.el7
    - allow_updates: True
docker-config-dir:
  file.directory:
    - name: /etc/docker
docker-bash-completion:
  pkg.installed:
    - name: bash-completion
  cmd.run:
    - name: /bin/cp /usr/share/bash-completion/completions/docker /etc/bash_completion.d/
docker-daemon-config:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://k8s/templates/docker/daemon.json.template
    - user: root
    - group: root
    - mode: 644
docker-service:
  file.managed:
    - name: /usr/lib/systemd/system/docker.service
    - source: salt://k8s/templates/docker/docker.service.template
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: systemctl daemon-reload
  service.running:
    - name: docker
    - enable: True
    - watch:
      - file: docker-daemon-config
