//
//  AssessmentTableViewController.m
//  landscapes
//
//  Created by Evan Cordell on 7/26/10.
//  Copyright National Park Service/NCPTT 2010. All rights reserved.
//

#import "AssessmentTableViewController.h"


@implementation AssessmentTableViewController
@synthesize fetchedResultsController;
@synthesize managedObjectContext;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	// Name the navigation bar
    self.title = @"Assessments";
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
	// Include an Edit button. More properly, this should be called "Delete" - see setEditing
	//self.navigationItem.leftBarButtonItem = self.editButtonItem;
	//self.navigationItem.leftBarButtonItem.title = @"Delete";
	
	// Include an Add + button
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    [addButtonItem release];	
	
	// Set the table view's row height
    self.tableView.rowHeight = 52.0;
	
    //load managedObjectContext from AppDelegate
    if(!managedObjectContext){
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }

    //set up fetchedResultsController
    [self fetchedResultsController];

    //Perform fetch and catch any errors
    NSError *error = nil;
    [fetchedResultsController performFetch:&error];
    
    //prepopulate if there are no records
    if ([[[fetchedResultsController sections] objectAtIndex:0] numberOfObjects] == 0) {
        [self prepopulateDb];
        [fetchedResultsController performFetch:&error];
    }
    
    if (error) {
        NSLog(@"Error occured fetching from db: %@", error);
    }
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)prepopulateDb {    
    NSManagedObjectContext *context = [self managedObjectContext];    
    
    Landscape *landscape = [NSEntityDescription insertNewObjectForEntityForName:@"Landscape" inManagedObjectContext:context];
    landscape.name = @"Test Landscape";
    
    AssessmentType *type = [NSEntityDescription insertNewObjectForEntityForName: @"AssessmentType" inManagedObjectContext:context];
    type.name = @"Tree";
    
    AssessmentTree *assessmentTree = [NSEntityDescription insertNewObjectForEntityForName:@"AssessmentTree" inManagedObjectContext:context];
    assessmentTree.assessor = @"Test Assessor";
    assessmentTree.created_at = [NSDate date];
    assessmentTree.landscape = landscape;
    assessmentTree.type = type;
    
    TreeCrownCondition *treeCrownCondition = [NSEntityDescription insertNewObjectForEntityForName:@"TreeCrownCondition" inManagedObjectContext:context];
    treeCrownCondition.name = @"Good";
    TreeFormCondition *treeFormCondition = [NSEntityDescription insertNewObjectForEntityForName:@"TreeFormCondition" inManagedObjectContext:context];
    treeFormCondition.name = @"Good";
    TreeRootFlareCondition *treeRootFlareCondition = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootFlareCondition" inManagedObjectContext:context];
    treeRootFlareCondition.name = @"Good";
    TreeRootsCondition *treeRootsCondition = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootsCondition" inManagedObjectContext:context];
    treeRootsCondition.name = @"Good";
    TreeTrunkCondition *treeTrunkCondition = [NSEntityDescription insertNewObjectForEntityForName:@"TreeTrunkCondition" inManagedObjectContext:context];
    treeTrunkCondition.name = @"Good";
    TreeOverallCondition *treeOverallCondition = [NSEntityDescription insertNewObjectForEntityForName:@"TreeOverallCondition" inManagedObjectContext:context];
    treeOverallCondition.name = @"Good";
    
    TreeCrownRecommendation *treeCrownRecommendation = [NSEntityDescription insertNewObjectForEntityForName:@"TreeCrownRecommendation" inManagedObjectContext:context];
    treeCrownRecommendation.name = @"No Action";
    TreeFormRecommendation *treeFormRecommendation = [NSEntityDescription insertNewObjectForEntityForName:@"TreeFormRecommendation" inManagedObjectContext:context];
    treeFormRecommendation.name = @"No Action";
    TreeRootFlareRecommendation *treeRootFlareRecommendation = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootFlareRecommendation" inManagedObjectContext:context];
    treeRootFlareRecommendation.name = @"No Action";
    TreeRootsRecommendation *treeRootsRecommendation = [NSEntityDescription insertNewObjectForEntityForName:@"TreeRootsRecommendation" inManagedObjectContext:context];
    treeRootsRecommendation.name = @"No Action";
    TreeTrunkRecommendation *treeTrunkRecommendation = [NSEntityDescription insertNewObjectForEntityForName:@"TreeTrunkRecommendation" inManagedObjectContext:context];
    treeTrunkRecommendation.name = @"No Action";
    TreeOverallRecommendation *treeOverallRecommendation = [NSEntityDescription insertNewObjectForEntityForName:@"TreeOverallRecommendation" inManagedObjectContext:context];
    treeOverallRecommendation.name = @"No Action";
    
    assessmentTree.crown_condition = treeCrownCondition;
    assessmentTree.form_condition = treeFormCondition;
    assessmentTree.rootflare_condition = treeRootFlareCondition;
    assessmentTree.roots_condition = treeRootsCondition;
    assessmentTree.trunk_condition = treeTrunkCondition;
    assessmentTree.overall_condition = treeOverallCondition;
    assessmentTree.crown_recommendation = treeCrownRecommendation;
    assessmentTree.form_recommendation = treeFormRecommendation;
    assessmentTree.rootflare_recommendation = treeRootFlareRecommendation;
    assessmentTree.roots_recommendation = treeRootsRecommendation;
    assessmentTree.trunk_recommendation = treeTrunkRecommendation;
    assessmentTree.overall_recommendation = treeOverallRecommendation;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}
- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    //Do super before, it will change the name of the editing button
    [super setEditing:editing animated:animated];
	
    if (editing) {
		self.navigationItem.leftBarButtonItem.title = @"Done";
		self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleDone;
    } else {
		self.navigationItem.leftBarButtonItem.title = @"Delete";
		self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleBordered;
    }
}

- (void)add:(id)sender {
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [actionSheet addSubview:pickerView];
    [pickerView release];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
    closeButton.momentary = YES; 
    closeButton.frame = CGRectMake(10, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    [closeButton release];
    
    UISegmentedControl *addButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Add"]];
    addButton.momentary = YES; 
    addButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    addButton.segmentedControlStyle = UISegmentedControlStyleBar;
    addButton.tintColor = [UIColor blackColor];
    [addButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:addButton];
    [addButton release];
    
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void)dismissActionSheet:(id)sender {
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    //we only have one component in picker
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString string];
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSInteger count = [[fetchedResultsController sections] count];
    
    if (count == 0) {
        count = 1;
    }
    NSLog(@"Number of Sections fetched: %d", count);
    return count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    NSLog(@"Number of Rows fetched: %d", [sectionInfo numberOfObjects]);
    
    return [sectionInfo numberOfObjects];
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"cellForRowAtIndexPath called");
    
	// Define your row
    NSInteger row = [indexPath row];
	
    static NSString *AssessmentCellIdentifier = @"AssessmentTableViewCell";
    
   
    AssessmentTableViewCell *assessmentCell = (AssessmentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:AssessmentCellIdentifier];
    if (assessmentCell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AssessmentTableViewCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                assessmentCell = (AssessmentTableViewCell *) currentObject;
                break;
            }
        }
    }
    [self configureCell:assessmentCell atIndexPath:indexPath];
    if (row % 2)
        [assessmentCell setBackgroundColor:[UIColor colorWithRed:0.616f green:0.616f blue:0.627f alpha:1.0f]];
    else
        [assessmentCell setBackgroundColor:[UIColor colorWithRed:0.525f green:0.5250f blue:0.541f alpha:1.0f]];
    
    return assessmentCell;
}
- (void)configureCell:(AssessmentTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
    Assessment *assessment = (Assessment *)[fetchedResultsController objectAtIndexPath:indexPath];
    cell.assessment = assessment;
    cell.landscapeName.text = assessment.landscape.name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSString *date= [dateFormatter stringFromDate:assessment.created_at];
    [dateFormatter release];
    cell.date.text = date;
    cell.typeName.text = assessment.type.name;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:YES animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Assessment *assessment = (Assessment *)[fetchedResultsController objectAtIndexPath:indexPath];
    NSDictionary *query = [NSDictionary dictionaryWithObject:assessment forKey:@"assessment"];
    if([assessment.type.name isEqualToString:@"Tree"]) {
        [[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"land://assessments/TreeViewAndInput"] applyQuery:query] applyAnimated:YES]];
    }
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Assessment" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"assessor" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"assessment_cache"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
    
    return fetchedResultsController;
}    
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(AssessmentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [actionSheet release];
    [fetchedResultsController release];
    [super dealloc];
}


@end

