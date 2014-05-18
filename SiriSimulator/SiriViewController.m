//
//  SiriViewController.m
//  PinterestSiri
//
//  Created by Wendy Lu on 11/15/13.
//  Copyright (c) 2013 Pinterest. All rights reserved.
//

#import "SiriLoadingView.h"
#import "SiriMicView.h"
#import "SiriViewController.h"
#import "SiriWaveView.h"

typedef enum {
    kSiriStateSmallWave = 0,
    kSiriStateLargeWave,
    kSiriStateLoading,
    kSiriStateLoaded,
} SiriAnimationState;

@interface SiriViewController ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SiriWaveView *waveView;
@property (nonatomic, strong) SiriLoadingView *loadingView;
@property (nonatomic, strong) SiriMicView *micView;
@property (nonatomic, strong) UIImageView *questionImageView;
@property (nonatomic, assign) SiriAnimationState state;
@end

@implementation SiriViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];

    self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:(25/255.0) green:(38/255.0) blue:(49/255.0) alpha:1.0];
    [self.view addSubview:self.backgroundView];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30.0];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"What can I help\nyou with?";

    CGRect frame;
    frame.size.width = 250.0;
    frame.size.height = 100.0;
    frame.origin.x = (CGRectGetWidth(self.view.frame) - CGRectGetWidth(frame)) / 2;
    frame.origin.y = 65.0;
    self.titleLabel.frame = frame;
    [self.view addSubview:self.titleLabel];

    self.waveView = [[SiriWaveView alloc] initWithFrame:[self waveViewFrame]];
    self.waveView.amplitude = 10.0;
    self.waveView.wavelength = 160.0;
    [self.view addSubview:self.waveView];
    self.state = kSiriStateSmallWave;

    self.loadingView = [[SiriLoadingView alloc] initWithFrame:[self loadingViewFrame]];
    self.loadingView.hidden = YES;
    [self.view addSubview:self.loadingView];

    self.micView = [[SiriMicView alloc] initWithFrame:[self loadingViewFrame]];
    self.micView.hidden = YES;
    [self.view addSubview:self.micView];

    self.questionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"question-mark-icon"]];
    frame = self.questionImageView.frame;
    frame.origin.x = 12.0;
    frame.origin.y = 533.0;
    self.questionImageView.frame = frame;
    [self.view addSubview:self.questionImageView];
    self.questionImageView.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed:)];
    [self.questionImageView addGestureRecognizer:tapRecognizer];
}

#pragma mark -
#pragma mark Private Methods

- (void)setState:(SiriAnimationState)state
{
    _state = state;

    switch ((SiriAnimationState)state) {
        case kSiriStateSmallWave:
            self.waveView.amplitude = 15.0;
            self.waveView.hidden = NO;
            self.loadingView.hidden = YES;
            self.micView.hidden = YES;
            break;

        case kSiriStateLargeWave:
            self.waveView.amplitude = 90.0;
            self.waveView.hidden = NO;
            self.loadingView.hidden = YES;
            self.micView.hidden = YES;
            break;

        case kSiriStateLoading:
            self.waveView.amplitude = 15.0;
            self.waveView.hidden = YES;
            self.loadingView.hidden = NO;
            self.micView.hidden = YES;
            break;

        case kSiriStateLoaded:
            self.waveView.amplitude = 15.0;
            self.waveView.hidden = YES;
            self.loadingView.hidden = YES;
            self.micView.hidden = NO;
            break;
    }
}

- (CGRect)waveViewFrame
{
    CGRect frame;
    frame.origin.x = -320.0;
    frame.origin.y = CGRectGetHeight(self.view.frame) - 70.0;
    frame.size.width = CGRectGetWidth(self.view.frame) * 2;
    frame.size.height = 100.0;
    return frame;
}

- (CGRect)loadingViewFrame
{
    CGRect frame;
    frame.size.width = 75.0;
    frame.size.height = 75.0;
    frame.origin.x = (CGRectGetWidth(self.view.frame) - CGRectGetWidth(frame)) / 2;
    frame.origin.y = CGRectGetHeight(self.view.frame) - CGRectGetHeight(frame) - 12.0;
    return frame;
}

- (void)buttonPressed:(id)sender
{
    switch ((SiriAnimationState)self.state) {

        case kSiriStateSmallWave:
            self.state = kSiriStateLargeWave;
            break;

        case kSiriStateLargeWave:
            self.state = kSiriStateLoading;
            break;

        case kSiriStateLoading:
            self.state = kSiriStateLoaded;
            break;

        case kSiriStateLoaded:
            self.state = kSiriStateSmallWave;
            break;
    }
}

#pragma mark -
#pragma mark UIViewController Overrides

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
