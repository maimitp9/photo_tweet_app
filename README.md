# Photo Tweet Application

Photos are uploded by the user and tweet that photos to Remote server by using [oAuth](https://oauth.net/2/) authorization

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

* Ruby version

  - Ruby-2.6.1

* Rails vesrion

  - Rails-5.2 

### Installing

A step by step series of examples that tell you how to get a development env running

- clone this repository

```
git clone https://github.com/maimitp9/photo_tweet_app.git
```

- Move to application folder after repository clone completed

```
cd photo_tweet_app
```

- Inatall bundle to install the application dependencey

```
bundle install
```

- Rename the *config/secrets.example.yml* to *scerets.yml* and update the required informarion in *secrets.yml*

## Database Configuration

*sqlite3* used as database for this application.

- Run migration to create database and tables 

```
rails db:migrate
```

- check the *db/schema.rb* after migration completed successfully
- Run *db/seed.rb* file to create sample data for application

```
rails db:seed
```

## Running Tests

For this application Rails-5.2 default test framework - [Minitest](https://guides.rubyonrails.org/testing.html) 

### Test includes

- Model tests
- Controller tests

### how to run tests

Run this command

```
rails test
```

All the tests should be *GREEN* to pass all test cases

## Running Application

- Start rails server

> Make sure you are in the application folder

```
rails s
```

- Check the application on browser, open the any browser of your choice and hit the following in the browser url

> Make sure server listen on port 3000

```
localhost:3000
```

## ActiveStorage attachment

This applicaion uses [ActiveStorage](https://edgeguides.rubyonrails.org/active_storage_overview.html) for attachment

### How to create attachment from rails console 

* Open rails console

```
rails c
```

- Create image with attachment from rails colsole

  - find user by user_name

  > make sure sample data created with *db/seed.rb*

  ```
  user = User.find_by(user_name: 'test_user')
  ```
  - create image with attachemnt belongs to above user

  ```
  user.images.create(title: 'image_title', photo: upload_file("#{Rails.root}/public/img_1.jpeg"))
  ```

  - check attachment, this will return *true* if attached. *false* otherwise

  ```
  user.images.first.photo.attached?
  ```

- View the attachment for this user run the application and check in the browser with login this user

## Author

* **Maimit Patel** - [GitHub profile](https://github.com/maimitp9)
