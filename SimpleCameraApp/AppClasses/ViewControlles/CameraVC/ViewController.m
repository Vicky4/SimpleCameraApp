//
//  ViewController.m
//  SimpleCameraApp
//
//  Created by ViCky Sharma on 10/10/18.
//  Copyright © 2018 viCky. All rights reserved.
//

#import "ViewController.h"
#import "ViewUtils.h"
#import "ImageViewController.h"
#import "LLSimpleCamera.h"


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) LLSimpleCamera *camera;
@property (strong, nonatomic) UILabel *errorLabel;
@property (strong, nonatomic) UIButton *snapButton;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UIButton *galleryButton;
@property (strong, nonatomic) UIButton *flashButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // ----- initialize camera -------- //
    
    self.camera = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPresetHigh
                                                 position:LLCameraPositionRear
                                             videoEnabled:YES];
    
    // attach to a view controller
    [self.camera attachToViewController:self withFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    self.camera.fixOrientationAfterCapture = NO;
    
   
    [self checkPermissions];
    [self setInitialViewWithButtons];
   

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // start the camera
    [self.camera start];
}

#pragma mark - View Setup

-(void)setInitialViewWithButtons
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    // snap button to capture image
    self.snapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.snapButton.frame = CGRectMake(0, 0, 70.0f, 70.0f);
    self.snapButton.clipsToBounds = YES;
    self.snapButton.layer.cornerRadius = self.snapButton.width / 2.0f;
    self.snapButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.snapButton.layer.borderWidth = 2.0f;
    self.snapButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.snapButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.snapButton.layer.shouldRasterize = YES;
    [self.snapButton addTarget:self action:@selector(snapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.snapButton];
    
    // button to toggle flash
    self.flashButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.flashButton.frame = CGRectMake(0, 0, 16.0f + 20.0f, 24.0f + 20.0f);
    self.flashButton.tintColor = [UIColor whiteColor];
    [self.flashButton setImage:[UIImage imageNamed:@"camera-flash.png"] forState:UIControlStateNormal];
    self.flashButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [self.flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.flashButton];
    
    if([LLSimpleCamera isFrontCameraAvailable] && [LLSimpleCamera isRearCameraAvailable])
    {
        // button to toggle camera positions
        self.switchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.switchButton.frame = CGRectMake(0, 0, 29.0f + 20.0f, 22.0f + 20.0f);
        self.switchButton.tintColor = [UIColor whiteColor];
        [self.switchButton setImage:[UIImage imageNamed:@"camera-switch.png"] forState:UIControlStateNormal];
        self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        [self.switchButton addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.switchButton];
    }
    
    // button to gallery option

    self.galleryButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.galleryButton.frame = CGRectMake(50.0f, screenRect.size.height - 75.0f, 58.0f , 58.0f);
    self.galleryButton.tintColor = [UIColor whiteColor];
    [self.galleryButton setImage:[UIImage imageNamed:@"gallery.png"] forState:UIControlStateNormal];
    self.galleryButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [self.galleryButton addTarget:self action:@selector(galleryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.galleryButton];
    
}

-(void)checkPermissions
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    __weak typeof(self) weakSelf = self;
    
    [self.camera setOnDeviceChange:^(LLSimpleCamera *camera, AVCaptureDevice * device)
     {
         
         // device changed, check if flash is available
         if([camera isFlashAvailable])
         {
             weakSelf.flashButton.hidden = NO;
             
             if(camera.flash == LLCameraFlashOff)
             {
                 weakSelf.flashButton.selected = NO;
             }
             else {
                 weakSelf.flashButton.selected = YES;
             }
         }
         else {
             weakSelf.flashButton.hidden = YES;
         }
     }];
    
    [self.camera setOnError:^(LLSimpleCamera *camera, NSError *error)
     {
         NSLog(@"Camera error: %@", error);
         
         if([error.domain isEqualToString:LLSimpleCameraErrorDomain])
         {
             if(error.code == LLSimpleCameraErrorCodeCameraPermission)
             {
                 
                 if(weakSelf.errorLabel)
                 {
                     [weakSelf.errorLabel removeFromSuperview];
                 }
                 
                 UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                 label.text = @"We need permission for the camera.\nPlease go to your settings.";
                 label.numberOfLines = 2;
                 label.lineBreakMode = NSLineBreakByWordWrapping;
                 label.backgroundColor = [UIColor clearColor];
                 label.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:13.0f];
                 label.textColor = [UIColor whiteColor];
                 label.textAlignment = NSTextAlignmentCenter;
                 [label sizeToFit];
                 label.center = CGPointMake(screenRect.size.width / 2.0f, screenRect.size.height / 2.0f);
                 weakSelf.errorLabel = label;
                 [weakSelf.view addSubview:weakSelf.errorLabel];
             }
         }
     }];
    
}

#pragma mark - camera button methods

- (void)switchButtonPressed:(UIButton *)button
{
    [self.camera togglePosition];
}

- (void)flashButtonPressed:(UIButton *)button
{
    if(self.camera.flash == LLCameraFlashOff) {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOn];
        if(done) {
            self.flashButton.selected = YES;
            self.flashButton.tintColor = [UIColor yellowColor];
        }
    }
    else {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOff];
        if(done) {
            self.flashButton.selected = NO;
            self.flashButton.tintColor = [UIColor whiteColor];
        }
    }
}

- (void)snapButtonPressed:(UIButton *)button
{
    __weak typeof(self) weakSelf = self;
        // capture
        [self.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
            if(!error) {
                ImageViewController *imageVC = [[ImageViewController alloc] initWithImage:image];
                [weakSelf presentViewController:imageVC animated:NO completion:nil];
            }
            else
            {
                NSLog(@"An error has occured: %@", error);
            }
        } exactSeenImage:YES];
        
    
}

- (void)galleryButtonPressed:(UIButton *)button
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __weak typeof(self) weakSelf = self;

    // output image
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        
//        NSData *imageData = UIImagePNGRepresentation(chosenImage);
//        NSString * base=[self encodeToBase64String:chosenImage];
     
        
        ImageViewController *imageVC = [[ImageViewController alloc] initWithImage:chosenImage];
        [weakSelf presentViewController:imageVC animated:NO completion:nil];
    }];
    
}

- (NSString *)encodeToBase64String:(UIImage *)image
{
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/* other lifecycle methods */

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.camera.view.frame = self.view.contentBounds;
    
    self.snapButton.center = self.view.contentCenter;
    self.snapButton.bottom = self.view.height - 15.0f;
    
    self.flashButton.center = self.view.contentCenter;
    self.flashButton.top = 5.0f;
    
    self.switchButton.top = 5.0f;
    self.switchButton.right = self.view.width - 5.0f;
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
