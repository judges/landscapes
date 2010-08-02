//
//  AssessmentViewAndInput.m
//  landscapes
//
//  Created by Evan Cordell on 8/2/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "AssessmentTreeViewAndInputController.h"


@implementation AssessmentTreeViewAndInputController
@synthesize assessment, assessmentTree, assessor, date, fetchedResultsController, managedObjectContext;
@synthesize formCText, crownCText, trunkCText, rootFlareCText, rootsCText, overallCText;
@synthesize formRText, crownRText, trunkRText, rootFlareRText, rootsRText, overallRText;

-(id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query { 
    if (self = [super initWithNibName:@"AssessmentTreeViewAndInput" bundle:[NSBundle mainBundle]]){ 
        if(query && [query objectForKey:@"assessment"]){ 
            self.assessment = (Assessment*) [query objectForKey:@"assessment"]; 
            self.assessor = [[UILabel alloc] init];
            self.date = [[UILabel alloc] init];
            self.formCText = [[UILabel alloc] init];
            self.crownCText = [[UILabel alloc] init];
            self.trunkCText = [[UILabel alloc] init];
            self.rootFlareCText = [[UILabel alloc] init];
            self.rootsCText = [[UILabel alloc] init];
            self.overallCText = [[UILabel alloc] init];
            self.formRText = [[UILabel alloc] init];
            self.crownRText = [[UILabel alloc] init];
            self.trunkRText = [[UILabel alloc] init];
            self.rootFlareRText = [[UILabel alloc] init];
            self.rootsRText = [[UILabel alloc] init];
            self.overallRText = [[UILabel alloc] init];
        } 
    } 
    return self; 
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
   //set up fetchedResultsController
    [self fetchedResultsController];
    
    //Perform fetch and catch any errors
    NSError *error = nil;
    [fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"Error occured fetching from db: %@", error);
    }
    
    self.title = @"Tree";
    self.assessor.text = self.assessment.assessor;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSString *dateStr= [dateFormatter stringFromDate:self.assessment.created_at];
    [dateFormatter release];
    NSLog(@"%@", dateStr);
    self.date.text = dateStr;
    if (self.assessment) {
        //self.assessmentTree = (AssessmentTree *)[fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    //NSLog(@"%@", [fetchedResultsController count]);
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:0];
    NSLog(@"Number of Rows fetched: %d", [sectionInfo numberOfObjects]);
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

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"AssessmentTree" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"assessment.created_at == %@", self.assessment.created_at];
        [fetchRequest setPredicate:predicate];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"assessment" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"assessmentTree_cache"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
    
    return fetchedResultsController;
}    

- (void)dealloc {
    [assessor release];
    [date release];
    [formCText release];
    [crownCText release];
    [trunkCText release];
    [rootFlareCText release];
    [rootsCText release];
    [overallCText release];
    [formRText release];
    [crownRText release];
    [trunkRText release];
    [rootFlareRText release];
    [rootsRText release];
    [overallRText release];
    [fetchedResultsController release];
    [managedObjectContext release];
    
    [super dealloc];
}


@end
