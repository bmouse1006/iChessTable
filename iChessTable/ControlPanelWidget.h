//
//  ControlPanelWidget.h
//  iChessTable
//
//  Created by Jin Jin on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlPanelWidget : UIView{
    UIImageView* _presentImageView;
    
    BOOL _enable;
    NSString* _notificationName;
}

@property (nonatomic, retain) UIImageView* presentImageView;
@property (nonatomic, assign, setter = setEnable:) BOOL enable;
@property (nonatomic, retain) NSString* notificationName;

-(void)sendNotification;

@end
