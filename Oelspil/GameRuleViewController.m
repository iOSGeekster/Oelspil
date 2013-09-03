//
//  GameRuleViewController.m
//  Oelspil
//
//  Created by Jesper Nielsen on 03/09/13.
//
//

#import "GameRuleViewController.h"

@interface GameRuleViewController ()

@end

@implementation GameRuleViewController
@synthesize gameTitle, gameDescription;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTitle:(NSString *)title andDescription:(NSString *)description{
    self = [super init];
    if (self) {
        self.gameTitle = title;
        self.gameDescription = description;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gameRules.text = gameDescription;
    self.navBar.topItem.title = gameTitle;
}

- (IBAction)okPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
