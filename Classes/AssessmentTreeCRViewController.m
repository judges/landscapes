//
//  AssessmentTreeCRViewController.m
//  landscapes
//
//  Created by Evan Cordell on 8/3/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "AssessmentTreeCRViewController.h"



@implementation AssessmentTreeCRViewController

@synthesize whichId, managedObjectContext, conditionArray, recommendationArray, conditionField, recommendationField, tree, isEditing;


-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query { 
    if (self = [super initWithNibName:@"AssessmentTreeCRView" bundle:[NSBundle mainBundle]]){
        if(query && [query objectForKey:@"assessmentTree"] && [query objectForKey:@"id"]){ 
            whichId = [query objectForKey:@"id"];
            tree = [query objectForKey:@"assessmentTree"];
            conditionArray = [[NSMutableArray alloc] init];
            recommendationArray = [[NSMutableArray alloc] init];
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
-(IBAction)segmentSwitch:(id)sender {
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
    isEditing = NO;
    [conditionField setHidden:NO];
    [conditionSaveButton setHidden:NO];
    conditionSaveButton.titleLabel.text = @"Add";
    [conditionField becomeFirstResponder];
}
-(IBAction)addRecommendation {
    isEditing = NO;
    [recommendationField setHidden:NO];
    [recommendationSaveButton setHidden:NO];
    recommendationSaveButton.titleLabel.text = @"Add";
    [recommendationField becomeFirstResponder];
}
-(IBAction)editCondition {
    isEditing = YES;
    [conditionField setHidden: NO];
    [conditionSaveButton setHidden: NO];
    conditionSaveButton.titleLabel.text = @"Edit";
    conditionField.text = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
    [conditionField becomeFirstResponder];
}
-(IBAction)editRecommendation {
    isEditing = YES;
    [recommendationField setHidden: NO];
    [recommendationSaveButton setHidden: NO];
    recommendationSaveButton.titleLabel.text = @"Edit";
    recommendationField.text = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
    [recommendationField becomeFirstResponder];
}
-(IBAction)deleteCondition {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSError *error;
    switch ([whichId intValue]) {
        case 1:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeFormCondition" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeFormCondition *item = (TreeFormCondition *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 2:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeCrownCondition" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeCrownCondition *item = (TreeCrownCondition *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 3:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeTrunkCondition" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeTrunkCondition *item = (TreeTrunkCondition *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 4:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeRootFlareCondition" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeRootFlareCondition *item = (TreeRootFlareCondition *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 5:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeRootsCondition" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeRootsCondition *item = (TreeRootsCondition *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 6:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeOverallCondition" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeOverallCondition *item = (TreeOverallCondition *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        default:
            break;
    }
    
    [fetchRequest release];
    [sortDescriptors release];
    [sortDescriptor release];
    if (![managedObjectContext save:&error]) {
       NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [conditionArray removeObjectAtIndex:[conditionPicker selectedRowInComponent:0]];
    [conditionPicker reloadComponent:0];
}
-(IBAction)deleteRecommendation {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSError *error;
    switch ([whichId intValue]) {
        case 1:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeFormRecommendation" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeFormRecommendation *item = (TreeFormRecommendation *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 2:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeCrownRecommendation" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeCrownRecommendation *item = (TreeCrownRecommendation *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 3:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeTrunkRecommendation" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeTrunkRecommendation *item = (TreeTrunkRecommendation *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 4:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeRootFlareRecommendation" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeRootFlareRecommendation *item = (TreeRootFlareRecommendation *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 5:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeRootsRecommendation" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeRootsRecommendation *item = (TreeCrownRecommendation *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        case 6:
        {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeOverallRecommendation" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]]];
            [fetchRequest setPredicate:predicate];
            NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
            TreeOverallRecommendation *item = (TreeOverallRecommendation *)[array objectAtIndex:0];
            [managedObjectContext deleteObject:item];
            break;
        }
        default:
            break;
    }
    
    [fetchRequest release];
    [sortDescriptors release];
    [sortDescriptor release];
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [recommendationArray removeObjectAtIndex:[recommendationPicker selectedRowInComponent:0]];
    [recommendationPicker reloadComponent:0];
}
-(IBAction)conditionSaveButtonClick {
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
            break;
        }
        case 2:
        {
            TreeCrownCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeCrownCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            break;
        }
        case 3:
        {
            TreeTrunkCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeTrunkCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            break;
        }
        case 4:
        {
            TreeRootFlareCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeTrunkCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            break;
        }
        case 5:
        {
            TreeRootsCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootsCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            break;
        }
        case 6:
        {
            TreeOverallCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeOverallCondition" inManagedObjectContext:managedObjectContext];
            item.name = [conditionField text];
            break;
        }
        default:
            break;
    }
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [conditionArray addObject:[conditionField text]];
    [conditionPicker reloadComponent:0];
    conditionField.text = @"";
}
-(IBAction)recommendationSaveButtonClick {
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
            break;
        }
        case 2:
        {
            TreeCrownRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeCrownRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            break;
        }
        case 3:
        {
            TreeTrunkRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeTrunkRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            break;
        }
        case 4:
        {
            TreeRootFlareRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeTrunkRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            break;
        }
        case 5:
        {
            TreeRootsRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootsRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            break;
        }
        case 6:
        {
            TreeOverallRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeOverallRecommendation" inManagedObjectContext:managedObjectContext];
            item.name = [recommendationField text];
            break;
        }
        default:
            break;
    }
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [recommendationArray addObject:[recommendationField text]];
    [recommendationPicker reloadComponent:0];
    recommendationField.text = @"";
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    if(!managedObjectContext){
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    NSFetchRequest *cFetchRequest = [[NSFetchRequest alloc] init];
    NSFetchRequest *rFetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
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
                if (tree.form_condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionArray addObject:item.name];
            }
            for (TreeFormRecommendation *item in rArray) {
                if (tree.form_recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationArray addObject:item.name];
            }
            break;
        }
        case 2:
        {
            for (TreeCrownCondition *item in cArray) {
                if (tree.crown_condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionArray addObject:item.name];
            }
            for (TreeCrownRecommendation *item in rArray) {
                if (tree.crown_recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationArray addObject:item.name];
            }
            break;
        }
        case 3:
        {
            for (TreeTrunkCondition *item in cArray) {
                if (tree.trunk_condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionArray addObject:item.name];
            }
            for (TreeTrunkRecommendation *item in rArray) {
                if (tree.trunk_recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationArray addObject:item.name];
            }
            break;
        }
        case 4:
        {
            for (TreeRootFlareCondition *item in cArray) {
                if (tree.rootflare_condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionArray addObject:item.name];
            }
            for (TreeRootFlareRecommendation *item in rArray) {
                if (tree.rootflare_recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationArray addObject:item.name];
            }
            break;
        }
        case 5:
        {
            for (TreeRootsCondition *item in cArray) {
                if (tree.roots_condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionArray addObject:item.name];
            }
            for (TreeRootsRecommendation *item in rArray) {
                if (tree.roots_recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationArray addObject:item.name];
            }
            break;
        }
        case 6:
        {
            for (TreeOverallCondition *item in cArray) {
                if (tree.overall_condition == item) {
                    selectedConditionIndex = cCtr;
                }
                ++cCtr;
                [conditionArray addObject:item.name];
            }
            for (TreeOverallRecommendation *item in rArray) {
                if (tree.overall_recommendation == item) {
                    selectedRecommendationIndex = rCtr;
                }
                ++rCtr;
                [recommendationArray addObject:item.name];
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
    
    [conditionPicker selectRow:selectedConditionIndex inComponent:0 animated:YES];
    [recommendationPicker selectRow:selectedRecommendationIndex inComponent:0 animated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger i;
    if (thePickerView == conditionPicker) {
        i = conditionArray.count;
    }
    else if (thePickerView == recommendationPicker) {
        i = recommendationArray.count;
    }
    return i;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *s;
    if (thePickerView == conditionPicker) {
        s = [conditionArray objectAtIndex:row];
    }
    else if (thePickerView == recommendationPicker) {
        s = [recommendationArray objectAtIndex:row];
    }
    return s;
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSError *error;
    
    if (thePickerView == conditionPicker) {
        [conditionField setHidden: YES];
        [conditionSaveButton setHidden: YES];
        switch ([whichId intValue]) {
            case 1:
                {
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeFormCondition" inManagedObjectContext:managedObjectContext];
                    [fetchRequest setEntity:entity];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:row]];
                    [fetchRequest setPredicate:predicate];
                    NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                    TreeFormCondition *fc = (TreeFormCondition *)[array objectAtIndex:0];
                    tree.form_condition = fc;
                    break;
                }
            case 2:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeCrownCondition" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeCrownCondition *fc = (TreeCrownCondition *)[array objectAtIndex:0];
                tree.crown_condition = fc;
                break;
            }
            case 3:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeTrunkCondition" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeTrunkCondition *fc = (TreeTrunkCondition *)[array objectAtIndex:0];
                tree.trunk_condition = fc;
                break;
            }
            case 4:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeRootFlareCondition" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeRootFlareCondition *fc = (TreeRootFlareCondition *)[array objectAtIndex:0];
                tree.rootflare_condition = fc;
                break;
            }
            case 5:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeRootsCondition" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeRootsCondition *fc = (TreeRootsCondition *)[array objectAtIndex:0];
                tree.roots_condition = fc;
                break;
            }
            case 6:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeOverallCondition" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [conditionArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeOverallCondition *fc = (TreeOverallCondition *)[array objectAtIndex:0];
                tree.overall_condition = fc;
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
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeFormRecommendation" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeFormRecommendation *fr = (TreeFormRecommendation *)[array objectAtIndex:0];
                tree.form_recommendation = fr;
                break;
            }
            case 2:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeCrownRecommendation" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeCrownRecommendation *fr = (TreeCrownRecommendation *)[array objectAtIndex:0];
                tree.crown_recommendation = fr;
                break;
            }
            case 3:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeTrunkRecommendation" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeTrunkRecommendation *fc = (TreeTrunkRecommendation *)[array objectAtIndex:0];
                tree.trunk_recommendation = fc;
                break;
            }
            case 4:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeRootFlareRecommendation" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeRootFlareRecommendation *fc = (TreeRootFlareRecommendation *)[array objectAtIndex:0];
                tree.rootflare_recommendation = fc;
                break;
            }
            case 5:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeRootsRecommendation" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeRootsRecommendation *fc = (TreeRootsRecommendation *)[array objectAtIndex:0];
                tree.roots_recommendation = fc;
                break;
            }
            case 6:
            {
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeOverallRecommendation" inManagedObjectContext:managedObjectContext];
                [fetchRequest setEntity:entity];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:row]];
                [fetchRequest setPredicate:predicate];
                NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
                TreeOverallRecommendation *fc = (TreeOverallRecommendation *)[array objectAtIndex:0];
                tree.overall_recommendation = fc;
                break;
            }
            default:
                break;
        }
    }
    [fetchRequest release];
    [sortDescriptors release];
    [sortDescriptor release];
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    NSLog(@"Memory Warning");
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [whichId release];
    [managedObjectContext release];
    [conditionArray release];
    [recommendationArray release];
    [conditionField release];
    [recommendationField release];
    [tree release];
    [super dealloc];
}


@end
