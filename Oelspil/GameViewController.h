//
//  FirstViewController.h
//  Oelspil
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MessageUI.h"
#import "Oelspil.h"

@interface GameViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>{
    BOOL pageControlBeingUsed;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) Oelspil *valgtSpil;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UITextView *timeText;
@property (strong, nonatomic) IBOutlet UITextView *propText;
@property (strong, nonatomic) IBOutlet UILabel *deltagerLabel;
@property (strong, nonatomic) IBOutlet UIImageView *diff1Image;
@property (strong, nonatomic) IBOutlet UIImageView *diff2Image;
@property (strong, nonatomic) IBOutlet UIImageView *diff3Image;
@property (strong, nonatomic) IBOutlet UIImageView *diff4Image;
@property (strong, nonatomic) IBOutlet UIImageView *diff5Image;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (id)initWithOelspil:(Oelspil *)spil;
@end
