
<p align='center'>
  <img src='assets/images/Calendar.Me.PNG' alt='Calendar.me Logo'>
</p>
<p align='center'>
  <a href='#About'>About</a>  • 
  <a href='#Features'>Features</a>  • 
  <a href='#Technologies'>Technologies</a>  •
  <a href='#To-Do'>To-Do</a>  • 
   <a href='#Resources'>Recources</a>  • 
</p>  

# About
This simple calendar and to-do list application built in Flutter. The intended purpose of this project was to learn Flutter fundamentals while building an application with a purpose. Although simple at the surface, the app incorporates several technologies and concepts within flutter that form a solid foundation for further learning.

# Features
<p align='center'>
<img src='assets/images/calendarme.gif' height='350px' width='auto'>
</p>

### Firebase Authentication
The App includes firebase authentication for user login and registeration.

### Cloud Firestore
Events that a user has added or removed from their calendar are saved in a Firestore database. Therefore logging in between devices ensures calender events are accessible.

### To-Do
The Daily To-Do list allows a user to add, complete and removes items that they need to complete. It is intended for a simple look at what a user needs to complete on a given day.

### Calendar and Daily Events
The calendar screen shows the user what events they have on a given day. The calendar itself shows the user the current date, is scrollable, and when a specific date is selected, the events on that day are loaded.

### Events Page
This page shows what events the user has in the up coming week. Additionally this is where events are added and removed from the calendar. 

# Technologies 
* Firebase - Authentication and Cloud Firestore
* Animation Text Kit - Used for text animations and transitions
* Flutter Calendar Carousel - Package used to create the Calendar Carousel
* Provider - Package used to share and make data sources easier to use and more reusable.

# To-Do
### Weatehr API
Add functionality to that makes a call to a weather API and shows the daily min/max temperatures and precipitation. 

### Sort Events
Add sorting algorithm for events on the calendar and events page.

### Redesign Event Widget
Redisgn the event widget so it looks nicer.

# Resources
* Background Design Inspired by Aurélien Salomon on dribbble - <a href='https://dribbble.com/shots/11222666-Android-Flutter-Reward-App-Login-Feed'> View on Dribbble</a>
* <a href='https://flutter.dev/'>Flutter</a> 
