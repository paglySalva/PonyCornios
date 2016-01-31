//
//  PNCNewPlayerViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 03/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCNewPlayerViewController.h"

//Models
#import "Team.h"

//Managers
#import "PNCPickerImageManager.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCNewPlayerViewController () <PNCPickerImageManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;

@property (strong, nonatomic) NSArray *teams;
@property (strong, nonatomic) PNCPickerImageManager *pickerPictureManager;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCNewPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self commonSetUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commonSetUp {

    self.view.backgroundColor     = [[UIColor blackColor]colorWithAlphaComponent:0.8];
    self.cardView.backgroundColor = [UIColor whiteColor];
    
    if (self.currentPlayer) {
        self.logoImageView.image = self.currentPlayer.photoImage;
        self.nameField.text      = self.currentPlayer.name;
        self.numberField.text    = [NSString stringWithFormat:@"%zd",self.currentPlayer.numberValue];
    }
    
    self.teamLabel.text = self.currentTeam.name;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectUserPicturePressed)];
    tap.numberOfTapsRequired = 1;
    
    self.logoImageView.userInteractionEnabled = YES;
    [self.logoImageView addGestureRecognizer:tap];
}

#pragma mark -
#pragma mark - Private Methods

- (void)cleanAndReset {
    self.logoImageView.image = [UIImage imageNamed:@"playerPlaceholder"];
    self.nameField.text = @"";
    self.numberField.text = @"";
}

#pragma mark -
#pragma mark - Getters

- (NSArray *)teams {
    if (!_teams) {
        _teams = [Team teamsIncontext:[NSManagedObjectContext MR_defaultContext]];
    }
    return _teams;
}

- (PNCPickerImageManager *)pickerPictureManager {
    if (!_pickerPictureManager) {
        _pickerPictureManager = [PNCPickerImageManager new];
        _pickerPictureManager.delegate = self;
    }
    
    return _pickerPictureManager;
}

#pragma mark -
#pragma mark - User Actions

- (IBAction)cancelButtonPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    if (!self.numberField.text.length || !self.nameField.text.length) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Waning!" message:@"Rellena todos los campos, breee por favor!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Vale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    //---Update an existing player
    if (self.currentPlayer) {
         [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
             
             Player *existingPlayer = [self.currentPlayer MR_inContext:localContext];
             NSData *imageData = UIImageJPEGRepresentation(self.logoImageView.image, 1.0);
             existingPlayer.photo  = imageData;
             existingPlayer.name   = self.nameField.text;
             existingPlayer.number =  @([self.numberField.text integerValue]);
         }];
        
        [self cancelButtonPressed:nil];
        
        return;
    }
    
    //---Create new Player
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {

        Player *newPlayer = [Player playerWithData:@{@"playerName" : self.nameField.text,
                                                     @"playerNumber" : @([self.numberField.text integerValue])}
                                           context:localContext];
        
        newPlayer.team = [self.currentTeam MR_inContext:localContext];
        
        if (self.logoImageView.image) {
            newPlayer.photo = UIImageJPEGRepresentation(self.logoImageView.image, 1);
        }
        
    } completion:^(BOOL contextDidSave, NSError *error) {
        [self cleanAndReset];
        //[self cancelButtonPressed:nil];
    }];
}

- (void)selectUserPicturePressed {
    [self.pickerPictureManager setDataToHandlerWithViewController:self];
    [self.pickerPictureManager showActionSheetPhotoOptions];
}

#pragma mark -
#pragma mark - PNCPickerImageManager

- (void)pickerManagerImageSelected:(UIImage *)imageSelected {
    self.logoImageView.image = imageSelected;
}

- (void)pickerManagerPresentSelectPictureViewController:(UIViewController *)viewControllerToPresent WithAnimation:(BOOL)animation {
    [self presentViewController:viewControllerToPresent animated:YES completion:nil];
}

- (void)pickerManagerDismissSelectPictureViewController:(UIViewController *)viewControllerToPresent WithAnimation:(BOOL)animation {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
