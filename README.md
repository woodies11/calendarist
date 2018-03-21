# Calendarist
An app that fetch all tasks from Todoist and display a heat map calendar based on number of tasks due on each date.

The app was created as part of a practice to learn the VIPER architecture.

## Todoist
The app rely on [Todoist](https://todoist.com) for its data. Thus, you will need to [create](https://todoist.com/Users/showRegister) a free account in order to use the it.

### Note about API privacy
Since Todoist API currently do not allow non https:// url to be used as OAuth2 redirect URI, I have to redirect the flow to a file on my github page. This file simply forward everything back to the app. It is in no way tracking, collecting, or storing any sort of data anywhere at all.


Also, the test API key in older commit has already been reset and will no longer work.

----

## Future Plans

I am currently in the middle of doing senior project so I might update this app later on.

As of now, the app work with basic use cases.

- **Better Error Handling**
However, error reporting/handling is very limited. Right now, every error generated from Todoist API is assumed to be network connection error. For example, if the user decided to revoke API access when logged in, the app will simply tell the user to check their Internet Connection and will required the user to manually log out and log back in again to re-request access.

- **Better VIPER Base Protocols**
I will look into using techniques like `associatedtype` to make the base protocols in my custom VIPER framework work better. 
	- For example, the protocols could enforce the implementation of `RWPView` to contain a reference to the presentator which have to have a type of `RWPViewOutput` *(or any of its subclass/implementaion)*. 
	- `RWPPresentator` may also enforce the reference to `view` to be weak to avoid circular dependencies problem.
	- many more!
	- I also want to look into a way to apply Abstract classes concept in Swift. I know we can use `protocol` + `extension` to achieve similar things. But I still haven't figure out how to have an abstract subclass—say, for the `UIViewController` so we can implement life cycles functions such as `viewDidLoad()` to be passed to the `presentator` by default. This would reduce a lot of repeated code!

- Better test coverage.