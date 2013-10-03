//
//  DetailViewController.h
//  AutoLayout iOS
//
//  Created by BJ Homer on 10/2/13.
//  Copyright (c) 2013 BJ Homer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
