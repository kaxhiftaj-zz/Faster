
#import "Constant.h"

#pragma mark-
#pragma mark- Methods

NSString *const FILE_COUNTRY_LIST=@"provider/country.php";
NSString *const FILE_REGISTER=@"provider/register";//register
NSString *const FILE_LOGIN=@"provider/login";//login
NSString *const FILE_REQUEST=@"provider/getrequests";//getrequests
NSString *const FILE_RESPOND_REQUEST=@"provider/respondrequest";//respondrequest
NSString *const FILE_GET_REQUEST=@"provider/getrequest";//getrequest
NSString *const FILE_WLKER_STARTED=@"provider/requestwalkerstarted";//requestwalkerstarted
NSString *const FILE_WLKER_ARRIVED=@"provider/requestwalkerarrived";//requestwalkerarrived
NSString *const FILE_WALK_STARTED=@"provider/requestwalkstarted";//requestwalkstarted
NSString *const FILE_ADD_LOCATION=@"provider/addlocation";//addlocation
NSString *const FILE_WALK_COMPLETED=@"provider/requestwalkcompleted";//requestwalkcompleted
NSString *const FILE_RATING=@"provider/rating";//rating
NSString *const FILE_PROGRESS=@"provider/requestinprogress";//requestinprogress
NSString *const FILE_USERLOCATION=@"provider/location";//location
NSString *const FILE_PAGES=@"application/pages";//application/pages
NSString *const FILE_UPDATE_PROFILE=@"provider/update";//provider/update
NSString *const FILE_WALKER_TYPE=@"application/types";//application/types
NSString *const FILE_HISTORY=@"provider/history";//user/history
NSString *const FILE_FORGOT_PASSWORD=@"application/forgot-password";//application/forgot-password
NSString *const FILE_CHECKSTATUS=@"provider/checkstate"; //provider/checkstate
NSString *const FILE_TOGGLE=@"provider/togglestate";//provider/togglestate
NSString *const FILE_WALK_LOCATION=@"request/location";//request/location
NSString *const FILE_REQUEST_PATH=@"provider/requestpath";//request/path
NSString *const FILE_LOGOUT=@"provider/logout";//provider/logout


#pragma mark-
#pragma mark- General Parameter

NSString *const PREF_IS_LOGIN=@"is_login";
NSString *const PREF_LOGIN_BY=@"type";
NSString *const PREF_EMAIL=@"email";
NSString *const PREF_PASSWORD=@"password";
NSString *const PREF_SOCIAL_ID=@"social_id";
NSString *const PREF_USER_TOKEN=@"token";
NSString *const PREF_USER_ID=@"id";
NSString *const PREF_REQUEST_ID=@"request_id";
NSString *const PREF_DEVICE_TOKEN=@"device_token";
NSString *const PREF_USER_NAME=@"name";
NSString *const PREF_USER_PHONE=@"phone";
NSString *const PREF_USER_RATING=@"rate";
NSString *const PREF_USER_PICTURE=@"picture";
NSString *const PREF_WALK_TIME=@"time";
NSString *const PREF_WALK_DISTANCE=@"distance";
NSString *const PREF_START_TIME=@"startTime";
NSString *const PREF_FIRST_NAME=@"first_name";
NSString *const PREF_LAST_NAME=@"last_name";
NSString *const PREF_IS_APPROVED=@"is_approved";

NSString *const PREF_NAV=@"PREF_NAV";



NSString *strowner_lati;
NSString *strowner_longi;
NSString *struser_lati;
NSString *struser_longi;
NSString *device_token;
NSArray *arrUser;
NSArray *arrPage;

NSDictionary *dictBillInfo;
int is_completed;
int is_dog_rated;
int is_walker_started;
int is_walker_arrived;
int is_started;
int payment;

#pragma mark-
#pragma mark- Register Parameter

 NSString *const PARAM_EMAIL=@"email";//email
 NSString *const PARAM_PASSWORD=@"password";//password
 NSString *const PARAM_OLDPASSWORD=@"old_password";//old_password
 NSString *const PARAM_NEWPASSWORD=@"new_password";//new_password
 NSString *const PARAM_FIRST_NAME=@"first_name";//first_name
 NSString *const PARAM_LAST_NAME=@"last_name";//last_name
 NSString *const PARAM_PHONE=@"phone";//phone
 NSString *const PARAM_DEVICE_TOKEN=@"device_token";//device_token
 NSString *const PARAM_DEVICE_TYPE=@"device_type";//device_type
 NSString *const PARAM_BIO=@"bio";//bio
 NSString *const PARAM_ADDRESS=@"address";//address
 NSString *const PARAM_STATE=@"state";//state
 NSString *const PARAM_COUNTRY=@"country";//country
 NSString *const PARAM_ZIPCODE=@"zipcode";//zipcode
 NSString *const PARAM_LOGIN_BY=@"login_by";//login_by
 NSString *const PARAM_SOCIAL_ID=@"social_unique_id";//social_unique_id
 NSString *const PARAM_PICTURE=@"picture";//picture
 NSString *const PARAM_WALKER_TYPE=@"type";//type
 NSString *const PARAM_TAXI_MODEL=@"car_model";//car_model
 NSString *const PARAM_TAXI_NUMBER=@"car_number";//car_number


#pragma mark-
#pragma mark- Check Request

NSString *PARAM_ID=@"id";//id
NSString *PARAM_TOKEN=@"token";//token

#pragma mark-
#pragma mark- Respond Request

NSString *PARAM_REQUEST_ID=@"request_id";//request_id
NSString *PARAM_ACCEPTED=@"accepted";//accepted

#pragma mark-
#pragma mark- Walker Started Request

NSString *PARAM_LATITUDE=@"latitude";//latitude
NSString *PARAM_LONGITUDE=@"longitude";//longitude

#pragma mark-
#pragma mark- Walk COMPLETED Request

NSString *PARAM_DISTANCE=@"distance";//distance
NSString *PARAM_TIME=@"time";//time

#pragma mark-
#pragma mark- RATING

NSString *PARAM_RATING=@"rating";//rating
NSString *PARAM_COMMENT=@"comment";//comment








