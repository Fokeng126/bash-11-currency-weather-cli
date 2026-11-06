# Currency and Weather CLI

# Problem Statement
- People may need a quick way to check currency exchange rates and weather information from the terminal to make it more easier

## Project Goal
- The goal of this project is to craete a simple bash scripts that can convert currencies and show the current weather for a city.

## Tech Stack
- Bash
- curl
- jq
- awk
- Public APIs

## Screenshot
![Currency Converter](image/currency.png)

![Weather CLI](image/weather.png)

## Features
- Convert one currency to another.

- Accept uppercase and lowercase currency codes.

- Validate user input and show clear errors.

-  Show current temperature, weather description, and humidity.

- Support city names with spaces.

- Use METEO_CITY or Yaounde as the default location.

## Installation and Setup
- Clone the repository and open the project folder.

 - chmod +x fx.sh meteo.sh : Makes the script executable.
 
 - ./fx.sh 100 USD XAF : Run currency converter.

 - ./meteo.sh Bamenda : Run weather script.

 ## Challenges Faced 
 - Some challenges were base on user input, working with APIs, reading JSON data using jq, and to make sure the script handle errors correctly.

 ## What I Learnt 
  I learnt how to :

 -   Write Bash scripts.

 - Use curl to get data from APIs.

 - Use jq to read JSON data.

 - Validate user input.

 - Use functions and shared files in Bash.

 - Work with Git and GitHub.

 ## Author
 **Joshua Kroos**



