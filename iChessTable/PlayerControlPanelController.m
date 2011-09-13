//
//  PlayerControlPanelController.m
//  iChessTable
//
//  Created by Jin Jin on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Chess.h"
#import "ChessPiece.h"
#import "ChessPlayer.h"
#import "PlayerControlPanelController.h"
#import "ControlPanelWidget.h"

@implementation PlayerControlPanelController

@synthesize player = _player;
@synthesize widgets = _widgets;
@synthesize trafficLight = _trafficLight;
@synthesize playerType = _playerType;
@synthesize redo = _redo;
@synthesize undo = _undo;
@synthesize backWidget = _backWidget;

-(NSMutableArray*)getWidgets{
    if (_widgets == nil){
        _widgets = [NSMutableArray arrayWithCapacity:0];
        [_widgets retain];
    }
    
    return _widgets;
}

-(void)setPlayer:(ChessPlayer *)player{
    if (_player != player){
        [self unregisterNotifications];
        [_player release];
        _player = player;
        [_player retain];
        if (_player != nil){
            //register notifications only if player is not nil
            [self registerNotifications];   
        }
    }
}

-(void)dealloc{
    self.player = nil;
    self.widgets = nil;
    self.trafficLight = nil;
    self.playerType = nil;
    self.redo = nil;
    self.undo = nil;
    self.backWidget = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //add all widget to panel
    [self.view addSubview:self.backWidget];
    [self composeWidgets];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//compose all widgets in control panel
-(void)composeWidgets{
    //load first
    [self loadAllWidgets];
    //lay out top widgets
    //add all to panel view first
    //animate to destiny location
    float height = 0;
    for (ControlPanelWidget* widget in self.widgets){
        CGRect rect = widget.frame;
        rect.origin.x = (self.view.frame.size.width - widget.frame.size.width)/2;
        rect.origin.y = 20;
        [widget setFrame:rect];
        [self.view addSubview:widget];
        height += 20;
        rect.origin.y = height;
        height += rect.size.height;
        [UIView animateWithDuration:0.5 animations:^{[widget setFrame:rect];}];    
    }
    [self.view addSubview:self.backWidget];
    CGRect rect = self.backWidget.frame;
    rect.origin.y = self.view.frame.size.height - rect.size.height - 20;
    rect.origin.x = (self.view.frame.size.width - rect.size.width)/2;
    [UIView animateWithDuration:0.5 animations:^{[self.backWidget setFrame:rect];}]; 
}

-(void)loadAllWidgets{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ControlPanelWidgets" ofType:@"plist"];
    NSDictionary* widgets = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray* top = [widgets objectForKey:@"topWidgets"];
    NSArray* buttom = [widgets objectForKey:@"buttomWidgets"];
    for (NSDictionary* wid in top){
        ControlPanelWidget* widget = [[ControlPanelWidget alloc] initWithPropertiesList:wid 
                                                                                 target:self
                                                                                 action:@selector(actionFromSelectorWithObject:)];
        if ([widget.type isEqualToString:PANELWIDGETTYPE_TYPE]){
            self.playerType = widget;
        }else if ([widget.type isEqualToString:PANELWIDGETTYPE_TRAFFICLIGHT]){
            self.trafficLight = widget;
        }else if ([widget.type isEqualToString:PANELWIDGETTYPE_REDO]){
            self.redo = widget;
        }else if ([widget.type isEqualToString:PANELWIDGETTYPE_DEFAULTCHESS]){
            NSString* imageName = [[Chess currentChess] getDefaultPieceByColor:self.player.color].imageName;
            UIImage* image = [UIImage imageNamed:imageName];
            UIImageView* view = [[UIImageView alloc] initWithImage:image];
            widget.primaryImageView = view;
            widget.presentView = widget.primaryImageView;
            [view release];
            self.playerType = widget;
        }else if ([widget.type isEqualToString:PANELWIDGETTYPE_UNDO]){
            self.undo = widget;
        }
        
        [self.widgets addObject:widget];
        [widget release];
    }
    
    for (NSDictionary* wid in buttom){
        ControlPanelWidget* widget = [[ControlPanelWidget alloc] initWithPropertiesList:wid target:self action:@selector(actionFromSelectorWithObject:)];
        self.backWidget = widget;
        [widget release];
    }
 }

-(void)registerNotifications{
    
}

-(void)unregisterNotifications{
    
}

-(void)actionFromSelectorWithObject:(id)obj{
    //do different action according to different type
    DebugLog(@"Player Control Panel - action received from widget", nil);
    if ([obj isKindOfClass:[ControlPanelWidget class]]){
        ControlPanelWidget* widget = (ControlPanelWidget*)obj;
        if ([PANELWIDGETTYPE_TRAFFICLIGHT isEqualToString:widget.type]){
            
        }else if([PANELWIDGETTYPE_TYPE isEqualToString:widget.type]){
            
        }else if([PANELWIDGETTYPE_DEFAULTCHESS isEqualToString:widget.type]){
            
        }else if ([PANELWIDGETTYPE_REDO isEqualToString:widget.type]){
            //redo a action
            
        }else if ([PANELWIDGETTYPE_UNDO isEqualToString:widget.type]){
            //undo a step
            
        }else if ([PANELWIDGETTYPE_BACK isEqualToString:widget.type]){
            //promote a dialog saying that is it OK to quit to main screen
        }
    }
}
                                    
@end
