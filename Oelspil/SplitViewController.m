//
//  SplitViewController.m
//  Oelspil
//
//  Created by Jesper Nielsen on 23/12/12.
//
//

#import "SplitViewController.h"
#import "KategoriViewController.h"
#import "GameViewController.h"
@interface SplitViewController ()

@end

@implementation SplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIViewController *kvc = [[KategoriViewController alloc] initWithNibName:@"KategoriView" bundle:nil];
        
        UIViewController *gameView = [[GameViewController alloc] initWithNibName:@"GameView" bundle:nil];
        
        self.viewControllers = [NSArray arrayWithObjects:kvc, gameView, nil];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
