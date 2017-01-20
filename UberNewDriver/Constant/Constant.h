
//// color

#define _RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kCLR_RANDOM_COLOR _RGB(arc4random()%255, arc4random()%255, arc4random()%255, 1)

#define ARR_COLOR [NSArray arrayWithObjects:_RGB(255, 115, 38, 1),_RGB(98, 217, 255, 1),_RGB(38, 255, 150, 1), _RGB(38, 79, 255, 1), _RGB(212, 38, 255, 1), nil]

//iPhone5 helper
#define ASSET_BY_SCREEN_HEIGHT(regular) (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? regular : [regular stringByAppendingString:@"-568h"])

//iPhone Or iPad
#define isiPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

//iOS7 Or less
#define ISIOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)


#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

#define IsIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsIPhone5 ([[UIScreen mainScreen] bounds].size.height == 568)

//Api Url

#define mapQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)
#define GOOGLE_KEY_NEW @"AIzaSyCLDSZl4y2CfTWwPzJ933jS2X5jOpDFkEI"

#define API_URL @"http://fasterride.com/"
//#define API_URL @"http://taxinew.taxinow.xyz/"
//#define API_URL @"http://192.168.0.26/uberforx_new/api/public/"

#define TERM_OF_USE_URL @""
#define PRIVACY_URL @"http://fasterride.com/public/termsncondition"


#define Address_URL @"https://maps.googleapis.com/maps/api/geocode/json?"


//////////// WS Methods
#pragma mark-
#pragma mark- Methods
extern NSString *const FILE_COUNTRY_LIST;
extern NSString *const FILE_REGISTER;//register
extern NSString *const FILE_LOGIN;//login
extern NSString *const FILE_REQUEST;//getrequests
extern NSString *const FILE_RESPOND_REQUEST;//respondrequest
extern NSString *const FILE_GET_REQUEST;//getrequest
extern NSString *const FILE_WLKER_STARTED;//requestwalkerstarted
extern NSString *const FILE_WLKER_ARRIVED;//requestwalkerarrived
extern NSString *const FILE_WALK_STARTED;//requestwalkstarted
extern NSString *const FILE_ADD_LOCATION;//addlocation
extern NSString *const FILE_WALK_COMPLETED;//requestwalkcompleted
extern NSString *const FILE_RATING;//rating
extern NSString *const FILE_PROGRESS;//requestinprogress
extern NSString *const FILE_USERLOCATION;//addlocation
extern NSString *const FILE_PAGES;//application/pages
extern NSString *const FILE_UPDATE_PROFILE;//@"provider/update"
extern NSString *const FILE_WALKER_TYPE;//application/types
extern NSString *const FILE_HISTORY;//provider/history
extern NSString *const FILE_FORGOT_PASSWORD;//application/forgot-password
extern NSString *const FILE_CHECKSTATUS; //provider/checkstate
extern NSString *const FILE_TOGGLE;//provider/togglestate
extern NSString *const FILE_WALK_LOCATION;//request/location
extern NSString *const FILE_REQUEST_PATH;//request/path
extern NSString *const FILE_LOGOUT;//provider/logout

#pragma mark-
#pragma mark- General Parameter

extern NSString *const PREF_IS_LOGIN;
extern NSString *const PREF_LOGIN_BY;
extern NSString *const PREF_EMAIL;
extern NSString *const PREF_PASSWORD;
extern NSString *const PREF_SOCIAL_ID;
extern NSString *const PREF_USER_TOKEN;
extern NSString *const PREF_USER_ID;
extern NSString *const PREF_REQUEST_ID;//request_id
extern NSString *const PREF_DEVICE_TOKEN;
extern NSString *const PREF_IS_APPROVED;


extern NSString *const PREF_USER_NAME;
extern NSString *const PREF_USER_PHONE;
extern NSString *const PREF_USER_RATING;
extern NSString *const PREF_USER_PICTURE;

extern NSString *const PREF_WALK_TIME;
extern NSString *const PREF_WALK_DISTANCE;
extern NSString *const PREF_START_TIME;
extern NSString *const PREF_FIRST_NAME;
extern NSString *const PREF_LAST_NAME;

extern NSString *const PREF_NAV;

extern NSString *device_token;
extern NSArray *arrUser;
extern NSArray *arrPage;

extern NSString *struser_lati;
extern NSString *struser_longi;
extern NSString *strowner_lati;
extern NSString *strowner_longi;
#pragma mark-
#pragma mark- register Parameter

extern NSString *const PARAM_EMAIL;//email
extern NSString *const PARAM_PASSWORD;//password
extern NSString *const PARAM_OLDPASSWORD;//old_password
extern NSString *const PARAM_NEWPASSWORD;//new_password
extern NSString *const PARAM_FIRST_NAME;//first_name
extern NSString *const PARAM_LAST_NAME;//last_name
extern NSString *const PARAM_PHONE;//phone
extern NSString *const PARAM_DEVICE_TOKEN;//device_token
extern NSString *const PARAM_DEVICE_TYPE;//device_type
extern NSString *const PARAM_BIO;//bio
extern NSString *const PARAM_ADDRESS;//address
extern NSString *const PARAM_STATE;//state
extern NSString *const PARAM_COUNTRY;//country
extern NSString *const PARAM_ZIPCODE;//zipcode
extern NSString *const PARAM_LOGIN_BY;//login_by
extern NSString *const PARAM_SOCIAL_ID;//social_unique_id
extern NSString *const PARAM_PICTURE;//picture
extern NSString *const PARAM_WALKER_TYPE;//type
extern NSString *const PARAM_TAXI_MODEL;//car_model
extern NSString *const PARAM_TAXI_NUMBER;//car_number


#pragma mark-
#pragma mark- Check Request

extern NSString *PARAM_ID;//id
extern NSString *PARAM_TOKEN;//token

#pragma mark-
#pragma mark- Respond Request

extern NSString *PARAM_REQUEST_ID;//request_id
extern NSString *PARAM_ACCEPTED;//accepted

#pragma mark-
#pragma mark- Walker Started Request

extern NSString *PARAM_LATITUDE;//latitude
extern NSString *PARAM_LONGITUDE;//longitude

#pragma mark-
#pragma mark- Walk COMPLETED Request

extern NSString *PARAM_DISTANCE;//distance
extern NSString *PARAM_TIME;//time


#pragma mark-
#pragma mark- RATING

extern NSString *PARAM_RATING;//rating
extern NSString *PARAM_COMMENT;//comment

extern NSDictionary *dictBillInfo;
extern int is_completed;
extern int is_dog_rated;
extern int is_walker_started;
extern int is_walker_arrived;
extern int is_started;
extern int payment;



