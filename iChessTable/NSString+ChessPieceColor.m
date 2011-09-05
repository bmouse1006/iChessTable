//
//  NSString+ChessPieceColor.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSString+ChessPieceColor.h"
#import "ChessPiece.h"

@implementation NSString (NSString_ChessPieceColor)

+(NSString*)ChessPieceColorString:(ChessPieceColor)color{
    NSString* colorStr = nil;
    switch (color) {
        case ChessBlackColor:
            colorStr = CHESSBLACKCOLOR;
            break;
        case ChessWhiteColor:
            colorStr = CHESSWHITECOLOR;
            break;
        case ChessMaxColor:
            colorStr = CHESSMAXCOLOR;
            break;
        default:
            break;
    }
    return colorStr;
}

@end
