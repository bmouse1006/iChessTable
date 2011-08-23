//
//  ChessTableViewController.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessTableViewController.h"
#import "ChessTable.h"
#import "ChessPiece.h"
#import "ChessTableView.h"
#import "ChessPieceView.h"
#import "ChessMatrix.h"

@implementation ChessTableViewController

@synthesize table = _table;
@synthesize tableView = _tableView;
@synthesize gridNodeWidth = _gridNodeWidth;
@synthesize gridNodeHeight = _gridNodeHeight;
@synthesize tableRect = _tableRect;

#pragma Class methods
+(id)tableViewControllerWithChessTable:(ChessTable*)table{
    ChessTableViewController* viewController = [[ChessTableViewController alloc] initWithNibName:nil 
                                                                                          bundle:nil 
                                                                                      chessTable:table];
    return [viewController autorelease];
}

#pragma setter and getter
-(void)setTable:(ChessTable *)table{
    if (_table != table){
        if (_table != nil){//do not unregister if _table is nil
            [self unregisterNotifications:_table];
        }
        [_table release];
        _table = table;
        [_table retain];
        if (_table != nil){//do not register again for nil table
            [self registerNotifications:_table];
        }
    }
}

#pragma instance methods
-(CGPoint)centerPointForPiece:(ChessPiece*)piece{
    CGPoint central = CGPointMake(piece.origin.x * self.gridNodeWidth, piece.origin.y * self.gridNodeHeight);
    CGPoint origin = self.tableRect.origin;
    return CGPointMake(origin.x + central.x, origin.y + central.y);
}

#pragma mark - instance life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chessTable:(ChessTable*)table
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.table = table;
    }
    return self;
}

-(void)dealloc{
    self.table = nil;
    self.tableView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)loadView{
    //init table view;
    ChessTableView* tempView = [[ChessTableView alloc] initWithImage:[UIImage imageNamed:self.table.bkImageName]];
    self.tableView = tempView;
    [tempView release];
    CGSize imageSize = self.tableView.image.size;
    self.tableRect = CGRectMake((imageSize.width - self.table.width)/2, (imageSize.height - self.table.height)/2, self.table.width, self.table.height);
    self.gridNodeWidth = self.table.width/(self.table.matrix.horiNodes-1);
    self.gridNodeHeight = self.table.height/(self.table.matrix.vertNodes-1);
    
    self.view = (UIView*)self.tableView;
    //add pieces to the table;
    //all pieces that need to be displayed
    NSEnumerator* enumerator = [self.table enumeratorOfPiecesInTable];
    ChessPiece* piece = nil;
    while (piece = [enumerator nextObject]) {
        //create view for piece and add to table view
        [self addPieceViewForPiece:piece at:piece.origin];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
	return YES;
}

//piece view control
-(void)addPieceViewForPiece:(ChessPiece*)piece at:(MatrixPoint*)at{
    ChessPieceView* pieceView = [[ChessPieceView alloc] initWithChessPiece:piece];
    //set center point for the piece view, according to given piece
    [pieceView setCenter:[self centerPointForPiece:piece]];
    [self.tableView addSubview:pieceView];
    [pieceView release];
}

-(void)removePieceViewForPiece:(ChessPiece*)piece at:(MatrixPoint*)at{
    
}
-(void)movePieceViewForPiece:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to{
    
}

-(void)registerNotifications:(id)object{
    //register for three notifications
    //NOTIFICATION_TABLE_UPDATE_BEGIN     @"NOTIFICATION_TABLE_UPDATE_BEGIN"
    //NOTIFICATION_TABLE_UPDATE_STEP      @"NOTIFICATION_TABLE_UPDATE_STEP"
    //NOTIFICATION_TABLE_UPDATE_END       @"NOTIFICATION_TABLE_UPDATE_END"
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(notificationTableUpdateBegin:)
                                                 name:NOTIFICATION_TABLE_UPDATE_BEGIN
                                               object:object];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(notificationTableUpdateStep:)
                                                 name:NOTIFICATION_TABLE_UPDATE_STEP
                                               object:object];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(notificationTableUpdateEnd:)
                                                 name:NOTIFICATION_TABLE_UPDATE_END
                                               object:object];
    
}

-(void)unregisterNotifications:(id)object{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TABLE_UPDATE_BEGIN object:object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TABLE_UPDATE_STEP object:object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_TABLE_UPDATE_END object:object];
}

//all notification selectors
-(void)notificationTableUpdateBegin:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_TABLE_UPDATE_BEGIN is received", nil);
}

-(void)notificationTableUpdateStep:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_TABLE_UPDATE_STEP is received", nil);
}

-(void)notificationTableUpdateEnd:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_TABLE_UPDATE_END is received", nil);
}

@end
