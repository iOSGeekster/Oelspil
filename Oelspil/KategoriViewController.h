//
//  SecondViewController.h
//  Oelspil
//
//  Created by Jesper Nielsen on 10/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KategoriViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>{

}
@property (strong, nonatomic) NSArray *kategorier;

@end
