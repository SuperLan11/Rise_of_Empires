## Project Background
Rise of Empires is a terminal-based game created in the Introduction to Unix course.
The goal of the project was to teach the player basic terminal commands in a gamified way. 
The games gives examples of important commands to guide the player through the beginning of the game.
The game also includes an instruction guide, which explains every command in the game.
This guide can be accessed at any time during the game.
I took inspiration from Age of Empires with the ability to create resource buildings and train troops. 

## How to Play the Game
After downloading the tgz file, open command prompt and type the folllowing line.
pscp c:\users\yourUser\Downloads\Rise-of-Empires-LarkGroup18.tgz userName@serverName:homeDirectory/Rise-of-Empires-LarkGroup18.tgz

This will copy the project file from your downloads into your server's home directory. 
Note that the following things need to be provided for the copy to be successful:
yourUser is the name of the user folder on your computer.
userName is your login name for the server you wish to login to.
serverName is the name of the server you wish to copy the file to.
homeDirectory is the main directory for your server. You can find it by typing "cd ~" then "pwd" while in the server. Include the first forward slash.

Once successful, login to the server.
Then use "tar -xzvf Rise-of-Empires-LarkGroup18.tgz".
This will unpack the project into a directory in your server.
Use "cd Rise-of-Empires-LarkGroup18" to change to this new directory.
Then use "cat readme.txt" and follow the instructions.

If you have issues tarring the tgz file, you can copy the folder provided instead. You can also view the code made to create the game in this folder. 
Note that some files are hidden.
