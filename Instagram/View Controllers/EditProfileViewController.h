//
//  EditProfileViewController.h
//  Instagram
//
//  Created by Ernest Omondi on 7/12/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditProfileViewController;

@protocol EditProfileDelegate

-(void) editedBioAndPic:(UIImage *)newProfilePic editedBio:(NSString *)newBio;
@end

@interface EditProfileViewController : UIViewController <UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *editBioLabel;
@property (weak, nonatomic) IBOutlet UIImageView *editedProfileView;
@property (weak, nonatomic) id <EditProfileDelegate> delegate;
@end
