//
//  OthelloRules.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OthelloRules.h"

@implementation OthelloRules

-(void)resetTable:(ChessTable*)table{
    
}

-(BOOL)isDroppingLegal:(ChessPoint*)point inTable:(ChessTable*)table{
    return NO;
}

-(BOOL)isMovingLegal:(NSArray*)pointArray inTable:(ChessTable*)table{
    return NO;
}

-(ChessStep*)generateStepForDropping:(ChessPoint*)point inTable:(ChessTable*)table{
    return nil;
}

-(ChessStep*)generateStepForMoving:(NSArray*)pointArray inTable:(ChessTable*)table{
    return nil;
}

-(BOOL)doesCurrentPlayerWin:(ChessTable*)table color:(NSString*)color{
    return NO;
}

@end
