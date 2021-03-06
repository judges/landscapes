//
//  AssessmentTreeCRViewController.m
//  landscapes
//
//  Created by Evan Cordell on 8/3/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "AssessmentTreeCRViewController.h"



@implementation AssessmentTreeCRViewController

@synthesize whichId, managedObjectContext, conditionStringArray, recommendationStringArray, conditionArray, recommendationArray, tree, isEditing;

-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query { 
    if (self = [super initWithNibName:@"AssessmentTreeCRView" bundle:[NSBundle mainBundle]]){
        if(query && [query objectForKey:@"assessmentTree"] && [query objectForKey:@"id"]){ 
            //Grabs the id that called the page so we know which properties to load.
            whichId = [query objectForKey:@"id"];
            //pass the TreeAssessment from the previous view
            tree = [query objectForKey:@"assessmentTree"];
            //initialize the arrays to store the conditions and recommendations
            conditionStringArray = [[NSMutableArray alloc] init];
            recommendationStringArray = [[NSMutableArray alloc] init];
            //create imagepicker
            imagePicker = [[UIImagePickerController alloc] init];
            //set appropriate title
            switch ([whichId intValue]) {
                case 1:
                    self.title = @"Tree Form";
                    break;
                case 2:
                    self.title = @"Tree Crown";
                    break;
                case 3:
                    self.title = @"Tree Trunk";
                    break;
                case 4:
                    self.title = @"Tree Root Flare";
                    break;
                case 5:
                    self.title = @"Tree Roots";
                    break;
                case 6:
                    self.title = @"Tree Overall";
                    break;
                default:
                    break;
            }
        }
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //clear the shared cache
    int urlctr = 0;
    NSString *path = [NSString stringWithFormat:@"images/%d.jpg", urlctr];
    NSString *url = [NSString stringWithFormat:@"temp://%@", path];
    while ([[TTURLCache sharedCache] hasDataForURL:url]) {
        path = [NSString stringWithFormat:@"images/%d.jpg",urlctr];
        url = [NSString stringWithFormat:@"temp://%@", path];
        [[TTURLCache sharedCache] removeURL:url fromDisk:YES];
        ++urlctr;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //load data into the condition and recommendation arrays from core data
    if(!managedObjectContext){
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    NSFetchRequest *cFetchRequest = [[NSFetchRequest alloc] init];
    NSFetchRequest *rFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *cEntity;
    NSEntityDescription *rEntity;
    switch ([whichId intValue]) {
        case 1:
            cEntity = [NSEntityDescription entityForName:@"TreeFormCondition" inManagedObjectContext:managedObjectContext];
            rEntity = [NSEntityDescription entityForName:@"TreeFormRecommendation" inManagedObjectContext:managedObjectContext];
            break;
        case 2:
            cEntity = [NSEntityDescription entityForName:@"TreeCrownCondition" inManagedObjectContext:managedObjectContext];
            rEntity = [NSEntityDescription entityForName:@"TreeCrownRecommendation" inManagedObjectContext:managedObjectContext];
            break;
        case 3:
            cEntity = [NSEntityDescription entityForName:@"TreeTrunkCondition" inManagedObjectContext:managedObjectContext];
            rEntity = [NSEntityDescription entityForName:@"TreeTrunkRecommendation" inManagedObjectContext:managedObjectContext];
            break;
        case 4:
            cEntity = [NSEntityDescription entityForName:@"TreeRootFlareCondition" inManagedObjectContext:managedObjectContext];
            rEntity = [NSEntityDescription entityForName:@"TreeRootFlareRecommendation" inManagedObjectContext:managedObjectContext];
            break;
        case 5:
            cEntity = [NSEntityDescription entityForName:@"TreeRootsCondition" inManagedObjectContext:managedObjectContext];
            rEntity = [NSEntityDescription entityForName:@"TreeRootsRecommendation" inManagedObjectContext:managedObjectContext];
            break;
        case 6:
            cEntity = [NSEntityDescription entityForName:@"TreeOverallCondition" inManagedObjectContext:managedObjectContext];
            rEntity = [NSEntityDescription entityForName:@"TreeOverallRecommendation" inManagedObjectContext:managedObjectContext];
            break;
        default:
            break;
    }
    [cFetchRequest setEntity:cEntity];
    [rFetchRequest setEntity:rEntity];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [cFetchRequest setSortDescriptors:sortDescriptors];
    [rFetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSMutableArray *cArray = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:cFetchRequest error:&error]];
    NSMutableArray *rArray = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:rFetchRequest error:&error]];
    int selectedConditionIndex = 0;
    int selectedRecommendationIndex = 0;
    int cCtr = 0;
    int rCtr = 0;
    switch ([whichId intValue]) {
        case 1:
        {
            for (TreeFormCondition *item in cArray) {
                if (tree.form.condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionStringArray addObject:item.name];
            }
            for (TreeFormRecommendation *item in rArray) {
                if (tree.form.recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationStringArray addObject:item.name];
            }
            break;
        }
        case 2:
        {
            for (TreeCrownCondition *item in cArray) {
                if (tree.crown.condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionStringArray addObject:item.name];
            }
            for (TreeCrownRecommendation *item in rArray) {
                if (tree.crown.recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationStringArray addObject:item.name];
            }
            break;
        }
        case 3:
        {
            for (TreeTrunkCondition *item in cArray) {
                if (tree.trunk.condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionStringArray addObject:item.name];
            }
            for (TreeTrunkRecommendation *item in rArray) {
                if (tree.trunk.recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationStringArray addObject:item.name];
            }
            break;
        }
        case 4:
        {
            for (TreeRootFlareCondition *item in cArray) {
                if (tree.rootflare.condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionStringArray addObject:item.name];
            }
            for (TreeRootFlareRecommendation *item in rArray) {
                if (tree.rootflare.recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationStringArray addObject:item.name];
            }
            break;
        }
        case 5:
        {
            for (TreeRootsCondition *item in cArray) {
                if (tree.roots.condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionStringArray addObject:item.name];
            }
            for (TreeRootsRecommendation *item in rArray) {
                if (tree.roots.recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationStringArray addObject:item.name];
            }
            break;
        }
        case 6:
        {
            for (TreeOverallCondition *item in cArray) {
                if (tree.overall.condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionStringArray addObject:item.name];
            }
            for (TreeOverallRecommendation *item in rArray) {
                if (tree.overall.recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationStringArray addObject:item.name];
            }
            break;
        }
        default:
            break;
    }
    
    [cFetchRequest release];
    [rFetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    conditionArray = [[NSMutableArray alloc] initWithArray:cArray];
    recommendationArray = [[NSMutableArray alloc] initWithArray:rArray];
    [conditionPicker selectRow:selectedConditionIndex inComponent:0 animated:YES];
    [recommendationPicker selectRow:selectedRecommendationIndex inComponent:0 animated:YES];
    [self pickerView:conditionPicker didSelectRow:selectedConditionIndex inComponent:0];
    [self pickerView:recommendationPicker didSelectRow:selectedRecommendationIndex inComponent:0];
}


-(IBAction)segmentSwitch:(id)sender {
    //switch between the views for condition and recommendation
    UISegmentedControl *segmentedButton = (UISegmentedControl *) sender;
    if (segmentedButton.selectedSegmentIndex == 0) {
        [conditionView setHidden:NO];
        [recommendationView setHidden:YES];
    } else {
        [conditionView setHidden:YES];
        [recommendationView setHidden:NO];
    }
}

-(IBAction)addCondition {
    //adds a new condition record
    isEditing = NO;
    [conditionField setHidden:NO];
    [conditionSaveButton setHidden:NO];
    conditionSaveButton.titleLabel.text = @"Add";
    [conditionField becomeFirstResponder];
}
-(IBAction)addRecommendation {
    //adds a new recommendation record
    isEditing = NO;
    [recommendationField setHidden:NO];
    [recommendationSaveButton setHidden:NO];
    recommendationSaveButton.titleLabel.text = @"Add";
    [recommendationField becomeFirstResponder];
}
-(IBAction)editCondition {
    //edit existing condition record
    isEditing = YES;
    [conditionField setHidden: NO];
    [conditionSaveButton setHidden: NO];
    conditionSaveButton.titleLabel.text = @"Edit";
    conditionField.text = [conditionStringArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
    [conditionField becomeFirstResponder];
}
-(IBAction)editRecommendation {
    //edit existing recommendation record
    isEditing = YES;
    [recommendationField setHidden: NO];
    [recommendationSaveButton setHidden: NO];
    recommendationSaveButton.titleLabel.text = @"Edit";
    recommendationField.text = [recommendationStringArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
    [recommendationField becomeFirstResponder];
}
-(IBAction)deleteCondition {
    //delete a condition record
    switch ([whichId intValue]) {
        case 1:
        {
            TreeFormCondition *item = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 2:
        {
            TreeCrownCondition *item = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 3:
        {
            TreeTrunkCondition *item = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 4:
        {
            TreeRootFlareCondition *item = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 5:
        {
            TreeRootsCondition *item = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 6:
        {
            TreeOverallCondition *item = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        default:
            break;
    }
    
    NSError *error;
    if (![managedObjectContext save:&error]) {
       NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [conditionStringArray removeObjectAtIndex:[conditionPicker selectedRowInComponent:0]];
	[conditionArray removeObjectAtIndex:[conditionPicker selectedRowInComponent:0]];
    [conditionPicker reloadComponent:0];
}
-(IBAction)deleteRecommendation {
    //delete a recommendation entry
    switch ([whichId intValue]) {
        case 1:
        {
            TreeFormRecommendation *item = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 2:
        {
            TreeCrownRecommendation *item = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 3:
        {
            TreeTrunkRecommendation *item = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 4:
        {
            TreeRootFlareRecommendation *item = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 5:
        {
            TreeRootsRecommendation *item = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 6:
        {
            TreeOverallRecommendation *item = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
            [managedObjectContext deleteObject:item];
            break;
        }
        default:
            break;
    }
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [recommendationStringArray removeObjectAtIndex:[recommendationPicker selectedRowInComponent:0]];
    [recommendationArray removeObjectAtIndex:[recommendationPicker selectedRowInComponent:0]];
	[recommendationPicker reloadComponent:0];
}
-(IBAction)conditionSaveButtonClick {
    //add new or edit existing condition
    [conditionField setHidden: YES];
    [conditionSaveButton setHidden: YES];
    if (isEditing) {
        [self deleteCondition];
    }
    [conditionField resignFirstResponder];
    switch ([whichId intValue]) {
        case 1:
        {
            TreeFormCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeFormCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            [conditionArray addObject:item];
            tree.form.condition = item;
            break;
        }
        case 2:
        {
            TreeCrownCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeCrownCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            [conditionArray addObject:item];
            tree.crown.condition = item;
            break;
        }
        case 3:
        {
            TreeTrunkCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeTrunkCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            [conditionArray addObject:item];
            tree.trunk.condition = item;
            break;
        }
        case 4:
        {
            TreeRootFlareCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootFlareCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            [conditionArray addObject:item];
            tree.rootflare.condition = item;
            break;
        }
        case 5:
        {
            TreeRootsCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootsCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            [conditionArray addObject:item];
            tree.roots.condition = item;
            break;
        }
        case 6:
        {
            TreeOverallCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeOverallCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            [conditionArray addObject:item];
            tree.overall.condition = item;
            break;
        }
        default:
            break;
    }
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [conditionStringArray addObject:[conditionField text]];
    [conditionPicker reloadComponent:0];
    conditionField.text = @"";
    [conditionPicker selectRow:[conditionArray count] - 1 inComponent:0 animated:YES];
}
-(IBAction)recommendationSaveButtonClick {
    //save new or edit existing recommendation
    [recommendationField setHidden: YES];
    [recommendationSaveButton setHidden: YES];
    if (isEditing) {
        [self deleteRecommendation];
    }
    [recommendationField resignFirstResponder];
    switch ([whichId intValue]) {
        case 1:
        {
            TreeFormRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeFormRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            [recommendationArray addObject:item];
            tree.form.recommendation = item;
            break;
        }
        case 2:
        {
            TreeCrownRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeCrownRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            [recommendationArray addObject:item];
            tree.crown.recommendation = item;
            break;
        }
        case 3:
        {
            TreeTrunkRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeTrunkRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            [recommendationArray addObject:item];
            tree.trunk.recommendation = item;
            break;
        }
        case 4:
        {
            TreeRootFlareRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootFlareRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            [recommendationArray addObject:item];
            tree.rootflare.recommendation = item;
            break;
        }
        case 5:
        {
            TreeRootsRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootsRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            [recommendationArray addObject:item];
            tree.roots.recommendation = item;
            break;
        }
        case 6:
        {
            TreeOverallRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeOverallRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            [recommendationArray addObject:item];
            tree.overall.recommendation = item;
            break;
        }
        default:
            break;
    }
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [recommendationStringArray addObject:[recommendationField text]];
    [recommendationPicker reloadComponent:0];
    recommendationField.text = @"";
    [recommendationPicker selectRow:[recommendationStringArray count] - 1 inComponent:0 animated:YES];
}
-(IBAction)conditionTypingFinished {
    [conditionField resignFirstResponder];
}
-(IBAction)recommendationTypingFinished {
    [recommendationField resignFirstResponder];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/





/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    //we only have one component in each picker
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    //returns number of rows in the pickers
    NSInteger i;
    if (thePickerView == conditionPicker) {
        i = conditionStringArray.count;
    }
    else if (thePickerView == recommendationPicker) {
        i = recommendationStringArray.count;
    }
    return i;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    //puts the entries in the pickers
    NSString *s;
    if (thePickerView == conditionPicker) {
        s = [conditionStringArray objectAtIndex:row];
    }
    else if (thePickerView == recommendationPicker) {
        s = [recommendationStringArray objectAtIndex:row];
    }
    return s;
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //changes condition or recommendation to selected row
    if (thePickerView == conditionPicker) {
        [conditionField setHidden: YES];
        [conditionSaveButton setHidden: YES];
        switch ([whichId intValue]) {
            case 1:
            {
				tree.form.condition = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
                break;
            }
            case 2:
            {
                tree.crown.condition = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
                break;
            }
            case 3:
            {
                tree.trunk.condition = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
                break;
            }
            case 4:
            {
                tree.rootflare.condition = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
                break;
            }
            case 5:
            {
                tree.roots.condition = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
                break;
            }
            case 6:
            {
                tree.overall.condition = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
                break;
            }
            default:
                break;
        }
    }
    else if (thePickerView == recommendationPicker) {
        [recommendationField setHidden: YES];
        [recommendationSaveButton setHidden: YES];
        switch ([whichId intValue]) {
            case 1:
            {
                tree.form.recommendation = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
                break;
            }
            case 2:
            {
                tree.crown.recommendation = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
                break;
            }
            case 3:
            {
                tree.trunk.recommendation = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
                break;
            }
            case 4:
            {
                tree.rootflare.recommendation = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
                break;
            }
            case 5:
            {
                tree.roots.recommendation = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
                break;
            }
            case 6:
            {
                tree.overall.recommendation = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
                break;
            }
            default:
                break;
        }
    }
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

-(IBAction)photoButtonClick:(id)sender {
    //user clicked photo button
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Photos" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Add Existing", @"View Photos", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
    [popupQuery showInView:self.view];
    [popupQuery release];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera; 
        imagePicker.allowsEditing = NO; 
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
    } else if (buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; 
        imagePicker.allowsEditing = NO; 
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
    } else if (buttonIndex == 2) {
        //flip to ttimageview thing
        
        switch ([whichId intValue]) {
            case 1:
            {
                NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:@"TreeForm", @"entity", [tree.form objectID] , @"objectID", nil];
                NSLog(@"CONDITION: %@", [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]]);
                [[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"land://Photos"] applyQuery:query] applyAnimated:YES]];
                break;
            }
            case 2:
            {
                NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:@"TreeCrown", @"entity", [tree.crown objectID] , @"objectID", nil];
                [[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"land://Photos"] applyQuery:query] applyAnimated:YES]];
                break;
            }
            case 3:
            {
                NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:@"TreeTrunk", @"entity", [tree.trunk objectID] , @"objectID", nil];
                [[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"land://Photos"] applyQuery:query] applyAnimated:YES]];
                break;
            }
            case 4:
            {
                NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:@"TreeRootFlare", @"entity", [tree.rootflare objectID] , @"objectID", nil];
                [[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"land://Photos"] applyQuery:query] applyAnimated:YES]];
                break;
            }
            case 5:
            {
                NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:@"TreeRoots", @"entity", [tree.roots objectID] , @"objectID", nil];
                [[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"land://Photos"] applyQuery:query] applyAnimated:YES]];
                break;
            }
            case 6:
            {
                NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:@"TreeOverall", @"entity", [tree.trunk objectID] , @"objectID", nil];
                [[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"land://Photos"] applyQuery:query] applyAnimated:YES]];
                break;
            }
            default:
                break;
        }
        
        
    } else if (buttonIndex == 3) {
        //cancel
    }
}

- (void)imagePickerController: (UIImagePickerController *)picker
        didFinishPickingImage: (UIImage *)image
                  editingInfo: (NSDictionary *)editingInfo {
    
    Image *newPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:managedObjectContext];
    newPhoto.image_data = UIImageJPEGRepresentation(image, 1.0);
    switch ([whichId intValue]) {
        case 1:
        {
            newPhoto.image_caption = @"Tree Assessment Form Condition";
            NSMutableSet *photos = [tree.form mutableSetValueForKey:@"images"];
            [photos addObject:newPhoto];
            [tree.form setValue:photos forKey:@"images"];
        }
            break;
        case 2:
        {
            newPhoto.image_caption = @"Tree Assessment Crown Condition";
            NSMutableSet *photos = [tree.crown mutableSetValueForKey:@"images"];
            [photos addObject:newPhoto];
            [tree.crown setValue:photos forKey:@"images"];
        }
            break;
        case 3:
        {
            newPhoto.image_caption = @"Tree Assessment Trunk Condition";
            NSMutableSet *photos = [tree.trunk mutableSetValueForKey:@"images"];
            [photos addObject:newPhoto];
            [tree.trunk setValue:photos forKey:@"images"];
        }
            break;
        case 4:
        {
            newPhoto.image_caption = @"Tree Assessment Rootflare Condition";
            NSMutableSet *photos = [tree.rootflare mutableSetValueForKey:@"images"];
            [photos addObject:newPhoto];
            [tree.rootflare setValue:photos forKey:@"images"];
        }
            break;
        case 5:
        {
            newPhoto.image_caption = @"Tree Assessment Roots Condition";
            NSMutableSet *photos = [tree.roots mutableSetValueForKey:@"images"];
            [photos addObject:newPhoto];
            [tree.roots setValue:photos forKey:@"images"];
        }
            break;
        case 6:
        {
            newPhoto.image_caption = @"Tree Assessment Overall Condition";
            NSMutableSet *photos = [tree.overall mutableSetValueForKey:@"images"];
            [photos addObject:newPhoto];
            [tree.overall setValue:photos forKey:@"images"];
        }
            break;
        default:
            break;
    }
    
    
    
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Error saving image: %@", error);
    }
    [managedObjectContext processPendingChanges];
    [[imagePicker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    // in case of cancel, get rid of picker
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    NSLog(@"Memory Warning");
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [conditionView release];
    [recommendationView release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    //[mainView release];
    [conditionStringArray release];
    [recommendationStringArray release];
    [conditionArray release];
    [recommendationArray release];
    [imagePicker release];
    [super dealloc];
}


@end
