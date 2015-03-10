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

#import "WDWExampleStatusFlowViewController.h"
#import "WDWExampleStatusFlowCell.h"
#import "WDWStatusFlowView.h"

@interface WDWExampleStatusFlowViewController ()
@property (weak, nonatomic) IBOutlet WDWStatusFlowView *statusFlowView;

@property (strong, nonatomic) NSArray *items;
@end

@implementation WDWExampleStatusFlowViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if( self ){
        [self initialize];
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if( self ){
        [self initialize];
    }
    
    return self;
}

- (void) initialize
{
    self.items = @[@"zero",
                   @"one",
                   @"two",
                   @"three",
                   @"four",
                   @"five",
                   @"six",
                   @"seven",
                   @"eight",
                   @"nine"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.statusFlowView.dataSource = self;
    self.statusFlowView.delegate = self;
    self.statusFlowView.gapBetweenCells = 10;
}

#pragma - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if( section == 0 ){
        return self.items.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if( !indexPath.section == 0 ){
        return nil;
    }
    
    WDWExampleStatusFlowCell *cell = (WDWExampleStatusFlowCell *)[self.statusFlowView dequeueReusableCellWithReuseIdentifier:@"WDWExampleCell" forIndexPath:indexPath];
    
    if( cell ){
        cell.imageName = self.items[indexPath.row];
    }

    return cell;
}

#pragma - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return CGSizeMake(50, 50);
    }
    
    return CGSizeZero;
}

#pragma - private handlers
- (IBAction)advanceTapped:(id)sender
{
    if( self.statusFlowView.selectedIndex < (self.items.count-1) ){
        self.statusFlowView.selectedIndex++;
    }
}

- (IBAction)backTapped:(id)sender
{
    if( self.statusFlowView.selectedIndex > 0 ){
        self.statusFlowView.selectedIndex--;
    }
}

@end
