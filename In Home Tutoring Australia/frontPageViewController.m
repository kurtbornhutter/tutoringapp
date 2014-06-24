//
//  frontPageViewController.m
//  In Home Tutoring Australia
//
//  Created by Kurt Bornhutter on 23/06/2014.
//  Copyright (c) 2014 kurt. All rights reserved.
//

#import "frontPageViewController.h"

@interface frontPageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPass;

@end
NSArray *userpass;
static NSString *user;
NSString *pass;

@implementation frontPageViewController
- (IBAction)loginAttempt:(id)sender {
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center=self.view.center;
    
    [activityView startAnimating];
    
    [self.view addSubview:activityView];
    PFObject *Users = [PFObject objectWithClassName:@"Users"];
    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    //query.limit = 1;
    //[query whereKey:@"user" equalTo:@"kurt"];
    [query whereKey:@"user" equalTo:self.userName.text];
    [query whereKey:@"pass" equalTo:self.userPass.text];
    userpass = [query findObjects];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            // Correct user/pass
            if (count>0) {
                userObject *usrObj = [userObject getInstance];
                usrObj.currentUser = self.userName.text;
                usrObj.currentType = userpass.firstObject[@"type"];
                
                [activityView stopAnimating];
                landingPageViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"landingPage"];
                [self presentViewController:monitorMenuViewController animated:YES completion:nil];
            } else {
                // incorrect user/pass
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Incorrect Combination"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [activityView stopAnimating];
                [alert show];
            }
            NSLog(@"%d Users that Match Combination", count);
        } else {
            // The request failed
            NSLog(@"Query Failed User Auth");
        }
    }];
    
}
- (IBAction)cancelButton:(id)sender {
    landingPageViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"landingPage"];
    [self presentViewController:monitorMenuViewController animated:YES completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DB User List"
//                                                    message:[NSString stringWithFormat:@"%d", (int)nextTag]
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard and attempt login
        UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.center=self.view.center;
        
        [activityView startAnimating];
        
        [self.view addSubview:activityView];
        PFObject *Users = [PFObject objectWithClassName:@"Users"];
        PFQuery *query = [PFQuery queryWithClassName:@"Users"];
        //query.limit = 1;
        //[query whereKey:@"user" equalTo:@"kurt"];
        [query whereKey:@"user" equalTo:self.userName.text];
        [query whereKey:@"pass" equalTo:self.userPass.text];
        userpass = [query findObjects];
        [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
            if (!error) {
                // The count request succeeded. Log the count
                // Correct user/pass
                if (count>0) {
                    userObject *usrObj = [userObject getInstance];
                    usrObj.currentUser = self.userName.text;
                    [activityView stopAnimating];
                    landingPageViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"landingPage"];
                    [self presentViewController:monitorMenuViewController animated:YES completion:nil];
                } else {
                    // incorrect user/pass
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                    message:@"Incorrect Combination"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [activityView stopAnimating];
                    [alert show];
                }
                NSLog(@"%d Users that Match Combination", count);
            } else {
                // The request failed
                NSLog(@"Query Failed User Auth");
            }
        }];

        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}
- (IBAction)callNow:(id)sender {
    NSString *phNo = @"0447526130";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
//    testObject[@"user"] = @"kurt";
//    testObject[@"pass"] = @"pass";
//    [testObject saveInBackground];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
