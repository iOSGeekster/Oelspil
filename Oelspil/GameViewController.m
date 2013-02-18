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
@synthesize pageControl;
@synthesize scrollView;

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
    valgtSpil = spil;
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
    UITextView *textView = (UITextView*)[self.scrollView viewWithTag:kDescriptionTextView];
    textView.text = valgtSpil.description;
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
    [textView scrollRangeToVisible:NSMakeRange(0, 0)];
    [textView flashScrollIndicators];
}

- (void)pickRandom{
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
    pageControlBeingUsed = NO;
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

    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    self.scrollView.backgroundColor = [UIColor clearColor];
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width;
    frame.origin.y = 0;
    frame.size.width = self.scrollView.frame.size.width;
    frame.size.height = self.scrollView.frame.size.height - 36;
    UITextView *textView = [[UITextView alloc]initWithFrame:frame];
    textView.backgroundColor = [UIColor clearColor];
    textView.tag = kDescriptionTextView;
    textView.editable = NO;
    textView.showsVerticalScrollIndicator = YES;
    textView.font = [UIFont fontWithName:@"Georgia" size:16.0];
    
    self.propText.backgroundColor = [UIColor clearColor];
    self.timeText.backgroundColor = [UIColor clearColor];

    [self.scrollView addSubview:textView];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    CGRect pageControlSize = CGRectMake(0, (self.tabBarController.tabBar.frame.origin.y - self.tabBarController.tabBar.frame.size.height)- 50, 320, 36);
    self.pageControl.frame = pageControlSize;
    
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
    [self setPageControl:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark ScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!pageControlBeingUsed){
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
        UITextView *textView = (UITextView *)[self.scrollView viewWithTag:kDescriptionTextView];
        [textView flashScrollIndicators];
    }
}

- (IBAction)pageChanged{
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    pageControlBeingUsed = YES;
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
    switch (self.valgtSpil.difficulty) {
        case 1:
            self.diff1Image.hidden = NO;
            break;
        case 2:
            self.diff1Image.hidden = NO;
            self.diff2Image.hidden = NO;
            break;
        case 3:
            self.diff1Image.hidden = NO;
            self.diff2Image.hidden = NO;
            self.diff3Image.hidden = NO;
            break;
        case 4:
            self.diff1Image.hidden = NO;
            self.diff2Image.hidden = NO;
            self.diff3Image.hidden = NO;
            self.diff4Image.hidden = NO;
            break;
        case 5:
            self.diff1Image.hidden = NO;
            self.diff2Image.hidden = NO;
            self.diff3Image.hidden = NO;
            self.diff4Image.hidden = NO;
            self.diff5Image.hidden = NO;
            break;
        default:
            break;
    }
    
    CGPoint point = CGPointMake(self.view.bounds.size.width/2.0f, -50.0f);
    self.diff1Image.center = point;
    self.diff2Image.center = point;
    self.diff3Image.center = point;
    self.diff4Image.center = point;
    self.diff5Image.center = point;
    
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.diff1Image.center = CGPointMake(163.0f, 58.0f);
                
    }completion:nil];
    
    [UIView animateWithDuration:1.0f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.diff2Image.center = CGPointMake(197.0f, 58.0f);
        
    }completion:nil];
    
    [UIView animateWithDuration:1.0f delay:0.4f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.diff3Image.center = CGPointMake(231.0f, 58.0f);
        
    }completion:nil];
    
    [UIView animateWithDuration:1.0f delay:0.6f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.diff4Image.center = CGPointMake(265.0f, 58.0f);
        
    }completion:nil];
    
    [UIView animateWithDuration:1.0f delay:0.8f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.diff5Image.center = CGPointMake(299.0f, 58.0f);
        
    }completion:nil];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    pageControlBeingUsed = NO;
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
