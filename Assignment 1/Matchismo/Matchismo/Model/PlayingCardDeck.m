//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Jayashree Nagarajan on 1/27/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

//id means pointer to an object of any class.
//we always have our initializer return id.
-(id)init
{
    //Give the super class a chance to initialize.
    //For some reason, it can't initialize (that almost never happens!)
    //then return itself.
    //It's just a weird convention. Just follow it!
    
    self = [super init];
    if(self)
    {
        for(NSString *suit in [PlayingCard validSuits])
        {
            for(NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++)
            {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:true];
            }
        }
    }
    
    return self;
}


@end
