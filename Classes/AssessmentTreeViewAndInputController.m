//
//  AssessmentViewAndInput.m
//  landscapes
//
//  Created by Evan Cordell on 8/2/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "AssessmentTreeViewAndInputController.h"


@implementation AssessmentTreeViewAndInputController

@synthesize assessment, assessmentTree, assessor, date, caliper, height;
@synthesize formCText, crownCText, trunkCText, rootFlareCText, rootsCText, overallCText;
@synthesize formRText, crownRText, trunkRText, rootFlareRText, rootsRText, overallRText;
@synthesize assessorField, caliperField, heightField;

-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query { 
    //initializes and passes assessment from parent controller
    if (self = [super initWithNibName:@"AssessmentTreeViewAndInput" bundle:[NSBundle mainBundle]]){ 
        if(query && [query objectForKey:@"assessment"]){ 
            self.assessment = (Assessment*) [query objectForKey:@"assessment"]; 
            imagePicker = [[UIImagePickerController alloc] init];
        } 
    } 
    return self; 
} 

-(IBAction)segmentSwitch:(id)sender {
    //switch between view and input views
    UISegmentedControl *segmentedButton = (UISegmentedControl *) sender;
    if (segmentedButton.selectedSegmentIndex == 0) {
        [viewView setHidden:NO];
        [inputView setHidden:YES];
    } else {
        [viewView setHidden:YES];
        [inputView setHidden:NO];
    }

}
-(IBAction)photoButtonClick:(id)sender {
    //user clicked photo button
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Photos" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Add Existing", @"View Photos", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleDefault;
    [popupQuery showInView:self.view];
    [popupQuery release];
    
}
-(IBAction)treeButtonClick:(id)sender {
    //user clicked one of the tree buttons, so send them to the other view with the right id
    int clickId = [[(UIButton*)sender titleLabel].text intValue];
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:self.assessmentTree, @"assessmentTree", [NSNumber numberWithInt:clickId], @"id", nil];
    [[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"land://assessments/TreeForm"] applyQuery:query] applyAnimated:YES]];
}
-(IBAction)saveAssessor:(id)sender {
    //edit the assessor field
    [assessorField resignFirstResponder];
    NSError *saveError;
    self.assessor.text = [(UITextField*)sender text];
    self.assessment.assessor = [(UITextField*)sender text];
    if (![managedObjectContext save:&saveError]) {
        NSLog(@"Saving changes to assessor failed: %@", saveError);
    }
}
-(IBAction)saveCaliper:(id)sender {
    //edit the caliper field
    [caliperField resignFirstResponder];
    self.assessmentTree.caliper = [NSDecimalNumber decimalNumberWithString:[(UITextField*)sender text]];
    NSError *saveError;
    if (![managedObjectContext save:&saveError]) {
       NSLog(@"Saving changes to caliper failed: %@", saveError);
    }
    self.caliper.text = [self.assessmentTree.caliper stringValue];
}
-(IBAction)saveHeight:(id)sender {
    //edit the height field
    [heightField resignFirstResponder];
    self.assessmentTree.height = [NSDecimalNumber decimalNumberWithString:[(UITextField*)sender text]];
    NSError *saveError;
    if (![managedObjectContext save:&saveError]) {
        NSLog(@"Saving changes to height failed: %@", saveError);
    }
    self.height.text = [self.assessmentTree.height stringValue];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
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
    
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Grab AssessmentTree that matches the Assessment.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AssessmentTree" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assessment == %@", self.assessment];
    [fetchRequest setPredicate:predicate];
    
    // sort by assessment
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"assessment" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSMutableArray *fetchedObjects = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    self.title = @"Tree";
    self.assessor.text = self.assessment.assessor;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSString *dateStr= [dateFormatter stringFromDate:self.assessment.created_at];
    [dateFormatter release];
    self.date.text = dateStr;
    if (self.assessment) {
        self.assessmentTree = (AssessmentTree *)([fetchedObjects objectAtIndex:0]);
        self.caliper.text = [NSString stringWithFormat:@"%@ \'", [self.assessmentTree.caliper stringValue]];
        self.height.text = [NSString stringWithFormat:@"%@ \'", [self.assessmentTree.height stringValue]]   ;
        self.formCText.text = self.assessmentTree.form_condition.name;
        self.crownCText.text = self.assessmentTree.crown_condition.name;
        self.trunkCText.text = self.assessmentTree.trunk_condition.name;
        self.rootFlareCText.text = self.assessmentTree.rootflare_condition.name;
        self.rootsCText.text = self.assessmentTree.roots_condition.name;
        self.overallCText.text = self.assessmentTree.overall_condition.name;
        self.formRText.text = self.assessmentTree.form_recommendation.name;
        self.crownRText.text = self.assessmentTree.crown_recommendation.name;
        self.trunkRText.text = self.assessmentTree.trunk_recommendation.name;
        self.rootFlareRText.text = self.assessmentTree.rootflare_recommendation.name;
        self.rootsRText.text = self.assessmentTree.roots_recommendation.name;
        self.overallRText.text = self.assessmentTree.overall_recommendation.name;
        self.assessorField.text = self.assessment.assessor;
        self.caliperField.text = [self.assessmentTree.caliper stringValue];
        self.heightField.text = [self.assessmentTree.height stringValue];
    }
    
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera; 
        imagePicker.allowsEditing = NO; 
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
    } else if (buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; 
        imagePicker.allowsEditing = NO; 
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
    } else if (buttonIndex == 2) {
        //flip to ttimageview thing
        [[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"land://Photos"] applyQuery:[NSDictionary dictionaryWithObject:@"AssessmentTree" forKey:@"entity"]]applyAnimated:YES]];
        

    } else if (buttonIndex == 3) {
        //cancel
    }
}

- (void)imagePickerController: (UIImagePickerController *)picker
        didFinishPickingImage: (UIImage *)image
                  editingInfo: (NSDictionary *)editingInfo {
    NSMutableSet *photos = [assessmentTree mutableSetValueForKey:@"images"];
    Image *newPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:managedObjectContext];
    newPhoto.image_data = UIImageJPEGRepresentation(image, 1.0);
    newPhoto.image_caption = @"Caption";
    [photos addObject:newPhoto];
    [assessmentTree setValue:photos forKey:@"images"];
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Error saving image.");
    }
    [managedObjectContext processPendingChanges];
    [[imagePicker parentViewController] dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    // in case of cancel, get rid of picker
    [[imagePicker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
    //[mainView release];
    //[assessment release];
    //[assessmentTree release];
    //[managedObjectContext release];
    [imagePicker release];
    [super dealloc];
}


@end
