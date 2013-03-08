//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by Beo Bo on 1/31/13.
//  Copyright (c) 2013 Beo Bo. All rights reserved.
//

#import "MatchingDeck.h"
#import "MatchingCard.h"
@implementation MatchingDeck
- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [MatchingCard validSuit]) {
            for (NSUInteger rank = 1; rank <= [MatchingCard maxRank]; rank++) {
                MatchingCard *card = [[MatchingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}
@end
