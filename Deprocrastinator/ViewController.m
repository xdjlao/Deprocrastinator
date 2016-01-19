//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Jerry on 1/18/16.
//  Copyright © 2016 Jerry Lao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *cellArray;
@property (weak, nonatomic) IBOutlet UITextField *enterTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cellArray = [NSMutableArray new];
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    cell.backgroundColor = [UIColor redColor];
//    [self.cellArray addObject:cell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [self.cellArray objectAtIndex:indexPath.row];
//    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor greenColor];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You sure?" message:@"Delete this" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.cellArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    UITableViewCell *listItem = [self.cellArray objectAtIndex:destinationIndexPath.row];
    [self.cellArray replaceObjectAtIndex:destinationIndexPath.row withObject:[tableView cellForRowAtIndexPath:sourceIndexPath]];
    [self.cellArray replaceObjectAtIndex:sourceIndexPath.row withObject:listItem];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (IBAction)onAddPressed:(UIButton *)sender {
    [self addToArray];
    [self.tableView reloadData];
    self.enterTextField.text = @"";
}
- (IBAction)onEditPressed:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"Done"]) {
        [self.tableView setEditing:NO animated:YES];
        sender.title = @"Edit";
    } else {
        [self.tableView setEditing:YES animated:YES];
        sender.title = @"Done";
    }
}

- (void)addToArray {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = self.enterTextField.text;
    cell.backgroundColor = [UIColor whiteColor];
    
    [self.cellArray addObject:cell];
}

- (IBAction)onSwipeRight:(UISwipeGestureRecognizer *)sender {
    CGPoint swipeLocation = [sender locationInView:self.tableView];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:swipeLocation]];
    if (cell.backgroundColor == [UIColor whiteColor]) {
        cell.backgroundColor = [UIColor greenColor];
    } else if (cell.backgroundColor == [UIColor greenColor]) {
        cell.backgroundColor = [UIColor yellowColor];
    } else if (cell.backgroundColor == [UIColor yellowColor]) {
        cell.backgroundColor = [UIColor redColor];
    } else if (cell.backgroundColor == [UIColor redColor]) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    [self.cellArray insertObject:cell atIndex:[self.tableView indexPathForRowAtPoint:swipeLocation].row];
}

@end
