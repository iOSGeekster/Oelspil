//
//  ChosenCategoryViewController.h
//  Oelspil
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface ChosenGamesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate,UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray *games;
@property (strong, nonatomic) NSString *selectedCategory;
@property (nonatomic) NSInteger numberOfPlayers;
@property (strong, nonatomic) IBOutlet UITableView *gamesTableView;
@property (strong, nonatomic) NSMutableArray *searchResults;
- (id)initWithCategory:(NSString *)category;
- (id)initWithNumberOfPlayers:(NSInteger)players;
- (void)handleSearchForTerm:(NSString *)searchTerm;
@end
