//
//  ControlPanelWidget.h
//  iChessTable
//
//  Created by Jin Jin on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PANELWIDGETTYPE_TRAFFICLIGHT    @"PANELWIDGETTYPE_TRAFFICLIGHT"
#define PANELWIDGETTYPE_DEFAULTCHESS    @"PANELWIDGETTYPE_DEFAULTCHESS"
#define PANELWIDGETTYPE_TYPE            @"PANELWIDGETTYPE_TYPE"
#define PANELWIDGETTYPE_UNDO            @"PANELWIDGETTYPE_UNDO"
#define PANELWIDGETTYPE_REDO            @"PANELWIDGETTYPE_REDO"
#define PANELWIDGETTYPE_BACK            @"PANELWIDGETTYPE_BACK"

@interface ControlPanelWidget : UIView{
    
    NSString* _type;
    
    UIView* _presentView;
    
    UIImageView* _primaryImageView;
    UIImageView* _secondaryImageView;
    UIImageView* _animationImageView;
    BOOL _enable;
    BOOL _humanOnly;
    
    id _target;
    SEL _action;
}

@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain, getter = getPresentView, setter = setPresentView:) UIView* presentView;
@property (nonatomic, retain, setter = setPrimaryImageView:) UIImageView* primaryImageView;
@property (nonatomic, retain, setter = setSecondaryImageView:) UIImageView* secondaryImageView;
@property (nonatomic, retain, setter = setAnimationImageView:) UIImageView* animationImageView;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) BOOL humanOnly;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

-(id)initWithPropertiesList:(NSDictionary*)plist 
                     target:(id)target
                     action:(SEL)action;

-(id)initWithImage:(UIImage*)image 
    secondaryImage:(UIImage*)secondaryImage 
    animationImage:(UIImage*)animationImage
            target:(id)target 
            action:(SEL)action;
//show widget view touched or not
-(void)touchedDown:(BOOL)down;
//play preloaded animation, if have one
-(void)playAnimation;
//add shadow to subviews
-(void)shadowView:(UIView*)view shadow:(BOOL)shadow;
//present view
-(void)presentThisView:(UIView*)view;

@end
