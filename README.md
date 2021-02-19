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

To get the user in this page, I created another method called "GetUserNameFromDB". I used where clause in this method to get the username. Then with the support of FutureBuilder(it has DocumentSnapshot to acces the data), I showed the users in a list by using ListTile.

![onsearchbutton](https://user-images.githubusercontent.com/73463728/108493169-1281a500-72b7-11eb-8722-ac7079a7c8d3.PNG)
![getUserName](https://user-images.githubusercontent.com/73463728/108493238-24634800-72b7-11eb-96b9-ce111a68a700.PNG)
![FutureBuilder](https://user-images.githubusercontent.com/73463728/108493296-3513be00-72b7-11eb-9018-720fe0f1c42f.PNG)

To chat with other users I need to create chatrooms. The chatrooms must include the chats, users and last message information. For the users, there should be at least two users. One of them is the current user and another one the user who I want to chat. For the current user, I need to store the current user data in local database. To implement this, I use shared preference. Shared preference uses keys and values for setString method. I need to implement this method when the user logins the app. For the chatrooms I wanted to use the usernames of the users. Inside these documents, the users, chats and last messsage info should be displayed. When the user clicks the user in the "ChatsPage", a new chatroom should be created. The name of the chatroom should be in format of "currentuser_user". Thus, when the other user chats, it should connect the same room.

![getChatRoomId](https://user-images.githubusercontent.com/73463728/108500042-40b7b280-72c0-11eb-9db5-1611f361dcd7.PNG)
![GenerateChatRoom](https://user-images.githubusercontent.com/73463728/108500096-56c57300-72c0-11eb-9065-52c4fe5bf14b.PNG)
![onTapGenerate](https://user-images.githubusercontent.com/73463728/108500293-9b510e80-72c0-11eb-9bd4-bb034e9aa300.PNG)

To add message in a chatroom and update the last message I created an addMessage method in the "Conversations" page and a database method. Inside the "addMessage" method, I created a map which keeps the message, send by who and time values for the message. Also, for all the chats, I generate a random message id. Moreover, whenever I add a message in to the chatroom, I also need to update the last message. For this, I created again a map which keeps the last message, last message send by who and last message time.

![addmessage](https://user-images.githubusercontent.com/73463728/108501338-35fe1d00-72c2-11eb-9e8b-d145b9344770.PNG)
![addupdateDB](https://user-images.githubusercontent.com/73463728/108501399-47dfc000-72c2-11eb-81d4-e60f5ba8e4e7.PNG)

These methods are implemented whenever the user adds a message in the "Conversations" page. The firestore view is seen on the below.



