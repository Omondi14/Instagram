//
//  profileTableViewCell.h
//  Instagram
//
//  Created by Ernest Omondi on 7/12/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"

@interface profileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postPhotoView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end
