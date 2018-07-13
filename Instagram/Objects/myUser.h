//
//  myUser.h
//  Instagram
//
//  Created by Ernest Omondi on 7/12/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import "PFUser.h"
#import "ParseUI.h"

@interface myUser : PFUser
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) NSString *myBio;


@end
