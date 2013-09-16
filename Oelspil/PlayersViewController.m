//
//  PlayersViewController.m
//  Oelspil
//
//  Created by Jesper Nielsen on 22/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayersViewController.h"
#import "SelectedCategoryViewController.h"
@implementation PlayersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Antal spillere", @"Antal spillere");
        self.tabBarItem.image = [UIImage imageNamed:@"group"];
    }
    return self;
}

#pragma mark - Table view methods

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
    if (indexPath.row < 5) {
        cell.textLabel.text = [NSString stringWithFormat:@"%d spillere",indexPath.row+2];
    }else{
        cell.textLabel.text = @"6+ spillere";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger selectedNumber = indexPath.row;
    SelectedCategoryViewController *selectedCategoryController = [[SelectedCategoryViewController alloc] initWithNumberOfPlayers:selectedNumber+2];
    [self.navigationController pushViewController:selectedCategoryController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
