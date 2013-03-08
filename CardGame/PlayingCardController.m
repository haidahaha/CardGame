//
//  PlayingCardController.m
//  CardGame
//
//  Created by Beo Bo on 3/7/13.
//  Copyright (c) 2013 Beo Bo. All rights reserved.
//

#import "PlayingCardController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardController ()

@end

@implementation PlayingCardController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
@end
