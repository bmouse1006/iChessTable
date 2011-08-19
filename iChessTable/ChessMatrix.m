//
//  ChessMatrix.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessMatrix.h"

@implementation ChessMatrix

@synthesize pieceSet = _pieceSet;
@synthesize removedPieces = _removedPieces;
@synthesize height = _height;
@synthesize width = _width;

//add a new piece to point
-(void)setPiece:(ChessPiece*)piece at:(MatrixPoint*)location{
    if ([self isLocationInTheMatrix:location]){
        [self.pieceSet addObject:piece];
        _matrix[location.x][location.y] = piece;
    }
}
//remove piece piece from location
-(void)removePieceFrom:(MatrixPoint*)location{
    if ([self isLocationInTheMatrix:location]){
        ChessPiece* piece = _matrix[location.x][location.y];
        [self.removedPieces addObject:piece];
        [self.pieceSet removeObject:piece];
        _matrix[location.x][location.y] = nil;
    }
}
//move an existing piece from point to another point
-(void)movePiece:(ChessPiece*)piece from:(MatrixPoint*)fromPoint to:(MatrixPoint*)toPoint{
    if ([self isLocationInTheMatrix:fromPoint] &&
        [self isLocationInTheMatrix:toPoint]){
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
    //need to meantain another index.....otherwise it will be very time wasting
    //maybe it's not required
    MatrixPoint* point = nil;
    return point;
}

//check if the location is in scope of matrix
-(BOOL)isLocationInTheMatrix:(MatrixPoint*)point{
    BOOL result = YES;
    if (point.x < 0 || point.y<0){
        result = NO;
    }
    
    if (point.x >= self.width || point.y >= self.height){
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

@end
