//
//  GameRuleViewController.h
//  Oelspil
//
//  Created by Jesper Nielsen on 16/09/13.
//
//

#import <UIKit/UIKit.h>

@interface GameRuleViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITextView *ruleView;
@property (nonatomic, strong) IBOutlet UINavigationBar *navBar;

- (id)initWithTitle:(NSString *)title andDescription:(NSString *)description;
- (IBAction)okButtonPressed:(id)sender;

@end
