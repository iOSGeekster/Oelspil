//
//  Oelspil.h
//  Oelspil
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Oelspil : NSObject
@property (strong, nonatomic) NSString *title;
@property (nonatomic) int difficulty;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *props;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *category;
@property (nonatomic) int minPlayers;
@property (nonatomic) int maxPlayers;

- (id)initWithTitle:(NSString*)gameTitle difficulty:(int)gameDifficulty time:(NSString*)gameTime props:(NSString*)gameProps description:(NSString *)gameDescription category:(NSString*)gameCategory  minPlayers:(int)gameMinPlayers andMaxPlayers:(int)gameMaxPlayers;

@end
