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
#define kDescriptionTextView 666
@implementation GameViewController
@synthesize titleLabel;
@synthesize valgtSpil;
@synthesize descriptionTextView;
@synthesize timeLabel;
@synthesize propLabel;
@synthesize deltagerLabel;
@synthesize diff1Image;
@synthesize diff2Image;
@synthesize diff3Image;
@synthesize diff4Image;
@synthesize diff5Image;
@synthesize pageControl;
@synthesize scrollView;

@interface GameViewController (PrivateMethods)
- (IBAction)pageChanged;
- (void)moreOptions;
- (void)addGameAsFavorite:(Oelspil*)game;

@end
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
    switch (valgtSpil.difficulty) {
        case 1:
            self.diff1Image.hidden = NO;
            self.diff2Image.hidden = YES;
            self.diff3Image.hidden = YES;
            self.diff4Image.hidden = YES;
            self.diff5Image.hidden = YES;
            break;
        case 2:
            self.diff1Image.hidden = NO;
            self.diff2Image.hidden = NO;
            self.diff3Image.hidden = YES;
            self.diff4Image.hidden = YES;
            self.diff5Image.hidden = YES;
            break;
        case 3:
            self.diff1Image.hidden = NO;
            self.diff2Image.hidden = NO;
            self.diff3Image.hidden = NO;
            self.diff4Image.hidden = YES;
            self.diff5Image.hidden = YES;
            break;
        case 4:
            self.diff1Image.hidden = NO;
            self.diff2Image.hidden = NO;
            self.diff3Image.hidden = NO;            
            self.diff4Image.hidden = NO;
            self.diff5Image.hidden = YES;
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
    
    self.navigationItem.title = valgtSpil.title;
    self.descriptionTextView.text = valgtSpil.description;
    UITextView *textView = (UITextView*)[self.scrollView viewWithTag:kDescriptionTextView];
    textView.text = valgtSpil.description;
    self.titleLabel.text = valgtSpil.title;
    self.timeLabel.text = valgtSpil.time;
    self.propLabel.text = valgtSpil.props;
    if(valgtSpil.maxPlayers == 999){
        self.deltagerLabel.text = [NSString stringWithFormat:@"%d - ? spillere", valgtSpil.minPlayers, valgtSpil.maxPlayers];
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

- (void)moreOptions{
    UIActionSheet *optionsSheet = [[UIActionSheet alloc] initWithTitle:@"Muligheder" delegate:self cancelButtonTitle:@"Annuller" destructiveButtonTitle:nil otherButtonTitles:@"Tilføj som favorit", @"Del via E-mail", nil];
    [optionsSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

- (void)viewDidLoad
{
    pageControlBeingUsed = NO;
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if(valgtSpil == nil && [appDelegate.oelspil count] > 0){
        UIBarButtonItem *nyKnap = [[UIBarButtonItem alloc] initWithTitle:@"Tilfældig" style:UIBarButtonItemStyleBordered target:self action:@selector(pickRandom)];
        self.navigationItem.leftBarButtonItem = nyKnap;
        
        int count = [appDelegate.oelspil count];
        int randomNumber = arc4random() % count;
        valgtSpil = [appDelegate.oelspil objectAtIndex:randomNumber];
    }

    UIBarButtonItem *optionsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"star-white"] landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(moreOptions)];

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
/*    textView.layer.borderWidth = 2.0f;
    textView.layer.cornerRadius = 10;
    textView.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0] CGColor];*/
    [self.scrollView addSubview:textView];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self updateView];
}

#pragma mark Actionsheet method
-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [self addGameAsFavorite:valgtSpil];
    } else{
        if(buttonIndex == 1){
            MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
            [mailController setSubject:@"Ølspil"];
            NSString *mailText = [NSString stringWithFormat:@"%@\n\nRekvisitter: %@\n\nVarighed: %@\n\nBeskrivelse: %@",valgtSpil.title, valgtSpil.props,valgtSpil.time, valgtSpil.description];
        
            [mailController setMessageBody:mailText isHTML:NO];
            mailController.mailComposeDelegate = self;
            [self presentModalViewController:mailController animated:YES];
        }
    }
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

#pragma mark MFMailCompose methods
-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView new] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    switch (result) {
    case MessageComposeResultSent:
        alertView.title = NSLocalizedString(@"Sendt", nil);
        alertView.message = NSLocalizedString(@"Mailen blev sendt", nil);
        [alertView show];
        break;
    case MessageComposeResultFailed:
        alertView.title = NSLocalizedString(@"Fejl", nil);
        alertView.message = NSLocalizedString(@"Kunne ikke sende mail", nil);
        [alertView show];
    default:
        break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setDescriptionTextView:nil];
    [self setTitleLabel:nil];
    [self setTimeLabel:nil];
    [self setPropLabel:nil];
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
