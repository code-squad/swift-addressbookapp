/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    MGCContactStore implements various functionalities of the Contacts
                framework. It demonstrates how to:
                -Check and request access to the Contacts application and observe 
                 changes using CNContactStoreDidChangeNotification.
                -Fetch the default container, all containers, all groups per container,
                 all contacts per container, and the container with a given identifier.
                -Fetch all groups, all contacts per group, the group with a given 
                 identifier, and the container that contains a given group.
                -Fetch all contacts, contacts matching a given name, and contact with
                 a given identifier.
                -Add, update, and delete contacts and groups. Describes best practices 
                 when updating and deleting them.
                -Add and remove an existing contact from an existing group.
                -Perform batching multiple changes into a single save request.
 */

import UIKit
import Contacts

class MGCContactStore {
    // MARK: - Types
    
    static let sharedInstance = MGCContactStore()
    
    // MARK: - Properties
    
    fileprivate var store = CNContactStore()
    
    /// A private and local queue to `MGCContactStore`.
    fileprivate let contactStoreQueue = DispatchQueue(label: Bundle.main.bundleIdentifier!+".MGCContactStore", attributes: DispatchQueue.Attributes.concurrent)
    
    fileprivate var contactStoreUtility = MGCContactStoreUtilities()
    
    /**
		- returns: true if we have previously registered for 
				   CNContactStoreDidChangeNotification and false, otherwise.
	*/
    fileprivate var hasRegisteredForNotifications: Bool?
    
    /// - returns: The identifier of the default container.
    var defaultContainerID: String {
        get {
            return store.defaultContainerIdentifier()
        }
    }
    
    
    // MARK: - Handle CNContactStoreDidChangeNotification
    
    /// Register for CNContactStoreDidChangeNotification notifications.
    fileprivate func registerForCNContactStoreDidChangeNotification() {
        // Don't register if we have already done so.
        if hasRegisteredForNotifications == nil {
			
            NotificationCenter.default.addObserver(self, selector: #selector(MGCContactStore.storeDidChange(_:)), name: NSNotification.Name.CNContactStoreDidChange, object: nil)
            hasRegisteredForNotifications = true
        }
    }
    
    /// Stop listening for CNContactStoreDidChangeNotification notifications.
    fileprivate func unregisterForCNContactStoreDidChangeNotification() {
        // Only unregister an existing notification registration.
        if hasRegisteredForNotifications ?? true {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.CNContactStoreDidChange, object: nil)
            hasRegisteredForNotifications = false
        }
    }
    
    /// Notifies listeners that changes have occured in the contact store.
    @objc func storeDidChange(_ notification: Notification) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: MGCAppConfiguration.MGCNotifications.storeDidChange), object: self)
    }
    
    
    // MARK: - Contacts Access
    
    /**
		Checks the authorization status for Contacts. Requests access if the 
		returned status is .notDetermined.
	*/
    func checkContactsAccess(_ completion: @escaping (_ accessGranted: Bool) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
			// Access was granted.
            case .authorized:
                registerForCNContactStoreDidChangeNotification()
                completion(true)
            case .notDetermined:
                self.store.requestAccess(for: .contacts, completionHandler: {(granted, error) in
                    self.registerForCNContactStoreDidChangeNotification()
                    completion(granted)
                })
            // Access was denied.
            case .restricted,.denied:
                completion(false)
        }
    }
    
    
    // MARK: - Deleting 
    
    /// Delete one or more existing groups.
    func delete(_ groups: [CNGroup]) {
        /* The save request operation will fail with an 
		   CNErrorCodeRecordDoesNotExist error if the groups to be removed do not
		   exist. First, let's check that each of them exists before attempting 
		   to remove it.
		*/
        
        // Fetch the identifiers of all groups to be removed.
        let identifiers = groups.map({(group: CNGroup) in group.identifier})
        
        fetchGroups(with: identifiers, completion: ({(groups: [CNGroup]) in
            if groups.count > 0 {
				
                let request = CNSaveRequest()
                
                // Batch all delete requests into a single one.
                for group in groups {
                    let newGroup = group.mutableCopy() as! CNMutableGroup
                    request.delete(newGroup)
                }
                
                self.contactStoreQueue.async(flags: .barrier, execute: {
                    do {
                        try self.store.execute(request)
                    } catch let error as NSError {
                        print("Error \(error.localizedDescription)")
                    }
                }) 
             }
        }))
    }

    /// Remove one or more contacts from a group.
    func remove(_ contacts: [CNContact], from group: CNGroup) {
        /* The save request operation will fail with an 
		   CNErrorCodeRecordDoesNotExist error if the contacts to be removed
           do not exist. First, let's check that each of them exists before 
		   attempting to remove it.
		*/
        
        // Fetch the identifiers of all contacts to be removed.
        let identifiers = contacts.map({(contact: CNContact) in contact.identifier})
       
        fetchContacts(with: identifiers, completion: ({(contacts: [CNContact]) in
            if contacts.count > 0 {
				
                let request = CNSaveRequest()
                
                for contact in contacts {
                    request.removeMember(contact, from: group)
                }
				
                self.contactStoreQueue.async(flags: .barrier, execute: {
                    do {
                        try self.store.execute(request)
                    } catch let error as NSError {
                        print("Error \(error.localizedDescription)")
                    }
                }) 
            }
        }))
    }

    /// Delete one or more existing contacts.
    func delete(_ contacts: [CNContact]) {
        /* The save request operation will fail with an 
			CNErrorCodeRecordDoesNotExist error if the contacts to be removed
            do not exist. First, let's check that each of them exists before 
			attempting to remove it.
		*/
        
        // Fetch the identifiers of all contacts to be removed
        let identifiers = contacts.map({(contact: CNContact) in contact.identifier})
        
        /* fetchContacts(with:completionHandler:) only returns already
		   existing contacts.
		*/
        fetchContacts(with: identifiers, completion: ({(contacts: [CNContact]) in
            if contacts.count > 0 {
				
                let request = CNSaveRequest()
                
                // Batch all delete requests into a single one.
                for contact in contacts {
                   request.delete(contact.mutableCopy() as! CNMutableContact)
                }
				
                self.contactStoreQueue.async(flags: .barrier, execute: {
                    do {
                        try self.store.execute(request)
                    } catch let error as NSError {
                        print("Error \(error.localizedDescription)")
                    }
                }) 
            }
        }))
    }

    
    // MARK: - Fetching 
    
    /// - returns: Existing contacts matching the specified array of identifiers.
    fileprivate func fetchContacts(with identifiers: [String], completion: @escaping (_ contacts: [CNContact]) -> Void) {
        var result = [CNContact]()
        // Only fetch the given name, family name, and organization keys.
        let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactOrganizationNameKey as CNKeyDescriptor])
        
        /* Create a predicate for getting the existing contacts matching the 
		   specified identifiers.
		*/
        request.predicate = CNContact.predicateForContacts(withIdentifiers: identifiers)
        
        contactStoreQueue.async {
            do {
                try self.store.enumerateContacts(with: request, usingBlock: {(contact, status) -> Void in
                    // Add the returned contact to result.
                    result.append(contact)
                })
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
			
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    /// - returns:  Fetches the container of the specified group
    func fetchContainerOfGroup(with identifier: String, completion: @escaping (_ container: CNContainer?) -> Void) {
        var result: CNContainer?
        let predicate = CNContainer.predicateForContainerOfGroup(withIdentifier: identifier)
        
        contactStoreQueue.async {
            do {
                let temp = try self.store.containers(matching: predicate)
                // We use the first item returned by the above query.
                result = (temp.count > 0) ? temp.first : nil
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    /// - returns: Fetches all contacts in the specified container.
    func fetchContactsInContainer(with identifier: String, completion: @escaping (_ contacts: [CNContact]) -> Void) {
        var result = [CNContact]()
        
        // Fetch only the full name of a person or organization.
        let request = CNContactFetchRequest(keysToFetch: [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
        request.predicate = CNContact.predicateForContactsInContainer(withIdentifier: identifier)
        
        contactStoreQueue.async {
            do {
                try self.store.enumerateContacts(with: request, usingBlock: {(contact, status) -> Void in
                    // Add each returned contact to result.
                    result.append(contact)
                })
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    /// - returns: Fetches all contacts in the specified group.
    func fetchContactsInGroup(with identifier: String, completion: @escaping (_ contacts: [CNContact]) -> Void) {
        var result = [CNContact]()
        // Fetch only the full name of a person or organization.
        let request = CNContactFetchRequest(keysToFetch: [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
        
        // Predicate to fetch all contacts that are members of the specified group.
        request.predicate = CNContact.predicateForContactsInGroup(withIdentifier: identifier)
        
        contactStoreQueue.async {
            do {
                try self.store.enumerateContacts(with: request, usingBlock: {(contact, status) -> Void in
                    // Add each retured contact to result.
                    result.append(contact)
                })
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
			
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    /** 
		- returns: Fetches all the contacts matching a given name. Only fetch
				   the given name, family name, and organization properties of 
	               each contact.
	*/
    func fetchContacts(with name: String, completion: @escaping (_ contacts: [CNContact]) -> Void) {
        var result = [CNContact]()
        let predicate = CNContact.predicateForContacts(matchingName: name)
        
        contactStoreQueue.async {
            do {
                /* Set keysToFetch to only return the given name, family name, 
				   and organization properties.
				*/
                result = try self.store.unifiedContacts(matching: predicate, keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
                
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    /// - returns: Fetches all available contacts sorted by family name.
    func fetchContacts(_ completion: @escaping (_ contacts: [CNContact]) -> Void) {
        var result = [CNContact]()
		
        // Keys required for the operation.
        let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactOrganizationNameKey as CNKeyDescriptor,
                                                          CNContactEmailAddressesKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor,
                                                          CNContactEmailAddressesKey as CNKeyDescriptor, CNContactPostalAddressesKey as CNKeyDescriptor,CNPostalAddressStreetKey as CNKeyDescriptor,
                                                          CNPostalAddressCityKey as CNKeyDescriptor, CNPostalAddressStateKey as CNKeyDescriptor, CNPostalAddressPostalCodeKey as CNKeyDescriptor,
                                                          CNPostalAddressCountryKey as CNKeyDescriptor, CNContactDatesKey as CNKeyDescriptor, CNContactThumbnailImageDataKey as CNKeyDescriptor,
                                                          CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
        
        // Sort the result by family name.
        request.sortOrder = .familyName
        
        contactStoreQueue.async {
            do {
                try self.store.enumerateContacts(with: request, usingBlock: {(contact, status) -> Void in
                    result.append(contact)
                })
                
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
			
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    /// - returns: Fetches all available containers.
    func fetchContainers(_ completion: @escaping (_ containers: [CNContainer]) -> Void) {
        var result = [CNContainer]()
        
         contactStoreQueue.async {
            do {
                result = try self.store.containers(matching: nil)
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    /// - returns: Fetches all groups in the specified container.
    func fetchGroupsInContainer(with identifier: String, completion: @escaping (_ groups: [CNGroup]) -> Void) {
        var result = [CNGroup]()
        
        contactStoreQueue.async {
            // Create a predicate to find groups in the specified container.
            let predicate = CNGroup.predicateForGroupsInContainer(withIdentifier: identifier)
			
            do {
                result = try self.store.groups(matching: predicate)
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    /// - returns: Fetches the container with the specified identifier.
    func fetchContainer(with identifier: String, completion: @escaping (_ container: CNContainer?) -> Void) {
        var result: CNContainer?
        
        // Send fetching operation to the background.
        contactStoreQueue.async {
            // Create a predicate to fetch containers matching the given identifier.
            let predicate = CNContainer.predicateForContainers(withIdentifiers: [identifier])
            
            do {
                let temp = try self.store.containers(matching: predicate)
                // We use the first item returned by the above query.
                result = (temp.count > 0) ? temp.first : nil
                
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    /// - returns: Fetches all available groups.
    func fetchGroups(_ completion: @escaping (_ groups: [CNGroup]) -> Void) {
        var result = [CNGroup]()
        
         contactStoreQueue.async {
            do {
                // Predicate to fetch all groups.
                result = try self.store.groups(matching: nil)
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    /// - returns: Existing groups matching the specified array of identifiers.
    fileprivate func fetchGroups(with identifiers: [String], completion: @escaping (_ groups: [CNGroup]) -> Void) {
        var result = [CNGroup]()
        
        contactStoreQueue.async {
            // Create predicate to get the existing groups matching the identifiers.
            let predicate = CNGroup.predicateForGroups(withIdentifiers: identifiers)
			
            do {
                result = try self.store.groups(matching: predicate)
                
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    
    // MARK: - Saving
    
    /**
        Use MGCContactStoreUtilities to create a new instance of CNMutableContact 
	    out of the given contact. Call save(_:toContainerWithIdentifier:) to save the resulting contact
	    into the default container.
	*/
    func add(_ contact: MGCContact) {
        let newContact = contactStoreUtility.create(contact)
		
        // Save new contact to the default container.
        save(newContact)
    }

    /// Add one or more contacts to the container specified by identifier.
    fileprivate func save(_ contact: CNMutableContact, toContainerWithIdentifier identifier: String? = nil) {
        let request = CNSaveRequest()
        request.add(contact, toContainerWithIdentifier: identifier)
        
        contactStoreQueue.async(flags: .barrier, execute: {
            do {
                try self.store.execute(request)
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
        }) 
    }
    
    /// Add one or more contacts to a group.
    func save(_ contacts: [CNContact], to group: CNGroup) {
        let request = CNSaveRequest()

        for contact in contacts {
            request.addMember(contact, to: group)
        }
		
        contactStoreQueue.async(flags: .barrier, execute: {
            do {
                try self.store.execute(request)
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
        }) 
    }
    
   /// Create and save a group to the container specified by identifier.
    func save(_ group: String, toContainerWithIdentifier identifier: String) {
        // Create a new instance of CNMutableGroup.
        let newGroup = CNMutableGroup()
        newGroup.name = group
        
        let request = CNSaveRequest()
        request.add(newGroup, toContainerWithIdentifier: identifier)
        
        contactStoreQueue.async(flags: .barrier, execute: {
            do {
                try self.store.execute(request)
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
        }) 
    }

    
    // MARK: - Updating
    
    /// Attempt to update a contact with the provided information.
    func update(_ contact: CNContact, with data: MGCContact, completion: @escaping (_ contact: CNContact?) -> Void) {
         /* The save request operation will fail with an 
		    CNErrorCodeRecordDoesNotExist error if the contact does not exist. 
		    So be sure to check that it exists before trying to update it.
		*/
        fetchContacts(with: [contact.identifier], completion: ({(contacts: [CNContact]) in
            if contacts.count > 0 {
				
                /* Get the updated contact which is of type CNMutableCNContact.
				   update(_:with:completion:) takes a CNMutableCNContact rather
				   than a CNContact as a parameter.
		        */
                let newContact = self.contactStoreUtility.update(contact.mutableCopy() as! CNMutableContact, with: data)
                
                let request = CNSaveRequest()
                request.update(newContact)
                
                self.contactStoreQueue.async(flags: .barrier, execute: {
                    do {
                        try self.store.execute(request)
                        completion(newContact)
                    } catch let error as NSError {
                        completion(nil)
                        print("Error \(error.localizedDescription)")
                    }
                }) 
            }
        }))
    }

    /// Attempt to update a group with the provided name.
    func update(_ group: CNGroup, with name: String, completion: @escaping (_ group: CNGroup?) -> Void) {
        /* The save request operation will fail with an
		   CNErrorCodeRecordDoesNotExist error if the group does not already exist.
           So be sure to check that it exists before trying to update it.
		*/
        fetchGroups(with: [group.identifier], completion: ({(groups: [CNGroup]) in
            if groups.count > 0 {
				
                /* update(_:with:completion:) takes CNMutableGroup rather than
				   CNGroup as a parameter. So let's convert group.
				*/
                let newGroup = group.mutableCopy() as! CNMutableGroup
                newGroup.name = name
                
                let request = CNSaveRequest()
                request.update(newGroup)
                
                self.contactStoreQueue.async(flags: .barrier, execute: {
                    do {
                        try self.store.execute(request)
                        completion(newGroup)
                    } catch let error as NSError {
                        completion(nil)
                        print("Error \(error.localizedDescription)")
                    }
                }) 
            }
        }))
    }
    
    
    // MARK: - Lifetime
    
    deinit {
        unregisterForCNContactStoreDidChangeNotification()
    }
}
