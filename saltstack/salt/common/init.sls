{% if salt['grains.get']('kernel', 'Unknown') == 'Windows' %}
include:
  - .packages
  - .sar
{% endif %}
