common_packages:
  pkg.installed:
    - pkgs:
      - htop
      - perl
      - strace
      - vim
      - python-virtualenv
      - python-devel 
      - git
      - sysstat
  pkg.installed:
    - only_upgrade: True
