common_packages:
  pkg.installed:
    - pkgs:
      - htop
      - perl
      - strace
      - vim-enhanced
      - python-virtualenv
      - python-devel 
      - git
      - sysstat

uptodate:
  pkg.uptodate:
    - refresh: True
