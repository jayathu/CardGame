//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jayashree Nagarajan on 1/27/13.
//  Copyright (c) 2013 Standford University. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "ThreeCardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabels;

//outlet connection is an array pointing to a collection of buttons.
//control-drag each button onto this collection property to link them to the collection
//the order of the buttons in the array are undetermined.
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

//No more required, now that we have a pointer to the Model (CardMatchingGame) that takes care of initializing Deck
//@property (strong, nonatomic) Deck *deck;
@property (nonatomic) int flipCount;
@property(nonatomic) UIImage *cardBackImage;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gamePlayMode;



//@property (weak, nonatomic) IBOutlet UILabel *display;

@end

@implementation CardGameViewController

#define TWO_CARD_MATCHING_GAME 0
#define THREE_CARD_MATCHING_GAME 1

#define ENABLED_ALPHA 1.0
#define DISABLED_ALPHA 0.3

-(UIImage *) cardBackImage
{
    _cardBackImage = [UIImage imageNamed:@"card-back@2x.png"];
    return _cardBackImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
}


- (CardMatchingGame *) game
{
    if(!_game) {
        switch (self.gamePlayMode.selectedSegmentIndex) {
            case TWO_CARD_MATCHING_GAME:
                NSLog(@"Initializing 2-Card-Matching Game");
                _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[PlayingCardDeck alloc] init]];
                
                break;
                
            case THREE_CARD_MATCHING_GAME:
                NSLog(@"Initializing 3-Card-Matching Game");
                _game = [[ThreeCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[PlayingCardDeck alloc] init]];
                
                break;
        }
    }
    return _game;
}


- (IBAction)deal:(id)sender {
    
    
    self.game = nil;
    self.gamePlayMode.enabled = YES;
    self.gamePlayMode.alpha = ENABLED_ALPHA;
    [self updateUI];
}

- (IBAction)gamePlaySelect:(id)sender {
    self.game = nil;
}

//this is just a setter for cardButton property
-(void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
    /*for(UIButton *cardButton in self.cardButtons) {
        Card *card = [self.deck drawRandowmCard];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }*/
}

-(void) updateUI
{
    for(UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
       
        cardButton.imageEdgeInsets = UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0);
        if(!card.isFaceUp) {
            
            [cardButton setBackgroundImage:self.cardBackImage forState:UIControlStateNormal];
        } else {
            UIImage *image = [UIImage imageNamed:card.contents];
            [cardButton setBackgroundImage:image forState:UIControlStateNormal];
            [cardButton setBackgroundImage:image 
                        forState:UIControlStateSelected |
                        UIControlStateHighlighted];
        }
        //set title for label with UIControlStateSelected
        //[cardButton setTitle:card.contents forState:UIControlStateSelected];
        //[cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.display.text = [self.game display];
}

@synthesize flipLabels;

/*@synthesize deck = _deck;

-(Deck *) deck {
    if(!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
        
    }
    
    return _deck;
}*/

-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabels.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    self.gamePlayMode.enabled = NO;
    self.gamePlayMode.alpha = DISABLED_ALPHA;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    NSString * _contents = [[self.game cardAtIndex:[self.cardButtons indexOfObject:sender]] contents];
     NSLog(@"CONTENTS = %@", _contents);
    self.flipCount++;
    [self updateUI];
    
    ///sender.selected = !sender.isSelected;
    /*Card *randomCard = self.deck.drawRandowmCard;
    [sender setTitle:randomCard.contents forState:UIControlStateSelected];
    NSLog(@"%@", randomCard.contents);
    self.flipCount++;*/

    
    
}

@end
