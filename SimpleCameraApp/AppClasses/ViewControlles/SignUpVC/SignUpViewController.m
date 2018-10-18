//
//  SignUpViewController.m
//  SimpleCameraApp
//
//  Created by ViCky Sharma on 18/10/18.
//  Copyright © 2018 viCky. All rights reserved.
//

#import "SignUpViewController.h"
#import "UIViewController+customFunction.h"
#import <SimpleCameraApp/Synchronicity.pbrpc.h>
#import "GlobalValue.h"
#import "AppDelegate.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUnderLine:emailTextfield color:[UIColor blackColor]];
    [self addUnderLine:passwordTextfield color:[UIColor blackColor]];
    [self createButtonRadius:registerBtn radius:7.0];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Button Actions

-(IBAction)backToLogin:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerAction:(id)sender
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
        [self registerUser:emailTextfield.text password:passwordTextfield.text];
        
    }
}

#pragma mark - Api Call

-(void)registerUser:(NSString *)email password:(NSString *)pass
{
    [self showHUD:@""];
    Synchronicity *client = [[Synchronicity alloc] initWithHost:HOST_URL];
    
    RegisterRequest *request = [RegisterRequest message];
    request.email  = email;
    request.password  =pass;
    
    [client registerWithRequest:request handler:^(RegisterReply * _Nullable response, NSError * _Nullable error) {
        if (error != nil )
        {
            [self hudHide];
            [self showNotification:error.localizedDescription  duration:3.0];
            
        }
        else
        {
            [self hudHide];
            NSString * alertMessage= [NSString stringWithFormat:@"Register Succesfully"];
            registerAlert=[[UIAlertView alloc]initWithTitle:@"" message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [registerAlert show];
            
            [self performSelector:@selector(registerMessage) withObject:self afterDelay:2.0];
        }
    }];
}

-(void)registerMessage
{
    [registerAlert dismissWithClickedButtonIndex:0 animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
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
