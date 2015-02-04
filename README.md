GO FISH, an Epicodus week 5 production.
=======================================

by Sarah Joy Calpo, Jackie Fletcher, Mike Goren, & Benjamin Herson

This is a Sinatra application, relying on Active Record.

Installation
------------

Install Go Fish by first cloning the repository.  
```
$ git clone http://github.com/mgoren/go_fish.git
```

Start the database:
```
$ postgres
```

Create the databases, tables, and test environment by running the following:
```
$ rake db:create
$ rake db:schema:load
$ rake db:test:prepare
```

Start the webserver:
```
$ ruby app.rb
```

In your web browser, go to http://localhost:4567

License
-------

GNU GPL v2. Copyright 2015
