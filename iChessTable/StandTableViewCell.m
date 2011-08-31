//
//  StandTableViewCell.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StandTableViewCell.h"
#import "StandGameIcon.h"

#define MAX_ICON 3

@implementation StandTableViewCell

@synthesize icons = _icons;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc{
    self.icons = nil;
    [super dealloc];
}

-(NSMutableArray*)getIcons{
    if (_icons == nil){
        self.icons = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _icons;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)removeAllIcons{
    NSEnumerator* enumerator = [self.icons objectEnumerator];
    StandGameIcon* icon = nil;
    while (icon = [enumerator nextObject]) {
        [icon removeFromSuperview];
    }
    
    [self.icons removeAllObjects];
}

-(void)addAnIcon:(StandGameIcon*)icon{
    if ([self.icons count] < MAX_ICON){
        [self.icons addObject:icon];
    }
}

-(void)layoutAllIcons{
    int count = [self.icons count];
    for (int i = 0; i<count; i++){
        CGPoint center = [self centerForIconNum:i];
        StandGameIcon* icon = [self.icons objectAtIndex:i];
        [self addSubview:icon];
        [UIView animateWithDuration:0.2 
                         animations:^{[icon setCenter:center];}];
        
    }
}

-(CGPoint)centerForIconNum:(NSInteger)index{
    CGFloat width = 748;
    CGPoint origin = CGPointMake(width/(MAX_ICON*2), self.frame.size.height/2);
    origin.x += origin.x*2*index;
    return origin;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self layoutAllIcons];
}

@end
