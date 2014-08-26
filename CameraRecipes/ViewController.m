//
//  ViewController.m
//  CameraRecipes
//
//  Created by mar Jinn on 8/26/14.
//  Copyright (c) 2014 mar Jinn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentAlertWithTitle:(NSString*) alertTitle
                     message:(NSString*)message
              preferredStyle:(UIAlertControllerStyle)preferredStyle
                actionTitles:(NSOrderedSet*) actionTitles
                actionStyles:(NSOrderedSet*) actionStyles
              actionHandlers:(NSOrderedSet*) actionHandlers

{
    NSUInteger actionTitlesCount    = INT_MIN;
    actionTitlesCount   =   [actionTitles count];
    
    NSUInteger actionStylesCount    = INT_MIN;
    actionStylesCount   =   [actionStyles count];
    
    NSUInteger actionHandlersCount    = INT_MIN;
    actionHandlersCount   =   [actionHandlers count];
    
    if (
        (actionTitlesCount == actionHandlersCount == actionHandlersCount) &&
        (actionTitlesCount > 0) &&
        (actionHandlersCount > 0) &&
        (actionHandlersCount > 0)
        )
    {
        //Create the UIAlertController
        UIAlertController* alert    =   nil;
        alert   =
        [UIAlertController alertControllerWithTitle:alertTitle
                                            message:message
                                     preferredStyle:(UIAlertControllerStyle)preferredStyle];
        
        __block NSOrderedSet* actionTitlesTmp   =   nil;
        actionTitlesTmp =   actionTitles;
        
        __block NSOrderedSet* actionStylesTmp   =   nil;
        actionStylesTmp =   actionStyles;
        
        __block NSOrderedSet* actionHandlersTmp   =   nil;
        actionHandlersTmp   =   actionHandlers;
        
        __block UIAlertController* alertTmp   =   nil;
        alertTmp    =   alert;
        
    typedef void (^AlertActionahndler)(UIAlertAction* action);
    
    [actionTitlesTmp enumerateObjectsUsingBlock:
    ^(id obj, NSUInteger idx, BOOL *stop)
    {
        if ([obj isKindOfClass:[NSString class]])
        {
            //add alert
            NSString* alertActionTitle  =   nil;
            alertActionTitle    =   actionTitlesTmp[idx];
            
            UIAlertActionStyle alertActionStyle  =  INT_MAX;
            alertActionStyle    =   [actionStylesTmp[idx] intValue];
            
            AlertActionahndler alertActionHandler   =   nil;
            alertActionHandler  =   actionHandlersTmp[idx];
            
            UIAlertAction*   alertAction    =   nil;
            alertAction =
            [UIAlertAction actionWithTitle:alertActionTitle
                                     style:(UIAlertActionStyle)alertActionStyle
                                   handler:alertActionHandler];
            
            [alertTmp addAction:(UIAlertAction *)alertAction];
            
            alertActionTitle    =   nil;
            alertActionHandler  =   nil;
            alertAction =   nil;
            
        }//obj isKindOfClass:[NSString class
    
    }];//actionTitles enumerateObjectsUsingBlock
        
        actionTitlesTmp =   nil;
        actionStylesTmp =   nil;
        actionHandlersTmp   =   nil;
        alertTmp    =   nil;
        
        //show alert
        [[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController]
         presentViewController:(UIViewController *)alert
         animated:YES
         completion:
         ^{
             NSLog(@"View Controller presented %@",alert);
         }];

        
    }//actionTitlesCount == actionHandlersCount
}



- (IBAction)takeAPicture:(id)sender
{
    //check if camera is available
    if(
       [UIImagePickerController isSourceTypeAvailable:
        (UIImagePickerControllerSourceType)UIImagePickerControllerSourceTypeCamera]
       )
    {
        if (NSClassFromString(@"UIAlertController"))
        {
            UIAlertController* alert    =   nil;
            alert   =
            [UIAlertController alertControllerWithTitle:@"Error"
                                                 message:@"Camera Unavailable"
                                          preferredStyle:(UIAlertControllerStyle)UIAlertControllerStyleAlert];
             
             [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss"
                                                       style:(UIAlertActionStyle)UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction *action)
            {
                [[[[UIApplication sharedApplication] windows][0] rootViewController]
                 dismissViewControllerAnimated:YES completion:
                 ^{
                    NSLog(@"dismissViewControllerAnimated %@",alert);
                }];//completion
                
            }]];//UIAlertAction
            
            //show alert
             [[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController]
             presentViewController:(UIViewController *)alert
        animated:YES
        completion:^{
           
            NSLog(@"View Controller presented %@",alert);
        }];
             
             }
             else
             {
                 
                 UIAlertView* alert  =   nil;
                 alert   =
                 [[UIAlertView alloc] initWithTitle:@"Error"
                                            message:@"Camera Unavailable"
                                           delegate:nil
                                  cancelButtonTitle:@"Dismiss"
                                  otherButtonTitles:nil,nil];
                 
                 [alert show];
             }
             }
             }
             @end
