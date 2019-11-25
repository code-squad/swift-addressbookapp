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
    
    private var store = CNContactStore()
    
    /// A private and local queue to `MGCContactStore`.
    private let contactStoreQueue = DispatchQueue(label: Bundle.main.bundleIdentifier!+".MGCContactStore", attributes: DispatchQueue.Attributes.concurrent)
    

    /// - returns: Fetches all available contacts sorted by family name.
    func fetchContacts(_ completion: @escaping (_ contacts: [CNContact]) -> Void) {
        var result = [CNContact]()
		
        // Keys required for the operation.
        let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor,
                                                          CNContactFamilyNameKey as CNKeyDescriptor,
                                                          CNContactEmailAddressesKey as CNKeyDescriptor,
                                                          CNContactPhoneNumbersKey as CNKeyDescriptor,
                                                          CNContactImageDataKey as CNKeyDescriptor,
                                                          CNContactThumbnailImageDataKey as CNKeyDescriptor,
                                                          CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
        
        // Sort the result by family name.
        request.sortOrder = .familyName
        
        contactStoreQueue.async {
            do {
                try self.store.enumerateContacts(with: request, usingBlock: { contact, status in
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
}
