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

- (id)initWithViewController:(GameViewController*)controller{
    self.controller = controller;
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
    BOOL canPerform = NO;
    for (id object in activityItems) {
        if ([object isKindOfClass:[Oelspil class]]) {
            canPerform = YES;
        }
    }
    return canPerform;
}

- (void)performActivity{
    [self.controller addGameAsFavorite:self.game];
    [self activityDidFinish:YES];
}

- (void)prepareWithActivityItems:(NSArray *)activityItems{
    for (id object in activityItems) {
        if ([object isKindOfClass:[Oelspil class]]) {
            self.game = (Oelspil *)object;
        }
    }
}

- (UIViewController *)activityViewController{
    return nil;
}

- (void)activityDidFinish:(BOOL)completed{
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

@end
