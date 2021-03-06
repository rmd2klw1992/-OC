//
//  UserInfoTableViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/24.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UserInfoTableViewCell.h"
#import "UserDetailTableViewController.h"
#import "Utils.h"
#import "User.h"

@implementation UserInfoTableViewController

bool isLoginedIn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginedIn:) name:@"isLoginedIn" object:nil];
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)isLoginedIn:(NSNotification *)noti {
    NSString *result = [noti.userInfo valueForKey:@"isLoginedIn"];
    if ([result isEqualToString:@"Success"]) {
        isLoginedIn = YES;
    } else {
        isLoginedIn = NO;
    }
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [Utils isLogedIn];
    [self.tableView reloadData];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (isLoginedIn != YES) {
        [cell.username setHidden:YES];
        [cell.btnLogin setHidden:NO];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        
    } else {
        [cell.username setHidden:NO];
        [cell.btnLogin setHidden:YES];
        
        NSString *username = [Utils GetUserInfo:@"username"];
        cell.username.text = username;
        cell.userImage.image = [Utils GetImage];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
    }

    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserDetailTableViewController *userDetail = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"editUserInfo"]) {
        
        
    }
    
}

@end
