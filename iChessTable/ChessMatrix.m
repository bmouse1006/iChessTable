//
//  ChessMatrix.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessMatrix.h"
#import "ChessPiece.h"

@implementation ChessMatrix

@synthesize pieceSet = _pieceSet;
@synthesize removedPieces = _removedPieces;
@synthesize horiNodes = _horiNodes;
@synthesize vertNodes = _vertNodes;

//add a new piece to point
-(void)addPiece:(ChessPiece*)piece to:(MatrixPoint*)location{
    if ([self isLocationInTheMatrix:location]){
        piece.origin = location;
        [self.pieceSet addObject:piece];
        _matrix[location.x][location.y] = piece;
    }
}
//remove piece piece from location
-(void)removePiece:(ChessPiece*)piece from:(MatrixPoint*)location{
    if ([self isLocationInTheMatrix:location]){
//        if (piece == _matrix[location.x][location.y]){
        [piece.origin offTable];
            [self.removedPieces addObject:piece];
            [self.pieceSet removeObject:piece];
            _matrix[location.x][location.y] = nil;
//        }
    }
}
//move an existing piece from point to another point
-(void)movePiece:(ChessPiece*)piece from:(MatrixPoint*)fromPoint to:(MatrixPoint*)toPoint{
    if ([self isLocationInTheMatrix:fromPoint] &&
        [self isLocationInTheMatrix:toPoint]){
        piece.origin = toPoint;
        _matrix[toPoint.x][toPoint.y] = _matrix[fromPoint.x][fromPoint.y];
        _matrix[fromPoint.x][fromPoint.y] = nil;
    }
}

//get piece at given location
-(ChessPiece*)pieceAtLocation:(MatrixPoint*)location{
    return ([self isLocationInTheMatrix:location])?_matrix[location.x][location.y]:nil;
}
//get location of given piece
-(MatrixPoint*)locationOfPiece:(ChessPiece*)piece{
    return piece.origin;
}

//check if the location is in scope of matrix
-(BOOL)isLocationInTheMatrix:(MatrixPoint*)point{
    BOOL result = YES;
    if (point.x < 0 || point.y<0){
        result = NO;
    }
    
    if (point.x >= self.horiNodes || point.y >= self.vertNodes){
        result = NO;
    }
    
    return result;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.pieceSet = [NSMutableSet setWithCapacity:0];
        self.removedPieces = [NSMutableSet setWithCapacity:0];
    }
    
    return self;
}

-(void)dealloc{
    self.pieceSet = nil;
    self.removedPieces = nil;
    [super dealloc];
}

@end

@implementation MatrixPoint

@synthesize x = _x;
@synthesize y = _y;

+(MatrixPoint*)pointWithX:(int)x andY:(int)y{
    MatrixPoint* point = [[MatrixPoint alloc] init];
    point.x = x;
    point.y = y;
    return [point autorelease];
}

-(void)offTable{
    self.x = -1;
    self.y = -1;
}

-(BOOL)isOffTable{
    return (self.x == -1 || self.y == -1);
}

@end
