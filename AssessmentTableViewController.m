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
	
	// Include an Edit button. More properly, this should be called "Delete" - see setEditing
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.navigationItem.leftBarButtonItem.title = @"Delete";
	
	// Include an Add + button
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    [addButtonItem release];	
	
	// Set the table view's row height
    self.tableView.rowHeight = 52.0;
	
	
    
    //Provide dummy Fetch request in order to create tables in SQLite DB
    /*
     Fetch existing events.
     Create a fetch request; find the Event entity and assign it to the request; add a sort descriptor; then execute the fetch.
    */
    if(!managedObjectContext){
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Assessment" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    for (NSPropertyDescription *property in entity)
    {
        NSLog(@"%@", property.name);
    }
    // Execute the fetch — create a mutable copy of the result.
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
    }
    [request release];
     
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    //code to add entry
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
	
    static NSString *AssessmentCellIdentifier = @"AssessmentCellIdentifier";
    
   
    AssessmentTableViewCell *assessmentCell = (AssessmentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:AssessmentCellIdentifier];
    if (assessmentCell == nil) {
        assessmentCell = [[[AssessmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AssessmentCellIdentifier] autorelease];
        assessmentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    
        
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


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
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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
        
        for (NSPropertyDescription *property in entity)
        {
            NSLog(@"%@", property.name);
        }
        
        
        // Edit the sort key as appropriate.
        //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        //NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        //[fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        //[sortDescriptor release];
        //[sortDescriptors release];
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
    [fetchedResultsController release];
    [managedObjectContext release];
    [super dealloc];
}


@end

