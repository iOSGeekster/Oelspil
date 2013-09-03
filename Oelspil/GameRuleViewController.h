//
//  GameRuleViewController.h
//  Oelspil
//
//  Created by Jesper Nielsen on 03/09/13.
//
//

#import <UIKit/UIKit.h>

@interface GameRuleViewController : UIViewController
@property (nonatomic,strong) NSString *gameTitle;
@property (nonatomic,strong) NSString *gameDescription;
@property (nonatomic,strong) IBOutlet UITextView *gameRules;
@property (nonatomic,strong) IBOutlet UINavigationBar *navBar;
- (id)initWithTitle:(NSString *)title andDescription:(NSString *)description;
@end
