//
//  PlayerControlPanelController.h
//  iChessTable
//
//  Created by Jin Jin on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChessPlayer, ControlPanelWidget;

@interface PlayerControlPanelController : UIViewController{
    ChessPlayer* _player;
    NSMutableArray* _widgets;

    ControlPanelWidget* _trafficLight;
    ControlPanelWidget* _playerType;
    ControlPanelWidget* _redo;
    ControlPanelWidget* _undo;
    ControlPanelWidget* _backWidget;
}

@property (nonatomic, retain, setter = setPlayer:) ChessPlayer* player;
@property (nonatomic, retain, getter = getWidgets) NSMutableArray* widgets;
@property (nonatomic, retain) ControlPanelWidget* trafficLight;
@property (nonatomic, retain) ControlPanelWidget* playerType;
@property (nonatomic, retain) ControlPanelWidget* redo;
@property (nonatomic, retain) ControlPanelWidget* undo;
@property (nonatomic, retain) ControlPanelWidget* backWidget;

//init an widget with target and action

//compose all widgets in control panel
-(void)composeWidgets;
-(void)loadAllWidgets;

-(void)registerNotifications;
-(void)unregisterNotifications;

@end
