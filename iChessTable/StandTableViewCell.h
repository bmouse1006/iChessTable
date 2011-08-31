//
//  StandTableViewCell.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StandGameIcon;

@interface StandTableViewCell : UITableViewCell{
    NSMutableArray* _icons;
}

@property (nonatomic, retain, getter = getIcons) NSMutableArray* icons;

-(void)removeAllIcons;
-(void)addAnIcon:(StandGameIcon*)icon;
-(void)layoutAllIcons;
-(CGPoint)centerForIconNum:(NSInteger)index;

@end
