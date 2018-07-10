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

@interface HomeViewController () 
@property (strong, nonatomic) NSArray *postsArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) fetchPostsData{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.postsArray = posts;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)onTapLogOut:(id)sender {
    [self logOut];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)didTapCamera:(id)sender {
    [self performSegueWithIdentifier:@"CameraSegue" sender:nil];
}

- (void) logOut {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        NSLog(@"Logged Out Successfully");
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *composeNavC = [segue destinationViewController];
}



@end
