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
#import "ChessGameController.h"
#import "ChessJudge.h"
#import "ChessTableView.h"
#import "ChessPieceView.h"
#import "ChessMatrix.h"
#import "ChessStep.h"

#define CHESSTABLEVIEWUPDATEANIMATION @"CHESSTABLEVIEWUPDATEANIMATION"

@implementation ChessTableViewController

@synthesize table = _table;
@synthesize tableView = _tableView;
@synthesize game = _game;
@synthesize selectedPieceView = _selectedPieceView;

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
    CGPoint central = CGPointMake(piece.origin.x * self.tableView.gridNodeWidth, piece.origin.y * self.tableView.gridNodeHeight);
    CGPoint origin = self.tableView.tableRect.origin;
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
    self.game = nil;
    self.selectedPieceView = nil;
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
    ChessTableView* tempView = [[ChessTableView alloc] initWithChessTable:self.table];
    tempView.delegate = self;
    self.tableView = tempView;
    [tempView release];
    
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

//piece view control, add, move and remove
-(void)addPieceViewForPiece:(ChessPiece*)piece at:(MatrixPoint*)at{
    ChessPieceView* pieceView = [[ChessPieceView alloc] initWithChessPiece:piece];
    pieceView.delegate = self;
    //add this piece view to view matrix
    _pieceViewMatrix[at.x][at.y] = pieceView;
    //set center point for the piece view, according to given piece
    [pieceView setCenter:[self centerPointForPiece:piece]];
    pieceView.alpha = 0;
    [self.tableView addSubview:pieceView];
    //animation using block
    [UIView animateWithDuration:0.2
                     animations:^{pieceView.alpha = 1.0;}
                     completion:NULL];
    [pieceView release];
}

-(void)removePieceViewForPiece:(ChessPiece*)piece at:(MatrixPoint*)at{
    ChessPieceView* pieceView = _pieceViewMatrix[at.x][at.y];
    //remove it from piece view matrix and then remove it from super view (table view) after animation is done
    _pieceViewMatrix[at.x][at.y] = nil;
    [UIView animateWithDuration:0.2
                     animations:^{pieceView.alpha = 0.0;}
                     completion:^(BOOL finished){[pieceView removeFromSuperview];}];
}

-(void)movePieceViewForPiece:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to{
    //fetch piece view from piece view matrix
    ChessPieceView* pieceView = _pieceViewMatrix[from.x][from.y];
    //move it to destiny
    _pieceViewMatrix[from.x][from.y] = nil;
    pieceView.piece = piece;
    piece.origin = to;
    _pieceViewMatrix[to.x][to.y] = pieceView;
    CGPoint center = [self centerPointForPiece:piece];
    [pieceView moveTo:center];
    //it's already in the table view so we don't need to add it again
//    [UIView animateWithDuration:0.2 
//                          delay:0 
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{[pieceView setCenter:center];} 
//                     completion:NULL];
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
    //begin a animation context
}

-(void)notificationTableUpdateStep:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_TABLE_UPDATE_STEP is received", nil);
    ChessSingleStep* ss = [notification.userInfo objectForKey:@"obj"];
    switch (ss.type) {
        case ChessSingleStepTypeAdd:
            [self addPieceViewForPiece:ss.piece at:ss.to];
            break;
        case ChessSingleStepTypeMove:
            [self movePieceViewForPiece:ss.piece from:ss.from to:ss.to];
            break;
        case ChessSingleStepTypeDelete:
            [self removePieceViewForPiece:ss.piece at:ss.to];
            break;
        default:
            break;
    }
}

-(void)notificationTableUpdateEnd:(NSNotification*)notification{
    DebugLog(@"NOTIFICATION_TABLE_UPDATE_END is received", nil);
    //commit animation context
}

#pragma delegate methods
//event from piece view
-(void)pieceViewIsSelected:(ChessPieceView*)pieceView{
    //if select is allowed
    if ([self.game.judge doesPieceCanBeSelected:pieceView.piece table:self.table]){
        if (((self.selectedPieceView != nil)&&(self.selectedPieceView != pieceView)&&self.selectedPieceView.isMoving == NO) || 
            self.selectedPieceView == nil){
            self.selectedPieceView = pieceView;
            //send out notifications to table
            [self postNotificaiotnWithName:NOTIFICATION_PLAYER_PIECE_SELECT
                                     piece:pieceView.piece 
                                      from:nil
                                        to:nil];
        }
    }
    //do more for the selected piece if needed
    //more animation
}
//event from piece view
-(void)pieceViewIsDropped:(ChessPieceView*)pieceView{
    //if this piece has been moved
    if (pieceView.isMoving == YES){
        //check if piece can be moved to the current position
        if ([self.game.judge doesPieceCanBeDropped:pieceView.piece 
                                                to:[self.tableView matrixPointFromPixarPoint:pieceView.center]
                                             table:self.table]){
            //dropping to current location is legal
            //send out piece is moved notification to table
            MatrixPoint* from = pieceView.piece.origin;
            MatrixPoint* to = [self.tableView matrixPointFromPixarPoint:pieceView.center];
            [self postNotificaiotnWithName:NOTIFICATION_PLAYER_PIECE_MOVE
                                     piece:pieceView.piece 
                                      from:from
                                        to:to];
        }else{
            //dropping to current location is not legal
            //move back
            [pieceView moveTo:[self centerPointForPiece:pieceView.piece]];
        }
        //set the selected piece view = nil
        self.selectedPieceView = nil;
    }
}
//event from piece view
-(void)pieceViewIsMoving:(ChessPieceView*)pieceView{

}
//event from piece view
-(void)pieceViewTouchingIsCancelled:(ChessPieceView*)pieceView{
    
}
//event from piece view
-(BOOL)doesPieceViewCanBeMoved:(ChessPieceView*)pieceView{
    BOOL result = NO;
    if ([self.game.judge doesPieceCanBeMoved:pieceView.piece table:self.table]){
        result = YES;
    }
    
    return result;
}


//from table view
-(void)tableView:(ChessTableView*)tableView isTouchedAt:(CGPoint)location{
    
    MatrixPoint* from = nil;
    MatrixPoint* to = [tableView matrixPointFromPixarPoint:location];
    
    if ([self.game.judge doesPieceCanBeMoved:nil table:self.table] == YES){//if piece is allowed to be moved
        if (self.selectedPieceView != nil){//if no piece view has been selected
            //move event
            //add some animation?
            //send out move notification
            from = self.selectedPieceView.piece.origin;
            [self postNotificaiotnWithName:NOTIFICATION_PLAYER_PIECE_MOVE
                                     piece:self.selectedPieceView.piece
                                      from:from   
                                        to:to];
        }
    }else{//piece can't move
        //drop event
        //add some animation?
        //send out drop notification
        [self postNotificaiotnWithName:NOTIFICATION_PLAYER_PIECE_DROP 
                                 piece:nil//default piece? or selected one?
                                  from:from
                                    to:to];
    }
}

-(void)postNotificaiotnWithName:(NSString*)name piece:(ChessPiece*)piece from:(MatrixPoint*)from to:(MatrixPoint*)to{
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithCapacity:0];
    if (piece){
        [userInfo setObject:piece forKey:@"piece"];
    }
    if (from){
        [userInfo setObject:from forKey:@"from"];
    }
    if (to){
        [userInfo setObject:to forKey:@"to"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:nil
                                                      userInfo:userInfo];
}

@end
