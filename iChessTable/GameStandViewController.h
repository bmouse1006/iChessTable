//
//  GameStandViewController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StandTableViewController;

@interface GameStandViewController : UIViewController{
    UIView* _standTitleView;
    StandTableViewController* _standTableController;
}

@property (nonatomic, retain) IBOutlet StandTableViewController* standTableController;
@property (nonatomic, retain) IBOutlet UIView* standTitleView;

@end
