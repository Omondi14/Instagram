//
//  ProfileViewController.h
//  Instagram
//
//  Created by Ernest Omondi on 7/11/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProfileViewController.h"

@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *postsArray;
@end
