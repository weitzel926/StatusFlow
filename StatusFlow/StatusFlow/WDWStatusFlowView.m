//Copyright (c) 2015 Wade Weitzel (wade.d.weitzel+github@gmail.com)
//
//Permission is hereby granted, free of charge, to any person obtaining
//a copy of this software and associated documentation files (the "Software"),
//to deal in the Software without restriction, including
//without limitation the rights to use, copy, modify, merge, publish,
//distribute, sublicense, and/or sell copies of the Software, and to
//permit persons to whom the Software is furnished to do so, subject to
//the following conditions:
//
//The above copyright notice and this permission notice shall be
//included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "WDWStatusFlowView.h"
#import "WDWStatusFlowLayout.h"

@implementation WDWStatusFlowView

- (void)initialize
{
    self.selectedIndex = 0;
    self.gapBetweenCells = 5;
    self.scrollEnabled = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame  collectionViewLayout:layout];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)setGapBetweenCells:(NSInteger)gapBetweenCells
{
    _gapBetweenCells = gapBetweenCells;

    [self resetLayout];
}

- (void)setDirection:(WDWStatusFlowViewDirection)direction
{
    _direction = direction;
    
    [self resetLayout];
}

- (void)setSelectedIndex:(NSInteger)index
{
    _selectedIndex = index;
    
    NSIndexPath *selectedItemPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self selectItemAtIndexPath:selectedItemPath
                       animated:NO
                 scrollPosition:UICollectionViewScrollPositionNone];
    
    [self resetLayout];
}

- (void)resetLayout
{
    NSIndexPath *selectedItemPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    WDWStatusFlowLayout *layout = [[WDWStatusFlowLayout alloc] initWithSelectedItemPath:selectedItemPath andDirection:self.direction];
    layout.gapBetweenCells = self.gapBetweenCells;
    [self setCollectionViewLayout:layout animated:YES];
}

@end