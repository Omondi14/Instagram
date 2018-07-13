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
    
    // get current users username
    PFUser *current = [PFUser currentUser];
    self.usernameLabel.text = current.username;
    
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
    // Pass the selected object to the new view controller.
    editVC.delegate = self;
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


// delegate protocol method that provides access to edited bio and image
- (void)editedBioAndPic:(UIImage *)newProfilePic editedBio:(NSString *)newBio {
    self.bioLabel.text = newBio;
    self.profilePhotoView.image = newProfilePic;
}



@end
