# Decusis website

To run the website locally, you need ruby v2.3 or more installed so that you can run `bundle install` to setup the environment.
Once the environment is setup, you can just run `bundle exec nanoc live`. It will do the following:
1. compile the static website
2. launch a webserver on http://localhost:3000
3. setup a watchguard on the files to re-compile automatically after every code change.

The code organization is pretty straightforward:
1. In `layouts`, you have the templates and the partials (default is the main template)
2. In `content`, you have the pages and the assets (scripts, css, images)

Hack away :)
