//
//  InstaTableViewCell.h
//  Instagram
//
//  Created by Ernest Omondi on 7/10/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"

@interface InstaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainPhotoView;

@end
