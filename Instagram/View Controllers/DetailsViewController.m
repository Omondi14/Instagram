//
//  DetailsViewController.m
//  Instagram
//
//  Created by Ernest Omondi on 7/11/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import "DetailsViewController.h"
#import "ParseUI.h"
#import "NSDate+DateTools.h"


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *detailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // show the image from the cell sent through the segue
    self.detailsImageView.file = self.post.image;
    [self.detailsImageView loadInBackground];
    
    // show the caption, username and timestamp of the selected cell
    PFUser *postAuthor = self.post.author;
    self.usernameLabel.text = postAuthor.username;
    self.captionLabel.text = self.post.caption;
    
    // show timestamp of post
    self.timestampLabel.text = self.post.createdAt.shortTimeAgoSinceNow;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
