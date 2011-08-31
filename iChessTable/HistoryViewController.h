//
//  HistoryViewController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HistoryTableViewController;

@interface HistoryViewController : UIViewController{
    HistoryTableViewController* _historyTableController;
    UIView* _historyTitleView;
}

@property (nonatomic, retain) IBOutlet HistoryTableViewController* historyTableViewController;
@property (nonatomic, retain) IBOutlet UIView* historyTitleView;

@end
