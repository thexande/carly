#Blinker iOS Candidate Interview Project 
1.	Using the JSON file (vehicles.json) included in the project, create a UITableView that shows each vehicle’s `year`, `make`, and `model` (1999 Honda Accord) in each cell, along with its mileage.
 * The year, make, and model should go in the upper left corner of the cell with 10 point margins on the left and the top.
 * The vehicle’s mileage should go in the bottom right corner of the cell with 10 point margins on the right and the bottom.
 * The vehicles.json file has many duplicate vehicles for the sake of getting a large, populated list. Don't worry about filtering out duplicates.
2. When a cell is tapped, load the image from the URL (`image_url`) included in the JSON file and display it on the top portion of the screen, above the table view.
 * Image should be landscape orientation with 4:3 aspect ratio.
3. Include a search field at the top of the screen to filter vehicles in the table view.
 * Should be able to search any combination of year, make, or model. e.g. "1999", "honda accord", "1999 accord", "honda 1999", etc.
4. Wherever possible when laying out views, use Auto Layout.
5. Write all code in Swift.
6. If you get stuck anywhere along the way, feel free to ask for help.
7. You may use whatever resources you’d like to complete the project. Import libraries, search Stack Overflow, ask for help, whatever. The only rule is that whatever implementation you come up with must be your own.

#Bonus (Not required and will not be counted against you should you choose not to complete this)
1. Create a Today Widget with the application that serves the 5 most recently created vehicles.
 * You may display the information in any way you'd like.
