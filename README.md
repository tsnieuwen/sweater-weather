# Sweater Weather

## About this Project
Sweater Weather is the backend component of a mock weather application in which the user can weather current, hourly, and daily weather, as well as forecasted estimated time of arrival weather at the destination of a road trip. The project spec from Turing can be found here: https://backend.turing.edu/module3/projects/sweater_weather/

## Table of Contents

  - [Getting Started](#getting-started)
  - [Running the tests](#running-the-tests)
  - [External API Endpoints](#external-api-endpoints)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
  - [Versioning](#versioning)
  - [Author](#author)

## Getting Started

To get the web application running, please fork and clone down the repo.
`git clone <your@github.account>/sweater-weather.git`

### Prerequisites

To run this application you will need Ruby 2.5.3 and Rails 5.2.5

### Installing

- Install the gem packages  
`bundle install`

- Create the database by running the following command in your terminal
`rails db{:drop, :create, :migrate}`

## Running the tests
RSpec testing suite is utilized for testing this application.
- Run the RSpec suite to ensure everything is passing as expected  
`bundle exec rspec`

## External API Endpoints

- Sweater Weather consumes four external APIs:
  - `https://developer.mapquest.com/documentation/geocoding-api/` for geocoded addresses
  - `https://openweathermap.org/api/one-call-api` for weather forecasts
  - `https://developer.mapquest.com/documentation/directions-api/` for road trip travel time
  - `https://unsplash.com/documentation#search-photos` for background images

This project will also require the gem `figaro`. Please add this in the development/ test part of the Gemfile.
  `gem figaro`

  - Run `bundle exec figaro install `
  - This will generate an `application.yml` file within the `config` folder.

    **It is imperative that the `application.yml` file is added to `.gitignore` so that the `env[VARS]` are not pushed up to production.**

  - You will need to get your own API keys from the three external endpoint sources listed above. These API keys will be set to to their own respective environmental variables as shown below

   ```
   #config/application.yml

   mapquest_key: <your mapquest api key>
   open_weather_key: <your open weather api key>
   unsplash_key: <your unsplash api key>

  - Add `application.yml` to `.gitignore` like so:
  `# Ignore application configuration
  /config/application.yml`

## Endpoints
- `GET /api/v1/forecast`

  - Required query param: `location`
  - Returns current forecasted data for the location. Also returns hourly forecasts up to 48 hours, and daily forecasts up to seven days.


- `GET /api/v1/backgrounds`

  - Required query param: `location`
  - Returns a url for an image that is returned based on the location query parameter.


- `POST /api/v1/users`

  - Required data passed via request body: `email, password, password_confirmation`
  - Creates a user in the database. Upon creation, users are assigned a random api key.


- `POST /api/v1/sessions`

  - Required data passed via request body: `email, password`
  - Logs user into the application


- `POST /api/v1/road_trip`

  - Required data passed via request body: `origin, destination, api_key`
  - Returns travel time between origin and destination, and forecasted weather at the destination at the estimated time of arrival


## Built With
- Ruby
- Rails
- RSpec
- Fast_JSONAPI


## Versioning
- Ruby 2.5.3
- Rails 5.2.5

## Author
**Tommy Nieuwenhuis**
|  [GitHub](https://github.com/tsnieuwen) |
    [LinkedIn](https://www.linkedin.com/in/thomasnieuwenhuis/)
