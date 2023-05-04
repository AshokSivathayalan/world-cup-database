# world-cup-database

## Description
Create a database of information about World Cup games, then query the database for various statistics

Created for freeCodeCamp's Relational Databases course

## Database

Teams - Stores teams, with a serial ID as the primary key, and each team's name
Games - Stores games, with a serial ID as the primary key, foreign keys referencing teams for the winner and loser, integers for each team's goals, the year, and the round.

To create database, run 'psql -U postgres < worldcup.sql'

## Inserting Data

Uses a Bash script to insert data

Wipes all the entries in the tables first, then reads from games.csv to get the teams and games info.

To insert data, run './insert_data.sh'

## Queries

Bash script that uses SQL to query for statistics about the world cup.

To view statistics, run './queries.sh'
