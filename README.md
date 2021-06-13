# Remote Control Computer Craft Turtle Using Websocket
This is a program that will allow you to remote control a turtle using a websocket in computer craft.

How to use:
Prerequisites: 
You must have node.js installed and minecraft java edition with the computer craft tweaked mod.

- First, copy the wsServer file to the computer you want the websocket server to run on.
- Next, place the json.lua and rewrite.lua into the file directory of a turtle.
  - Computercraft files are saved in .minecraft/saves/[world name]/computercraft/computer/[id of the computer]
- Now open a terminal window in the wsServer folder and run node ./listenForWeb.js
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
