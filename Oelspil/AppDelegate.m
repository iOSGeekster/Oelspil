//
//  AppDelegate.m
//  Oelspil
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "GameViewController.h"

#import "KategoriViewController.h"
#import "FavoriteListViewController.h"
#import "PlayersViewController.h"
#import "AboutViewController.h"
#import "Oelspil.h"
#import "AVFoundation/AVFoundation.h"
#import <iRate.h>
@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize oelspil,categories,favoriteList;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self initGames];
    [self customizeInterface];
    [self loadFavoriteList];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"nav-bar"];
    [[UINavigationBar appearance] setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    UIImage *buttonBackground = [[UIImage imageNamed:@"bar-button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, -2, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:buttonBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *backButtonBackground = [[UIImage imageNamed:@"back-button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, -2, 6)];

    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIViewController *gameViewController = [[GameViewController alloc] initWithNibName:@"GameView" bundle:nil];
    UINavigationController *navControllerForGameView = [[UINavigationController alloc] initWithRootViewController:gameViewController];
    UIViewController *kategoriViewController = [[KategoriViewController alloc] initWithNibName:@"KategoriView" bundle:nil];
    UINavigationController *navControllerForKategoriView = [[UINavigationController alloc] initWithRootViewController:kategoriViewController];
    
    UIViewController *favoriteViewController = [[FavoriteListViewController alloc] initWithNibName:@"FavoriteListView" bundle:nil];
    UINavigationController *navControllerForFavoriteView = [[UINavigationController alloc] initWithRootViewController:favoriteViewController];
    
    UIViewController *playersViewController = [[PlayersViewController alloc] initWithNibName:@"PlayersView" bundle:nil];
    UINavigationController *navControllerForPlayersView = [[UINavigationController alloc] initWithRootViewController:playersViewController];
    UIViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
    UINavigationController *navControllerForAboutView = [[UINavigationController alloc] initWithRootViewController:aboutView];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navControllerForGameView, navControllerForKategoriView, navControllerForFavoriteView, navControllerForPlayersView, navControllerForAboutView, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
//    [self playSound];
    
    [iRate sharedInstance].appStoreCountry = @"dk";
    [iRate sharedInstance].previewMode = YES;
    
    return YES;
}

/*- (void)playSound{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"beer" ofType:@"mp3"];
    NSLog(@"Path = %@", path);
    NSURL *soundFile = [NSURL fileURLWithPath:path];
    if (soundFile) {
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
        if([player prepareToPlay]){
            NSLog(@"play");
            [player play];
        }
    }
    
}*/

- (void)loadFavoriteList{
    NSString *favoriteFilePath = [self favoriteFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:favoriteFilePath]){
        favoriteList = [[NSMutableArray alloc] initWithContentsOfFile:favoriteFilePath];
    }else {
        favoriteList = [[NSMutableArray alloc] init];
    }
}

- (void)initGames{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Oelspil" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSDictionary *categoriesDict = [dict valueForKey:@"Oelspil"];
    categories = [[NSMutableArray alloc] init];
    self.oelspil = [[NSMutableArray alloc] init];
    [categories addObject:@"Alle"];
    for(id key in categoriesDict){
        NSDictionary *games = [categoriesDict valueForKey:key];
        NSString *category = key;
        [categories addObject:category];
        for (id key in games) {
            NSArray *array = [games valueForKey:key];
            NSString *title = [array objectAtIndex:0];
            NSNumber *diffNumber = [array objectAtIndex:1];            
            int difficulty = [diffNumber intValue];
            NSString *time = [array objectAtIndex:2];
            NSString *props = [array objectAtIndex:3];
            NSString *desc = [array objectAtIndex:4];
            NSNumber *maxPlayers = [array objectAtIndex:5];
            int max = [maxPlayers intValue];
            NSNumber *minPlayers = [array objectAtIndex:6];
            int min = [minPlayers intValue];
    
            Oelspil *spil = [[Oelspil alloc] initWithTitle:title difficulty:difficulty time:time props:props description:desc category:category minPlayers:min andMaxPlayers:max];
            [self.oelspil addObject:spil];
        }
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [self.oelspil sortUsingDescriptors:sortDescriptors];
    
    //TODO: Find another way to rearrange the categories to put "Andet" at the last position
    NSString *andet = [categories objectAtIndex:3];
    [categories replaceObjectAtIndex:3 withObject:[categories objectAtIndex:4]];
    [categories removeObjectAtIndex:4];
    [categories addObject:andet];
}

- (void)customizeInterface{
    _window.rootViewController.wantsFullScreenLayout = YES;
/*    UIColor *tangerineYellow = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:1.0];*/
    UIColor *leatherBrown = [UIColor colorWithRed:126.0/255.0 green:79.0/255.0 blue:51.0/255.0 alpha:1.0];
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = leatherBrown;
    [[UITableViewCell appearance] setSelectedBackgroundView:selectedBackgroundView];
    [[UISearchBar appearance] setTintColor:leatherBrown];
    
    [[UIPageControl appearance] setPageIndicatorTintColor:leatherBrown];
}

- (NSString *)favoriteFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFavoriteList];
}

- (void)addToFavoriteList:(Oelspil*)game{
    [favoriteList addObject:game.title];
    [favoriteList writeToFile:[self favoriteFilePath] atomically:YES];
    [self updateFavoriteBadge:[favoriteList count]];
}

- (void)saveFavoriteList{
    [favoriteList writeToFile:[self favoriteFilePath] atomically:YES];
}

- (void)removeFromFavoriteList:(NSString *)title{
    [favoriteList removeObject:title];
    [favoriteList writeToFile:[self favoriteFilePath] atomically:YES];
    [self updateFavoriteBadge:[favoriteList count]];
}

- (void)updateFavoriteBadge:(int)number{
    UINavigationController *controller = [self.tabBarController.viewControllers objectAtIndex:2];
    if (number == 0) {
        controller.tabBarItem.badgeValue = nil;
    } else {
        controller.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",number];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/
 
/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
