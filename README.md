<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
    <img src="https://user-images.githubusercontent.com/116703107/234485025-fb4e2b81-17cb-4cda-8699-2787664b504f.png" height="200">
<br>
  <h3 align="center"> Road Trip Advisor </h3>
<br>
  <p align="center">
    Mod 3 Final Project
    <br />
  </p>
</div>
<br>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#schema">Road Trip Advisor Schema</a></li>
    <li><a href="#endpoint">Endpoint Details</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowlegdements</a></li>
  </ol>
</details>


## About The Project

Road Trip Advisor is a road trip planning application, consisting of only the back end API consumption and distribution at the moment. It allows users to see the current weather, 5 day forecast, and 24 hourly weather for each of those 5 days, for a given destination. This project was part of the Module 3 cirriculum for the Turing School of Software and Design.

The learning goals for this project were;

* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).


### Inception - Diagramming and Brainstorming

* Whenever I get assigned a project, I like to start with some brain-storming and diagramming. It helps me get an eagle's eye view of the problems I'm trying to solve.

![brainstorm](https://user-images.githubusercontent.com/116703107/234486110-948632be-f898-4613-b249-3d878e4428c1.png)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Built With

[![Rails]][Rails-url][![PostgreSQL]][PostgreSQL-url][![Puma]][Puma-url][![bcrypt]][bcrypt-url][![Faraday]][Faraday-url][![Figaro]][Figaro-url][![JSON-Serializer]][JSON-Serializer-url][![Capybara]][Capybara-url][![Shoulda-Matchers]][Shoulda-Matchers-url][![RSpec]][RSpec-url][![VCR]][VCR-url][![Web-mock]][Web-mock-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Getting Started
<!-- can change this later or add more detail -->
### Prerequisites

* Ruby
  ```sh
  Ruby 3.1.1
  ```

* Rails
  ```sh
  Rails 7.0.4.3
  ```
* [PostgreSQL](https://www.postgresql.org/download/)

### Installation

_Follow the steps below to install and set up this app._

1. NEEDS TWO API Keys. Sign up for your free API Keys at [MapQuest’s Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/) and [Weather API](https://www.weatherapi.com/)
2. Clone this Repository
   ```sh
   git clone https://github.com/Bobsters986/psydiary_back_end
   ```
3. In your terminal, run the following commands;
    ```sh
    bundle install
    bundle exec figaro install
    rails db:{drop,create,migrate,seed}
    ```
4. Enter your API keys in `application.yml`
   ```ruby
   MAPQUEST_API_KEY: 'YOUR API KEY'
   WEATHER_API_KEY: 'YOUR API KEY'
   ```
5. Run `rails s` in your terminal and visit [http://localhost:3000](http://localhost:3000) to explore the end points for yourself!


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Schema

<div align="center">

  ![schema](https://user-images.githubusercontent.com/116703107/234483881-63cc5382-7223-4465-9c18-81503b36e44e.png)
</div>


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Testing -->
## Testing

* This project utilizes RSpec testing
* After cloning this repo and following the steps above to install all necessary gems and API keys:
  * Run the entire test suite using the command `bundle exec rspec`


<!-- JSON Contract -->
## Endpoint Details
* Below are example Requests and Responses for each endpoint

### Weather for Location Request/Response
![weather_request](https://user-images.githubusercontent.com/116703107/234476140-b0750f71-6b2a-4ee5-83f6-4200d90bc7d9.png)

* Response

![weather_response](https://user-images.githubusercontent.com/116703107/234476434-5c473fe1-f8a2-47ea-81cf-ae7365e252b2.png)

### User Registration Request/Response
![registration](https://user-images.githubusercontent.com/116703107/234477540-1e9ef340-f129-4061-a125-453ab20a5dcc.png)

### User Login Request/Response
![login](https://user-images.githubusercontent.com/116703107/234477634-099538e5-85c3-4b22-ab18-19ff96700b14.png)

### Road Trip Request/Response
![road_trip_request](https://user-images.githubusercontent.com/116703107/234477729-5cd68dc5-70cd-4d46-ab9c-4b5029145814.png)

* Response

![road_trip_response](https://user-images.githubusercontent.com/116703107/234477841-80693e8d-2c1d-4128-a602-7491d23d2160.png)


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

<div align="center">
  <img src="https://avatars.githubusercontent.com/Bobsters986" alt="Profile" height="150" width="150">
  <p>Bobby Luly</p>
  <a href="https://github.com/Bobsters986">GitHub</a><br>
  <a href="https://www.linkedin.com/in/bobbyy-luly-217653260/">LinkedIn</a>
</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Acknowledgements
* ["The Best README Template" by Github User othneil](https://github.com/othneildrew/Best-README-Template)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 

[Rails]: https://img.shields.io/badge/-Ruby%20on%20Rails-CC0000?logo=ruby-on-rails&logoColor=white&style=for-the-badge
[Rails-url]: https://rubyonrails.org 

[Circle-CI]: https://img.shields.io/circleci/build/github/wise-app-team/wise-app-be/main
[Circle-url]: https://app.circleci.com/

[PostgreSQL]: https://img.shields.io/badge/-PostgreSQL-4169E1?logo=postgresql&logoColor=white&style=for-the-badge
[PostgreSQL-url]: https://www.postgresql.org/

[Puma]: https://img.shields.io/badge/-Puma-FFD43B?logo=puma&logoColor=black&style=for-the-badge
[Puma-url]: https://github.com/puma/puma

[bcrypt]: https://img.shields.io/badge/-bcrypt-00599C?logo=gnu-privacy-guard&logoColor=white&style=for-the-badge
[bcrypt-url]: https://github.com/codahale/bcrypt-ruby

[Faraday]: https://img.shields.io/badge/-Faraday-3E3E3E?logo=ruby&logoColor=white&style=for-the-badge
[Faraday-url]: https://github.com/lostisland/faraday

[Figaro]: https://img.shields.io/badge/-Figaro-FF4136?logo=rubygems&logoColor=white&style=for-the-badge
[Figaro-url]: https://github.com/laserlemon/figaro

[JSON-Serializer]: https://img.shields.io/badge/-JSON%20API%20Serializer-1E90FF?logo=json&logoColor=white&style=for-the-badge
[JSON-Serializer-url]: https://github.com/jsonapi-serializer/jsonapi-serializer

[Capybara]: https://img.shields.io/badge/-Capybara-FF7F50?logo=rubygems&logoColor=white&style=for-the-badge
[Capybara-url]: https://github.com/teamcapybara/capybara

[RSpec]: https://img.shields.io/badge/-RSpec-FF7F50?logo=rubygems&logoColor=white&style=for-the-badge
[RSpec-url]: https://github.com/rspec/rspec

[Faker]: https://img.shields.io/badge/-Faker-FF69B4?logo=rubygems&logoColor=white&style=for-the-badge
[Faker-url]: https://github.com/faker-ruby/faker

[Shoulda-Matchers]: https://img.shields.io/badge/-Shoulda%20Matchers-5B5B5B?logo=rubygems&logoColor=white&style=for-the-badge
[Shoulda-Matchers-url]: https://github.com/thoughtbot/shoulda-matchers

[Web-mock]: https://img.shields.io/badge/-WebMock-8B0000?logo=rubygems&logoColor=white&style=for-the-badge
[Web-mock-url]: https://github.com/bblimke/webmock

[VCR]: https://img.shields.io/badge/-VCR-2F4F4F?logo=rubygems&logoColor=white&style=for-the-badge
[VCR-url]:  https://github.com/vcr/vcr
