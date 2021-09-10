# README

Assuming you have docker engine installed

- Move to payloader root directory
- run '$ docker-compose build' 
- run '$ docker-compose up'
- run '$ docker-compose run server rake db:create'
- run '$ docker-compose run server rake db:migrate'

At this point the server should be running and ready for testing.

The reservations endpoint should be on 'localhost:3000/reservations'. 