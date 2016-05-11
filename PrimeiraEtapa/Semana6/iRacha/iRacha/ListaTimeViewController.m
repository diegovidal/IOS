//
//  ListaTimeViewController.m
//  iRacha
//
//  Created by bepid on 21/11/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ListaTimeViewController.h"
#import "Jogador.h"

@interface ListaTimeViewController ()

@end

@implementation ListaTimeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.time.jogadores count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellJogadores" forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellJogadores"];
    }
    
    
    cell.textLabel.text = [[self.time.jogadores objectAtIndex:indexPath.row] nome];
    
    cell.detailTextLabel.text = [[[self.time.jogadores objectAtIndex:indexPath.row] numJogador] stringValue];
    
    
    
    return cell;
}

-(void)addJogador:(Jogador *)jogador{
    [_time.jogadores addObject:jogador];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    JogadorViewController *jogadorController = segue.destinationViewController;
    jogadorController.delegate = self;
    
}



@end
