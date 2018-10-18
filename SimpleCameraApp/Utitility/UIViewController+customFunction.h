//
//  UIViewController+customFunction.h
//  thooth
//
//  Created by ViCky Sharma on 10/07/18.
//  Copyright © 2018 viCky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (customFunction)
{
}






/*!
 * @description To show an alert with fixed title
 * @param message Message of the alert
 */
-(void) showAlertWithMessage:(NSString*)message title:(NSString *)title;

-(void) showHUD:(NSString*)message;

-(void) hudHide;

-(void)createButtonRadius:(UIView *)buttonPassed radius:(NSInteger)radiusValue;

-(BOOL)checkValidation:(UITextField *)textField text:(NSString *)warningText;

-(void)addUnderLine:(UITextField *)txt color:(UIColor *)clr;

-(void)addElementToNavigation;

-(void)roundRect:(UIImageView *)userImage;

-(void)createBorder:(UIView *)viewPassed radius:(NSInteger)radiusValue color:(UIColor *) borderColor width:(NSInteger)borderWidth;

-(void)addPadding:(UITextField *)txt imageName:(NSString *)image;

- (void)showNotification:(NSString *)string duration:(CGFloat)d;

-(void)addToolbar:(UITextView *)view;

-(BOOL)checkValidationOnString:(NSString *)text text:(NSString *)warningText;

-(void)addToolbarTxt:(UITextField *)view;

-(void)addRightPadding:(UITextField *)txt imageName:(NSString *)image;

-(BOOL)checkValidationTxtView:(UITextView *)textField text:(NSString *)warningText;

-(void)addShadowToView:(UIView*)viewPassed color:(UIColor *)clr;

-(void)addImageTonavigation:(NSString *)imageName; 

-(NSString *)currentDate:(NSDate *)cDate; 
 

@end
