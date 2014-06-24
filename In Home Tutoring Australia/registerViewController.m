//
//  registerViewController.m
//  In Home Tutoring Australia
//
//  Created by Kurt Bornhutter on 23/06/2014.
//  Copyright (c) 2014 kurt. All rights reserved.
//

#import "registerViewController.h"

@interface registerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pass;

@property (strong, nonatomic) IBOutlet UITextField *passRetype;
@property (strong, nonatomic) IBOutlet UITextField *first;
@property (strong, nonatomic) IBOutlet UITextField *last;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *suburb;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *mobileno;
@property (weak, nonatomic) IBOutlet UISwitch *parentSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *studentSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *tutorSwitch;


@end

@implementation registerViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)cancelButton:(id)sender {
    frontPageViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"frontPage"];
    [self presentViewController:monitorMenuViewController animated:YES completion:nil];
}
- (IBAction)registerAttempt:(id)sender {
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center=self.view.center;
    
    [activityView startAnimating];
    
    [self.view addSubview:activityView];
    PFObject *newUser = [PFObject objectWithClassName:@"Users"];
    newUser[@"user"] = (!_user.text || _user.text.length == 0) ? @"none provided" : _user.text;
    newUser[@"pass"] = (!_pass.text || _pass.text.length == 0) ? @"none provided" : _pass.text;
    newUser[@"first"] = (!_first.text || _first.text.length == 0) ? @"none provided" : _first.text;
    newUser[@"last"] = (!_last.text || _last.text.length == 0) ? @"none provided" : _last.text;
    newUser[@"address"] = (!_address.text || _address.text.length == 0) ? @"none provided" : _address.text;
    newUser[@"suburb"] = (!_suburb.text || _suburb.text.length == 0) ? @"none provided" : _suburb.text;
    newUser[@"email"] = (!_email.text || _email.text.length == 0) ? @"none provided" : _email.text;
    newUser[@"mobile"] = (!_mobileno.text || _mobileno.text.length == 0) ? @"none provided" : _mobileno.text;
    if (_parentSwitch.isOn) {
        newUser[@"type"] = @"Parent";
    } else if (_studentSwitch.isOn) {
        newUser[@"type"] = @"Student";
    } else if (_tutorSwitch.isOn) {
        newUser[@"type"] = @"Tutor";
    }
    
    if ([_pass.text isEqualToString: _passRetype.text] && _pass.text && _passRetype && _pass.text.length>0) {
        if (!_parentSwitch.isOn && !_studentSwitch.isOn && !_tutorSwitch.isOn) {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete"
                                                            message:@"Please indicate whether you're a Parent, Student or Tutor"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        } else if (_user.text && _first.text && _last.text && _last.text && _address.text && _suburb.text && _email.text && _mobileno.text && _user.text.length>0 && _first.text.length>0 && _last.text.length>0 && _last.text.length>0 && _address.text.length>0 && _suburb.text.length>0 && _email.text.length>0 && _mobileno.text.length>0) {
            [newUser saveInBackground];
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Successful"
                                                            message:@"You are now able to Sign In"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        } else {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete Form"
                                                            message:@"Please fill out entire form"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    } else {
        [activityView stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Mismatch"
                                                       message:@"Please re-enter your password"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
-  (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    frontPageViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"frontPage"];
    [self presentViewController:monitorMenuViewController animated:YES completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Text Field Tage"
//                                                    message:[NSString stringWithFormat:@"%d", (int)textField.tag]
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSInteger currentTag = textField.tag;
    if (currentTag > 4) {
        [self animateTextField: textField up: YES];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger currentTag = textField.tag;
    if (currentTag > 4) {
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 180; // tweak as needed
    const float movementDuration = 0.8f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
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
