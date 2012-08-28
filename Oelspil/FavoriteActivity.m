//
//  FavoriteActivity.m
//  Oelspil
//
//  Created by Jesper Nielsen on 28/08/12.
//
//

#import "FavoriteActivity.h"
#import "Oelspil.h"
@implementation FavoriteActivity

- (id)initWithViewController:(GameViewController*)controller andGame:(Oelspil *)game{
    self.controller = controller;
    self.game = game;
    return self;
}

- (NSString *)activityTitle{
    return @"Tilføj favorit";
}

- (NSString *)activityType{
    return @"favorit";
}

- (UIImage *)activityImage{
    return [UIImage imageNamed:@"star-white"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
    return YES;
}

- (void)performActivity{
    [self.controller addGameAsFavorite:self.game];
    [self activityDidFinish:YES];
}

- (void)prepareWithActivityItems:(NSArray *)activityItems{
    
}

- (UIViewController *)activityViewController{
    return nil;
}

- (void)activityDidFinish:(BOOL)completed{
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

@end
