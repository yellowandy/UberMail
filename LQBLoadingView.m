//
//  LQBLoadingView.m
//  UberMail
//
//  Created by Amanda Sandberg on 4/22/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import "LQBLoadingView.h"

@implementation LQBLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Load the nib
        [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil];
        [self addSubview:self.view];
        [self.spinnerView startAnimating];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
