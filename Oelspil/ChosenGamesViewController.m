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

- (void)handleSearchForTerm:(NSString *)searchTerm{
    if (self.searchResults == nil) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [self setSearchResults:array];
    }
    [self.searchResults removeAllObjects];
    
    for (Oelspil *currentSpil in games) {
        if ([currentSpil.title rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [self.searchResults addObject:currentSpil];
        }
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self handleSearchForTerm:searchString];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [self.gamesTableView reloadData];
    [self setSearchResults:nil];
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
