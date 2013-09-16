//
//  GameRuleViewController.m
//  Oelspil
//
//  Created by Jesper Nielsen on 16/09/13.
//
//

#import "GameRuleViewController.h"

@interface GameRuleViewController ()
@property (nonatomic, strong) NSString *gameTitle;
@property (nonatomic, strong) NSString *gameDescription;
@end

@implementation GameRuleViewController
@synthesize ruleView, gameDescription, gameTitle, navBar;
- (id)initWithTitle:(NSString *)title andDescription:(NSString *)description{
    self = [super init];
    if (self) {
        self.gameTitle = title;
        self.gameDescription = description;
    }
    return self;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navBar.topItem.title = self.gameTitle;
    ruleView.text = self.gameDescription;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)okButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
