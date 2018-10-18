//
//  SignUpViewController.h
//  SimpleCameraApp
//
//  Created by ViCky Sharma on 18/10/18.
//  Copyright © 2018 viCky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
{
    IBOutlet UITextField *emailTextfield;
    IBOutlet UITextField *passwordTextfield;
    IBOutlet UIButton * registerBtn;
    UIAlertView * registerAlert; 
}

@end
