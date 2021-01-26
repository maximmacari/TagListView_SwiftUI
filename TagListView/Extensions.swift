//
//  Extensions.swift
//  TagListView
//
//  Created by Maxim Macari on 26/1/21.
//

import SwiftUI

extension View {
    func dismissKeyboard(){
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive})
            .map({ $0 as? UIWindowScene})
            .first??.windows
            .filter({ $0.isKeyWindow}).first
        keyWindow?.endEditing(true)
    }
}
