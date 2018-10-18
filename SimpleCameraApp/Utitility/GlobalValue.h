//  thooth
//
//  Created by ViCky Sharma on 10/07/18.
//  Copyright © 2018 viCky. All rights reserved.
//

#ifndef CivilLines_GlobalValue_h
#define CivilLines_GlobalValue_h


#define  HOST_URL @"tingle-grpc.synchronicity.ai:443"



#define IS_IOS_VERSION_ABOVE_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?YES:NO
#define IS_LARGE_DEVICE     ([[[UIApplication sharedApplication] delegate] window].frame.size.height > 480)?YES:NO
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define defaultsValue [NSUserDefaults standardUserDefaults]
#define screenSize [UIScreen mainScreen].bounds.size.width
#define screenDimen [UIScreen mainScreen].bounds.size

#define App_Font_Regular(v) [UIFont fontWithName:@"HelveticaNeue" size:v]
#define App_Font_Bold(v) [UIFont fontWithName:@"HelveticaNeue-Bold" size:v]
#define isiPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad


#endif



