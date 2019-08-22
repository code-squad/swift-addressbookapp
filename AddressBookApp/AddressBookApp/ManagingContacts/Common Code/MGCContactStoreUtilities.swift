/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A utility class used to filter contacts and containers. It creates a
    			new mutable contact with the following properties: contactType, 
                familyName, givenName, organizationName, urlAddresses,
    			socialProfiles, instantMessageAddresses, and dates.
                It shows how to use CNContact's isKeyAvailable. It also shows how 
    			to retrieve and update the following properties of a contact:
                familyName, givenName,organizationName, emailAddresses, phoneNumbers,
    			and postalAddresses.
                It uses the thumbnailImageData and imageData properties to fetch a 
    			contact profile picture's thumbnail and update its profile picture, 
    			respectively.
*/

import UIKit
import Contacts

class MGCContactStoreUtilities {
    // MARK: - Initialization
	
    init() {
    }
    
    
    // MARK: - Create Mutable Contact
    
    /**
        - returns: Create and return a mutable contact with the following 
				   properties if available: contact type, given name, family name, 
				   organization, url, social profile, instant message, and anniversary.
    */
    func create(_ contact: MGCContact) -> CNMutableContact {
        let newContact = CNMutableContact()
        
        // Set contactType to Person if contact is a person and to Organization, otherwise.
        newContact.contactType = (contact.isPerson) ? .person : .organization
        
        newContact.familyName = contact.lastName
        newContact.givenName = contact.firstName
        newContact.organizationName = contact.organization
		
		if let profilePicture = contact.profilePicture, let imageData = profilePicture.imageData {
			newContact.imageData = imageData as Data
		}
		
        if let url = contact.url, !(url.value.isEmpty) {
			
            /* If the user did not enter a label for the url, set it to the 
			   default one, which is homepage.
			*/
            let label = (url.label.isEmpty) ? MGCAppConfiguration.ContactInfo.homepage : url.label
            newContact.urlAddresses = [CNLabeledValue(label: label, value: NSString(string: url.value))]
        }
        
        if let socialProfile = contact.socialProfile, socialProfile.hasLabelValue() {
			
            // Fetch the social profile service associated with the user's input.
            let service = CNSocialProfile.socialProfileServiceMatching(socialProfile.label)
            
            // If the service exists, set the socialProfiles property.
            if let service = service {
                newContact.socialProfiles = [CNLabeledValue(label: socialProfile.label, value: CNSocialProfile(urlString: nil,
                                                                                                                username: socialProfile.value,
                                                                                                          userIdentifier: nil,
                                                                                                                 service: service))]
            }
        }
        
        if let instantMessage = contact.instantMessage, instantMessage.hasLabelValue() {
			
            // Fetch the instant message service with the user's input.
            let service = CNInstantMessageAddress.instantMessageServiceMatching(instantMessage.label)
            
            // If the service exists, set the instantMessageAddresses property.
            if let service = service {
                newContact.instantMessageAddresses = [CNLabeledValue(label: instantMessage.label, value: CNInstantMessageAddress(username: instantMessage.value, service: service))]
            }
        }
        
        
        if let anniversary = contact.anniversary {
			
            let anniversaryDate = CNLabeledValue(label: CNLabelDateAnniversary, value: anniversary)
            newContact.dates = [anniversaryDate]
        }
        return newContact
    }
    
    
    // MARK: - Parsing Contact
    
    /**
		- returns: A mutable postal address object with the street, city, state,
				   postal code, and country properties.
	*/
    fileprivate func convert(_ address: MGCPostalAddress) -> CNPostalAddress {
        let newAddress = CNMutablePostalAddress()
        newAddress.street = address.street
        newAddress.city = address.city
        newAddress.state = address.state
        newAddress.postalCode = address.postalCode
        newAddress.country = address.country
        return newAddress as CNPostalAddress
    }

    /// - returns: Label and value of the first postal address found in contact.
    fileprivate func postalAddress(from contact: CNContact) -> MGCLabelValue? {
        if !contact.postalAddresses.isEmpty {
            
			// Only use the first address found.
            let addresses = contact.postalAddresses.first!
            let address = addresses.value 
            
            let label = (addresses.label == nil) ? MGCAppConfiguration.ContactInfo.defaultLabel : CNLabeledValue<CNPostalAddress>.localizedString(forLabel: addresses.label!)
            let value = MGCPostalAddress(street: address.street, city: address.city, state: address.state, postalCode: address.postalCode, country: address.country)
            return MGCLabelValue(label: label, address: value)
        }
        return nil
    }

    /// - returns: Label and value of the first email address found in contact.
    fileprivate func emailLabelValue(from contact: CNContact) -> MGCLabelValue? {
        if !contact.emailAddresses.isEmpty {
            
			// Only use the first email address.
            let email = contact.emailAddresses.first!
            
            let label = (email.label == nil) ? MGCAppConfiguration.ContactInfo.defaultLabel : CNLabeledValue<NSString>.localizedString(forLabel: email.label!)
            let value = email.value as String
            return MGCLabelValue(label: label, value: value)
        }
        return nil
    }
    
    
    
    /// - returns: Label and value of the first phone number found in contact.
    fileprivate func phoneNumberLabelValue(from contact: CNContact) -> MGCLabelValue? {
        if !contact.phoneNumbers.isEmpty {
            
			// Only use the first phone number found.
            let phoneNumber = contact.phoneNumbers.first!
            
            /* Fetch the label associated with the phone number. The property
               label can be nil, let's check it before using it.
            */
            let label = (phoneNumber.label == nil) ? MGCAppConfiguration.ContactInfo.defaultLabel : CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: phoneNumber.label!)
            // Get the phone number's value.
            let value = (phoneNumber.value ).stringValue
            return MGCLabelValue(label: label, value: value)
        }
        return nil
    }
    
    /// - returns: A model object representing a CNContact object.
    func parse(_ contact: CNContact) -> MGCContact {
        let result = MGCContact()
        
        /* We first check whether a property value was fetched before using it. 
		   Accessing a unfetched property will throw 
		   CNContactPropertyNotFetchedExceptionName.
		*/
        if contact.isKeyAvailable(CNContactThumbnailImageDataKey) {
			
            if let imageData = contact.thumbnailImageData {
                result.profilePicture = MGCLabelValue(imageData: imageData)
            }
        }
        
        if contact.isKeyAvailable(CNContactGivenNameKey) {
			
            if !contact.givenName.isEmpty {
                result.firstName = contact.givenName
            }
        }
        
        if contact.isKeyAvailable(CNContactFamilyNameKey) {
			
            if !contact.familyName.isEmpty {
                result.lastName = contact.familyName
            }
        }
        
        if contact.isKeyAvailable(CNContactOrganizationNameKey) {
			
            if !contact.organizationName.isEmpty {
                result.organization = contact.organizationName
            }
        }
        
        if contact.isKeyAvailable(CNContactPhoneNumbersKey) {
			
            /* If the user did not provide a label for the phone number, use the 
			   default label, which is "Other."
			*/
            if let number = phoneNumberLabelValue(from: contact) {
                result.phoneNumber = number
            }
            else {
                result.phoneNumber = MGCLabelValue(label: MGCAppConfiguration.ContactInfo.defaultLabel)
            }
        }
        
        if contact.isKeyAvailable(CNContactEmailAddressesKey) {
			
            /* If the user did not provide a label for the email, use the 
			   default label, which is "Other." 
			*/
            if let email = emailLabelValue(from: contact) {
                result.email = email
            }
            else {
                result.email = MGCLabelValue(label: MGCAppConfiguration.ContactInfo.defaultLabel)
            }
        }
        
        if contact.isKeyAvailable(CNContactPostalAddressesKey) {
			
            if let address = postalAddress(from: contact) {
                result.postalAddress = address
            }
        }
        return result
    }
    
    
    // MARK: - Filtering Content
    
    /// - returns: An array of contacts filtered according to a specified contact type.
    func filter(_ contacts: [CNContact], for type: CNContactType) -> [CNContact] {
        return contacts.filter({(contact: CNContact) in contact.contactType == type})
    }
    
    /// - returns: An array of containers filtered according to a specified container type.
    func filter(_ containers: [CNContainer], for type: CNContainerType) -> [CNContainer] {
        return containers.filter({(container: CNContainer) in container.type == type})
    }
    
    
    // MARK: - Update Contact
    
    /// - returns: Update and return an existing contact.
    func update(_ contact: CNMutableContact, with data: MGCContact) -> CNMutableContact {
        contact.givenName = data.firstName
        contact.familyName = data.lastName
        contact.organizationName = data.organization
        
        if let profilePicture = data.profilePicture, let imageData = profilePicture.imageData {
            contact.imageData = imageData as Data
        }
            
        /* First check whether the user's provided label already exists among 
		   the current labeled email addresses.
           If the label already exists, update its associated value. 
		   If it does not, create and add a new CNLabeledValue object, then add
		   it to emailAddresses. We repeat the same steps for phone numbers and 
		   postal addresses.
		*/
        if let email = data.email {
			
            let labels = contact.emailAddresses.map({(item: CNLabeledValue<NSString>) -> String in
                /* If the label property does not exist, return the default 
                   label and its localized string otherwise.
                */
                return (item.label == nil) ? MGCAppConfiguration.ContactInfo.defaultLabel : CNLabeledValue<NSString>.localizedString(forLabel: item.label!)})

            if labels.contains(email.label) {
				/* If the label exists, then it is associated with the first 
				   item in the array. We only show the first item in the 
				   labeledValue object to the user.
				*/
                contact.emailAddresses[0] = CNLabeledValue(label: email.label, value: NSString(string: email.value))
            }
            else {
                contact.emailAddresses.append(CNLabeledValue(label: MGCAppConfiguration.ContactInfo.defaultLabel, value: NSString(string: email.value)))
            }
        }
        
        if let phoneNumber = data.phoneNumber {
			
            let labels = contact.phoneNumbers.map({(item: CNLabeledValue<CNPhoneNumber>) -> String in
                return (item.label == nil) ? MGCAppConfiguration.ContactInfo.defaultLabel : CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: item.label!)})
            
            if labels.contains(phoneNumber.label) {
                contact.phoneNumbers[0] = CNLabeledValue(label: phoneNumber.label, value: CNPhoneNumber(stringValue: phoneNumber.value))
            }
            else {
                contact.phoneNumbers.append(CNLabeledValue(label: MGCAppConfiguration.ContactInfo.defaultLabel, value: CNPhoneNumber(stringValue: phoneNumber.value)))
            }
        }
        
        if let postalAddress = data.postalAddress, let address = postalAddress.address {
			
            let labels = contact.postalAddresses.map({(item: CNLabeledValue<CNPostalAddress>) -> String in
                return (item.label == nil) ? MGCAppConfiguration.ContactInfo.defaultLabel : CNLabeledValue<CNPostalAddress>.localizedString(forLabel: item.label!)})
            
            if labels.contains(postalAddress.label) {
                contact.postalAddresses[0] = CNLabeledValue(label: postalAddress.label, value: convert(address))
            }
            else {
                contact.postalAddresses.append(CNLabeledValue(label: MGCAppConfiguration.ContactInfo.defaultLabel, value: convert(address)))
            }
        }
        return contact
    }
 }
