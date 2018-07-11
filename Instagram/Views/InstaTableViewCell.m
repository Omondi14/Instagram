//
//  InstaTableViewCell.m
//  Instagram
//
//  Created by Ernest Omondi on 7/10/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import "InstaTableViewCell.h"
#import "Post.h"


@implementation InstaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showPhoto:(Post *)post {
    self.mainPhotoView.file = post.image;
    [self.mainPhotoView loadInBackground];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
