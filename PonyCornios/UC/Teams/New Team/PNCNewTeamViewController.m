//
//  PNCNewTeamViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 05/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCNewTeamViewController.h"

//Models
#import "Team.h"

//Managers
#import "PNCPickerImageManager.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCNewTeamViewController () <PNCPickerImageManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) PNCPickerImageManager *pickerPictureManager;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCNewTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetUp];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commonSetUp {
    
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
    self.cardView.backgroundColor = [UIColor whiteColor];
    self.logoImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectUserPicturePressed)];
    tap.numberOfTapsRequired = 1;
    [self.logoImageView addGestureRecognizer:tap];
}

#pragma mark -
#pragma mark - Getters

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
    
    if (!self.nameField.text.length) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cooomo?" message:@"¿Vas a crear un equipo sin nombre?, venga ya..." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Vale le pongo nombre" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        Team *newTeam = [Team teamWithData:@{@"teamName" : self.nameField.text} context:localContext];
        
        if (self.logoImageView.image) {
            newTeam.logo = UIImageJPEGRepresentation(self.logoImageView.image, 1);
        }
    } completion:^(BOOL contextDidSave, NSError *error) {
        [self cancelButtonPressed:nil];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
