//
//  FavoriteListViewController.h
//  Oelspil
//
//  Created by Jesper Nielsen on 10/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *favoriteListTable;
@property (strong, nonatomic) NSMutableArray *favoriteList;
@end
