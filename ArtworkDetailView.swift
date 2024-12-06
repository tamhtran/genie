import SwiftUI

struct ArtworkDetailView: View {
    let artwork: ArtworkItem
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                AsyncImage(url: artwork.imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .foregroundColor(.white)
                            .onAppear {
                                print("DEBUG: Loading image from URL: \(artwork.imageUrl)")
                            }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onAppear {
                                print("DEBUG: Successfully loaded image")
                            }
                    case .failure(let error):
                        VStack {
                            Image(systemName: "photo")
                                .font(.system(size: 40))
                            Text("Failed to load image")
                            Text(error.localizedDescription)
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .onAppear {
                            print("DEBUG: Failed to load image: \(error.localizedDescription)")
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            print("DEBUG: Detail view appeared for image: \(artwork.title)")
        }
    }
}

#Preview {
    ArtworkDetailView(
        artwork: ArtworkItem(
            imageUrl: URL(string: "https://images.unsplash.com/photo-1454496522488-7a8e488e8606?auto=format&fit=crop&w=1000&q=80")!,
            title: "Sample Image"
        ),
        isPresented: .constant(true)
    )
} 
