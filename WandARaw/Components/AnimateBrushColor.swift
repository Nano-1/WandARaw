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
        VStack{
            if isColorListVisible {
                colorListView
            }
            BrushColor(colorSet: selectedColor)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isColorListVisible.toggle()
                        
                    }
                }
                .padding()
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
                .buttonStyle(.borderless) // Ensure consistent button style
            }
        }
       .cornerRadius(10)
       .shadow(radius: 5)
       .offset(x:100)
    }
    
//    let colorOptions: [Color] = [.blue,.green,.yellow,.red,.white,.black]
}
