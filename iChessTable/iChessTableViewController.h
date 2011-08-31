//
//  iChessTableViewController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameStandViewController, HistoryViewController;

@interface iChessTableViewController : UIViewController{
    GameStandViewController* _gameStandController;
    HistoryViewController* _historyViewController;
    
    UIView* _standContainer;
    UIView* _historyContainer;
}

@property (nonatomic, retain) IBOutlet GameStandViewController* gameStandController;
@property (nonatomic, retain) IBOutlet HistoryViewController* historyViewController;

@property (nonatomic, retain) IBOutlet UIView* standContainer;
@property (nonatomic, retain) IBOutlet UIView* historyContainer;

@end
