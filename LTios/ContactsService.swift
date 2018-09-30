//
//  Contacts.swift
//  LT_Contacts_Manager
//
//  Created by Paul Bénéteau on 28/07/2018.
//  Copyright © 2018 Paul Bénéteau. All rights reserved.
//

import Foundation
import Contacts
import PhoneNumberKit
import CryptoSwift


class ContactsService {
    
    public static var shared = ContactsService()
    var contactStore = CNContactStore()
    
    
    func loadContacts(completion: @escaping ([CNContact]?) -> Void) {
        
        requestAccess() { _ in
            
            var phoneContacts = [CNContact]()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey] as [Any]
            let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
            
            do {
                try self.contactStore.enumerateContacts(with: request) { (contact, stop) in
                    if !contact.phoneNumbers.isEmpty {
                        phoneContacts.append(contact)
                    }
                }
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
            completion(phoneContacts)
        }
    }
    
    func updateContacts() {
        
        var serializedContacts = [String:String]()
        
        loadContacts { contacts in
            guard let contacts = contacts else { return }
            
            for contact in contacts {
                let formatedPhoneNumber = self.formatPhoneNumber(phoneNumber: contact.phoneNumbers.first?.value)
                
                if formatedPhoneNumber != nil {
                    let hash = formatedPhoneNumber?.sha256()
                    serializedContacts[hash!] = "\(contact.givenName) \(contact.familyName)"
                }
            }
            
            mainUserInstance.contacts = serializedContacts
            DatabaseService.shared.uploadUserContactsToDatabase(contacts: serializedContacts)
        }
    }
    
    func formatPhoneNumber(phoneNumber: CNPhoneNumber?) -> String? {
        
        guard let phoneNumber = phoneNumber else { return nil }
        
        let phoneNumberKit = PhoneNumberKit()
        do {
            let parsedPhoneNumber = try phoneNumberKit.parse(phoneNumber.stringValue)
            return phoneNumberKit.format(parsedPhoneNumber, toType: .international)
        }
        catch {
            print("[Error] Generic parser for phone number: \(phoneNumber.stringValue)")
            return nil
        }
        
    }
    
    func requestAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completionHandler(true)
        case .denied: break
        case .restricted, .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    completionHandler(true)
                } else {
                    DispatchQueue.main.async {
                    }
                }
            }
        }
    }

    func getCommonFriends(userContacts: [String:String]) -> [String:String]? {
        
        guard let contacts = mainUserInstance.contacts else { print("[Error] Main user contacts not initialized"); return nil }
        
        let commonElements: Array = Set(contacts.keys).filter(Set(userContacts.keys).contains)
        var commonFriends = [String:String]()
        
        for element in commonElements {
            commonFriends[element] = contacts[element]
        }
        return commonFriends
    }
    
    func isAlreadyInContactList(phoneNumber: String) -> Bool {

        if mainUserInstance.contacts.keys.contains(phoneNumber.sha256()) {
            return true
        } else {
            return false
        }
    }
    
    
}
