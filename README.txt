Requirements to run:
Rails version 4+
Ruby version 2+
MySQL

Instructions:
open the terminal and cd into this directory
run the following commands in this order:
* bundle install
* rake db:create
* rake db:migrate
If you want to populate the database with dummy data (will not generate stats, competed_ats or debated_ats):
* rake db:seed
To start the local server:
* rails server
The open localhost:3000 in your web browser

The database schema in SQL is in Dump20151210.sql
The schema analysis is in 1.docx
