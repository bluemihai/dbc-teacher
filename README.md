DBC Teacher
================

Problems? Issues?
-----------

Contact Mihai: mihai.banulescu@devbootcamp.com

Ruby on Rails
-------------

This application requires:

- Ruby 2.0.0
- Rails 4.2.6

Getting Started
---------------
Create an application.yml in config/ with
```
OMNIAUTH_PROVIDER_KEY: d25ee7c7f1655bf98b39
OMNIAUTH_PROVIDER_SECRET: ba7f4bbfa4f55b657eb63ff590f6e5dca06c3808
```

Create a database.yml file in config/ with:
```
development:
  adapter:  postgresql
  host:     localhost
  encoding: unicode
  database: dbc-teacher_development
  pool:     5
  username: [YOURS]
  password: [YOURS]
  template: template0

test:
  adapter:  postgresql
  host:     localhost
  encoding: unicode
  database: dbc-teacher_test
  pool:     5
  username: [YOURS]
  password: [YOURS]
  template: template0
```

To run all specs:
```rspec spec/```

To start the server, while watching for changes:
```guard```


Documentation and Support
-------------------------

Issues
-------------

Similar Projects
----------------

Contributing
------------

Ask to be added as a collaborator, then make the changes you want to see.
Keep master green.

Suggestions:
* get a code review from a peer
* write some specs for your code

Credits
-------

License
-------
