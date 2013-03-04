//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jayashree Nagarajan on 2/4/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import "CardMatchingGame.h"


@interface  CardMatchingGame ()

@property (readwrite, nonatomic) int score ; //public readonly, private readwrite

@property (strong, nonatomic) NSMutableArray *cards; //of Card

//WikiNote:
//there is no way in Objective-C to specify what KIND of objects can an NSMutableArray or NSArray can have.
@property (readwrite, nonatomic) NSString *display;

@end


@implementation CardMatchingGame
//Tip:Ideally you might wanna have these configurable - like properties and not some constants like below.
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(NSMutableArray * )cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


- (void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(card && !card.isUnplayable) {
        if(!card.isFaceUp) {
            
            self.display = [NSString stringWithString:card.contents];
            self.display = [self.display stringByAppendingString:@"was flipped!"];
            
        for(Card *otherCard in self.cards) {
            if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                int matchScore = [card match:@[otherCard]];  //making an array on demand - new in ios6.
                if(matchScore) {
                    card.unplayable = YES;
                    otherCard.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    self.display = [NSString stringWithString:card.contents];
                    self.display = [self.display stringByAppendingString:@"and "];
                    self.display = [self.display stringByAppendingString:otherCard.contents];
                    self.display = [self.display stringByAppendingString:@"match! with 4 points!"];
                    
                    
                } else {
                    otherCard.faceUp = NO;
                    self.score -= MISMATCH_PENALTY;
                    self.display = [NSString stringWithString:card.contents];
                    self.display = [self.display stringByAppendingString:@"and "];
                    self.display = [self.display stringByAppendingString:otherCard.contents];
                    self.display = [self.display stringByAppendingString:@"don't match! Penalty 2 points!"];
                }
                
                break;
            }
        }
        self.score -= FLIP_COST;
    }
        
    card.faceUp = !card.isFaceUp;
       
    }
}

//WikiNote:
//NSArray count is not a property but a method. Try holding Alt Key and Click on count below. You'll see it's a method.
//And you really shouldn't use dot notation on count as if it were a property.
//Only propeties get to be called using dot notatios.

//Also, you really shouldn't have a property to be doing a lot of calculations. If it does, you should make it a method. This is really an art of programming thing.

-(Card *) cardAtIndex:(NSUInteger)index
{
    return ( index < [self.cards count]) ? self.cards[index] : nil;
}

-(id) initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck;
{
    self = [super init];
    if(self) {
        for(int i = 0; i < count; i++) {
            Card *card = [deck drawRandowmCard];
            
            if(card) {  //what if somebody tried to init with 100 cards, so we check 
                self.cards[i] = card;
            } else {
                self = nil;
            }
        }
    }
    
    return self;
}
@end
