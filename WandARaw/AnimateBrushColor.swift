import SwiftUI

protocol AnimateBrushColorDelegate {
    func didSelectColor(_ color: Color)
}

struct AnimateBrushColor: View {
    @Binding var selectedColor: Color
    @State private var isColorListVisible = false
    var viewController = ViewController()
    
    var delegate: AnimateBrushColorDelegate?
    let colorOptions: [Color]
    
    init(selectedColor: Binding<Color>, delegate: AnimateBrushColorDelegate? = nil, colorOptions: [Color] = [.blue, .green, .yellow, .red, .white, .black]) {
        _selectedColor = selectedColor
        self.delegate = delegate
        self.colorOptions = colorOptions
    }
    
    var body: some View {
        VStack {
            BrushColor(colorSet: selectedColor)
               .onTapGesture {
                    withAnimation {
                        isColorListVisible.toggle()
                    }
                }
               .padding()
            
            if isColorListVisible {
                colorListView
                   .transition(.move(edge:.bottom))
            }
        }
    }
    
    @ViewBuilder
    var colorListView: some View {
        VStack {
            ForEach(colorOptions, id: \.self) { color in
                Button(action: {
                    self.selectedColor = color
                    self.delegate?.didSelectColor(color)
//                    print("selected color \(selectedColor)")
                    viewController.selectedColor = selectedColor
                }) {
                    Circle()
                       .fill(color)
                       .frame(width: 30, height: 30)
                }
               .buttonStyle(PlainButtonStyle()) // Ensure consistent button style
            }
        }
       .padding()
       .background(Color.white)
       .cornerRadius(10)
       .shadow(radius: 5)
       .padding(.horizontal)
    }
    
//    let colorOptions: [Color] = [.blue,.green,.yellow,.red,.white,.black]
}
