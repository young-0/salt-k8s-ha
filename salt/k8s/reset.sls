reset.sh:
  file.managed:
    - name: /tmp/reset.sh
    - source: salt://k8s/files/reset/reset.sh
    - user: root
    - group: root
    - mode: 755
reset-process:
  cmd.run:
    - name: /bin/bash /tmp/reset.sh
    - require:
      - file: /tmp/reset.sh
