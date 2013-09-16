//
//  FirstViewController.m
//  Oelspil
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "AppDelegate.h"
#import "Oelspil.h"
#import "FavoriteActivity.h"
#import "GameRuleViewController.h"
#define kDescriptionTextView 666
@implementation GameViewController


@synthesize titleLabel;
@synthesize valgtSpil;
@synthesize descriptionTextView;
@synthesize timeText;
@synthesize propText;
@synthesize deltagerLabel;
@synthesize diff1Image;
@synthesize diff2Image;
@synthesize diff3Image;
@synthesize diff4Image;
@synthesize diff5Image;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Tilfældig", @"Tilfældig");
        self.tabBarItem.image = [UIImage imageNamed:@"beer-mug"];
    }
    return self;
}

- (id)initWithOelspil:(Oelspil *)spil{

    self = [super init];
    if (self) {
        valgtSpil = spil;
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)updateView{
    [self prepareForAnimation];
    [self animateBeerGlasses];
    
    self.navigationItem.title = valgtSpil.title;
    self.descriptionTextView.text = valgtSpil.description;

    self.titleLabel.text = valgtSpil.title;
    self.timeText.text = valgtSpil.time;
    self.propText.text = valgtSpil.props;
    if(valgtSpil.maxPlayers == 999){
        self.deltagerLabel.text = [NSString stringWithFormat:@"%d - ? spillere", valgtSpil.minPlayers];
    }else if(valgtSpil.minPlayers == valgtSpil.maxPlayers){
        self.deltagerLabel.text = [NSString stringWithFormat:@"%d spillere", valgtSpil.minPlayers];
    }else {
        self.deltagerLabel.text = [NSString stringWithFormat:@"%d - %d spillere", valgtSpil.minPlayers, valgtSpil.maxPlayers];
    }
}

- (void)pickRandom{
    [self stopAnimations];
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    int count = [appDelegate.oelspil count];
    int randomNumber = arc4random() % count;
    Oelspil *nytSpil = [appDelegate.oelspil objectAtIndex:randomNumber];
    if([valgtSpil.title isEqualToString:nytSpil.title]){
        [self pickRandom];
        return;
    }
    valgtSpil = nytSpil;
    [self updateView];
}

- (void)showShareMenu{
    NSString *concatTitle = [NSString stringWithFormat:@"Ølspillet: %@\n\n%@",valgtSpil.title,valgtSpil.description];
    FavoriteActivity *customActivity = [[FavoriteActivity alloc] initWithViewController:self];
    __block UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[concatTitle, valgtSpil] applicationActivities:@[customActivity]];
    activityController.excludedActivityTypes = @[ UIActivityTypePostToWeibo,
    UIActivityTypePostToTwitter,
    UIActivityTypeAssignToContact];
    [self presentViewController:activityController animated:YES completion:^{
        activityController.excludedActivityTypes = nil;
        activityController = nil;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if(valgtSpil == nil && [appDelegate.oelspil count] > 0){
        UIBarButtonItem *nyKnap = [[UIBarButtonItem alloc] initWithTitle:@"Ny Tilfældig" style:UIBarButtonItemStyleBordered target:self action:@selector(pickRandom)];
        self.navigationItem.leftBarButtonItem = nyKnap;
        
        int count = [appDelegate.oelspil count];
        int randomNumber = arc4random() % count;
        valgtSpil = [appDelegate.oelspil objectAtIndex:randomNumber];
    }

    UIBarButtonItem *optionsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showShareMenu)];

    self.navigationItem.rightBarButtonItem = optionsButton;
    
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Default.png"]];

    CGRect frame;

    UITextView *textView = [[UITextView alloc]initWithFrame:frame];
    textView.backgroundColor = [UIColor clearColor];
    textView.tag = kDescriptionTextView;
    textView.editable = NO;
    textView.showsVerticalScrollIndicator = YES;
    textView.font = [UIFont fontWithName:@"Georgia" size:16.0];
    
    self.propText.backgroundColor = [UIColor clearColor];
    self.timeText.backgroundColor = [UIColor clearColor];
    
    [self updateView];
}

- (void)addGameAsFavorite:(Oelspil*)game{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([delegate.favoriteList containsObject:game.title]){
        UIAlertView *alreadySavedAlert = [[UIAlertView alloc] initWithTitle:@"Allerede favorit" message:@"Dette spil er allerede på favoritlisten" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
        [alreadySavedAlert show];
    }else{
        [delegate addToFavoriteList:game];
    }
}

- (void)viewDidUnload
{
    [self setDescriptionTextView:nil];
    [self setTitleLabel:nil];
    [self setTimeText:nil];
    [self setPropText:nil];
    [self setDiff1Image:nil];
    [self setDiff2Image:nil];
    [self setDiff3Image:nil];
    [self setDiff4Image:nil];
    [self setDiff5Image:nil];
    [self setDeltagerLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Animation Methods

- (void)prepareForAnimation{
    self.diff1Image.hidden = YES;
    self.diff2Image.hidden = YES;
    self.diff3Image.hidden = YES;
    self.diff4Image.hidden = YES;
    self.diff5Image.hidden = YES;
}

- (void)animateBeerGlasses{
    self.diff1Image.hidden = NO;
    self.diff1Image.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // animate it to the identity transform (100% scale)
        diff1Image.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        if (finished && self.valgtSpil.difficulty >= 2) {
            self.diff2Image.hidden = NO;
            self.diff2Image.transform = CGAffineTransformMakeScale(0.01, 0.01);
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                // animate it to the identity transform (100% scale)
                diff2Image.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (finished && self.valgtSpil.difficulty >= 3) {
                    self.diff3Image.hidden = NO;
                    self.diff3Image.transform = CGAffineTransformMakeScale(0.01, 0.01);
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        // animate it to the identity transform (100% scale)
                        diff3Image.transform = CGAffineTransformIdentity;
                    } completion:^(BOOL finished){
                        if (finished && self.valgtSpil.difficulty >= 4) {
                            self.diff4Image.hidden = NO;
                            self.diff4Image.transform = CGAffineTransformMakeScale(0.01, 0.01);
                            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                                // animate it to the identity transform (100% scale)
                                diff4Image.transform = CGAffineTransformIdentity;
                            } completion:^(BOOL finished){
                                if (finished && self.valgtSpil.difficulty == 5) {
                                    self.diff5Image.hidden = NO;
                                    self.diff5Image.transform = CGAffineTransformMakeScale(0.01, 0.01);
                                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                                        // animate it to the identity transform (100% scale)
                                        diff5Image.transform = CGAffineTransformIdentity;
                                    } completion:^(BOOL finished){
                                        // if you want to do something once the animation finishes, put it here
                                    }];

                                }
                                
                            }];

                        }
                        
                    }];

                }
            }];

        }
    }];
}

- (void)stopAnimations{
    [self.view.layer removeAllAnimations];
}

- (IBAction)showRules:(id)sender{
    GameRuleViewController *ruleController = [[GameRuleViewController alloc] initWithTitle:self.valgtSpil.title andDescription:self.valgtSpil.description];
    [self presentViewController:ruleController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
