# README

Assuming you have docker engine installed:
- Move to payloader root directory
- run '$ docker-compose build' 
- run '$ docker-compose up'
- run '$ docker-compose run server rake db:create'
- run '$ docker-compose run server rake db:migrate'



If you don't have docker installed:
- Make sure you have all the dependencies needed first. Installation may vary depending on your OS.
  - ruby 2.7.0
  - ruby-dev
  - nodejs
  - postgresql-client

- Move to payloader root directory
- run '$ bundle install'
- run '$ rake db:create'
- run '$ rake db:migrate'
- run '$ rails server'


At this point the server should be running and ready to accept post requests.

The reservations POST endpoint should be on 'localhost:3000/process_reservations'.
The params should look like:
{
  payload: {
    // raw_payload_here
  }
}



Additional notes for when you didn't have docker installed:
- You might want to remove the databases created by
    running '$ rake db:drop' while your on the payloader
    root directory.
- Also you may uninstall the dependencies installed so that 
    it won't interfere with other projects.



References: 
- https://docs.docker.com/compose/
- https://dry-rb.org/gems/dry-monads/1.3/
- https://dry-rb.org/gems/dry-schema/1.5/
- https://dry-rb.org/gems/dry-matcher/0.8/