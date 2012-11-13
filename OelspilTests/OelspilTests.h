//
//  OelspilTests.h
//  OelspilTests
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AppDelegate.h"
#import "Oelspil.h"
@interface OelspilTests : SenTestCase
@property (strong, atomic) AppDelegate *delegate;
@property (strong, atomic) Oelspil *testGame;
@end
