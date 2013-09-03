//
//  SelectedCategoryViewController.m
//  Oelspil
//
//  Created by Jesper Nielsen on 03/09/13.
//
//

#import "SelectedCategoryViewController.h"
#import "Oelspil.h"
#import "GameViewController.h"
#import "AppDelegate.h"
@interface SelectedCategoryViewController ()

@end

@implementation SelectedCategoryViewController
@synthesize games;
@synthesize selectedCategory;
@synthesize numberOfPlayers;
@synthesize gamesTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCategory:(NSString *)category{
    self = [super init];
    if (self) {
        selectedCategory = category;
    }
    return self;
}

- (id)initWithNumberOfPlayers:(NSInteger)players{
    self = [super init];
    if (self) {
        numberOfPlayers = players;
    }
    return self;
}

#pragma mark - UITable methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
//    if (tableView == [[self searchDisplayController] searchResultsTableView]) {
//        Oelspil *spil = [searchResults objectAtIndex:indexPath.row];
//        cell.textLabel.text = spil.title;
//    }else{
        Oelspil *spil = [games objectAtIndex:indexPath.row];
        cell.textLabel.text = spil.title;
//    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if (tableView == [[self searchDisplayController] searchResultsTableView]) {
    //        return [self.searchResults count];
    //    }
    return [games count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Oelspil *valgtSpil = nil;
//    if (tableView == [[self searchDisplayController] searchResultsTableView]) {
//        valgtSpil = [searchResults objectAtIndex:indexPath.row];
//    }else{
        valgtSpil = [games objectAtIndex:indexPath.row];
//    }
    GameViewController *controller = [[GameViewController alloc] initWithOelspil:valgtSpil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    /*    [self.searchDisplayController.searchBar setShowsScopeBar:NO];
     [self.searchDisplayController.searchBar sizeToFit];*/
    
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
    //    self.searchDisplayController.searchBar.placeholder = NSLocalizedString(@"Søg", nil);
    
    //    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonPressed:)];
    //    self.navigationItem.rightBarButtonItem = searchButton;
    
    [self.gamesTableView reloadData];
    //    [self setSearchResults:nil];
    
    //    CGRect newBounds = self.gamesTableView.bounds;
    //    newBounds.origin.y = newBounds.origin.y + self.searchDisplayController.searchBar.bounds.size.height;
    //    self.gamesTableView.bounds = newBounds;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
