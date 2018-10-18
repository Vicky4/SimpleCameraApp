//
//  HomeVC.m
//  SimpleCameraApp
//
//  Created by ViCky Sharma on 18/10/18.
//  Copyright © 2018 viCky. All rights reserved.
//

#import "HomeVC.h"
#import "UIViewController+customFunction.h"
#import <SimpleCameraApp/Synchronicity.pbrpc.h>
#import "GlobalValue.h"
#import <gRPC-RxLibrary/RxLibrary/GRXWriter+Immediate.h>
#import <GRPCClient/GRPCCall.h>
#import <ProtoRPC/ProtoRPC.h>

@interface HomeVC ()<UINavigationControllerDelegate , UIImagePickerControllerDelegate>

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self addRightNavigationButton];
    
    // Do any additional setup after loading the view.
}

-(void)addRightNavigationButton
{
    UIButton * backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(cameraBtnPress) forControlEvents:UIControlEventTouchUpInside];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIBarButtonItem *cameraBar =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [self.navigationItem setRightBarButtonItem:cameraBar];
}

-(void)cameraBtnPress
{
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Select Image"
                                 message:@""
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
 
    
    
    
    UIAlertAction* camera = [UIAlertAction
                         actionWithTitle:@"Camera"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [view dismissViewControllerAnimated:YES completion:nil];

                             if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
                             {
                                 
                             }
                             else
                             {
                                 [self showNotification:@"Testing On Simulator" duration:3.0];
                                 
                             }
                             
                             
                         }];
    
    
    UIAlertAction* gallery = [UIAlertAction
                             actionWithTitle:@"Gallery"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 [self galleryButtonPressed];
                                 
                             }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:camera];
    [view addAction:gallery];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];
}


#pragma Camera / Gallery Delegate

- (void)galleryButtonPressed
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    // output image
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        localImage.image=chosenImage;
       
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Button Action

-(IBAction)sendServer:(id)sender
{
    [self sendImageToServer];
}

#pragma mark - Api call
-(void)sendImageToServer
{
    [self showHUD:@""];
    NSData *imageData = UIImagePNGRepresentation(localImage.image);
    
    Synchronicity *client = [[Synchronicity alloc] initWithHost:HOST_URL];
    
    StreamDataBytes * request = [StreamDataBytes message];
    request.content=imageData;
    
    GRXWriter *imageWriter=[GRXWriter writerWithValue:request];
    
    GRPCProtoCall *call =  [client RPCToSimpleRPCBytesWithRequestsWriter:imageWriter eventHandler:^(BOOL done, StreamDataResponseBytes * _Nullable response, NSError * _Nullable error)
    {


        if (error!=nil)
        {
            [self hudHide];
            NSLog(@"================ %@",error.localizedDescription);
        }
        else
        {
            [self hudHide];
            NSLog( @"%@",response);
            [imageWriter setState:GRXWriterStateFinished];

        }
    }];

    [call start];
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
