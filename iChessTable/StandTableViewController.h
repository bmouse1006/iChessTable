//
//  StandTableViewController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StandTableViewCell, StandGameIcon;

@interface StandTableViewController : UITableViewController{
    UITableView* _tableView;
    
    NSDictionary* _chessList;
    NSArray* _chessListKeys;
    
    StandTableViewCell* _tempCell;
    StandGameIcon* _tempIcon;
}

@property (nonatomic, retain) IBOutlet UITableView* tableView;
//this list is read from ChessList.plist
@property (nonatomic, retain, getter = getChessList, setter = setChessList:) NSDictionary* chessList;
@property (nonatomic, retain) IBOutlet StandTableViewCell* tempCell;
@property (nonatomic, retain) IBOutlet StandGameIcon* tempIcon;

@end
