# About PetMe!

![alt text](https://github.com/RochaLS/PetMeWeb/blob/master/images/petme-brand.JPG "PetMe! brand/logo")
Logo made by: Gabriel Figliolino


PetMe! is your new pet companion app, add and keep track of useful information about your pet's well-being and the best part is that all this information can be shared with your family, friends, or the person who you live with.

# Why I created this app

I love having pets. I myself have two amazing dogs and two very cute cats and I used to live with my family. So I thought it was a little bit hard to organize all my pet's information in one place. And I thought it would be very nice to be able to share and control all this information together with my family. Then I decided to build this app to facilitate the sharing of important pet-related information between members of the same household.

# Screenshots

![alt text](https://github.com/RochaLS/PetMeWeb/blob/master/images/screenshots.png "UI screenshots")

# Language and Libraries
* Swift 5
* UIKit
* User Notifications
* Firebase (Firestore, Storage, Cloud Functions, FCM and Authentication)
* WebKit
* SwipeCellKit
* DZNEmptyDataSet
* NotificationBannerSwift
* SwiftSpinner
* PMAlertController
* RLBAlertsPickers

# Architecture

![alt text](https://github.com/RochaLS/PetMeWeb/blob/master/images/petme-architecture.png "Architecture ilustration")



## Front End

For this app, I decided to follow the MVC design pattern recommended by Apple, and it was the one I was already comfortable with. It's a very simple pattern and it helped me to organize my app's files and assets.

## Database and Storage

This app uses Firestore and Firebase Storage to store all it's related data and images. I found that Firebase was very easy and simple to work with, retrieving and sending data is very straight forward.

## Back End

To send users notifications that new pet-related data was added to the app, I used Firebase Cloud Functions to listen to the Firestore data, and then if something is triggered I'm using Firebase Cloud Messaging to send the user a real-time notification. I'm using Cloud Functions to trigger changes in the database when needed.

# Features

- User authentication

- Add multiple pets to your list

- Keep track of all the vaccination information of your pets, that includes: type of vaccine and date taken

- Add your pet's favorite foods, treats, and toys in the supplies section

- Add and keep track of your pet's mood and behavior in the moods history section

- Invite family members or friends who you live with to your group so you can share all the same pet information

- Receive a push notification when invited

- Add reminders to your group and receive a push notification when a new reminder is added

# Upcoming Features

* Add a calendar to better track vaccination information.
* Receive a notification when it's time for the pet to take a new vaccine
* Allow user to select a time and date to be reminded in the reminders section
* Add a pet photo album
* Add graphs and statics in the mood section
* Give user directions to the nearest pet shop

# Contact Me

If you have any questions please contact me at: ld.rocha@hotmail.com
