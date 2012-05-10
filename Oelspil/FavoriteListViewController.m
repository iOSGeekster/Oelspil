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

@end

@implementation FavoriteListViewController
@synthesize favoriteList,favoriteListTable;

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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Favoritter", @"Favoritter");
        self.tabBarItem.image = [UIImage imageNamed:@"notepad"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.favoriteList = delegate.favoriteList;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
