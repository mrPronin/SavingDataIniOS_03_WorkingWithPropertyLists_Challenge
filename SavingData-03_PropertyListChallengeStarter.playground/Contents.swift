import UIKit

//: ## Saving Data in iOS: Challenge 3 - NSFileManager
//:
//: Property lists allow you to configure your app through the use of key value pairs. In this challenge, you'll read from a property list and instantiate objects based on the values in the property list.
//:
//: ----
//: 
//: First, there needs to be an object to store the data kept within the property list. The videogame class simply contains a list of properties that is stored in the property list.

class VideoGame {
  var name: String
  var genre: String
  var rating: Int
  var synopsis: String
  
  init() {
    name = ""
    genre = ""
    rating = 0
    synopsis = ""
  }
}

//: Now, you need to get a reference to the NSFileManager object. To do this, you call efaultManager() on the NSFileManager object.
// Code goes here
let fileManager = NSFileManager.defaultManager()
//: Next, get a reference to the NSURL of the reviews.plist. This is included in the NSBundle. You need to call URLForResrouce on NSBundle.mainBundle
// Code goes here
let plistURL = NSBundle.mainBundle().URLForResource("reviews", withExtension: "plist")
//: Once you have the main url, you now need to first convert it to an NSData by calling NSData(contentsOfURL:)
// Code goes here
let plistData = NSData(contentsOfURL: plistURL!)
//: With everything set, a video game array has been setup for you. Each time you create a video game object, you'll place it in this array.
var vGames = [VideoGame]()

//: Now comes the part where you take that data and convert it to a property list. First you need to determine the format of the property list. This property list is stored as XML. To specify this, you need to create a new variable and have it store: NSPropertyListFormat.XMLFormat_v1_0
// Code goes here
var format = NSPropertyListFormat.XMLFormat_v1_0

do {
//: This is the point where you serialize your property list. From the NSPropertyListSerialization object, call propertyListWithData passing in the data that you created, setting the options to .Immutable, and passing in the property list format variable as well. You will have to cast the result as an [AnyObject]
  // Code goes here
    let games = try NSPropertyListSerialization.propertyListWithData(plistData!, options: .Immutable, format: &format) as! [AnyObject]
//: Loop through the array and create a new VideoGame object per iteration. You can reference the property list values by opening up the property list in Xcode to get the correct field name.
   for game in games {
    let videoGame = VideoGame()
    if let name = game["Name"] {
        videoGame.name = name! as! String
    }
    if let genre = game["Genre"] {
        videoGame.genre = genre! as! String
    }
    if let rating = game["Rating"] {
        videoGame.rating = rating! as! Int
    }
    if let synopsis = game["Synopsis"] {
        videoGame.synopsis = synopsis! as! String
    }
    vGames.append(videoGame)
  }
  
  
} catch {
  print(error)
}


//: Finally, loop through all your created video games and print them out to the console.
for game in vGames {
  print("name: \(game.name) genre: \(game.genre) rating: \(game.rating)")
}




