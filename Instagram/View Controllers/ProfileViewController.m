//
//  ProfileViewController.m
//  Instagram
//
//  Created by Ernest Omondi on 7/11/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse.h"
#import "Post.h"
#import "ParseUI.h"
#import "profileTableViewCell.h"


@interface ProfileViewController ()
@property (strong, nonatomic) PFUser *currUser;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    // get current users username, profile pic and bio
    self.currUser = [PFUser currentUser];
    self.usernameLabel.text = self.currUser.username;
    self.bioLabel.text = self.currUser[@"bio"];
    
    // set image for profile pic
    PFFile* file = self.currUser[@"profilePic"];
    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if(error == nil)
        {
            [self.profilePhotoView setImage:[UIImage imageWithData:data]];
        }
    }];
    
    //fetch posts for the current user
    [self fetchPosts];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) fetchPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    // sort by descending order
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    
    //fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray * posts, NSError * _Nullable error) {
        if(posts != nil){
            // do something with the array of object returned
            self.postsArray = posts;
        }
        else{
            NSLog(@"%@", error.localizedDescription);
        }
        [self.tableview reloadData];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    EditProfileViewController *editVC = [segue destinationViewController];
    // Set the block property of editVC as a block that you define here that will be called at some point by the editVC
    [editVC setSendPicAndBioBlock:^(UIImage *newImage, NSString *newBio) {
        self.profilePhotoView.image = newImage;
        self.bioLabel.text = newBio;
        
        // Add a profile and bio property to the currentUser object of PFUser
        PFFile *file = [PFFile fileWithName:@"profilePic.png" data:UIImagePNGRepresentation(newImage)];
        self.currUser[@"profilePic"] = file;
        self.currUser[@"bio"] = newBio;
        
        // save the currentUser in background on the Parse server
        [self.currUser saveInBackground];
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    profileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
    Post *post = self.postsArray[indexPath.row];
    
    // set the caption of the photo
    cell.captionLabel.text = post.caption;
    
    // set file property of the cell's image view to the one from the post
    cell.postPhotoView.file = post.image;
    [cell.postPhotoView loadInBackground];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

@end
