#! /bin/bash

#Allowing for tests of the script without modifying main databse
if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

#Removing existing entries in the databases
echo $($PSQL "TRUNCATE games,teams")

#Looping through every entry in the games.csv file
cat games.csv | while IFS="," read YEAR ROUND WINNER OPP WGOALS OGOALS
do
  #Ignoring the header at the top of the file
  if [[ $YEAR != "year" ]]
  then
    #Getting the winner ID
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    #Adding the winner to the teams table if they were not found
    if [[ -z $WINNER_ID ]]
    then
      INSERT_WINNER=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    fi
    #Getting the opponent ID
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP';")
    #Adding the opponent to the teams table if they were not found
    if [[ -z $OPP_ID ]]
    then
      INSERT_OPP=$($PSQL "INSERT INTO teams(name) VALUES('$OPP');")
      OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP';")
    fi

    #Inserting the game into the games table
    INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPP_ID, $WGOALS, $OGOALS);")
  fi
done