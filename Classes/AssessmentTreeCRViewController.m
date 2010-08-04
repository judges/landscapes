//
//  AssessmentTreeCRViewController.m
//  landscapes
//
//  Created by Evan Cordell on 8/3/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "AssessmentTreeCRViewController.h"



@implementation AssessmentTreeCRViewController

@synthesize whichId, managedObjectContext, conditionArray, recommendationArray, conditionField, recommendationField, tree;


-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query { 
    if (self = [super initWithNibName:@"AssessmentTreeCRView" bundle:[NSBundle mainBundle]]){
        if(query && [query objectForKey:@"assessmentTree"] && [query objectForKey:@"id"]){ 
            whichId = [query objectForKey:@"id"];
            tree = [query objectForKey:@"assessmentTree"];
            conditionArray = [[NSMutableArray alloc] init];
            recommendationArray = [[NSMutableArray alloc] init];
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
    [conditionField becomeFirstResponder];
}
-(IBAction)addRecommendation {
    [recommendationField becomeFirstResponder];
}
-(IBAction)editCondition {
    conditionField.text = [conditionArray objectAtIndex:[conditionPicker selectedRowInComponent:0]];
    [conditionField becomeFirstResponder];
}
-(IBAction)editRecommendation {
    recommendationField.text = [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]];
    [recommendationField becomeFirstResponder];
}
-(IBAction)deleteCondition {
    //TODO: other types of attributes
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
        }
            break;
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TreeFormRecommendation" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [recommendationArray objectAtIndex:[recommendationPicker selectedRowInComponent:0]]];
    [fetchRequest setPredicate:predicate];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    [fetchRequest release];
    [sortDescriptors release];
    [sortDescriptor release];
    TreeFormRecommendation *fr = (TreeFormRecommendation *)[array objectAtIndex:0];
    [managedObjectContext deleteObject:fr];
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [recommendationArray removeObjectAtIndex:[recommendationPicker selectedRowInComponent:0]];
    [recommendationPicker reloadComponent:0];
}
-(IBAction)conditionSaveButtonClick {
    [conditionField resignFirstResponder];
    switch ([whichId intValue]) {
        case 1:
        {
            TreeFormCondition *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeFormCondition" inManagedObjectContext:managedObjectContext];
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
    [recommendationField resignFirstResponder];
    switch ([whichId intValue]) {
        case 1:
        {
            TreeFormRecommendation *item = [NSEntityDescription insertNewObjectForEntityForName:@"TreeFormRecommendation" inManagedObjectContext:managedObjectContext];
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
                }
                break;
            default:
                break;
        }
    }
    else if (thePickerView == recommendationPicker) {
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
            }
                break;
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
