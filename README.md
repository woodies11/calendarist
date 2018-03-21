# calendarist
An app that fetch all tasks from Todoist and display a heat map calendar based on number of tasks due on each date.

The app was created as part of a practice to learn the VIPER architecture.

## Todoist
The app rely on [Todoist](https://todoist.com) for its data. Thus, you will need to [create](https://todoist.com/Users/showRegister) a free account in order to use the it.

### Note about API privacy
Since Todoist API currently do not allow non https:// url to be used as OAuth2 redirect URI, I have to redirect the flow to a file on my github page. This file simply forward everything back to the app. It is in no way tracking, collecting, or storing any sort of data anywhere at all.
