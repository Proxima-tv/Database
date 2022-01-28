# Database
The Safe for everything

Relationmodel
User(ID,Username,Password,Name,Nachname,Email,ProfileLikes,ProfilePic,ProfileID)
Permissions(UserID,VIP,PermissionNodes)
Tickets(TicketID,Status,Author,Header,Body,AssignedTo)
Profile(ProfileID,User,Watchtime,Points,WatchID,Video)
Comments(ComID,Author,Comment,Video,ProfileID,VidID)
Videos(VidID,file,title,likes,dislikes,premium)
has permissions(UserID,ID)

Tables, Attributes and they're Type's  

Table : user  
--------------
id 				      : int Auto Increment Not Null  
username 		    : varchar(20) Not Null  
password 		    : varchar(100) Not Null  
name 			      : varchar(30) Null  
nachname 		    : varchar(50) Null  
email 			    : varchar(254) Not Null  
profile_likes 	: int Null  
profile_pic 	  : blob Null  
profile_id 		  : int Not Null  


Table : has_permission  
--------------
id 				  : int Auto Increment Not Null  
user_id			: int Not Null


Table : permissions  
--------------
id               : int Auto Increment Not Null  
user_id			     : int NOT NULL
permission_nodes : varchar(100) Null  
vip				       : boolean Not Null  


Table : tickets  
--------------
ticket_id 	: int Auto Increment Not Null  
status 			: varchar(50) Not Null  
author 			: varchar(20) Not Null  
header			: varchar(50) Not Null  
body 			  : text Not Null  
assigned_to	: varchar(50) Null  


Table : profile  
--------------
profile_id	: int Auto Increment Not Null  
user 			  : varchar(20) Not Null  
watchtime		: float Not Null  
points			: int Null  
watch_id		: int Not Null  
video			  : varchar(255) Not Null  


Table : comments  
--------------
com_id 			: int Auto Increment Not Null  
author 			: varchar(20) Not Null  
comment			: varchar(300) Not Null  
video 			: varchar(255) Not Null  
commented_on: timestamp(current_timestamp) Not Nutll  
profile_id	: int Not Null  
vid_id			: int Not Null  


Table : videos  
--------------
vid_id			: int Auto Increment Not Null  
file 			  : blob Not Null  
title			  : varchar(100) Not Null  
likes 			: int Null  
dislikes 		: int Null  
clicks      : int Null
premium			: boolean Null  
uploaded_on : timestamp(Current_Time)

Table : interactions
--------------
id       : int NOT NULL AUTO_INCREMENT
user_id  : int NOT NULL
vid_id   : int NOT NULL

Table : watchhistory
--------------
id      : int NOT NULL AUTO_INCREMENT,
user_id : int NOT NULL,
vid_id  : int NOT NULL,
