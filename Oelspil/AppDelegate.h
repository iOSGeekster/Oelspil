//
//  AppDelegate.h
//  Oelspil
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) NSMutableArray *oelspil;

@property (strong, nonatomic) NSMutableArray *categories;

- (void)initGames;
- (void)customizeInterface;
//- (void)playSound;

@end
