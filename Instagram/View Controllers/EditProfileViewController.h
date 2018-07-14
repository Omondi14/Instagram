//
//  EditProfileViewController.h
//  Instagram
//
//  Created by Ernest Omondi on 7/12/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@class EditProfileViewController;

@interface EditProfileViewController : UIViewController <UIImagePickerControllerDelegate>
// property that stores the block accessed by ProfileVC
@property (strong, nonatomic) void (^sendPicAndBioBlock)(UIImage *newImage, NSString *newBio);
@property (weak, nonatomic) IBOutlet UITextView *editBioLabel;
@property (weak, nonatomic) IBOutlet PFImageView *editedProfileView;
@end
