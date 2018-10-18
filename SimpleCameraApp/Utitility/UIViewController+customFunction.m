//
//  UIViewController+customFunction.m
//  thooth
//
//  Created by ViCky Sharma on 10/07/18.
//  Copyright © 2018 viCky. All rights reserved.
//

#import "UIViewController+customFunction.h"
#import "AppDelegate.h"
#import "GlobalValue.h"

@implementation UIViewController (customFunction)

-(void) showAlertWithMessage:(NSString*)message title:(NSString *)title
{
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
 
    
    [view addAction:ok];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)showHUD:(NSString *)message
{
    MBProgressHUD * HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if(message)
    {
      HUD.labelText=message;
    }
    HUD.square = YES;
}

-(void)addElementToNavigation
{
    //----------------------------------------------//
    
    UIButton * backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 35, 35);
    [backBtn setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnPress) forControlEvents:UIControlEventTouchUpInside];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIBarButtonItem *backBar =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:backBar];
    

}


-(void)rightNavigationElement
{
  
    
    
}


-(void)addImageTonavigation:(NSString *)imageName
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self rightNavigationElement];

}

-(void)hudHide
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


-(void)createButtonRadius:(UIView *)buttonPassed radius:(NSInteger)radiusValue
{
    
    buttonPassed.layer.cornerRadius=radiusValue;

}

-(void)addShadowToView:(UIView*)viewPassed color:(UIColor *)clr
{
    viewPassed.layer.shadowRadius  = 1.5f;
    viewPassed.layer.shadowColor   = clr.CGColor;
    viewPassed.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    viewPassed.layer.shadowOpacity = 0.9f;
    viewPassed.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(viewPassed.bounds, shadowInsets)];
    viewPassed.layer.shadowPath    = shadowPath.CGPath;
}

-(void)createBorder:(UIView *)viewPassed radius:(NSInteger)radiusValue color:(UIColor *) borderColor width:(NSInteger)borderWidth
{
    
    viewPassed.layer.cornerRadius=radiusValue;
    viewPassed.layer.borderWidth=borderWidth;
    viewPassed.layer.borderColor=[borderColor CGColor];
    
}

#pragma mark - validations

-(BOOL)checkValidation:(UITextField *)textField text:(NSString *)warningText
{
    
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if([[textField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        
        [self showNotification:warningText duration:3.0];
        
        return YES;
    }
    else
    {
        return NO;
    }
    
}


-(BOOL)checkValidationTxtView:(UITextView *)textField text:(NSString *)warningText
{
    
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if([[textField.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        
        [self showNotification:warningText duration:3.0];
        
        return YES;
    }
    else
    {
        return NO;
    }
    
}


-(BOOL)checkValidationOnString:(NSString *)text text:(NSString *)warningText
{
    
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if([[text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        
        [self showNotification:warningText duration:3.0];
        
        return YES;
    }
    else
    {
        return NO;
    }
    
}

-(void)roundRect:(UIImageView *)userImage
{
    CALayer *imageLayer = userImage.layer;
    [imageLayer setCornerRadius:userImage.frame.size.width/2];
    [imageLayer setBorderWidth:1];
    [imageLayer setMasksToBounds:YES];
    [userImage.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
}


-(void)backBtnPress
{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - Warning Banner 

- (void)showNotification:(NSString *)string duration:(CGFloat)d
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, -65.0, screenDimen.width, 65.0)];
    [view setBackgroundColor:[UIColor redColor]];
    UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 15.0, screenDimen.width, 50)];
    lblMessage.textColor = [UIColor whiteColor];
    lblMessage.textAlignment = NSTextAlignmentCenter;
    lblMessage.font = App_Font_Bold(18.0);
    lblMessage.text = string;
    lblMessage.numberOfLines = 0;
    [view addSubview:lblMessage];
    [appdelegate().window addSubview:view];
    
    [UIView animateWithDuration:0.25 animations:^(void)
     {
         view.frame = CGRectOffset(view.frame, 0.0, 65.0);
     }
                     completion:^(BOOL finished)
     {
         [self performSelector:@selector(hideView:) withObject:view afterDelay:d];
     }];
}
- (void)hideView:(UIView *)view
{
    
    [UIView animateWithDuration:0.7 animations:^(void)
     {
         view.alpha = 0.0;
         if (view.hidden)
             [view setHidden:NO];
     }
                     completion:^(BOOL finished)
     {
         
             [view removeFromSuperview];
        
     }];

}

#pragma mark - TextField 


-(void)addPadding:(UITextField *)txt imageName:(NSString *)image
{
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, txt.frame.size.height)];

    txt.leftView = paddingView1;
    txt.leftViewMode = UITextFieldViewModeAlways;

}


-(void)addRightPadding:(UITextField *)txt imageName:(NSString *)image
{
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, txt.frame.size.height)];
    
    UIImageView * img=[[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 16,16)];
    img.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",image]];
    img.contentMode = UIViewContentModeCenter;
    [paddingView1 addSubview:img];
    
    txt.rightView = paddingView1;
    txt.rightViewMode = UITextFieldViewModeAlways;
    
}

-(void)addUnderLine:(UITextField *)txt color:(UIColor *)clr
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = clr.CGColor;
    border.frame = CGRectMake(0, txt.frame.size.height - borderWidth, txt.frame.size.width, txt.frame.size.height);
    border.borderWidth = borderWidth;
    [txt.layer addSublayer:border];
    txt.layer.masksToBounds = YES;
}


#pragma mark - Date

-(NSString *)dateConvertor:(NSDate *)origDate dateFormat:(NSString *)format
{
    
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:format];
    NSString *_date=[_formatter stringFromDate:origDate];
    return _date;
    
}

-(NSString *)currentDate:(NSDate *)cDate
{
    NSString * dateString=[self dateConvertor:cDate dateFormat:@"dd-MMMM-YYYY"];
    
    return dateString;
}




-(void)addToolbar:(UITextView *)view
{
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, screenSize, 50)];
    numberToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    
    view.inputAccessoryView = numberToolbar;
    view.inputAccessoryView = numberToolbar;
    view.inputAccessoryView = numberToolbar;
    
    
    
}

-(void)addToolbarTxt:(UITextField *)view
{
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, screenSize, 50)];
    numberToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    
    view.inputAccessoryView = numberToolbar;
    
    
    
}


-(void)doneWithNumberPad
{
    [self.view endEditing:YES];
}



@end
