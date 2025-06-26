
import SwiftUI

// 1. Define a custom button style
struct PrettyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// 2. Create a demo view to showcase the custom button style
struct CustomButtonStyleDemo: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Custom Button Style Demo")
                .font(.largeTitle)

            VStack(spacing: 20) {
                Text("Default Button Style")
                Button("Press Me") {
                    print("Default button pressed")
                }
                .buttonStyle(.borderedProminent)
            }

            VStack(spacing: 20) {
                Text("Custom 'PrettyButtonStyle'")
                Button("Press Me") {
                    print("Custom button pressed")
                }
                .buttonStyle(PrettyButtonStyle())
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Custom Button Style")
    }
}

// 3. Add a preview for easy development
struct CustomButtonStyleDemo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomButtonStyleDemo()
        }
    }
}
