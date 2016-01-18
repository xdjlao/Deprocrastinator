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
@property NSMutableArray *toDoList;
@property (weak, nonatomic) IBOutlet UITextField *enterTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.toDoList = [[NSMutableArray alloc] initWithObjects:@"Study Objective-C", @"Eat", @"Sleep", nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.toDoList objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toDoList.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor greenColor];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.toDoList removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    [self.toDoList addObject:self.enterTextField.text];
}

@end
