//
import SwiftUI


struct NavButtons: View {
    @State private var selectedColor = Color.blue


    var body: some View {
        HStack {
            AnimateBrushColor(selectedColor: $selectedColor, colorOptions: [.red, .orange, .yellow, .green, .blue, .purple])
//
            Button(action: {
                print("Color = \(selectedColor)")
            }) {
                DrawButton()
            }
        }
    }
}

struct NavButtons_Previews: PreviewProvider {
    static var previews: some View {
        NavButtons()    }
}

#Preview {
    NavButtons()
}
