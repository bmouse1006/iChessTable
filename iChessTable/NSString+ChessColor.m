//
//  NSString+ChessColor.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSString+ChessColor.h"
#import "ChessPiece.h"

@implementation NSString (NSString_ChessColor)

+(NSString*)chessColorString:(ChessColor)color{
    NSString* colorStr = nil;
    switch (color) {
        case ChessBlackColor:
            colorStr = CHESSBLACKCOLOR;
            break;
        case ChessWhiteColor:
            colorStr = CHESSWHITECOLOR;
        default:
            break;
    }
    return colorStr;
}

@end
