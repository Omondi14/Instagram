//
//  ComposeViewController.m
//  Instagram
//
//  Created by Ernest Omondi on 7/9/18.
//  Copyright © 2018 Ernest Omondi. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"

@interface ComposeViewController () 
@property (weak, nonatomic) IBOutlet UIImageView *composeImageView;
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (strong, nonatomic) UIImage *instaImage;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Post a photo to Instagram!" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:imagePickerVC animated:YES completion:nil];
            
        }];
        
        UIAlertAction *actionGallery = [UIAlertAction actionWithTitle:@"Choose Photo from Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:imagePickerVC animated:YES completion:nil];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:actionCamera];
        [alert addAction:actionGallery];
        [alert addAction:cancel];
        
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Post a photo to Instagram!" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        UIAlertAction *actionGallery = [UIAlertAction actionWithTitle:@"Choose Photo from Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:imagePickerVC animated:YES completion:nil];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:actionGallery];
        [alert addAction:cancel];
        
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // resize image to be 10mb
    self.instaImage = [self resizeImage:originalImage withSize:CGSizeMake(1024, 768)];
    
    // Do something with the images (based on your use case)
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:^{
        [self.composeImageView setImage:self.instaImage];
    }];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)didTapShare:(id)sender {
    // show progressHUD
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // get caption text
    NSString *captionText = self.composeTextView.text;
    // create a post for the current user using the post class
    [Post postUserImage:self.instaImage withCaption:captionText withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Posting photo failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User posted photo and caption successfully!");
            [self dismissViewControllerAnimated:YES completion:nil];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

- (IBAction)didTapCancel:(id)sender {
    // dismiss the view controller
    [self dismissViewControllerAnimated:YES completion:nil];
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
        
