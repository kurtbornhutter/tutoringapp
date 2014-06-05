//
//  SquareItDetailViewController.h
//  In Home Tutoring Australia
//
//  Created by Kurt Bornhutter on 5/06/2014.
//  Copyright (c) 2014 kurt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareItDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
