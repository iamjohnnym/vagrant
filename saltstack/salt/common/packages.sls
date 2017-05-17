common_packages:
  pkg.installed:
    - pkgs:
      - perl
      - strace
      - python-virtualenv
      - git
      - sysstat
    {% if grains['os_family'] == 'Debian' %}
      - python-dev
      - vim
    {% elif grains['os_family'] == 'RedHat' %}
      - python-devel 
      - vim-enhanced
    {% endif %}

uptodate:
  pkg.uptodate:
    - refresh: True
