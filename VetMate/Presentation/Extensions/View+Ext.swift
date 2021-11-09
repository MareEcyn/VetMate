import SwiftUI

extension View {
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture { hideKeyboard() }
    }
}
