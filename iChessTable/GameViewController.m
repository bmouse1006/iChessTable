//
//  GameViewController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "GameViewController.h"
#import "ChessGameController.h"
#import "ChessTableViewController.h"
#import "ChessTableView.h"
#import "Chess.h"
#import "ChessJudge.h"
#import "ChessPiece.h"
#import "ChessPieceView.h"
#import "PlayerControlPanelController.h"

@implementation GameViewController

@synthesize game = _game;
@synthesize tableViewController = _tableViewController;
@synthesize panelControllerLeft = _panelControllerLeft;
@synthesize panelControllerRight = _panelControllerRight;
@synthesize controlPanelLeftContainer = _controlPanelLeftContainer;
@synthesize controlPanelRightContainer = _controlPanelRightContainer;
@synthesize chessTableViewContainer = _chessTableViewContainer;

#pragma create subviews
-(void)composeSubViews{
    [self composePlayerControlPanelViews];
    [self composeChessTableViews];
}
//compose all control panels for players
-(void)composePlayerControlPanelViews{
    //add more code here
    //set shadow and round corner for panels
    [self shadowAndRoundCorner:self.controlPanelLeftContainer];
    [self shadowAndRoundCorner:self.controlPanelRightContainer];
    PlayerControlPanelController* controller = [[PlayerControlPanelController alloc] init];
    controller.player = 
    self.panelControllerLeft = controller;
    [controller release];
    controller = [[PlayerControlPanelController alloc] init];
    self.panelControllerRight = controller;
    [controller release];
    switch (self.game.mode) {
        case ChessGameModeBlueTooth:
            self.panelControllerRight.type = ChessPlayerTypeBlueTooth;
            break;
        case ChessGameModeOnePlayer:
            self.panelControllerRight.type = ChessPlayerTypeAI;
            break;
        case ChessGameModeGameCenter:
            self.panelControllerRight.type = ChessPlayerTypeGameCenter;
            break;
        case ChessGameModeTwoPlayers:
            self.panelControllerRight.type = ChessPlayerTypePeople;
        default:
            break;
    }
    //turn it upside down
    self.panelControllerRight.view.transform = CGAffineTransformMake(-1, 0, 0, -1, 0, 0);
    //compose button in control panel
    //add to the containers
    [self.controlPanelLeftContainer addSubview:self.panelControllerLeft.view];
    [self.controlPanelRightContainer addSubview:self.panelControllerRight.view];
}

//table and pieces are all included
-(void)composeChessTableViews{
    //add more code here
    //get table view and put it centralize
    //chess pieces are also included in the chess table
    //set shadow and round corner
    [self shadowAndRoundCorner:self.chessTableViewContainer];
    UIView* view = self.tableViewController.view;
    CGRect inframe = view.frame;
    CGRect outframe = self.chessTableViewContainer.frame;
    inframe.origin.x = (outframe.size.width - inframe.size.width)/2;
    inframe.origin.y = (outframe.size.height - inframe.size.height)/2;
    [view setFrame:inframe];
    [self.chessTableViewContainer addSubview:view];
}

//init a new game view controller by chess game name
-(id)initWithChessGameName:(NSString*)name mode:(ChessGameMode)mode choosenColor:(ChessPieceColor)color{
    return [self initWithNibName:nil bundle:nil gameName:name mode:mode choosenColor:color];
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil 
             gameName:(NSString*)name 
                 mode:(ChessGameMode)mode 
         choosenColor:(ChessPieceColor)color
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.game = [ChessGameController gameControllerWithChessBundleName:name 
                                                                      mode:mode
                                                              choosenColor:color];
        self.tableViewController = [ChessTableViewController tableViewControllerWithChessTable:self.game.chess.table];
        self.tableViewController.game = self.game;
    }
    return self;
}

-(void)dealloc{
    self.game = nil;
    self.tableViewController = nil;
    self.panelControllerRight = nil;
    self.panelControllerLeft = nil;
    self.controlPanelLeftContainer = nil;
    self.controlPanelRightContainer = nil;
    self.chessTableViewContainer = nil;
    [super dealloc];
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
    //transparent background view
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    // Do any additional setup after loading the view from its nib.
    [self composeSubViews];
    [self.game start];
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
	return YES;
}

#pragma mark - notification selectors
-(void)notificationSwitchPlayer:(NSNotification*)notification{
    //player is switched
    //do needed change for player control panels
    //add code here
}

-(void)registerNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationSwitchPlayer:)
                                                 name:NOTIFICATION_GAME_SWITCHPLAYER 
                                               object:nil];
}

-(void)unregisterNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)shadowAndRoundCorner:(UIView*)view{
    view.layer.shadowOffset = CGSizeMake(5, 3);
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.6f;
    view.layer.cornerRadius = 10.0f;
}

@end
