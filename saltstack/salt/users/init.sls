# loop over all users presented by pillar:
# create user's group, create user, then add pub keys
{% for username, details in pillar.get('users', {}).items() %}
{{ username }}:

  group:
    - present
    - name: {{ username }}
    - gid: {{ details.get('gid', '') }}

  user:
    - present
    - fullname: {{ details.get('fullname','') }}
    - name: {{ username }}
    - shell: /bin/bash
    - home: /home/{{ username }}
    - uid: {{ details.get('uid', '') }}
    - gid: {{ details.get('gid', '') }}
    {% if 'groups' in details %}
    - groups:
      {% for group in details.get('groups', []) %}
      - {{ group }}
      {% endfor %}
    {% endif %}


{% endfor %}
