import SwiftUI
import UIKit

// Custom View for Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct OnboardingStep3View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedAvatar: Int? = nil
    @State private var customAvatar: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    let avatars = Array(1...9)
    
    var body: some View {
        VStack {
            if let customAvatar = customAvatar {
                Image(uiImage: customAvatar)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 30)
            } else if let avatarData = viewModel.userData.avatar, let uiImage = UIImage(data: avatarData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 30)
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 120, height: 120)
                    .overlay(
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                    )
                    .padding(.bottom, 30)
            }
            
            Header(title: "Choose your avatar")
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 5), spacing: 20) {
                ForEach(avatars, id: \.self) { avatar in
                    Button(action: {
                        selectedAvatar = avatar
                        customAvatar = nil 
                    }) {
                        if selectedAvatar == avatar {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                )
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 60, height: 60)
                        }
                    }
                }
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        )
                }
            }
            .padding(.bottom, 30)
            
            Spacer()
            
            OnboardingNavigation(
                backAction: {
                    viewModel.goToPreviousStep()
                },
                nextAction: {
                    if let customAvatar = customAvatar {
                        viewModel.setAvatar(image: customAvatar)
                    } else if let selectedAvatar = selectedAvatar {
                        // to be implemented
                    }
                    
                    viewModel.goToNextStep()
                }
            )
        }
        .padding()
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $customAvatar, isPresented: $isImagePickerPresented)
        }
    }
}

#Preview {
    OnboardingStep3View(viewModel: OnboardingViewModel())
}
 
