//
//  ViewController.m
//  TesteCoreData
//
//  Created by Diego Vidal on 29/01/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(UIButton *)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSManagedObject *newContact;
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
    
    [newContact setValue:_mNome.text forKey:@"name"];
    [newContact setValue:_mAdress.text forKey:@"adress"];
    [newContact setValue:_mPhone.text forKey:@"phone"];
    
    _mNome.text = @"";
    _mAdress.text = @"";
    _mPhone.text = @"";
    
    NSError *error;
    [context save:&error];
    _labelFind.text = @"Contact saved.";
}

- (IBAction)find:(UIButton *)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    NSLog(@"Objects: %@", objects);
    
    if([objects count] == 0){
        _labelFind.text = @"No matches.";
    }
    else{
        matches = objects[0];
        _mAdress.text = [matches valueForKey:@"adress"];
        _mPhone.text = [matches valueForKey:@"phone"];
        
        NSLog(@"adress é %@ e phone é %@", [matches valueForKey:@"adress"],[matches valueForKey:@"phone"]);
        
        _labelFind.text = [NSString stringWithFormat:@"%i matches found"], objects.count ;
    }
}
@end
