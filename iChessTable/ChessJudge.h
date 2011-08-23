//
//  ChessJudge.h
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessRules.h"

@interface ChessJudge : NSObject{
    id<ChessRules> _rules;
}

@property (nonatomic, retain) id<ChessRules> rules;

//generate a new judge with given rules
+(ChessJudge*)judgeWithRules:(id<ChessRules>)rules;

@end
