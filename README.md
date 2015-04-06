# SimpleCompany
Simple app using Sinatra (Ruby) for BackEnd and AngularJS+Bootstrap for FrontEnd

## Live Demo

You can see a [live demo] in Heroku.

## Installation

1.Clone the repo

```bash
$ git clone https://github.com/IsmiKin/simplecompany.git
```

2.Configure the database file (config/database.yml)

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

3.Make sure all dependencies in your Gemfile are available to your application.

```bash
$ bundle install
```

4.Install all the javascript/css libraries

```bash
$ bower install
```

5.Run the app

```bash
$ ruby simplecompany.rb
```

## Model

You can see the [Model] in the Wiki's section

## API

You can interact with the database using *curl* in your console.

##### Get all companies
Retrieve all the companies (it only returns the active ones)

```bash
$ curl http://<host>:<port>/api/company/all/
```
  * Calling example
  ```bash
  $ curl http://simplecompany.herokuapp.com:80/api/company/all/
  ```
  
  * Example response
  ```json
    [{"idcompany":5,"name":"Universe Systems","address":"Galaxy","country":"Argentina","city":"Mercury","email":"aa@aa.com","phone":"6944","active":true},{"idcompany":7,"name":"Pluton","address":"Kaisiopea","country":"Antigua & Barbuda","city":"Miami","email":"aa@aa.com","phone":"6944","active":true},{"idcompany":8,"name":"Nombrecito","address":"Angel","country":"Antigua & Barbuda","city":"ddd","email":"lala@lala.com","phone":"6944","active":true}]
  ```

  
##### Get one company 
Get one company using the id (it only returns the active ones)

```bash
  $ curl http://<host>:<port>/api/company/company/:idcompany
```
  * Calling example
  
  ```bash
    $ curl  http://simplecompany.herokuapp.com:80/api/company/1
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
Create one company and create a record in CompanyBK. It only includes the company attributes, not the personal assigned.

```bash
  $ curl -d "name=<value1>&address=<value2>&city=<value3>&country=<value4>&email=<value5>&phone=<value6>" http://<host>:<port>/api/company/
```

  * Calling example
  
  ```bash
    $ curl -d "name=Google&address=MountainView&city=SF&country=USA&email=g%40g.com&phone=111111" http://simplecompany.herokuapp.com:80/api/company/
  ```
  
  * Example response
  
  ```json
    {
        "error": 0,
        "message": "The new company has been created.",
        "idcompany": 13
    }
  ```
  

##### Update company 
Update an existing company. This action override the company's data and create a record in CompanyBK.

```bash
  $ curl -X PUT -d "name=<value1>&address=<value2>&city=<value3>&country=<value3>&email=<g%40g.com>&phone=<111111>&idcompany=<1>" http://<host>:<port>/api/company/
```

  * Calling example
  
  ```bash
    $ curl -X PUT -d "name=Google&address=MountainView&city=SF&country=USA&email=g%40g.com&phone=111111&idcompany=1" http://simplecompany.herokuapp.com:80/api/company/
  ```
  
  * Example response
  
  ```json
      {
        "error": 0,
        "message": "The new company has been updated."
      }
  ```

##### Delete company 
Delete an existing company. This action set a "false" the attribute "active", it means that the Company is still existing but it is not accesible.

```bash
  $ curl -X DELETE  http://<host>:<port>/api/company/:idcompany
```

  * Calling example
  
  ```bash
    $ curl -X DELETE  http://simplecompany.herokuapp.com:80/api/company/1
  ```
  
  * Example response
  
  ```json
      {
        "error": 0,
        "message": "The company with id 1 has been removed"
      }
  ```

##### Get full company info
Get all the information regarding a company. It includes the attributes and the personal assigned.


```bash
  $ curl http://localhost:4567/api/company/full/:idcompany
```

  * Calling example
  
  ```bash
    $ curl http://simplecompany.herokuapp.com:80/api/company/full/17
  ```
  
  * Example response
  
  ```json
      {
          "error": 0,
          "company": {
              "idcompany": 17,
              "name": "Google",
              "address": "Mountain View",
              "country": "Albania",
              "city": "SF",
              "email": "g@g.com",
              "phone": "1111111",
              "active": true
          },
          "staff": [
            {
              "idperson": 7,
              "name": "Michael",
              "type": "Director",
              "passport": "/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSgBBwcHCggKEwoKEyg... (binary data truncated)",
              "active": true,
              "company_idcompany": 17
            }
          ]
      }
  ```
  
  
##### Create new person
Assign person to a Company.


```bash
  $ curl -F "passport=@<filename.pdf>" -F "name=<value1>&type=<value2>" http://<host>:<port>/api/person/
```

  * Calling example
  
  ```bash
    $ curl -F "passport=@pdffile.pdf" -F "name=Gandalf&type=Director" http://simplecompany.herokuapp.com:80/api/person/
  ```
  
  * Example response
  
  ```json
      {
        "error": 0,
        "message": "The new person has been created."
      }
  ```

**Note:** If you are using [Rest Postman Client] (Chrome App) you can download this collection or copy it from this [gist collection].
**Note2:** All the examples are made using all the attributes. You can avoid non-mandatory attributes. You can observe this information in the next "Model Section".

##License
MIT

[gist collection]:https://gist.github.com/IsmiKin/20eb40d95c58f7f9f8f2
[Rest Postman Client]:http://www.getpostman.com/
[live demo]:http://simplecompany.herokuapp.com/
[Model]:https://github.com/IsmiKin/simplecompany/wiki/Model
