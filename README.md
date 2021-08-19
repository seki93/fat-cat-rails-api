# README

So this is my first time sharing a project with someone, I hope that I included everything.

Some stuff I would do differently (definitely rename TimeTrack model).
Also, I added HMAC_SECRET which should not be present in Git/Project, that should be in ENV or Rails secret.

To start the server use the command: docker-compose up --build
I changed PORT to 3001 because React part use 3000.

***NOTE***
In order to use React you should comment before_action :authenticate_user in TimeTracksController line 5.
In the frontend app, I don't have the mechanism to get the user token that is required to access any time_tracks routes.


