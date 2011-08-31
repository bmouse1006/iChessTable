//
//  Chess.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Chess.h"
#import "ChessTable.h"
#import "ChessPiece.h"
#import "NSString+ChessColor.h"
#import <Foundation/NSObjCRuntime.h>

@implementation Chess

@synthesize name = _name;
@synthesize move = _move;
@synthesize table = _table;
@synthesize pieces = _pieces;
@synthesize rules = _rules;
@synthesize pieceModel = _pieceModel;

#pragma class method
+(Chess*)chessWithBundleName:(NSString*)name{
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    
    NSDictionary* bundle = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    return [self chessWithPropertyList:bundle];

}

+(Chess*)chessWithPropertyList:(NSDictionary*)plist{
    Chess* newChess = nil;
    @try {
        newChess = [[[Chess alloc] init] autorelease];
        newChess.name = [plist valueForKey:@"name"];
        newChess.move = [(NSNumber*)[plist valueForKey:@"move"] boolValue];
        //change it from dictionary to mutable dictionary
        newChess.pieces = [NSMutableDictionary dictionaryWithDictionary:0];
        NSDictionary* tempPieces = [plist valueForKey:@"pieces"];
        for (NSString* key in [tempPieces allKeys]){
            [newChess.pieces setValue:[NSMutableDictionary dictionaryWithDictionary:[tempPieces valueForKey:key]]
                                                                             forKey:key];
        }
        
        newChess.rules = [[[NSClassFromString([plist valueForKey:@"rules"]) alloc] init] autorelease];
        newChess.table = [ChessTable chessTableWithPropertyList:[plist valueForKey:@"table"]];
        newChess.pieceModel = [plist valueForKey:@"pieceModel"];
    }
    @catch (NSException *exception) {
        DebugLog(@"error happened. Reason is %@", exception.reason);
        newChess = nil;
    }
    @finally {
    }
    
    return newChess;
}

#pragma instance method
-(ChessPiece*)getPieceByKind:(NSString*)kind color:(ChessColor)color{
    NSMutableDictionary* piecesForColor = [self.pieces valueForKey:[NSString chessColorString:color]];
    NSNumber* numberForPiece = [piecesForColor valueForKey:kind];
    if ([numberForPiece isEqualToNumber:[NSNumber numberWithInt:0]]){
        //if no more pieces
        return nil;
    }else{
        NSNumber* newNum = [NSNumber numberWithInt:[numberForPiece intValue]-1];
        [piecesForColor setValue:newNum forKey:kind];
    }
    
    //generate a new instance of piece and return
    return [ChessPiece chessPieceWithProperyList:[self.pieceModel valueForKey:kind]
                                        andColor:color];
}

-(ChessPiece*)getDefaultPieceByColoy:(ChessColor)color{
    return [self getPieceByKind:[self defaultPieceKind]
                          color:color];
}

-(NSString*)defaultPieceKind{
    return [self.pieces objectForKey:@"defaultPieceKind"];
}

//init and dealloc
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc{
    self.name = nil;
    self.table = nil;
    self.pieces = nil;
    self.rules = nil;
    self.pieceModel = nil;
    [super dealloc];
}

@end
