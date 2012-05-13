//
//  FavoriteListViewController.m
//  Oelspil
//
//  Created by Jesper Nielsen on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteListViewController.h"
#import "AppDelegate.h"
#import "GameViewController.h"
@interface FavoriteListViewController ()
- (void)editFavorites;
@end

@implementation FavoriteListViewController
@synthesize favoriteList,favoriteListTable;

#pragma mark UITableView methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *selectedTitle = [self.favoriteList objectAtIndex:indexPath.row];
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    Oelspil *selectedGame = nil;
    for (Oelspil *game in delegate.oelspil) {
        if ([game.title isEqualToString:selectedTitle]) {
            selectedGame = game;
        }
    }
    GameViewController *gameView = [[GameViewController alloc] initWithOelspil:selectedGame];
    [self.navigationController pushViewController:gameView animated:YES];
    [self.favoriteListTable deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [favoriteList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
    NSString *title = [favoriteList objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        NSString *titleToBeRemoved = [favoriteList objectAtIndex:indexPath.row];
        [delegate removeFromFavoriteList:titleToBeRemoved];
        [favoriteListTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    if ([favoriteList count] == 0 ) {
        self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleBordered;
        self.navigationItem.rightBarButtonItem.title = @"Rediger";
        self.favoriteListTable.editing = NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *titleToMove = [self.favoriteList objectAtIndex:sourceIndexPath.row];
    [self.favoriteList removeObjectAtIndex:sourceIndexPath.row];
    [self.favoriteList insertObject:titleToMove atIndex:destinationIndexPath.row];
    
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate saveFavoriteList];
    
}


- (void)editFavorites{
    [self.favoriteListTable setEditing:!self.favoriteListTable.editing animated:YES];
    if (self.favoriteListTable.editing) {
        self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
        self.navigationItem.rightBarButtonItem.title = @"OK";
    }else {
        self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleBordered;
        self.navigationItem.rightBarButtonItem.title = @"Rediger";
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Favoritter", @"Favoritter");
        self.tabBarItem.image = [UIImage imageNamed:@"star-grey"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.favoriteList = delegate.favoriteList;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.favoriteListTable reloadData];
    if ([self.favoriteList count] > 0) {
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Rediger" style:UIBarButtonItemStyleBordered target:self action:@selector(editFavorites)];
        self.navigationItem.rightBarButtonItem = editButton;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.favoriteListTable = nil;
    self.favoriteList = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
