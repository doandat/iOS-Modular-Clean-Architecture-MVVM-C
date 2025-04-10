import SwiftUI

/// Loading Indicator View
struct TxLoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .scaleEffect(1.5)
            .padding(30)
            .background(Color.black.opacity(0.7))
            .cornerRadius(15)
    }
}

/// Loading Overlay with Background
struct TxLoadingOverlay<Content: View>: View {
    @Binding var isShowing: Bool
    let content: Content

    init(isShowing: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isShowing = isShowing
        self.content = content()
    }

    var body: some View {
        ZStack {
            content
                .disabled(isShowing)
                .blur(radius: isShowing ? 2 : 0)

            if isShowing {
                GeometryReader { geometry in
                    TxLoadingView()
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .transition(.scale)
                        .animation(.easeInOut, value: isShowing)
                }
            }
        }
    }
}

// MARK: - View Modifier
public extension View {
    func activityIndicator(isShowing: Binding<Bool>) -> some View {
        TxLoadingOverlay(isShowing: isShowing) {
            self
        }
    }
}
