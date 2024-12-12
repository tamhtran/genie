import SwiftUI

/// A wrapper around AsyncImage that provides caching functionality
struct CachedAsyncImage: View {
    let url: URL
    
    @State private var image: UIImage?
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .transition(.opacity)
            } else {
                ProgressView()
                    .scaleEffect(1.5)
            }
        }
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        // First check cache
        if let cachedImage = ImageCache.shared.get(url) {
            withAnimation {
                image = cachedImage
                isLoading = false
            }
            return
        }
        
        // If not in cache, load from network
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let downloadedImage = UIImage(data: data) {
                ImageCache.shared.insert(downloadedImage, for: url)
                withAnimation {
                    image = downloadedImage
                    isLoading = false
                }
            }
        } catch {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
} 