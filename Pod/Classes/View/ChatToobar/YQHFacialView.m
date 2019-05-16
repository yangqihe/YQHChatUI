//
//  YQHFacialView.m
//  家校共享
//
//  Created by 杨棋贺 on 2019/2/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "YQHFacialView.h"

#import "YQHEmoji.h"
#import "YQHFaceView.h"
#import "YQHEmotionManager.h"

@interface UIButton (UIButtonImageWithLable)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
@end

@implementation UIButton (UIButtonImageWithLable)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    CGSize titleSize;
    if ([NSString instancesRespondToSelector:@selector(sizeWithAttributes:)]) {
        titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    } else {
        //titleSize = [title sizeWithFont:[UIFont systemFontOfSize:10]];
        CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        titleSize=[title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    }
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0,
                                              0.0,
                                              20,
                                              0)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self setTitleColor:[UIColor blackColor] forState:stateType];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(CGRectGetHeight(self.bounds)-20,
                                              -image.size.width,
                                              0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}

@end

@protocol YQHCollectionViewCellDelegate

@optional

- (void)didSendEmotion:(YQHEmotion*)emotion;

@end

@interface YQHCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<YQHCollectionViewCellDelegate> delegate;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) YQHEmotion *emotion;

@end

@implementation YQHCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.frame = self.bounds;
        _imageButton.userInteractionEnabled = YES;
        [self.contentView addSubview:_imageButton];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _imageButton.frame = self.bounds;
}

- (void)setEmotion:(YQHEmotion *)emotion
{
    _emotion = emotion;
    if ([emotion isKindOfClass:[YQHEmotion class]]) {
        if (emotion.emotionType == YQHEmotionGif) {
            [_imageButton setImage:[UIImage imageNamed:emotion.emotionThumbnail] withTitle:emotion.emotionTitle forState:UIControlStateNormal];
        } else if (emotion.emotionType == YQHEmotionPng) {
            [_imageButton setImage:[UIImage imageNamed:emotion.emotionThumbnail] forState:UIControlStateNormal];
            _imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [_imageButton setTitle:nil forState:UIControlStateNormal];
            [_imageButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [_imageButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        } else {
            [_imageButton.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
            [_imageButton setTitle:emotion.emotionThumbnail forState:UIControlStateNormal];
            [_imageButton setImage:nil forState:UIControlStateNormal];
            [_imageButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [_imageButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        [_imageButton addTarget:self action:@selector(sendEmotion:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [_imageButton setTitle:nil forState:UIControlStateNormal];
        [_imageButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_imageButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_imageButton setImage:[UIImage imageNamed:@"EaseUIResource.bundle/faceDelete"] forState:UIControlStateNormal];
        [_imageButton setImage:[UIImage imageNamed:@"EaseUIResource.bundle/faceDelete_select"] forState:UIControlStateHighlighted];
        [_imageButton addTarget:self action:@selector(sendEmotion:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)sendEmotion:(id)sender
{
    if (_delegate) {
        if ([_emotion isKindOfClass:[YQHEmotion class]]) {
            [_delegate didSendEmotion:_emotion];
        } else {
            [_delegate didSendEmotion:nil];
        }
    }
}

@end


@interface YQHFacialView () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YQHCollectionViewCellDelegate>
{
    CGFloat _itemWidth;
    CGFloat _itemHeight;
}

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *emotionManagers;

@end

@implementation YQHFacialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pageControl = [[UIPageControl alloc] init];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        [self.collectionView registerClass:[YQHCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.userInteractionEnabled = YES;
        //        [self addSubview:_scrollview];
        [self addSubview:_pageControl];
        [self addSubview:_collectionView];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section < [_emotionManagers count]) {
        YQHEmotionManager *emotionManager = [_emotionManagers objectAtIndex:section];
        return [emotionManager.emotions count];
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (_emotionManagers == nil || [_emotionManagers count] == 0) {
        return 1;
    }
    return [_emotionManagers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identify = @"collectionCell";
    YQHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (!cell) {
        
    }
    [cell sizeToFit];
    YQHEmotionManager *emotionManager = [_emotionManagers objectAtIndex:indexPath.section];
    YQHEmotion *emotion = [emotionManager.emotions objectAtIndex:indexPath.row];
    cell.emotion = emotion;
    cell.userInteractionEnabled = YES;
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    YQHEmotionManager *emotionManager = [_emotionManagers objectAtIndex:section];
    CGFloat itemWidth = self.frame.size.width / emotionManager.emotionCol;
    NSInteger pageSize = emotionManager.emotionRow*emotionManager.emotionCol;
    NSInteger lastPage = (pageSize - [emotionManager.emotions count]%pageSize);
    if (lastPage < emotionManager.emotionRow ||[emotionManager.emotions count]%pageSize == 0) {
        return CGSizeMake(0, 0);
    } else{
        NSInteger size = lastPage/emotionManager.emotionRow;
        return CGSizeMake(size*itemWidth, self.frame.size.height);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableview = headerView;
        
    }
    if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableview = footerview;
    }
    return reusableview;
}

#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YQHEmotionManager *emotionManager = [_emotionManagers objectAtIndex:indexPath.section];
    NSInteger maxRow = emotionManager.emotionRow;
    NSInteger maxCol = emotionManager.emotionCol;
    CGFloat itemWidth = self.frame.size.width / maxCol;
    CGFloat itemHeight = (self.frame.size.height) / maxRow;
    return CGSizeMake(itemWidth, itemHeight);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma makr - EaseCollectionViewCellDelegate
- (void)didSendEmotion:(YQHEmotion *)emotion
{
    if (emotion) {
        if (emotion.emotionType == YQHEmotionDefault) {
            if (_delegate) {
                [_delegate selectedFacialView:emotion.emotionId];
            }
        } else {
            if (_delegate) {
                [_delegate sendFace:emotion];
            }
        }
    } else {
        [_delegate deleteSelected:nil];
    }
}

-(void)loadFacialView:(NSArray*)emotionManagers size:(CGSize)size
{
    for (UIView *view in [self.scrollview subviews]) {
        [view removeFromSuperview];
    }
    _emotionManagers = emotionManagers;
    [_collectionView reloadData];
}

-(void)loadFacialViewWithPage:(NSInteger)page
{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:page]
                            atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                    animated:NO];
    CGPoint offSet = _collectionView.contentOffset;
    if (page == 0) {
        [_collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    } else {
        [_collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.frame)*((int)(offSet.x/CGRectGetWidth(self.frame))+1), 0) animated:NO];
    }
    //    [_collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.frame)*2, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

@end
