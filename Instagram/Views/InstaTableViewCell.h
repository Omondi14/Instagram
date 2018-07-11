//
//  InstaTableViewCell.h
//  Instagram
//
//  Created by Ernest Omondi on 7/10/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "Post.h"

@interface InstaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *mainPhotoView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
- (void)showPhoto:(Post *)post;


@end
