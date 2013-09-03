//
//  SelectedCategoryViewController.h
//  Oelspil
//
//  Created by Jesper Nielsen on 03/09/13.
//
//

#import <UIKit/UIKit.h>

@interface SelectedCategoryViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *games;
@property (strong, nonatomic) NSString *selectedCategory;
@property (nonatomic) NSInteger numberOfPlayers;
@property (strong, nonatomic) IBOutlet UITableView *gamesTableView;
- (id)initWithCategory:(NSString *)category;
- (id)initWithNumberOfPlayers:(NSInteger)players;

@end
