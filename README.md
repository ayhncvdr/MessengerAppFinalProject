CET341 Final Project Report


Firstly, I began my project with the design of the SignIn and SignUp pages. I have designed these pages with TextFormField widgets and RaisedButtons. In the “SignIn” page, there are two options that users can login the app. One of them is login with the account which is created in the “SignUp” page and the other one is directly with Google account. To implement these, I used firebase authentication. I imported the “firebase_auth” package (Multidex issue, google json).  Also, I used Cloud Firestore to save the information of the users in database. 


![login](https://user-images.githubusercontent.com/73463728/108489731-f5e36e00-72b2-11eb-9029-05d344ce0c97.PNG)
![1](https://user-images.githubusercontent.com/73463728/108489920-304d0b00-72b3-11eb-875f-9d4bd1d4df88.PNG)
![addUserInfoToDb](https://user-images.githubusercontent.com/73463728/108490071-5d012280-72b3-11eb-93b2-8e4fb3859473.PNG)


Similarly, for google sign in I used “google-signin” package and store the information of the google account on my firestore database with the support of the “addUserInfoToDB” method.
