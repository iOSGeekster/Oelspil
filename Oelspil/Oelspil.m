//
//  Oelspil.m
//  Oelspil
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Oelspil.h"

@implementation Oelspil
@synthesize title,time,props,description,category,difficulty,minPlayers,maxPlayers;

- (id)initWithTitle:(NSString *)gameTitle difficulty:(int)gameDifficulty time:(NSString *)gameTime props:(NSString *)gameProps description:(NSString *)gameDescription category:(NSString *)gameCategory minPlayers:(int)gameMinPlayers andMaxPlayers:(int)gameMaxPlayers{
    self.title = gameTitle;
    self.difficulty = gameDifficulty;
    self.time = gameTime;
    self.props = gameProps;
    self.description = gameDescription;
    self.category = gameCategory;
    self.minPlayers = gameMinPlayers;
    self.maxPlayers = gameMaxPlayers;
    return self;
}
@end
