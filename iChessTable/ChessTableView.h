//
//  ChessTableView.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessViewControllerDelegate.h"

@class ChessTable, ChessPieceView, MatrixPoint;

@interface ChessTableView : UIImageView{
    id<ChessViewControllerDelegate> _delegate;
    ChessTable* _table;
    //frame for the chess table, inside table view
    CGRect _tableRect;
    CGFloat _gridNodeWidth;
    CGFloat _gridNodeHeight;
}

@property (nonatomic, assign) id<ChessViewControllerDelegate> delegate;
@property (nonatomic, retain) ChessTable* table;
@property (nonatomic, assign) CGRect tableRect;
@property (nonatomic, assign) CGFloat gridNodeWidth;
@property (nonatomic, assign) CGFloat gridNodeHeight;

-(id)initWithChessTable:(ChessTable*)table;
//transform CGPoint to a matrix point in the chess table
-(MatrixPoint*)matrixPointFromPixarPoint:(CGPoint)point;
//transform a matrix point to a CGRect frame that in the table view
-(CGRect)frameForMatrixPoint:(MatrixPoint*)location;

@end
