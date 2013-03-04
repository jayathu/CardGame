//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jayashree Nagarajan on 1/27/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) UIImage *cardImage;
+(NSArray *)validSuits;
+(NSUInteger) maxRank;
+(NSArray *)rankStrings;

@end
