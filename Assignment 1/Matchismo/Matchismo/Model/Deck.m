//
//  Deck.m
//  Matchismo
//
//  Created by Jayashree Nagarajan on 1/27/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import "Deck.h"

@interface Deck()

//This is a private property as it's declared within the implementation class and not the head file.
//NSMutableArray - you can add objects to it and modify them. (As opposed to NSArray where you can't add / modify objects)
@property(strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

//A note of setter-getter in Object-C:
//If you implement the setter and getters like below, the compiler won't implement for you. If not, the compiler provides a default implementation.
-(NSMutableArray *)cards
{
    //lazy instatiation
    //alloc and init ALWAYS are nested like as follows. Never separate them. You will get into trouble.
    //They all start out with zero.
    if(!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

-(void)addCard:(id)card atTop:(BOOL)atTop
{
    //this check is necessary to check if the card that we pass in is not NIL. You can't pass a NIL to an array! It will crash!. 
    if(card)
    {
        if(atTop) {
            [self.cards insertObject:card atIndex:0];
        }else {
            [self.cards addObject:card];
        }
    }
    
}

//nil is a keyword for number zero.

-(Card *)drawRandowmCard
{
    Card *randomCard = nil;
    int count = self.cards.count;
    if(count > 0 ) {
        unsigned index = arc4random() % count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
