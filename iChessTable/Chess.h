//
//  Chess.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessRules.h"
#import "ChessPiece.h"

@class ChessTable;

@interface Chess : NSObject{
    NSString* _name; 
    ChessTable* _table;    
    //key is ChessPieceColor, instance of NSString. Value is NSDictionary, which store names of piece and according number
    //number could be changed. So use mutable dictionary
    NSMutableDictionary* _pieces;     
    id<ChessRules> _rules;
    NSDictionary* _pieceModel;
    
    //Class name for AI
    NSString* _aiClass;
}

@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) ChessTable* table;
@property (retain, nonatomic) NSMutableDictionary* pieces;
@property (retain, nonatomic) id<ChessRules> rules;
@property (nonatomic, retain) NSDictionary* pieceModel;
@property (nonatomic, retain) NSString* aiClass;

+(Chess*)chessWithBundleName:(NSString*)name;
+(Chess*)chessWithPropertyList:(NSDictionary*)plist;

//get an instance of piece by kind and color, in the piece pool
-(ChessPiece*)getPieceByKind:(NSString*)kind color:(ChessPieceColor)color;
//get an instance for default type of piece, by color
-(ChessPiece*)getDefaultPieceByColor:(ChessPieceColor)color;
-(NSString*)defaultPieceKind;

@end
