import SwiftUI

/// Displays a full-screen view of a selected artwork
/// Supports both local and remote images with loading states
struct ArtworkDetailView: View {
    let artwork: ArtworkItem
    /// Binding to control the presentation state
    @Binding var isPresented: Bool
    @State private var isImageLoaded = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Dark background for better image viewing
                Color.black.ignoresSafeArea()
                
                // Handle different image sources
                switch artwork.source {
                case .local(let name):
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onAppear { isImageLoaded = true }
                case .remote(let url):
                    CachedAsyncImage(url: url)
                        .aspectRatio(contentMode: .fit)
                        .opacity(isImageLoaded ? 1 : 0)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.3)) {
                                isImageLoaded = true
                            }
                        }
                }
            }
            .navigationTitle(artwork.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Close") {
                    isPresented = false
                }
            }
            .preferredColorScheme(.dark)
        }
        .onDisappear {
            isImageLoaded = false
        }
    }
}

#Preview {
    ArtworkDetailView(
        artwork: ArtworkItem(
            id: "preview-1",
            source: .remote(url: URL(string: "https://images.unsplash.com/photo-1454496522488-7a8e488e8606?auto=format&fit=crop&w=1000&q=80")!),
            title: "Sample Image"
        ),
        isPresented: .constant(true)
    )
} 