//
//  ThreeCardMatchingGame.m
//  Matchismo
//
//  Created by JAYASHREE NAGARAJAN on 3/3/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import "ThreeCardMatchingGame.h"

@interface  ThreeCardMatchingGame ()
@property (readwrite, nonatomic) int score ; //public readonly, private readwrite
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@property (readwrite, nonatomic) NSString *display;
@property (readwrite, nonatomic)  NSMutableArray *faceUpCards;
@end

@implementation ThreeCardMatchingGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

-(NSMutableArray *) faceUpCards
{
    if(!_faceUpCards) _faceUpCards = [[NSMutableArray alloc] init];
    return _faceUpCards;
}

-(void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(card && !card.isUnplayable) {
        if(!card.isFaceUp) {
            
            self.display = [NSString stringWithString:card.contents];
            self.display = [self.display stringByAppendingString:@"was flipped!"];
            
            for(Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable && [self.faceUpCards count] < 2) {
                    if(![self.faceUpCards containsObject:otherCard])
                    {
                        [self.faceUpCards addObject:otherCard];
                        NSLog(@"Adding = %@", [otherCard contents]);
                        
                        if([self.faceUpCards count] == 2)
                        {
                            NSLog(@"Count = 2");
                            int matchScore = [card match:self.faceUpCards];  //making an array on demand - new in ios6.
                            if(matchScore) {
                                card.unplayable = YES;
                                for(Card *c in self.faceUpCards) {
                                    c.unplayable = YES;
                                }
                                self.score += matchScore * MATCH_BONUS;
                                self.display = [NSString stringWithString:card.contents];
                                self.display = [self.display stringByAppendingString:@"and "];
                                for(Card *c in self.faceUpCards) {
                                    self.display = [self.display stringByAppendingString:c.contents];
                                    self.display = [self.display stringByAppendingString:@" "];
                                }
                                self.display = [self.display stringByAppendingString:@"match!"];
                                
                                
                            } else {
                                for(Card *c in self.faceUpCards) {
                                    c.faceUp = NO;
                                }
                                self.score -= MISMATCH_PENALTY;
                                self.display = [NSString stringWithString:card.contents];
                                self.display = [self.display stringByAppendingString:@"and "];
                                for(Card *c in self.faceUpCards) {
                                    self.display = [self.display stringByAppendingString:c.contents];
                                    self.display = [self.display stringByAppendingString:@" "];
                                }
                                self.display = [self.display stringByAppendingString:@"Dont Match!"];
                            }
                            NSLog(@"setting opened cards to Nil");
                            self.faceUpCards = nil;
                            break;
                        }
                    }else {
                        NSLog(@"Already contains %@", [otherCard contents] );
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
        if(!card.isFaceUp && [self.faceUpCards containsObject:card])
        {
            NSLog(@"Removing %@", [card contents]);
            [self.faceUpCards removeObject:card];
        }
        
    }
    
}


@end
