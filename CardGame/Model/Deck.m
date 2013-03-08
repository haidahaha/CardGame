//
//  Deck.m
//  CardGame
//
//  Created by Beo Bo on 1/31/13.
//  Copyright (c) 2013 Beo Bo. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop)
        [self.cards insertObject:card atIndex:0];
    else
        [self.cards addObject:card];
}

- (Card *)drawRandomCard
{
    Card *randomcard = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomcard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomcard;
}
@end
