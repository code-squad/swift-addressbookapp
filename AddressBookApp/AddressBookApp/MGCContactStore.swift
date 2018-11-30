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
    
    /// - returns: The identifier of the default container.
    var defaultContainerID: String {
        get {
            return store.defaultContainerIdentifier()
        }
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
}
