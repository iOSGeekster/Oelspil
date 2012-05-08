//
//  AboutViewController.h
//  Oelspil
//
//  Created by Jesper Nielsen on 26/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MessageUI.h"

@interface AboutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableViewCell *contactCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *copyrightCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *baseretCell;
@end
