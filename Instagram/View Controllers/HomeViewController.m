//
//  HomeViewController.m
//  Instagram
//
//  Created by Ernest Omondi on 7/9/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import "HomeViewController.h"
#import "Parse.h"
#import "ComposeViewController.h"
#import "InstaTableViewCell.h"
#import "Post.h"
#import "DetailsViewController.h"
#import "AppDelegate.h"

@interface HomeViewController () 
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *postsArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // call function to fetch posts
    [self fetchPosts];
    
    // refreshControl stuff
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) fetchPosts{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    // sort by descending order
    [query orderByDescending:@"createdAt"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.postsArray = posts;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];

    }];
    
}


- (IBAction)onTapLogOut:(id)sender {
    [self logOut];
    

}
- (IBAction)didTapCamera:(id)sender {
    [self performSegueWithIdentifier:@"CameraSegue" sender:nil];
}

- (void) logOut {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate logout];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailsSegue"])
    {
        // Get the new view controller using [segue destinationViewController].
        DetailsViewController *detailsVC = [segue destinationViewController];
        // Pass the selected object to the new view controller.
        InstaTableViewCell *cell = sender;
        NSIndexPath *cellPath = [self.tableView indexPathForCell:cell];
        detailsVC.post = self.postsArray[cellPath.row];
    }
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // dequeue reusable cell
    InstaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstaTableViewCell" forIndexPath:indexPath];
    
    // get specific post from your stored array of posts
    Post *post = self.postsArray[indexPath.row];
    // set the file property of the PFPhotoView to the one in the queried post
    cell.mainPhotoView.file = post.image;
    [cell.mainPhotoView loadInBackground];
    
    //set username label to author of the post
    PFUser *postAuthor = post.author;
    cell.usernameLabel.text = postAuthor.username;
    cell.captionLabel.text = post.caption;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}


@end
