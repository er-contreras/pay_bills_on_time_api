## Description

A RESTful API to add bills on a table with the last day these have to being paid. We can sing up and sing in to add bills and see the bills of our own user.
It has a nice implementation where we can get notified by email when a bill is about to expire.

## Technologies

- Ruby on Rails
- PostgreSQL
- RSpec
- Rubocop
- Redis
- Sidekiq

## How to use it

1. Clone the repository to your local machine. ```git clone git@github.com:er-contreras/time_management_BE.git  ```
2. cd into the directory ```cd time_management_BE```
3. Install all the gems ```bundle install```
4. Create the database ```rails db:create```
5. Run the migrations ```rails db:migrate```
6. Run the server ```rails s```
7. Run the redis server ```redis-server```
8. Run the sidekiq server ```bundle exec sidekiq```
9. Run the tests ```bundle exec rspec```
10. Open the browser and go to sidekiq UI ```http://localhost:3000/sidekiq```
11. Enjoy!

## API Documentation

### Users

#### Sign up

```POST /users```

##### Parameters

| Name | Type | Description |

| ---- | ---- | ----------- |

| `email` | `string` | **Required**. |

| `password` | `string` | **Required**. |

| `password_confirmation` | `string` | **Required**. |

##### Example

```json
{
  "user": {
    "name": "John Doe",
    "username": "johndoe",
    "email": "johndoe@gmail.com",
    "password": "123456"
  }
}
```

## Example when a job was scheduled for the next day.
![Screenshot 2023-08-14 at 19 23 40](https://github.com/er-contreras/pay_bills_on_time_api/assets/67211919/088e5640-8a6f-490e-ba4e-3cc0861a5645)

