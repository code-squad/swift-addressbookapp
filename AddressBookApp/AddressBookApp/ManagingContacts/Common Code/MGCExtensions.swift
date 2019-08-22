/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Creates extensions for the CNContact, CNContainer, CNSocialProfile,
    			and CNInstantMessageAddress classes.
*/

import UIKit
import Contacts

// MARK: - CNContact

extension CNContact {
    /// - returns: The formatted name of a contact if there is one and "No Name", otherwise.
    var formattedName: String {
        let formatter = CNContactFormatter()
		
        if let name = formatter.string(from: self) {
            return name
        }
        return MGCAppConfiguration.MainStoryboard.Cells.namelessContact
    }
    
    /// Determines whether a contact is a person or organization.
    var isPerson: Bool {
        return (self.contactType == .person)
    }
}


// MARK: - CNContainer

extension CNContainer {
     /// - returns: The name matching a given container type.
    var nameMatchingContainerType: String {
        switch self.type {
            case .local: return MGCAppConfiguration.MainStoryboard.TableHeaderSection.Containers.local
            case .cardDAV: return MGCAppConfiguration.MainStoryboard.TableHeaderSection.Containers.carddav
            case .exchange: return MGCAppConfiguration.MainStoryboard.TableHeaderSection.Containers.exchange
            case .unassigned: return MGCAppConfiguration.MainStoryboard.TableHeaderSection.Containers.unassigned
        }
    }
}


// MARK: - CNSocialProfile

extension CNSocialProfile {
	
    /// - returns: The CNSocialProfile value matching a label.
    class func socialProfileServiceMatching(_ label: String) -> String? {
        if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.facebook) == .orderedSame {
            return CNSocialProfileServiceFacebook
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.SocialProfile.flickr) == .orderedSame {
            return CNSocialProfileServiceMySpace
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.SocialProfile.mySpace) == .orderedSame {
            return CNSocialProfileServiceMySpace
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.SocialProfile.sinaWeibo) == .orderedSame {
            return CNSocialProfileServiceSinaWeibo
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.SocialProfile.twitter) == .orderedSame {
            return CNSocialProfileServiceTwitter
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.SocialProfile.yelp) == .orderedSame {
            return CNSocialProfileServiceYelp
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.SocialProfile.gameCenter) == .orderedSame {
            return CNSocialProfileServiceGameCenter
        }
        return nil
    }
}


// MARK: - CNInstantMessageAddress

extension CNInstantMessageAddress {
	
    /// - returns: The CNInstantMessageAddress value matching a label.
    class func instantMessageServiceMatching(_ label: String) -> String? {
        if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.facebook) == .orderedSame {
            return CNSocialProfileServiceFacebook
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.InstantMessages.aim) == .orderedSame {
            return CNInstantMessageServiceAIM
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.InstantMessages.gaduGadu) == .orderedSame {
            return CNInstantMessageServiceGaduGadu
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.InstantMessages.googleTalk) == .orderedSame {
            return CNInstantMessageServiceGoogleTalk
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.InstantMessages.icq) == .orderedSame {
           return CNInstantMessageServiceICQ
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.InstantMessages.jabber) == .orderedSame {
            return CNInstantMessageServiceJabber
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.InstantMessages.msn) == .orderedSame {
            return CNInstantMessageServiceMSN
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.InstantMessages.qq) == .orderedSame {
            return CNInstantMessageServiceQQ
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.InstantMessages.skype) == .orderedSame {
            return CNInstantMessageServiceSkype
        }
        else if label.localizedCaseInsensitiveCompare(MGCAppConfiguration.ContactInfo.InstantMessages.yahoo) == .orderedSame {
            return CNInstantMessageServiceYahoo
        }
        return nil
    }
}
