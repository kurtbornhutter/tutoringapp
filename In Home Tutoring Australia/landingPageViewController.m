//
//  landingPageViewController.m
//  In Home Tutoring Australia
//
//  Created by Kurt Bornhutter on 24/06/2014.
//  Copyright (c) 2014 kurt. All rights reserved.
//

#import "landingPageViewController.h"

@interface landingPageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@end

@implementation landingPageViewController

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
    userObject *usrObj = [userObject getInstance];
    
    [self.userLabel setText : usrObj.currentUser];
    int64_t delayInSeconds = 3.6;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        tutorViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorPage"];
        [self presentViewController:monitorMenuViewController animated:YES completion:nil];
            });
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
