# The default for sar on Ubuntu is to have it turned off.
{% if grains['os_family'] == 'Debian' %}
/etc/default/sysstat:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://common/files/sar.ubuntu
{% endif %}

{% if grains['os_family'] == 'Debian' or grains['os_family'] == 'RedHat' %}
{% if grains['os_family'] == 'Debian' %}
/etc/sysstat/sysstat:
{% elif grains['os_family'] == 'RedHat' %}
/etc/sysconfig/sysstat:
{% endif %}
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://common/files/sysstat.config
{% endif %}
