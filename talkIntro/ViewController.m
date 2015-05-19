//
//  ViewController.m
//  talkIntro
//
//  Created by 史丹青 on 15/5/18.
//  Copyright (c) 2015年 sdq. All rights reserved.
//

#import "ViewController.h"
#import "StyledPageControl.h"

#define NUMBER_OF_PAGES 4

#define timeForPage(page) (NSInteger)(self.view.frame.size.width * (page - 1))

@interface ViewController ()

@property (nonatomic) NSInteger currentPageIndex;

//pageControl
@property (strong, nonatomic) StyledPageControl *pageControl;

//page1
@property (strong, nonatomic) UIImageView *titleView1;
@property (strong, nonatomic) UIImageView *voiceGroup;
@property (strong, nonatomic) UIImageView *myVoice;
@property (strong, nonatomic) UIImageView *redPoint;

//page2
@property (strong, nonatomic) UIImageView *titleView2;
@property (strong, nonatomic) UIImageView *searchField;
@property (strong, nonatomic) UIImageView *searchResult;
@property (strong, nonatomic) UIImageView *pdfIcon;

//page3
@property (strong, nonatomic) UIImageView *titleView3;
@property (strong, nonatomic) UIImageView *categoryIcon;
@property (strong, nonatomic) UIImageView *categoryItems;

//page4
@property (strong, nonatomic) UIImageView *titleView4;
@property (strong, nonatomic) UIImageView *teamColor;
@property (strong, nonatomic) UIImageView *greenPoint;
@property (strong, nonatomic) UIButton *startButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //hide the status bar
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    //set scrollview
    self.scrollView.contentSize = CGSizeMake(NUMBER_OF_PAGES * CGRectGetWidth(self.view.frame),
                                              CGRectGetHeight(self.view.frame));
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.accessibilityLabel = @"Intro";
    self.scrollView.accessibilityIdentifier = @"Talk";
    
    [self initPageControl];
    
    [self placeViews];
    [self configureAnimation];
    
    self.delegate = self;
}

#pragma mark - pageControl

- (void)initPageControl
{
    //init pagecontrol
    StyledPageControl *pageControl = [[StyledPageControl alloc] init];
    pageControl.frame = CGRectMake(0, self.view.bounds.size.height - 80, self.view.bounds.size.width, 14);
    pageControl.numberOfPages = NUMBER_OF_PAGES;
    pageControl.currentPage = 0;
    [pageControl setPageControlStyle:PageControlStyleDefault];
    [pageControl setCoreNormalColor:[UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:217/255.f]];
    [pageControl setCoreSelectedColor:[UIColor colorWithRed:25/255.f green:118/255.f blue:210/255.f alpha:1]];
    [pageControl setGapWidth:23];
    [pageControl setDiameter:14];
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}

#pragma mark - placeViews

- (void)placeViews
{
    [self placeViewsOnPage1];
    [self placeViewsOnPage2];
    [self placeViewsOnPage3];
    [self placeViewsOnPage4];
}

- (void)placeViewsOnPage1
{
    UIImageView *titleView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title1CN"]];
    [self.scrollView addSubview:titleView1];
    self.titleView1 = titleView1;
    [self.titleView1 setCenter:CGPointMake(self.view.center.x, 0)];
    
    UIImageView *voiceGroup = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VoiceGroup"]];
    [self.scrollView addSubview:voiceGroup];
    self.voiceGroup = voiceGroup;
    [self.voiceGroup setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    
    UIImageView *myVoice = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyVoice"]];
    [self.scrollView addSubview:myVoice];
    self.myVoice = myVoice;
    [self.myVoice setCenter:CGPointMake(self.view.center.x + self.myVoice.frame.size.width/2 , self.view.center.y + self.voiceGroup.frame.size.height/2 + self.myVoice.frame.size.height)];
    
    UIImageView *redPoint = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RedPoint"]];
    [self.scrollView addSubview:redPoint];
    self.redPoint = redPoint;
    [self.redPoint setCenter:CGPointMake(self.view.center.x + self.voiceGroup.frame.size.width/6 , self.view.center.y + self.voiceGroup.frame.size.height*19/50)];
}

- (void)placeViewsOnPage2
{
    UIImageView *titleView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title2CN"]];
    [self.scrollView addSubview:titleView2];
    self.titleView2 = titleView2;
    
    [self.titleView2 setCenter:CGPointMake(self.view.center.x + timeForPage(4), 0)];//out of the screen
    
    UIImageView *searchField = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchField"]];
    [self.scrollView addSubview:searchField];
    self.searchField = searchField;
    [self.searchField setCenter:CGPointMake(self.view.center.x + timeForPage(2), self.view.center.y - self.searchField.frame.size.height * 2)];
    
    UIImageView *searchResult = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchResult"]];
    [self.scrollView addSubview:searchResult];
    self.searchResult = searchResult;
    [self.searchResult setCenter:CGPointMake(self.view.center.x + timeForPage(2), self.view.center.y - self.searchField.frame.size.height + self.searchResult.frame.size.height/2 + self.view.frame.size.height/2)];
    
    UIImageView *pdfIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pdfIcon"]];
    [self.scrollView addSubview:pdfIcon];
    self.pdfIcon = pdfIcon;
    [self.pdfIcon setCenter:CGPointMake(self.view.center.x + timeForPage(2) - self.searchResult.frame.size.width*81/200 , self.view.center.y + self.searchResult.frame.size.height*43/100)];
}

- (void)placeViewsOnPage3
{
    UIImageView *titleView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title3CN"]];
    [self.scrollView addSubview:titleView3];
    self.titleView3 = titleView3;
    
    [self.titleView3 setCenter:CGPointMake(self.view.center.x + timeForPage(3), 0)];
    
    UIImageView *categoryIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CategoryIcon"]];
    [self.scrollView addSubview:categoryIcon];
    self.categoryIcon = categoryIcon;
    [self.categoryIcon setCenter:CGPointMake(self.view.center.x + timeForPage(3), self.view.center.y - self.categoryIcon.frame.size.height)];
    
    UIImageView *categoryItems = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CategoryItemsCN"]];
    [self.scrollView addSubview:categoryItems];
    self.categoryItems = categoryItems;
    [self.categoryItems setCenter:CGPointMake(self.view.center.x + timeForPage(2), self.view.center.y)];
}

- (void)placeViewsOnPage4
{
    UIImageView *titleView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title4CN"]];
    [self.scrollView addSubview:titleView4];
    self.titleView4 = titleView4;
    
    [self.titleView4 setCenter:CGPointMake(self.view.center.x + timeForPage(4), 0)];
    
    UIImageView *teamColor = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TeamColor"]];
    [self.scrollView addSubview:teamColor];
    self.teamColor = teamColor;
    [self.teamColor setCenter:CGPointMake(self.view.center.x + timeForPage(4), self.view.center.y)];
    
    UIButton *startButton = [[UIButton alloc] init];
    UIImage *startButtonImg = [UIImage imageNamed:@"StartButtonCN"];
    startButton.frame = CGRectMake(0, 0, startButtonImg.size.width, startButtonImg.size.height);
    [startButton setBackgroundImage:startButtonImg forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(appStart) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:startButton];
    self.startButton = startButton;
    [self.startButton setCenter:CGPointMake(self.view.center.x + timeForPage(4), self.view.bounds.size.height - 80)];
    
    UIImageView *greenPoint = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GreenPoint"]];
    [self.scrollView addSubview:greenPoint];
    self.greenPoint = greenPoint;
    [self.greenPoint setCenter:CGPointMake(self.view.center.x + timeForPage(4) + self.teamColor.frame.size.width/6 , self.view.center.y + self.voiceGroup.frame.size.height*19/50)];
}

#pragma mark - configure animation

- (void)configureAnimation
{
    [self configureBackgroundAnimation];
    [self configurePage1Animation];
    [self configurePage2Animation];
    [self configurePage3Animation];
    [self configurePage4Animation];
}

- (void)configureBackgroundAnimation
{
    //Scrollview background color
    IFTTTColorAnimation *backgroundColorAnimation = [IFTTTColorAnimation new];
    backgroundColorAnimation.view = self.scrollView;
    [self.animator addAnimation:backgroundColorAnimation];
    
    [backgroundColorAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1) andColor:[UIColor colorWithRed:25/255.f green:118/255.f blue:210/255.f alpha:5/100.f]]];
    [backgroundColorAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2) andColor:[UIColor colorWithRed:136/255.f green:50/255.f blue:151/255.f alpha:4/100.f]]];
    [backgroundColorAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3) andColor:[UIColor colorWithRed:0/255.f green:150/255.f blue:136/255.f alpha:4/100.f]]];
    [backgroundColorAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4) andColor:[UIColor colorWithRed:92/255.f green:107/255.f blue:192/255.f alpha:5/100.f]]];
    
}

- (void)configurePage1Animation
{
    //titleView frame animation
    IFTTTFrameAnimation *titleView1FrameAnimation = [IFTTTFrameAnimation new];
    titleView1FrameAnimation.view = self.titleView1;
    [self.animator addAnimation:titleView1FrameAnimation];
    
    [titleView1FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1)
                                                                                    andFrame:self.titleView1.frame]];
    [titleView1FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                           andFrame:CGRectOffset(self.titleView1.frame, timeForPage(2), 0)]];
    [titleView1FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                           andFrame:CGRectOffset(self.titleView1.frame, timeForPage(3), 0)]];
    [titleView1FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4)
                                                                           andFrame:CGRectOffset(self.titleView1.frame, timeForPage(4), 0)]];
    
    //titleView alpha animation
    IFTTTAlphaAnimation *titleView1AlphaAnimation = [IFTTTAlphaAnimation new];
    titleView1AlphaAnimation.view = self.titleView1;
    [self.animator addAnimation:titleView1AlphaAnimation];
    
    [titleView1AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1) andAlpha:1.0f]];
    [titleView1AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2) andAlpha:0.0f]];
    
    //myVoice frame animation
    IFTTTFrameAnimation *myVoiceFrameAnimation = [IFTTTFrameAnimation new];
    myVoiceFrameAnimation.view = self.myVoice;
    [self.animator addAnimation:myVoiceFrameAnimation];
    [myVoiceFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1)
                                                                              andFrame:self.myVoice.frame]];
    [myVoiceFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                              andFrame:CGRectOffset(self.myVoice.frame, timeForPage(3), 0)]];
    //hide
    IFTTTHideAnimation *myVoiceHideAnimation = [[IFTTTHideAnimation alloc] initWithView:self.myVoice hideAt:timeForPage(2)];
    [self.animator addAnimation:myVoiceHideAnimation];
    
    //redPoint frame animation
    IFTTTFrameAnimation *redPointFrameAnimation = [IFTTTFrameAnimation new];
    redPointFrameAnimation.view = self.redPoint;
    [self.animator addAnimation:redPointFrameAnimation];
    [redPointFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1)
                                                                           andFrame:self.redPoint.frame]];
    [redPointFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                           andFrame:self.pdfIcon.frame]];
    
    //redPoint alpha animation
    IFTTTAlphaAnimation *redPointAlphaAnimation = [IFTTTAlphaAnimation new];
    redPointAlphaAnimation.view = self.redPoint;
    [self.animator addAnimation:redPointAlphaAnimation];
    
    [redPointAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1) andAlpha:1.0f]];
    [redPointAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2) andAlpha:0.0f]];
    
}

- (void)configurePage2Animation
{
    //titleView frame animation
    IFTTTFrameAnimation *titleView2FrameAnimation = [IFTTTFrameAnimation new];
    titleView2FrameAnimation.view = self.titleView2;
    [self.animator addAnimation:titleView2FrameAnimation];
    
    [titleView2FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1)
                                                                              andFrame:self.titleView1.frame]];
    [titleView2FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                              andFrame:CGRectOffset(self.titleView1.frame, timeForPage(2), 0)]];
    [titleView2FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                              andFrame:CGRectOffset(self.titleView1.frame, timeForPage(3), 0)]];
    [titleView2FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4)
                                                                              andFrame:CGRectOffset(self.titleView1.frame, timeForPage(4), 0)]];
    
    //titleView alpha animation
    IFTTTAlphaAnimation *titleView2AlphaAnimation = [IFTTTAlphaAnimation new];
    titleView2AlphaAnimation.view = self.titleView2;
    [self.animator addAnimation:titleView2AlphaAnimation];
    
    [titleView2AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1) andAlpha:0.0f]];
    [titleView2AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2) andAlpha:1.0f]];
    [titleView2AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3) andAlpha:0.0f]];
    
    //searchField alpha animation
    IFTTTAlphaAnimation *searchFieldAlphaAnimation = [IFTTTAlphaAnimation new];
    searchFieldAlphaAnimation.view = self.searchField;
    [self.animator addAnimation:searchFieldAlphaAnimation];
    
    [searchFieldAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1.5) andAlpha:0.0f]];
    [searchFieldAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2) andAlpha:1.0f]];
    [searchFieldAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2.5) andAlpha:0.0f]];
    
    //searchResult frame animation
    IFTTTFrameAnimation *searchResultFrameAnimation = [IFTTTFrameAnimation new];
    searchResultFrameAnimation.view = self.searchResult;
    [self.animator addAnimation:searchResultFrameAnimation];
    
    [searchResultFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1)
                                                                              andFrame:self.searchResult.frame]];
    [searchResultFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                              andFrame:CGRectOffset(self.searchResult.frame, 0, -self.view.frame.size.height/2)]];
    [searchResultFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                              andFrame:self.searchResult.frame]];
    
    //pdfIcon frame animation
    IFTTTFrameAnimation *pdfIconFrameAnimation = [IFTTTFrameAnimation new];
    pdfIconFrameAnimation.view = self.pdfIcon;
    [self.animator addAnimation:pdfIconFrameAnimation];
    [pdfIconFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1)
                                                                            andFrame:self.redPoint.frame]];
    [pdfIconFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                            andFrame:self.pdfIcon.frame]];
    [pdfIconFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                           andFrame:self.categoryIcon.frame]];
    
    //pdfIcon alpha animation
    IFTTTAlphaAnimation *pdfIconAlphaAnimation = [IFTTTAlphaAnimation new];
    pdfIconAlphaAnimation.view = self.pdfIcon;
    [self.animator addAnimation:pdfIconAlphaAnimation];
    
    [pdfIconAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1) andAlpha:0.0f]];
    [pdfIconAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2) andAlpha:1.0f]];
    [pdfIconAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3) andAlpha:0.0f]];
}

- (void)configurePage3Animation
{
    //titleView frame animation
    IFTTTFrameAnimation *titleView3FrameAnimation = [IFTTTFrameAnimation new];
    titleView3FrameAnimation.view = self.titleView3;
    [self.animator addAnimation:titleView3FrameAnimation];
    
    [titleView3FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1)
                                                                              andFrame:self.titleView1.frame]];
    [titleView3FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                              andFrame:CGRectOffset(self.titleView1.frame, timeForPage(2), 0)]];
    [titleView3FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                              andFrame:CGRectOffset(self.titleView1.frame, timeForPage(3), 0)]];
    [titleView3FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4)
                                                                              andFrame:CGRectOffset(self.titleView1.frame, timeForPage(4), 0)]];
    
    //titleView alpha animation
    IFTTTAlphaAnimation *titleView3AlphaAnimation = [IFTTTAlphaAnimation new];
    titleView3AlphaAnimation.view = self.titleView3;
    [self.animator addAnimation:titleView3AlphaAnimation];
    
    [titleView3AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2) andAlpha:0.0f]];
    [titleView3AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3) andAlpha:1.0f]];
    [titleView3AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4) andAlpha:0.0f]];
    
    //categoryIcon alpha animation
    IFTTTAlphaAnimation *categoryIconAlphaAnimation = [IFTTTAlphaAnimation new];
    categoryIconAlphaAnimation.view = self.categoryIcon;
    [self.animator addAnimation:categoryIconAlphaAnimation];
    
    [categoryIconAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2) andAlpha:0.0f]];
    [categoryIconAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3) andAlpha:1.0f]];
    [categoryIconAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4) andAlpha:0.0f]];
    
    //categoryIcon frame animation
    IFTTTFrameAnimation *categoryIconFrameAnimation = [IFTTTFrameAnimation new];
    categoryIconFrameAnimation.view = self.categoryIcon;
    [self.animator addAnimation:categoryIconFrameAnimation];
    
    [categoryIconFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                                andFrame:self.pdfIcon.frame]];
    [categoryIconFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                                andFrame:self.categoryIcon.frame]];
    [categoryIconFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4)
                                                                                andFrame:self.greenPoint.frame]];
    
    //categoryItems alpha animation
    IFTTTAlphaAnimation *categoryItemsAlphaAnimation = [IFTTTAlphaAnimation new];
    categoryItemsAlphaAnimation.view = self.categoryItems;
    [self.animator addAnimation:categoryItemsAlphaAnimation];
    
    [categoryItemsAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2.5) andAlpha:0.0f]];
    [categoryItemsAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3) andAlpha:1.0f]];
    
    //categoryItems frame animation
    IFTTTFrameAnimation *categoryItemsFrameAnimation = [IFTTTFrameAnimation new];
    categoryItemsFrameAnimation.view = self.categoryItems;
    [self.animator addAnimation:categoryItemsFrameAnimation];
    
    [categoryItemsFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                                andFrame:self.categoryItems.frame]];
    [categoryItemsFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                                andFrame:CGRectOffset(self.categoryItems.frame, timeForPage(2), self.categoryItems.frame.size.height)]];
}

- (void)configurePage4Animation
{
    //titleView frame animation
    IFTTTFrameAnimation *titleView4FrameAnimation = [IFTTTFrameAnimation new];
    titleView4FrameAnimation.view = self.titleView4;
    [self.animator addAnimation:titleView4FrameAnimation];
    
    [titleView4FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(1)
                                                                              andFrame:self.titleView1.frame]];
    [titleView4FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(2)
                                                                              andFrame:CGRectOffset(self.titleView1.frame, timeForPage(2), 0)]];
    [titleView4FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                              andFrame:CGRectOffset(self.titleView1.frame, timeForPage(3), 0)]];
    [titleView4FrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4)
                                                                              andFrame:CGRectOffset(self.titleView1.frame, timeForPage(4), 0)]];
    
    //titleView alpha animation
    IFTTTAlphaAnimation *titleView4AlphaAnimation = [IFTTTAlphaAnimation new];
    titleView4AlphaAnimation.view = self.titleView4;
    [self.animator addAnimation:titleView4AlphaAnimation];
    
    [titleView4AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3) andAlpha:0.0f]];
    [titleView4AlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4) andAlpha:1.0f]];
    
    //greenPoint frame animation
    IFTTTFrameAnimation *greenPointFrameAnimation = [IFTTTFrameAnimation new];
    greenPointFrameAnimation.view = self.greenPoint;
    [self.animator addAnimation:greenPointFrameAnimation];
    [greenPointFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3)
                                                                            andFrame:self.categoryIcon.frame]];
    [greenPointFrameAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4)
                                                                            andFrame:self.greenPoint.frame]];
    
    //greenPoint alpha animation
    IFTTTAlphaAnimation *greenPointAlphaAnimation = [IFTTTAlphaAnimation new];
    greenPointAlphaAnimation.view = self.greenPoint;
    [self.animator addAnimation:greenPointAlphaAnimation];
    
    [greenPointAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(3) andAlpha:0.0f]];
    [greenPointAlphaAnimation addKeyFrame:[[IFTTTAnimationKeyFrame alloc] initWithTime:timeForPage(4) andAlpha:1.0f]];
}

#pragma mark - click the start button

- (void)appStart
{
    NSLog(@"app starting...");
}

#pragma mark - hide the status bar

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    [super scrollViewDidScroll:self.scrollView];
    
    //set pageControl
    int pageIndex = 0;
    CGFloat pageWidth = self.scrollView.frame.size.width;
    pageIndex = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (pageIndex == 0) {
        [self.pageControl setHidden:NO];
        [self.pageControl setCoreSelectedColor:[UIColor colorWithRed:25/255.f green:118/255.f blue:210/255.f alpha:1]];
    }
    if (pageIndex == 1) {
        [self.pageControl setHidden:NO];
        [self.pageControl setCoreSelectedColor:[UIColor colorWithRed:136/255.f green:50/255.f blue:151/255.f alpha:1]];
    }
    if (pageIndex == 2) {
        [self.pageControl setHidden:NO];
        [self.pageControl setCoreSelectedColor:[UIColor colorWithRed:0/255.f green:150/255.f blue:136/255.f alpha:1]];
    }
    if (pageIndex == 3) {
        [self.pageControl setHidden:YES];
    }
    [self.pageControl setCurrentPage:pageIndex];
}

#pragma mark - IFTTTAnimatedScrollViewControllerDelegate

- (void)animatedScrollViewControllerDidScrollToEnd:(IFTTTAnimatedScrollViewController *)animatedScrollViewController
{
    NSLog(@"Scrolled to end of scrollview!");
}

- (void)animatedScrollViewControllerDidEndDraggingAtEnd:(IFTTTAnimatedScrollViewController *)animatedScrollViewController
{
    NSLog(@"Ended dragging at end of scrollview!");
}

@end
