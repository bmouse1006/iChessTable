//
//  NSString+ChessColor.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHESSBLACKCOLOR @"chessBlackColor"
#define CHESSWHITECOLOR @"chessWhiteColor"

@interface NSString (NSString_ChessColor)

+(NSString*)chessBlackColor;
+(NSString*)chessWhiteColor;

@end
