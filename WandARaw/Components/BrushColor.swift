import SwiftUI

struct BrushColor: View {
    var colorSet: Color = .black

    var body: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundColor(colorSet)
    }
}
