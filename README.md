# Remote Control Computer Craft Turtle Using Websocket
This is a program that will allow you to remote control a turtle using a websocket in computer craft.

How to use:
Prerequisites: 
You must have node.js installed and minecraft java edition with the computer craft tweaked mod.

- First, copy the wsServer file to the computer you want the websocket server to run on.
- Next, place the json.lua and rewrite.lua into the file directory of a turtle.
  - Computercraft files are saved in .minecraft/saves/[world name]/computercraft/computer/[id of the computer]
- Now open a terminal window in the wsServer folder and run node ./listenForWeb.js
- Now we need to set the ip for both the turtle and the controller to connect to. If you are running the server on the same computer as minecraft and the controller, you do not need to change the ip. If you are however going to run the server on a different computer to either the minecraft or the controller, you must change the IP in each one to the ip of the computer that the server is running on.
- Also, if you run it on localhost, you must go in to the cc config at .minecraft/[world name]/serverconfig/computercraft-server.toml and edit line 53 to say "allow". This will stop computer craft from blocking local connections.
- Now place a turtle in minecraft and on the turtle execute rewrite.lua
- Now load up controller.html
- It should now be connected and you will be able to control the turtle with the controller.

Usage:
- These buttons require information in the context box to run
  - Label - the string you would like it to be named
  - select - the slot you want to select
  - inspect peripheral inventory - the direction of the chest peripheral

Limitations:
- You can only control one turtle at once.

Future Plans:
- Allow simultanious connections to multiple turtles
