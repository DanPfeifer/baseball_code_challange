# Baseball Code Challange 

#Requirements:
	Ruby version >= 2.2.2 
	Rails 5.0
	ImageMagick
	ffmepg

#setup 
	These are install directions for use with a Mac, Linix users should be able to figure out the approprate install process. Windows users... Sorry

	Install homebrew if not already installed
		ruby -e “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”
	Install rbenv 
		brew install rbenv
	Install Imagemagick
		brew install imagemagick
	Install ffmpeg
		brew install ffmpeg
	Install bundler
		gem install bundler
	Clone this repository 
		git clone https://github.com/DanPfeifer/baseball_code_challange.git
	Use bundler to run the install 
		bundle install
	Run the migrations
		bundle exec rails db:migrate:status << check to see if you need to run them
		bundle exec rails db:migrate
	Make sure paperclip can talk with imagemagick
		this can be set in config/enviornments/development.rb 
		by default its set to Paperclip.options[:command_path] = "/usr/local/bin/"
	Start	
		bundle exec rails s

#uses
	The following rails app was built as a JOSN API on Rails 5.0 racecar 1.  You can use the following curl commands to interact with the api:


#teams
team are organized by number of games won
	curl -X GET localhost:3000/teams.json
	curl -X POST -d team[name]=<new_name> localhost:3000/teams.json
	curl -X GET localhost:3000/teams/<id>.json
	curl -X PUT -d team[name]=Angles localhost:3000/teams/<id>.json
	curl -X DELETE localhost:3000/teams/<id>.json

#players
players are organized by number of runs scored 
	curl -X GET localhost:3000/players.json
	curl -X POST --data "player[name]=<new_name>&player[team_id]=<team_id>" localhost:3000/players.json
	curl -X GET localhost:3000/players/<id>.json
	curl -X PUT --data "player[name]=<new_name>&player[team_id]=<team_id>" localhost:3000/players/<id>.json
	curl -X DELETE localhost:3000/players/<id>.json

player card features images and videos for the player 
	curl -X GET localhost:3000/players/<id>/player_card.json
videos is all videos for the player
	curl -X GET localhost:3000/players/<id>/videos.json
iamges is all images for the player
	curl -X GET localhost:3000/players/<id>/images.json
highlights is the highligh video for the player, actual video url is returned in the json data
	curl -X GET localhost:3000/players/<id>/highlights.json

#games
list of games, winning team is not set if the teams are tied or no team has scored a run
	curl -X GET localhost:3000/games.json
	curl -X POST --data "game[away_team_id]=<team_id>&game[home_team_id]=<team_id>" localhost:3000/games.json
	curl -X GET localhost:3000/games/<id>.json
	curl -X PUT --data "game[away_team_id]=<team_id>&game[home_team_id]=<team_id>" localhost:3000/games/<id>.json
	curl -X DELETE localhost:3000/games/<id>.json

#runs
list of runs 
	curl -X GET localhost:3000/runs.json
runs requires that the player be in the game being played in order to post successfully
	curl -X POST --data "run[player_id]=<player_id>&run[game_id]=<game_id>" localhost:3000/runs.json
	curl -X GET localhost:3000/runs/<id>.json
	curl -X PUT -data "run[player_id]=<player_id>&run[game_id]=<game_id>" localhost:3000/runs/<id>.json
	curl -X DELETE localhost:3000/runs/<id>.json

#images
list of all images
	curl -X GET localhost:3000/images.json
	curl -X POST -F image[image]=@<path_to_image> -F image[player_id]=<player_id> localhost:3000/images.json
	curl -X GET localhost:3000/images/<id>.json
	curl -X PUT -F image[image]=@<path_to_image> -F image[player_id]=<player_id>localhost:3000/images/<id>.json
	curl -X DELETE localhost:3000/images/<id>.json


#videos
list of all videos
	curl -X GET localhost:3000/videos.json
	curl -X POST -F video[video]=@<path_to_video> -F video[player_id]=<player_id> localhost:3000/videos.json
	curl -X GET localhost:3000/videos/<id>.json
	curl -X PUT -F video[video]=@<path_to_video> -F video[player_id]=<player_id> localhost:3000/videos/<id>.json
	curl -X DELETE localhost:3000/videos/<id>.json

