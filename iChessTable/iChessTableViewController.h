//
//  iChessTableViewController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameStandViewController, HistoryViewController, GameViewController;

@interface iChessTableViewController : UIViewController{
    GameStandViewController* _gameStandController;
    HistoryViewController* _historyViewController;
    GameViewController* _gameViewController;
    UIView* _standContainer;
    UIView* _historyContainer;
}

@property (nonatomic, retain) IBOutlet GameStandViewController* gameStandController;
@property (nonatomic, retain) IBOutlet HistoryViewController* historyViewController;

@property (nonatomic, retain) IBOutlet UIView* standContainer;
@property (nonatomic, retain) IBOutlet UIView* historyContainer;

@property (nonatomic, retain) GameViewController* gameViewController;

-(void)registerNotifications;
-(void)unregisterNotifications;

@end
