CET341 Final Project Report


Firstly, I began my project with the design of the SignIn and SignUp pages. I have designed these pages with TextFormField widgets and RaisedButtons. In the “SignIn” page, there are two options that users can login the app. One of them is login with the account which is created in the “SignUp” page and the other one is directly with Google account. To implement these, I used firebase authentication. I imported the “firebase_auth” package (Multidex issue, google json).  Also, I used Cloud Firestore to save the information of the users in database. 


![login](https://user-images.githubusercontent.com/73463728/108489731-f5e36e00-72b2-11eb-9029-05d344ce0c97.PNG)
![1](https://user-images.githubusercontent.com/73463728/108489920-304d0b00-72b3-11eb-875f-9d4bd1d4df88.PNG)
![addUserInfoToDb](https://user-images.githubusercontent.com/73463728/108490071-5d012280-72b3-11eb-93b2-8e4fb3859473.PNG)


Similarly, for google sign in I used “google-signin” package and store the information of the google account on my firestore database with the support of the “addUserInfoToDB” method.

![googlesignin](https://user-images.githubusercontent.com/73463728/108490475-d567e380-72b3-11eb-888c-11fa36242d82.PNG)

For the "signUp" page, I also wanted to add the user information with the support of the "addUserInfoToDB" again. The UI design of this page is similar to the "SignIn" page.

![signup](https://user-images.githubusercontent.com/73463728/108491137-95553080-72b4-11eb-99f9-baf384a137ba.PNG)
![signUpp](https://user-images.githubusercontent.com/73463728/108491313-cc2b4680-72b4-11eb-84dd-f9f2d19e44c8.PNG)

The users in the app are stored in Cloud Firestore and you can see an example in below.

![users](https://user-images.githubusercontent.com/73463728/108491589-288e6600-72b5-11eb-887b-b51c392f2bd2.PNG)

After the user login the app, I navigate them to the "TabsPage". In this page, there are 4 tabs (only chats is working, dont have the time to complete the others). The usage of the Chats tab is that the user searchs another user, clicks the user and go to conversations page.

![tabs](https://user-images.githubusercontent.com/73463728/108492105-cda93e80-72b5-11eb-8f73-99f34c0ce0f2.PNG)
![deneme deneme](https://user-images.githubusercontent.com/73463728/108492255-fb8e8300-72b5-11eb-839b-35a245601220.PNG)


