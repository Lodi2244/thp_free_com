# THP FREE COM

## Introduction

> This kickass spammer app was designed by Team Ponctuals aka : 
- Eric LING @Eric Ling
- Colin LECORDIER @Colin Lecordier
- Mélisande FLEISCH @Mélisande
- Marc ARNAL @Marc_A
- Steve BALEBA @Bsteve
- Elodie LETELLIER @tite_Lodi

The only purpose of this app is to piss off every town hall of France with lovely spams from The Hacking Project <3 

You're wondering how ? Just run the following commands in your terminal : 

- ```$ bundle install```
- ```$ ruby app.rb```

____________________________________________________________________________________

This app is split into 4 different features : 

1. The MailScrapper => Parse through town hall informations (county, city name, city email) in an online library and store the data into a .csv file.
- The Mailer => Initiate automated mailing based on the .csv database
- The TwitterScrapper => Parse through Twitter User database based on the city names stored in the .csv file then returns the handles for each city Twitter account and adds a column to the .csv file with the parsed data.
- TheTweeterBot => Initiate automated following based on the handles previously added on the .csv database.
 

## APP STRUCTURE

> What you 'll find in our app : 

 -  Gemfile : 
 we used nokogiri  to parse HTML, twitter, gmail and google_drive to build the bots and csv for the database.

-  app : 
    -   lib : holds Twitter and Mailer folders containing both a scrapping program and a bot. 
    
    - views : holds Index.rb which display all ruby programs from /lib and Done.rb which render a "Checks Ok" message when the app is launched.

- db : holds db.csv our database.

- app.rb : launch the app.

    
     => You'll note that we chose not to initialize both of the scrapper programs for time saving purposes considering the average loading window of 40 minutes each !


                                                                   

## PURPOSE

> Final result :

Once implemented this app enabled us to scrap 290 email addresses to which were sent automatically an email promoting The Hacking Project bootcamp program via peer-learning, while following automatically as many Twitter accounts. 

In conclusion, this app can definitely be used for marketing purposes.







