//
//  GameViewController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "ChessGameController.h"
#import "ChessTableViewController.h"
#import "ChessTableView.h"
#import "Chess.h"
#import "ChessJudge.h"
#import "ChessPiece.h"
#import "ChessPieceView.h"

@implementation GameViewController

@synthesize game = _game;
@synthesize tableViewController = _tableViewController;

#pragma create subviews
-(void)composeSubViews{
    [self composePlayerControlPanelViews];
    [self composeChessTableViews];
}
//compose all control panels for players
-(void)composePlayerControlPanelViews{
    //add more code here
}

//table and pieces are all included
-(void)composeChessTableViews{
    //add more code here
    //get table view and put it centralize
    //chess pieces are also included in the chess table
    UIView* view = self.tableViewController.view;
    CGRect inframe = view.frame;
    CGRect outframe = self.view.frame;
    inframe.origin.x = (outframe.size.width - inframe.size.width)/2;
    inframe.origin.y = (outframe.size.height - inframe.size.height)/2;
    [view setFrame:inframe];
    [self.view addSubview:view];
}

-(void)setupPropertiesWithGameName:(NSString*)name{
    self.game = [ChessGameController gameControllerWithChessBundleName:name];
    self.tableViewController = [ChessTableViewController tableViewControllerWithChessTable:self.game.chess.table];
    self.tableViewController.game = self.game;
}

//init a new game view controller by chess game name
-(id)initWithChessGameName:(NSString*)name{
    return [self initWithNibName:nil bundle:nil gameName:name];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameName:(NSString*)name
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setupPropertiesWithGameName:name];
    }
    return self;
}

-(void)dealloc{
    self.game = nil;
    self.tableViewController = nil;
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
    // Do any additional setup after loading the view from its nib.
    [self composeSubViews];
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


@end
