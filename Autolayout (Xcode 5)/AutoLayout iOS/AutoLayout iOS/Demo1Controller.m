//
//  Demo1Controller.m
//  AutoLayout iOS
//
//  Created by BJ Homer on 10/2/13.
//  Copyright (c) 2013 BJ Homer. All rights reserved.
//

#import "Demo1Controller.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface Demo1Cell : UITableViewCell
@property (weak) IBOutlet UILabel *firstLabel;
@property (weak) IBOutlet UILabel *secondLabel;
@end

@implementation Demo1Cell
@end


@interface Demo1Controller ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
@implementation Demo1Controller {
	NSArray *_people;
}

- (void)loadPeople
{
	ABAddressBookRef book = ABAddressBookCreateWithOptions(nil, nil);

	ABAddressBookRequestAccessWithCompletion(book, ^(bool granted, CFErrorRef error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			_people = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(book));
			NSLog(@"people: %@", _people);
			[self.tableView reloadData];
		});
	});
}

- (void)viewWillAppear:(BOOL)animated {
	if ([self isMovingToParentViewController]) {
		[self loadPeople];
	}
	[super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _people.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	ABRecordRef person = (__bridge ABRecordRef)(_people[indexPath.row]);
	if (indexPath.row == 1) {
		Demo1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];
		
		NSString *fullname = CFBridgingRelease(ABRecordCopyCompositeName(person));
		
		cell.secondLabel.text = fullname;
		return cell;
	}
	else {
		Demo1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
		
		ABMultiValueRef addressMultiValue = ABRecordCopyValue(person, kABPersonAddressProperty);
		NSDictionary *addressDict = CFBridgingRelease(ABMultiValueCopyValueAtIndex(addressMultiValue, 0));
		CFRelease(addressMultiValue);
		
		
		NSString *address = ABCreateStringWithAddressDictionary(addressDict, NO);
		cell.secondLabel.text = address;
		return cell;

	}
}

@end
