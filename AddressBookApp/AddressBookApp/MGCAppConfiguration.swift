/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Handles the application's configuration information.
*/

import Foundation

class MGCAppConfiguration {
    // MARK: - MGCAppConfiguration.ContactInfo
    
    struct ContactInfo {
        static let facebook = "Facebook"
        static let homepage = "homepage"
        static let defaultLabel = "Other"
    
        struct InstantMessages {
            static let aim = "AIM"
            static let gaduGadu = "Gadu Gadu"
            static let googleTalk = "Google Talk"
            static let icq = "ICQ"
            static let jabber = "Jabber"
            static let msn = "MSN"
            static let qq = "QQ"
            static let skype = "Skype"
            static let yahoo = "Yahoo"
        }
        
        struct SocialProfile {
            static let flickr = "Flickr"
            static let linkedIn = "LinkedIn"
            static let mySpace = "MySpace"
            static let sinaWeibo = "Sina Weibo"
            static let tencentWeibo = "Tencent Weibo"
            static let twitter = "Twitter"
            static let yelp = "Yelp"
            static let gameCenter = "Game Center"
        }
    }
    
    
    // MARK: - MGCAppConfiguration.Content
    
    struct Content {
        static let contacts = "Contacts"
        static let containers = "Containers"
        static let groups = "Groups"
        
        // Used when there are no contacts or groups.
        enum NoItems: String {
            case contacts = "No contacts"
            case groups = "No groups"
        }
    }

    
    // MARK: - MGCAppConfiguration.MainStoryboard
    
    struct MainStoryboard {
        struct Cells {
            static let local = "Local"
            static let namelessContact = "No Name"
            static let selectAllContatcs = "Select All Contacts"
            static let deselectAllContacts = "Deselect All Contacts"
            static let emptyString = ""
        }
        
        struct SegueIdentifiers {
            struct Contacts {
                static let addContact = "addContact"
                static let deleteContact = "deleteContact"
                static let fetchAllContacts = "fetchAllContacts"
                static let fetchContactsMatchingName = "fetchContactsMatchingName"
                static let performUpdateContact = "performUpdateContact"
                static let updateContact = "updateContact"
            }
            
            struct Containers {
                static let fetchAllContainers = "fetchAllContainers"
                static let fetchContactsPerContainer = "fetchContactsPerContainer"
                static let fetchDefaultContainer = "fetchDefaultContainer"
                static let fetchGroupsPerContainer = "fetchGroupsPerContainer"
                static let performFetchContactsPerContainer = "performFetchContactsPerContainer"
                static let performFetchGroupsPerContainer = "performFetchGroupsPerContainer"
            }
            
            struct Groups {
                static let addContactToGroup = "addContactToGroup"
                static let addGroup = "addGroup"
                static let deleteGroup = "deleteGroup"
                static let fetchContactsPerGroup = "fetchContactsPerGroup"
                static let fetchAllGroups = "fetchAllGroups"
                static let performAddContactToGroup = "performAddContactToGroup"
                static let performFetchContactsPerGroup = "performFetchContactsPerGroup"
                static let performRemoveContactFromGroup = "performRemoveContactFromGroup"
                static let performUpdateGroup = "performUpdateGroup"
                static let removeContactFromGroup = "removeContactFromGroup"
                static let updateGroup = "updateGroup"
            }
        }
        
        struct TableHeaderSection {
            struct Contacts {
                static let person = "PERSON"
                static let organization = "ORGANIZATION"
            }
            
            struct Containers {
                static let carddav = "CARDDAV"
                static let exchange = "EXCHANGE"
                static let local = "LOCAL"
                static let unassigned = "UNASSIGNED"
            }
            
            struct Groups {
                static let addGroup = "ADD GROUP"
                static let selectContainer = "SELECT CONTAINER"
                static let selectAllContacts = "SELECT ALL CONTACTS"
            }
        }
    }
    
    
    // MARK: - MGCAppConfiguration.Messages
    
    struct Messages {
        static let status = "Status"
        static let accessDenied = "Access was not granted to Contacts."
        static let ok = "OK"
        static let deleteAll = "Delete All"
        static let resourceNotFound = "Could not find resource file: "
    }
    
    
    // MARK: - MGCAppConfiguration.MGCNotifications
    
    struct MGCNotifications {
        static let accessGranted = "accessGranted"
        static let storeDidChange = "storeDidChange"
        static let refreshTab = "refreshTab"
    }
}
    
