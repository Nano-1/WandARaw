import SwiftUI

protocol AnimateBrushColorDelegate {
    func didSelectColor(_ color: Color)
}

struct AnimateBrushColor: View {
    @Binding var selectedColor: Color
    @State private var isColorListVisible = false
//    var sceneView: ARSCNView
    var viewController : ViewController
    var contentView: ContentView
    var delegate: AnimateBrushColorDelegate?
    let colorOptions: [Color]
    
    init(selectedColor: Binding<Color>, contentViewInstance: ContentView, delegate: AnimateBrushColorDelegate? = nil, colorOptions: [Color] = [.blue,.green,.yellow,.red,.white,.black], viewController : ViewController) {
        _selectedColor = selectedColor
//        self.sceneView = sceneView
        self.contentView = contentViewInstance
        self.delegate = delegate
        self.colorOptions = colorOptions
        self.viewController = viewController
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
                    print("selected color \(selectedColor)")
                    viewController.selectedColor = self.selectedColor
                    contentView.selectedColor = self.selectedColor
                    
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
