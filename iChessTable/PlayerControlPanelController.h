//
//  PlayerControlPanelController.h
//  iChessTable
//
//  Created by Jin Jin on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChessPlayer;

@interface PlayerControlPanelController : UIViewController{
    ChessPlayer* _player;
    NSMutableArray* _widgets;
}

@property (nonatomic, retain) ChessPlayer* player;
@property (nonatomic, retain) NSMutableArray* widgets;

@end
