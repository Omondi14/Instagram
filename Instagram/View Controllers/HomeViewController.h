//
//  HomeViewController.h
//  Instagram
//
//  Created by Ernest Omondi on 7/9/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIImage *Image;
@end
