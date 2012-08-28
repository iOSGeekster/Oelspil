//
//  FavoriteActivity.h
//  Oelspil
//
//  Created by Jesper Nielsen on 28/08/12.
//
//

#import <UIKit/UIKit.h>
#import "Oelspil.h"
#import "GameViewController.h"
@interface FavoriteActivity : UIActivity
@property (nonatomic, strong) GameViewController *controller;
@property (nonatomic, strong) Oelspil *game;

- (NSString *)activityType;
- (NSString *)activityTitle;
- (UIImage *)activityImage;
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems;
- (void)prepareWithActivityItems:(NSArray *)activityItems;
- (UIViewController *)activityViewController;
- (void)performActivity;
- (void)activityDidFinish:(BOOL)completed;
- (id)initWithViewController:(GameViewController*)controller andGame:(Oelspil *)game;
@end
