//
//  User.h
//  Instagram
//
//  Created by Ernest Omondi on 7/13/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import "PFUser.h"
#import "ParseUI.h"

@interface User : PFUser
@property (strong, nonatomic, nullable) PFFile *profilePic;
@property (strong, nonatomic, nullable) NSString *username;
@property (strong, nonatomic, nullable) NSString *password;
@property (strong, nonatomic, nullable) NSString *bio;

@end
