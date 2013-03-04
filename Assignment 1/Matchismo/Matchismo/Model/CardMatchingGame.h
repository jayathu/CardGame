//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jayashree Nagarajan on 2/4/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject
//WikiNote:
//(other initializers - convenient initializer are possible which
//will have to call designated initializer, if needed.
//designated initializer
-(id) initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck;

-(void) flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex : (NSUInteger) index;
 

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *display;
@end
