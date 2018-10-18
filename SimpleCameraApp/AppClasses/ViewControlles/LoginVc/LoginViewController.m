//
//  LoginViewController.m
//  SimpleCameraApp
//
//  Created by ViCky Sharma on 18/10/18.
//  Copyright © 2018 viCky. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+customFunction.h"
#import <SimpleCameraApp/Synchronicity.pbrpc.h>
#import "GlobalValue.h"
#import "HomeVC.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addUnderLine:emailTextfield color:[UIColor blackColor]];
    [self addUnderLine:passwordTextfield color:[UIColor blackColor]];
    [self createButtonRadius:loginBtn radius:7.0];

    // Do any additional setup after loading the view.
}

#pragma mark - Button Actions

- (IBAction)loginAction:(id)sender
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if([self checkValidation:emailTextfield text:@"Enter email"])
    {
        return;
    }
    else if ([emailTest evaluateWithObject:emailTextfield.text] == NO)
    {
        [self showNotification:@"Invalid Email ID" duration:3.0];
        return;
    }
    if([self checkValidation:passwordTextfield text:@"Enter email"])
    {
        return;
    }
    else
    {
        [self loginApi:emailTextfield.text password:passwordTextfield.text];
        
    }
}

#pragma mark - Api's

-(void)loginApi:(NSString *)emailId password:(NSString *)pass
{
    [self showHUD:@""];
    Synchronicity *client = [[Synchronicity alloc] initWithHost:HOST_URL];
    LoginRequest *request = [LoginRequest message];
    request.email  = emailId;
    request.password  =pass;
    
    [client loginWithRequest:request handler:^(LoginReply * _Nullable response, NSError * _Nullable error)
    {
        
        if (error != nil )
        {
        
                [self hudHide];
                [self showNotification:@"Email or Password incorrect" duration:3.0];
                emailTextfield.text = @"";
                passwordTextfield.text = @"";

                        
        }
        else
        {
            [self hudHide];
            NSLog(@"%@",response);
            HomeVC * homeObj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
            [self.navigationController pushViewController:homeObj animated:YES];
            
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
