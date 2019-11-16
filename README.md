# HR Presence

HR Presence is an API for managing the moment when an employee of a company arrives and leaves on a certain day. It generates reports with the presence of employees through time.

It has two types of users:
- *Employee*: can log in to the system and check a report with the moment they arrived and left in the last days
- *Administrator*: can manage employees, their reports and the precise moment when an employee arrived or left on a certain day. This type of user is in charge of "marking" those moments.

## Sample API

A sample API can be found [here](https://hr-presence.herokuapp.com/).

Sample data includes:
- 2 employees: both with days worked for a period of 1 month
	- User 1 (`user-1@example.org`). No report created
	- User 2 (`user-2@example.org`). A report created including half a month
- 1 administrator:
	- Administrator (`admin@example.org`)

## Considerations

 1. Only administrators can manage employees reports. Employees can only see their corresponding report.
 2. The system was built thinking on a single company or organization. Multiple companies would require different running instances of the API.
 3. Administrators have the ability to register new employees. There is no registration or sign up process. Administrators can also modify/remove existing users, and create new administrator users.
 4. Authentication is needed to perform every operation on the system. This is accomplished using [JWTs](https://jwt.io/). When a user enters their credentials, a token is sent back to them, and it's the user's (client) responsibility to include it inside the `Authorization` header on subsequent requests.
 5. Reports are not automatically generated, but they should be created by an administrator. When this happens, that administrator needs to specify a start date and an end date for the employee report. By doing so, the report will consist of the days the employee worked, limited by the mentioned dates. If no report exists, then the last month will be shown by default.
 6. Related to the previous point, an administrator can (and very likely will) update the dates of an employee report, to keep them aware of their presence on the company, or can even delete the report (which will cause to use the default dates).


## API Docs

The API endpoints specification can be found on the [wiki](https://github.com/sivicencio/hr-presence/wiki).

## Stack

- Ruby 2.6.5
- Ruby on Rails 5.2.3
- PostgreSQL 11.5
- Heroku (Sample API)



## Setup instructions

For development follow the next steps.

1. Install Ruby version `2.6.5`
2. Clone the repository
3. Inside the root of the repository, run `bundle install` to install gem dependencies
4. Configure database running the following:
	```bash
	rails db:create db:migrate
	rails db:seed
	```
5. Set the `DEVISE_JWT_SECRET_KEY` env variable to a convenient key. A random key can be generated running `bundle exec rake secret`. If you use `direnv` shell extension, you can create a `.envrc` file on the root of the project and add this env variable there.
6. Run `rails server`, which will initiate a local web server with the application running on port `3000`.

## Testing

RSpec is used in this project. You can run the test suite with the following:

```bash
bundle exec rspec
```
The types of specs present are:
- Request specs for all endpoints
- Model specs for all models

## Future work

- Paginate resources
- Standardize errors
