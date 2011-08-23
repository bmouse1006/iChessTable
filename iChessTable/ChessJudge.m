//
//  ChessJudge.m
//  iChessTable
//
//  Created by Jin Jin on 11-8-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ChessJudge.h"

@implementation ChessJudge

@synthesize rules = _rules;

+(ChessJudge*)judgeWithRules:(id<ChessRules>)rules{
    ChessJudge* judge = [[ChessJudge alloc] init];
    //add more code here
    judge.rules = rules;
    
    return [judge autorelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc{
    self.rules = nil;
    [super dealloc];
}

@end
