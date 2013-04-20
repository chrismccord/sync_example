# [Sync](http://github.com/chrismccord/sync) Example Rails Application

This repo includes a basic Rails todo application with projects, todos, users, and comments for use in 
demonstrating the integration of [Sync](http://github.com/chrismccord/sync), a gem for making your Rails applications 
 realtime.
 
## Installation

    $ git clone https://github.com/chrismccord/sync_example
    $ cd sync_example
    $ bundle
    $ rails g sync:install
    $ rake db:create
    $ rake db:migrate
    $ rake db:seed
    
## Configuration

  - Edit `config/sync.yml` to include your Faye or [Pusher](http://pusher.com) credentials
  - If using Faye, run the Faye server: `rackup sync.ru -E production`


## Default seed user
You can log in and explore the app by visiting the root url and logging in with `user@example.com` and `password`
