# SimpleCompany
Simple app using Sinatra (Ruby) for BackEnd and AngularJS+Bootstrap for FrontEnd

## Installation

1. Clone the repo

```bash
$ git clone https://github.com/IsmiKin/simplecompany.git
```

2. Configure the database file (config/database.yml)

```yml
development:
  host: 127.0.0.1
  adapter: mysql2
  encoding: utf8
  database: simplecompany
  username: admin
  password: admin
  pool: 5
  timeout: 5000
  ...
```

3. Make sure all dependencies in your Gemfile are available to your application.

```bash
$ bundle install
```

4. Install all the javascript/css libraries

```bash
$ bower install
```

5. Run the app

```bash
$ ruby simplecompany.rb
```

## API

You can interact with the database using *curl* in your console.

##### Get all companies
Retrieve all the companies (it only returns the active ones)

```bash
$ curl -i http://<host>:<port>/api/company/all/
```
  * Calling example
  ```bash
  $ curl -i http://simplecompany.herokuapp.com:80/api/company/all/
  ```
  
  * Example response
  ```json
    [{"idcompany":5,"name":"Universe Systems","address":"Galaxy","country":"Argentina","city":"Mercury","email":"aa@aa.com","phone":"6944","active":true},{"idcompany":7,"name":"Pluton","address":"Kaisiopea","country":"Antigua & Barbuda","city":"Miami","email":"aa@aa.com","phone":"6944","active":true},{"idcompany":8,"name":"Nombrecito","address":"Angel","country":"Antigua & Barbuda","city":"ddd","email":"lala@lala.com","phone":"6944","active":true}]
  ```
  
##### Get one company 
Get one company using the id (it only returns the active ones)

```bash
  $ curl -i http://<host>:<port>/api/company/company/:idcompany
```
  * Calling example
  
  ```bash
    $ curl -i http://simplecompany.herokuapp.com:80/api/company/1
  ```
  
  * Example response
  
  ```json
    {
      "error": 0,
      "company": {
        "idcompany": 1,
        "name": "Universe",
        "address": "Lejos",
        "country": "Argentina",
        "city": "Torremolinos",
        "email": "iskn@iskn.com",
        "phone": "6664441",
        "active": true
      }
    }
  ```

##### Create company 
Create one company. It only includes the company attributes, not the personal assigned.
