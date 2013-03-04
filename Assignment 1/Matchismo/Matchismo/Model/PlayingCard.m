//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jayashree Nagarajan on 1/27/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int) match:(NSArray *)otherCards
{
    int score= 0;
    if([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if(otherCard.rank == self.rank) {
            score = 4;
        }
    }
    else if([otherCards count] == 2){
        PlayingCard *otherCard1 = [otherCards objectAtIndex:0];
        PlayingCard *otherCard2 = [otherCards objectAtIndex:1];
        if([otherCard1.suit isEqualToString:self.suit] &&
           [otherCard2.suit isEqualToString:self.suit]) {
            score = 3;
        } else if(otherCard1.rank == self.rank &&
                  otherCard2.rank == self.rank) {
            score = 6;
        } else if ([otherCard1.suit isEqualToString:self.suit] ||
                   [otherCard2.suit isEqualToString:self.suit]) {
            score = 2;
        }else if(otherCard1.rank == self.rank ||
                 otherCard2.rank == self.rank) {
            score = 4;
        }
            
    }
    return score;
}

-(NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    
  //  return [rankStrings[self.rank] stringByAppendingString:self.suit];
    return [self.suit stringByAppendingString:rankStrings[self.rank]];
}

//Important Note on @synthesize: when you implement both setter and getter, you won't get @synthesize for free by Objective-C. You will have to explicitly define @synthesize like follows.
@synthesize suit = _suit;
-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(UIImage *) cardImage
{
    _cardImage = [UIImage imageNamed:self.contents];
    return _cardImage;
}

-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

/*
+ (NSArray *) validSuits
{
    return @[@"♥",@"♦",@"♣",@"♠"];
}
*/

+ (NSArray *) validSuits
{
    return @[@"heart-",@"diamond-",@"club-",@"spade-"];
}

/*+ (NSArray *) validSuits
{
    return @[@"heart-",@"dimond-",@"club-",@"spade-"];
}

//NSArray: Objects in array can be of any type, all at the same time!
+(NSArray *) rankStrings
{
    //Non Mutable Array, created on the fly.
   return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

*/
 +(NSArray *) rankStrings
 {
 //Non Mutable Array, created on the fly.
 return @[@"?", @"A.png", @"2.png", @"3.png", @"4.png", @"5.png", @"6.png", @"7.png", @"8.png", @"9.png", @"10.png", @"J.png", @"Q.png", @"K.png"];
 }

+(NSUInteger) maxRank
{
    return [self rankStrings].count - 1;
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


            


@end
