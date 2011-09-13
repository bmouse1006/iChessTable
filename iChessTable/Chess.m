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
#import "NSString+ChessPieceColor.h"
#import <Foundation/NSObjCRuntime.h>

@implementation Chess

@synthesize name = _name;
@synthesize table = _table;
@synthesize pieces = _pieces;
@synthesize rules = _rules;
@synthesize pieceModel = _pieceModel;
@synthesize aiClass = _aiClass;

static Chess* _currentChess;

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
//        newChess.move = [(NSNumber*)[plist valueForKey:@"move"] boolValue];
        //change it from dictionary to mutable dictionary
        newChess.pieces = [NSMutableDictionary dictionaryWithCapacity:0];
        NSDictionary* tempPieces = [plist valueForKey:@"pieces"];
        for (NSString* key in [tempPieces allKeys]){
            //we need to modify this dictionary later so all dictionary needs to be changed to mutable one
            if ([[tempPieces valueForKey:key] isKindOfClass:[NSDictionary class]]){
                [newChess.pieces setValue:[NSMutableDictionary dictionaryWithDictionary:[tempPieces valueForKey:key]]
                                   forKey:key];
            }else{
                [newChess.pieces setValue:[tempPieces valueForKey:key]
                                   forKey:key];
            }
            
        }
        
        newChess.rules = [[[NSClassFromString([plist valueForKey:@"rules"]) alloc] init] autorelease];
        newChess.table = [ChessTable chessTableWithPropertyList:[plist valueForKey:@"table"]];
        newChess.pieceModel = [plist valueForKey:@"pieceModel"];
        newChess.aiClass = [plist valueForKey:@"aiClass"];
    }
    @catch (NSException *exception) {
        DebugLog(@"error happened. Reason is %@", exception.reason);
        newChess = nil;
    }
    @finally {
    }
    
    return newChess;
}

+(Chess*)currentChess{
    return _currentChess;
}

#pragma instance method
-(ChessPiece*)getPieceByKind:(NSString*)kind color:(ChessPieceColor)color{
    NSMutableDictionary* piecesForColor = [self.pieces valueForKey:[NSString ChessPieceColorString:color]];
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

-(ChessPiece*)getDefaultPieceByColor:(ChessPieceColor)color{
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
        _currentChess = self;
    }
    
    return self;
}

-(void)dealloc{
    self.name = nil;
    self.table = nil;
    self.pieces = nil;
    self.rules = nil;
    self.pieceModel = nil;
    self.aiClass = nil;
    _currentChess = nil;
    [super dealloc];
}

@end
