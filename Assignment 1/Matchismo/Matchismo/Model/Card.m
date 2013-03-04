//
//  Card.m
//  Matchismo
//
//  Created by Jayashree Nagarajan on 1/27/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize contents = _contents;
@synthesize faceUp = _faceUp;
@synthesize unplayable = _unplayable;

-(int) match:(NSArray *)otherCards
{
    int score = 0;
    for(Card *card in otherCards)
    {
        if([card.contents isEqualToString:self.contents]) {
            score += 1;
            
        }
    }
    
    return score;
}



 @end
