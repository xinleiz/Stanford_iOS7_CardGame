//
//  ViewController.m
//  Matchismo
//
//  Created by Zhang Xinlei on 11/25/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//models are like the data source of controller.
@property (nonatomic, strong) CardMatchingGame* game;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *cardButtons;//card are stored in random order.
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end


@implementation ViewController

-(CardMatchingGame *) game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]
                         ];
    return _game;
}

-(Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

//"Sender" is the object that will send messages to the controller
- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score %ld", (long)self.game.score];
    }
    
}

- (NSString *)titleForCard: (Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard : (Card *) card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
@end
