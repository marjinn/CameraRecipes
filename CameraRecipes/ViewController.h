//
//  ViewController.h
//  CameraRecipes
//
//  Created by mar Jinn on 8/26/14.
//  Copyright (c) 2014 mar Jinn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
- (IBAction)takeAPicture:(id)sender;

@end

