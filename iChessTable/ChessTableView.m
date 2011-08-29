//
//  ChessTableView.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessTableView.h"
#import "ChessPieceView.h"
#import "ChessPiece.h"
#import "ChessTable.h"
#import "ChessMatrix.h"

@implementation ChessTableView

@synthesize delegate = _delegate;
@synthesize table = _table;
@synthesize tableRect = _tableRect;
@synthesize gridNodeWidth = _gridNodeWidth;
@synthesize gridNodeHeight = _gridNodeHeight;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithChessTable:(ChessTable*)table{
    self = [super initWithImage:[UIImage imageNamed:table.bkImageName]];
    if (self){
        self.multipleTouchEnabled = NO;
        //caculate the table rect
        self.table = table;
        CGSize imageSize = self.image.size;
        self.tableRect = CGRectMake((imageSize.width - self.table.width)/2, (imageSize.height - self.table.height)/2, self.table.width, self.table.height);
        self.gridNodeWidth = self.table.width/self.table.matrix.horiNodes;
        self.gridNodeHeight = self.table.height/self.table.matrix.vertNodes;
    }
    
    return self;
}

-(void)dealloc{
    self.table = nil;
    [super dealloc];
}

//transform CGPoint to a matrix point in the chess table
-(MatrixPoint*)matrixPointFromPixarPoint:(CGPoint)point{
    MatrixPoint* result = [MatrixPoint pointWithX:-1 andY:-1];
    CGPoint origin = self.tableRect.origin;
    CGPoint deltaPoint = CGPointMake(point.x-origin.x, point.y-origin.y);
    result.x = deltaPoint.x/self.gridNodeWidth;
    result.y = deltaPoint.y/self.gridNodeHeight;
    
    return result;
}
//transform a matrix point to a CGRect frame that in the table view
-(CGRect)frameForMatrixPoint:(MatrixPoint*)location{
    CGFloat x = self.tableRect.origin.x + self.gridNodeWidth*location.x;
    CGFloat y = self.tableRect.origin.y + self.gridNodeHeight*location.y;
    return CGRectMake(x, y, self.gridNodeWidth, self.gridNodeWidth);
}

//response to touch event
//touches began
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //drop event happended while touch begins
    NSEnumerator* enumerator = [touches objectEnumerator];
    UITouch* touch = nil;
    while (touch = [enumerator nextObject]){
        [self.delegate tableView:self 
                     isTouchedAt:[touch locationInView:self]];
    }
}

//touches moved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //no response to move
}

//touches ended
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //no response
    
}

//touches cancelled
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    //no response
}

@end
