//
//  ChessPiece.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChessPiece : NSObject{
    
    NSString* _name;
    NSString* _chessName;
    NSString* _color;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* chessName;
@property (nonatomic, retain) NSString* color;
@property (nonatomic, readonly, getter = getImageName) NSString* imageName;//combined by chessname+name+color

//generate a new chess by given property list
//returns nil if any exception happens
+(ChessPiece*)chessPieceWithProperyList:(NSDictionary*)plist andColor:(NSString*)color; 

@end
