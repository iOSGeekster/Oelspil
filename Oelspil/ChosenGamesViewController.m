//
//  ChosenCategoryViewController.m
//  Oelspil
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ChosenGamesViewController.h"
#import "AppDelegate.h"
#import "Oelspil.h"
#import "GameViewController.h"

@implementation ChosenGamesViewController
@synthesize games;
@synthesize selectedCategory;
@synthesize numberOfPlayers;
@synthesize gamesTableView;
@synthesize searchResults;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCategory:(NSString *)category{
    selectedCategory = category;
    return self;
}

- (id)initWithNumberOfPlayers:(NSInteger)players{
    numberOfPlayers = players;
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UITable methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
    if (tableView == [[self searchDisplayController] searchResultsTableView]) {
        Oelspil *spil = [searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = spil.title;
    }else{
        Oelspil *spil = [games objectAtIndex:indexPath.row];
        cell.textLabel.text = spil.title;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == [[self searchDisplayController] searchResultsTableView]) {
        return [self.searchResults count];
    }
    return [games count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Oelspil *valgtSpil = nil;
    if (tableView == [[self searchDisplayController] searchResultsTableView]) {
        valgtSpil = [searchResults objectAtIndex:indexPath.row];
    }else{
        valgtSpil = [games objectAtIndex:indexPath.row];
    }
    GameViewController *controller = [[GameViewController alloc] initWithOelspil:valgtSpil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:controller animated:YES];    
}

#pragma mark Search Delegate methods


- (void)handleSearchForTerm:(NSString *)searchTerm andScope:(NSString* )scope{
    if (self.searchResults == nil) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [self setSearchResults:array];
    }
    [self.searchResults removeAllObjects];
    
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"SELF.title contains[c] %@",searchTerm];
    self.searchResults = [NSMutableArray arrayWithArray:[self.games filteredArrayUsingPredicate:titlePredicate]];

    if (![scope isEqualToString:@"Alle"]) {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@",scope];
        [self.searchResults filterUsingPredicate:scopePredicate];
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self handleSearchForTerm:searchString andScope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self handleSearchForTerm:self.searchDisplayController.searchBar.text andScope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    [self.gamesTableView reloadData];
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    self.searchDisplayController.searchBar.showsCancelButton = YES;
    UIButton *cancelButton = nil;
    for (UIView *subView in self.searchDisplayController.searchBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UIButton")]) {
            cancelButton = (UIButton*)subView;
        }
    }
    [cancelButton setTitle:@"Annuller" forState:UIControlStateNormal];
}

- (IBAction)searchButtonPressed:(id)sender{
    [self.searchDisplayController.searchBar becomeFirstResponder];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchDisplayController.searchBar setShowsScopeBar:NO];
    [self.searchDisplayController.searchBar sizeToFit];
    
    self.navigationItem.title = selectedCategory;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    games = [[NSMutableArray alloc] init];
    NSArray *allGames = appDelegate.oelspil;
    if (selectedCategory != nil) {
        if ([selectedCategory isEqualToString:@"Alle"]) {
            [games addObjectsFromArray:allGames];
        }else{
            for (Oelspil *spil in allGames) {
                if ([spil.category isEqualToString:selectedCategory]) {
                    [games addObject:spil];
                }
            }
        }
    }else if(numberOfPlayers != 0){
        for (Oelspil *spil in allGames) {
            if ((self.numberOfPlayers == 7) && (self.numberOfPlayers >= spil.minPlayers)) {
                [games addObject:spil];
            }else if ((self.numberOfPlayers >= spil.minPlayers) && (self.numberOfPlayers <= spil.maxPlayers)){
                [games addObject:spil];
            }
        }
    }
    self.searchDisplayController.searchBar.placeholder = NSLocalizedString(@"Søg", nil);
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonPressed:)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    [self.gamesTableView reloadData];
    [self setSearchResults:nil];
    
    CGRect newBounds = self.gamesTableView.bounds;
    newBounds.origin.y = newBounds.origin.y + self.searchDisplayController.searchBar.bounds.size.height;
    self.gamesTableView.bounds = newBounds;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
