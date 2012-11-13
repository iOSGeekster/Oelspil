//
//  OelspilTests.m
//  OelspilTests
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OelspilTests.h"
#import "AppDelegate.h"
#import "GameViewController.h"
#import "Oelspil.h"

@implementation OelspilTests

- (void)setUp
{
    [super setUp];
    NSLog(@"Setup");
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.testGame = [[Oelspil alloc] initWithTitle:@"TestGame" difficulty:5 time:@"1 minute" props:@"None" description:@"Test game" category:@"Kort" minPlayers:1 andMaxPlayers:1];

    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    NSLog(@"tear down");
    [self.delegate.favoriteList removeObject:@"TestGame"];
    [self.delegate saveFavoriteList];
    [super tearDown];
}

/*- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in OelspilTests");
}*/

- (void)testWhenPressingFavoriteGameShouldBeAdded{
    GameViewController *gameController = [[GameViewController alloc] init];
    [gameController addGameAsFavorite:self.testGame];
    
    NSMutableArray *favoriteList = self.delegate.favoriteList;
    
    STAssertTrue([favoriteList containsObject:@"TestGame"], @"Favorite list should contain game");
    
}

- (void)testBadgeNumberShouldBeUpdated{
    UINavigationController *controller = [self.delegate.tabBarController.viewControllers objectAtIndex:2];
    int firstNumber = [controller.tabBarItem.badgeValue intValue];
    
    GameViewController *gameController = [[GameViewController alloc] init];
    [gameController addGameAsFavorite:self.testGame];
    
    int secondNumber = [controller.tabBarItem.badgeValue intValue];
    NSLog(@"First number: %d", firstNumber);
    NSLog(@"Second number: %d", secondNumber);
    STAssertTrue(secondNumber == (firstNumber+1), @"Badgevalue should be incremented with 1");
    
    
}

- (void)testFavoriteListShouldBeWrittenInFile{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    GameViewController *gameController = [[GameViewController alloc] init];
    [gameController addGameAsFavorite:self.testGame];
    [delegate loadFavoriteList];
    NSMutableArray *list = delegate.favoriteList;
    STAssertTrue([list containsObject:@"TestGame"], @"List loaded from file should contain added game");
}

@end
