//
//  ViewController.m
//  CameraRecipes
//
//  Created by mar Jinn on 8/26/14.
//  Copyright (c) 2014 mar Jinn. All rights reserved.
//

#import "ViewController.h"
@import MobileCoreServices;


@interface ViewController () <UIVideoEditorControllerDelegate>


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
        (actionTitlesCount == actionHandlersCount)
        &&
        (actionStylesCount  ==  actionHandlersCount)
        &&
        (actionStylesCount == actionTitlesCount)
        &&
        (actionTitlesCount > 0)
        &&
        (actionStylesCount > 0)
        &&
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
    }//ImagePicker Avaialbaility
    
    if ([self imagePicker] ==   nil)
    {
        [self setImagePicker:[UIImagePickerController new]];
        
        [[self imagePicker] setDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>) self];
        
        [[self imagePicker] setSourceType:(UIImagePickerControllerSourceType)
         UIImagePickerControllerSourceTypeCamera];
        
        //enable editing
        [[self imagePicker] setAllowsEditing:YES];
        
        //add video recording
        [[self imagePicker] setMediaTypes:(NSArray *)
        [UIImagePickerController availableMediaTypesForSourceType:(UIImagePickerControllerSourceType)UIImagePickerControllerSourceTypeCamera]];
        
    
    }
    
    [self presentViewController:(UIViewController *)[self imagePicker]
                       animated:YES
                     completion:
     ^{
          NSLog(@"View Controller presented %@",[self imagePicker]);
         
     }];
    
}




#pragma mark UIImagePickerDelegates
//UIImagePickerDelegates
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //Adding movie capture support
    NSString* mediaType =   nil;
    mediaType   =
    (NSString*)[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(__bridge NSString*)kUTTypeMovie])
    {
        
    }
    
    if (
        CFStringCompare
        (
         (__bridge CFStringRef)mediaType,
         kUTTypeMovie,
         kCFCompareCaseInsensitive
         )
        ==
        kCFCompareEqualTo
        )
    {
        //Movie Captured
        NSString* moviePath =   nil;
        moviePath   = (NSString*)
        [[info objectForKey:(id)UIImagePickerControllerMediaURL] path];
        
        //get vidoe path
        [self setPathToRecordedVideo:moviePath];
        
        //save video to path
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath))
        {
            UISaveVideoAtPathToSavedPhotosAlbum
            (
             moviePath,
             nil,
             nil,
             NULL
             );
        }
    
    }//kUTTypeMovie
    
    else
    {
    
    UIImage* origImage  =   nil;
    origImage   = (UIImage*)
    [info objectForKey:(id)UIImagePickerControllerOriginalImage];
    
    UIImage* editedImage  =   nil;
    editedImage   = (UIImage*)
    [info objectForKey:(id)UIImagePickerControllerEditedImage];
    
    //write image to album
    UIImageWriteToSavedPhotosAlbum(editedImage, nil, nil, NULL);
    
    //To acces this image we need to add
    //However, as of iOS 6 privacy restrictions have been applied to the saved-photos album; an app that wants to access it now needs an explicit authorization from the user. Therefore, you should also provide an explanation as to why your app requests access to the saved-photos library. This is done in the application’s Info.plist file (found in the Supporting Files folder in the project navigator) and the key NSPhotoLibraryUsageDescription (or “Privacy—Photo Library Usage Description,” as it’s displayed in the property list).
    
    [[self imageView] setImage:editedImage];
    origImage   =   nil;
    editedImage   =   nil;
    
    [[self imageView] setContentMode:
     (UIViewContentMode)UIViewContentModeScaleAspectFill];
    
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:
     ^{
         
          NSLog(@"View Controller Dismissed %@",picker);
         
         [self setImagePicker:nil];
     }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES
                             completion:
     ^{
         
         NSLog(@"View Controller Dismissed %@",picker);
         
         [self setImagePicker:nil];
     }];
}

- (IBAction)EditAVideo:(id)sender
{
    //Uivideo editing
    if ([self pathToRecordedVideo])
    {
        UIVideoEditorController* editor =   nil;
        editor  =   [UIVideoEditorController new];
        
        [editor setVideoPath:[self pathToRecordedVideo]];
        
        [editor setVideoQuality:
         (UIImagePickerControllerQualityType)UIImagePickerControllerQualityTypeHigh];
        
        [editor setDelegate:
         (id<UINavigationControllerDelegate,UIVideoEditorControllerDelegate>)self];
        
        [self presentViewController:(UIViewController *)editor
                           animated:YES
                         completion:
         ^{
             NSLog(@"View Controller Presented %@",editor);
         }];
    }//[self pathToRecordedVideo]
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"No Video Recorded Yet"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


#pragma mark UIVideoEditorControllerDelegate

//UIVideoEditorControllerDelegate

- (void)videoEditorController:(UIVideoEditorController *)editor
     didSaveEditedVideoToPath:(NSString *)editedVideoPath // edited video is saved to a path in app's temporary directory
{
    [self setPathToRecordedVideo:editedVideoPath];
    
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(editedVideoPath))
    {
        UISaveVideoAtPathToSavedPhotosAlbum
        (
         editedVideoPath,
         nil,
         nil,
         NULL
         );
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:
     ^{
         
         NSLog(@"View Controller Dismissed %@",editor);
         
         
     }];

    
}

- (void)videoEditorController:(UIVideoEditorController *)editor
             didFailWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES
                             completion:
     ^{
         
         NSLog(@"View Controller Dismissed %@",editor);
         
         
     }];

}

- (void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor
{
    [self dismissViewControllerAnimated:YES
                             completion:
     ^{
         
         NSLog(@"View Controller Dismissed %@",editor);
         
         
     }];

}

@end
