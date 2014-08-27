//
//  ViewController.h
//  CameraRecipes
//
//  Created by mar Jinn on 8/26/14.
//  Copyright (c) 2014 mar Jinn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *cameraButton;

@property(strong, nonatomic)    UIImagePickerController* imagePicker;

@property(strong, nonatomic)    NSString* pathToRecordedVideo;


- (IBAction)takeAPicture:(id)sender;


- (IBAction)EditAVideo:(id)sender;
@end

