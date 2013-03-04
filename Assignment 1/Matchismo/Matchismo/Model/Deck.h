//
//  Deck.h
//  Matchismo
//
//  Created by Jayashree Nagarajan on 1/27/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject


-(void)addCard:(Card *)card atTop:(BOOL)atTop;

-(Card *)drawRandowmCard;

@end
