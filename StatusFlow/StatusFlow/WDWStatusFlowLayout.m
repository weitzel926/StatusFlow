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

#import "WDWStatusFlowLayout.h"

@interface WDWStatusFlowLayout ()
@property (nonatomic, strong) NSIndexPath *selectedItemPath;
@property (nonatomic, assign) WDWStatusFlowViewDirection direction;
@end

@implementation WDWStatusFlowLayout

- (instancetype)initWithSelectedItemPath:(NSIndexPath *)itemPath andDirection:(WDWStatusFlowViewDirection)direction
{
    self = [super init];
    if (self) {
        self.selectedItemPath = itemPath;
        self.gapBetweenCells = 5;
        self.direction = direction;
    }
    return self;
}

- (instancetype)initWithSelectedItemPath:(NSIndexPath *)itemPath
{
    self = [super init];
    if (self) {
        self.selectedItemPath = itemPath;
        self.gapBetweenCells = 5;
        self.direction = WDWStatusFlowViewDirectionHorizontal;
    }
    return self;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    [self modifyAttributes:attributes];
    
    return attributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *layoutAttributesForCellsInRect = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *cellAttributes in layoutAttributesForCellsInRect){
       [self modifyAttributes:cellAttributes];
    }
    
    return layoutAttributesForCellsInRect;
}

- (void)modifyAttributes:(UICollectionViewLayoutAttributes *)attributes
{
    if(attributes.indexPath.section == 0){
        NSInteger indexFromCenterItem = ABS(self.selectedItemPath.row - attributes.indexPath.row);  //ABS macro is architecture safe
        
        CGRect collectionViewFrame = self.collectionView.frame;
        
        CGFloat centerX = self.collectionView.frame.size.width/2;
        CGFloat centerY = self.collectionView.frame.size.height/2;
        
        CGFloat widthCenterCell = attributes.size.width * 2;
        CGFloat widthCell = attributes.size.width;
        
        CGFloat heightCenterCell = attributes.size.height * 2;
        CGFloat heightCell = attributes.size.height;
        
        CGFloat x, y;
        
        if ([attributes.indexPath isEqual:self.selectedItemPath]) {
            attributes.center = CGPointMake(collectionViewFrame.size.width/2, collectionViewFrame.size.height/2);
            attributes.transform = CGAffineTransformMakeScale(2.0, 2.0);
            
        } else if (attributes.indexPath.row < self.selectedItemPath.row) {
            if (self.direction == WDWStatusFlowViewDirectionHorizontal){
                x = centerX - widthCenterCell/2 - widthCell/2 - indexFromCenterItem*self.gapBetweenCells - (indexFromCenterItem-1)*widthCell;
                y = collectionViewFrame.size.height/2;
            } else {  // vertical
                y = centerY - heightCenterCell/2 - heightCell/2 - indexFromCenterItem*self.gapBetweenCells - (indexFromCenterItem-1)*heightCell;
                x = collectionViewFrame.size.width/2;
            }
            attributes.center = CGPointMake(x,y);
        } else if (attributes.indexPath.row > self.selectedItemPath.row) {
            if (self.direction == WDWStatusFlowViewDirectionHorizontal){
                x = centerX + widthCenterCell/2 + widthCell/2 + indexFromCenterItem*self.gapBetweenCells + (indexFromCenterItem-1)*widthCell;
                y = collectionViewFrame.size.height/2;
            } else { // vertical
                y = centerY + heightCenterCell/2 + heightCell/2 + indexFromCenterItem*self.gapBetweenCells + (indexFromCenterItem-1)*heightCell;
                x = collectionViewFrame.size.width/2;
            }
            
            attributes.center = CGPointMake(x, y);
        }
        
        if( indexFromCenterItem > 1) {
            attributes.alpha = 0;
            attributes.hidden = YES;
        } else {
            attributes.hidden = NO;
        }
    }
}

@end
