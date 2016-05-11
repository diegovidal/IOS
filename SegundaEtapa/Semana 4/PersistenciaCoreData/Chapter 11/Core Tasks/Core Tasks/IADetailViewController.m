//
//  IADetailViewController.m
//  Core Tasks
//
//  Created by Brendan G. Lim on 8/12/13.
//  Copyright (c) 2013 iOS in Action. All rights reserved.
//

#import "IADetailViewController.h"
#import "IAAppDelegate.h"
#import "Task.h"
#import "List.h"

@interface IADetailViewController ()
- (void)configureView;
@end

#define kAlertNewTask 1002

@implementation IADetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        [self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem)
    {
        self.title = [self.detailItem valueForKey:@"name"];
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [self configureView];
}

- (NSArray *)allTasks
{
    NSSortDescriptor *completed = [NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:NO];
    NSSortDescriptor *created = [NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO];

    return [self.detailItem.tasks sortedArrayUsingDescriptors:@[completed, created]];
}

- (void)insertNewObject:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create Task"
                                                    message:@"Add a new task"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Save", nil];
    [alert setTag:kAlertNewTask];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kAlertNewTask && buttonIndex != alertView.cancelButtonIndex)
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        if ([textField.text length] == 0)
            return;
        
        Task *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task"
                                                      inManagedObjectContext:self.managedObjectContext];
        
        [newTask setValue:textField.text forKey:@"summary"];
        [newTask setValue:[NSDate date] forKey:@"created"];
        [newTask setValue:@(NO) forKey:@"completed"];
        
        [self.detailItem addTasksObject:newTask];
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        [self.tableView reloadData];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self allTasks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"
                                                            forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Task *task = [[self allTasks] objectAtIndex:indexPath.row];
    BOOL completed = [[task valueForKey:@"completed"] boolValue];
    [task setValue:@(!completed) forKey:@"completed"];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Task *task = [[self allTasks] objectAtIndex:indexPath.row];
        [self.managedObjectContext deleteObject:task];
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        [self setEditing:NO animated:YES];
        [self.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Task *task = [[self allTasks] objectAtIndex:indexPath.row];

    BOOL completed = [[task valueForKey:@"completed"] boolValue];
    cell.textLabel.text = [task valueForKey:@"summary"];
    
    if (completed)
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    else
        [cell setAccessoryType:UITableViewCellAccessoryNone];
}

@end
