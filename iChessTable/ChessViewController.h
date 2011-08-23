//
//  ChessViewController.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChessTable;

@interface ChessViewController : UIViewController{
    ChessTable* _table;
}

@property (nonatomic, retain) ChessTable* table;

@end
