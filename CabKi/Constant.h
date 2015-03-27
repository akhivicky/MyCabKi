//
//  Constant.h
//  TriniPossed
//
//  Created by Manjit Bhuriya on 19/12/13.
//  Copyright (c) 2013 Manjit Bhuriya. All rights reserved.
//

//===== UIAlertView =======//

#define _AlertView_With_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}

#define _AlertView_WithOut_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}

//
//#define REGISTER_API @"http://192.168.0.3/nvert/iphonewebservices/signup.php"
//#define LOGIN_API @"http://192.168.0.3/nvert/iphonewebservices/login.php"
//#define SAVE_REQUEST @"http://192.168.0.3/nvert/iphonewebservices/booking.php"
//
//#define CAB_LOGIN @"http://192.168.0.3/nvert/iphonewebservices/cab_verification.php"
//#define UPDATE_CABLOCATION @"http://192.168.0.3/nvert/iphonewebservices/update_cab_loc.php"
//#define UPDATE_USERLOCATION @"http://192.168.0.3/nvert/iphonewebservices/update_userlocation.php"
//#define SEARCH_CAB @"http://192.168.0.3/nvert/iphonewebservices/searchcab.php"
//live
//http://72.167.41.165/cabki/

//local
//http://72.167.41.165/cabki/

//nvert cabki server
//http://72.167.41.165/cabki/

//dedicated server
//http://72.167.41.165/cabki/
//http://72.167.41.165/~cabki

#define REGISTER_API @"http://72.167.41.165/cabki/iphonewebservices/signup.php"

#define VERIFY_API @"http://72.167.41.165/cabki/iphonewebservices/verified_signup.php"

#define LOGIN_API @"http://72.167.41.165/cabki/iphonewebservices/login.php"
#define SAVE_REQUEST @"http://72.167.41.165/cabki/iphonewebservices/booking.php"

#define CAB_LOGIN @"http://72.167.41.165/cabki/iphonewebservices/cab_verification.php"

#define UPDATE_CABLOCATION @"http://72.167.41.165/cabki/iphonewebservices/update_cab_loc.php"
#define UPDATE_USERLOCATION @"http://72.167.41.165/cabki/iphonewebservices/update_userlocation.php"
#define SEARCH_CAB @"http://72.167.41.165/cabki/iphonewebservices/searchcab.php"

#define ACCEPT_API @"http://72.167.41.165/cabki/iphonewebservices/acceptreject_user_request.php"

#define GETBOOKING_API @"http://72.167.41.165/cabki/iphonewebservices/driver_logcurrent.php"

#define GETCUSTOMERLOCATION  @"http://72.167.41.165/cabki/iphonewebservices/getcustomer_location.php"

#define DRIVERLOCATION  @"http://72.167.41.165/cabki/iphonewebservices/getdriver_location.php"

#define GETCUSTOMERBOOKING @"http://72.167.41.165/cabki/iphonewebservices/customer_log.php"
#define RIDINGSTARTED @"http://72.167.41.165/cabki/iphonewebservices/driver_ride.php"
#define SUSPENDBYDRIVER @"http://72.167.41.165/cabki/iphonewebservices/suspendedbydriver.php"

#define RIDINGSTARTEDCUSTOMER @"http://72.167.41.165/cabki/iphonewebservices/customer_ride.php"
#define CANCELRIDE @"http://72.167.41.165/cabki/iphonewebservices/suspend_riding.php"

#define RIDINGSTARTEDFINAL @"http://72.167.41.165/cabki/iphonewebservices/riding_started.php"

#define BOOKINGRIDE @"http://72.167.41.165/cabki/iphonewebservices/booking_ride.php"

#define PAYMENTAPI @"http://72.167.41.165/cabki/iphonewebservices/payment_existingcard.php"

#define GETNEARESTDRIVER @"http://72.167.41.165/cabki/iphonewebservices/Getnearestdriver.php"

#define UPDATECREDITCARD @"http://72.167.41.165/cabki/iphonewebservices/UpdateCreditcard.php"

#define CHANGE_PASS @"http://72.167.41.165/cabki/iphonewebservices/Changepassword.php"

#define FORGOTPASS @"http://72.167.41.165/cabki/iphonewebservices/forgotpassword.php"


#define GETPROFILE @"http://72.167.41.165/cabki/iphonewebservices/profile.php"

#define GETCABPROFILE @"http://72.167.41.165/cabki/iphonewebservices/cabprofile.php"

#define EXISTING_CARD @"http://72.167.41.165/cabki/iphonewebservices/existing_creditcard.php"

#define DELETE_CARD @"http://72.167.41.165/cabki/iphonewebservices/removecreditcardinfo.php"


#define ADDCREDITCARD @"http://72.167.41.165/cabki/iphonewebservices/AddCreditCard.php"

#define PROMOCODE @"http://72.167.41.165/cabki/iphonewebservices/getpromocode.php"

#define ADDPROMOCODE @"http://72.167.41.165/cabki/iphonewebservices/setpromocode.php"

#define RATING @"http://72.167.41.165/cabki/iphonewebservices/Rating.php"

#define COMPLETERIDING @"http://72.167.41.165/cabki/iphonewebservices/complete_booking.php"

#define ADD_DESTINATION @"http://72.167.41.165/cabki/iphonewebservices/add_destination.php"

#define SKIP_DESTINATION @"http://72.167.41.165/cabki/iphonewebservices/skip_destination.php"

#define Customer_Histroy @"http://72.167.41.165/cabki/iphonewebservices/booking_history.php"

#define Driver_Histroy @"http://72.167.41.165/cabki/iphonewebservices/driver_booking_history.php"


#define SEARCHNEARESTDRIVER @"http://72.167.41.165/cabki/iphonewebservices/searchnearestcab.php"

#define ADDPRIVATEBOOKING_API @"http://72.167.41.165/cabki/iphonewebservices/PrivateBooking.php"

#define ActivateInactivateCloudStatus_API @"http://72.167.41.165/cabki/iphonewebservices/updateCabCloudStatus.php"


#define CompletePrivateBooking @"http://72.167.41.165/cabki/iphonewebservices/CompletePrivateJob.php"


#define CancelPrivateBooking @"http://72.167.41.165/cabki/iphonewebservices/CancelPrivateJob.php"

#define ClosePrivateJob @"http://72.167.41.165/cabki/iphonewebservices/ClosePrivateJob.php"

#define TripHistoryAPI @"http://72.167.41.165/cabki/iphonewebservices/trip_history.php"

#define TripHistoryDetaiAPI @"http://72.167.41.165/cabki/iphonewebservices/trip_history_detail.php"

#define USER_REGISTER @"register"
#define USER_LOGIN @"login"
#define USER_GET_PHOTO @"getPhoto"
#define USER_GET_VIDEO @"getVideo"
#define USER_GET_EVENT @"getEvent"
#define USER_EVENT_DETAIL @"id"
#define USER_GET_EVENT_YEAR @"geteventyear"
#define USER_CREATE_EVENT @"createEvent"

#define SUCCESS_RESPONSE @"true"
#define ERROR_RESPONSE @"false"



#define emailandphonevalidation @"http://72.167.41.165/cabki/iphonewebservices/validate_email_phone.php"

#define codevalidation @"http://72.167.41.165/cabki/iphonewebservices/sms_verification.php"

#define resendcode @"http://72.167.41.165/cabki/iphonewebservices/resend_sms.php"

#define nameValidation @"http://72.167.41.165/cabki/iphonewebservices/add_name.php"



