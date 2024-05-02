import SwiftUI

protocol AnimateBrushColorDelegate {
    func didSelectColor(_ color: Color)
}

struct AnimateBrushColor: View {
    @Binding var selectedColor: Color
    
    @State private var isColorListVisible = false
    @State private var isPortalVisible = false
    @Binding var colorFormationArr: [Color]
    @Binding var count: Int

//    var sceneView: ARSCNView
    var viewController : ViewController
    var contentView: ContentView
    var delegate: AnimateBrushColorDelegate?
    let colorOptions: [Color]
    let secretCode: [Color] = [.red, .yellow, .blue]
    let haptics = UIImpactFeedbackGenerator(style: .heavy)
    
    
    
    
    
    init(selectedColor: Binding<Color>, contentViewInstance: ContentView, delegate: AnimateBrushColorDelegate? = nil, colorOptions: [Color] = [.blue,.green,.yellow,.red,.white,.black], viewController : ViewController, colorFormationArr: Binding<[Color]>, count : Binding<Int>) {
        _selectedColor = selectedColor
//        self.sceneView = sceneView
        self.contentView = contentViewInstance
        self.delegate = delegate
        self.colorOptions = colorOptions
        self.viewController = viewController
        _colorFormationArr = colorFormationArr
        _count = count
    }
    var body: some View {
        VStack{
            if isColorListVisible {
                VStack {
                    ForEach(colorOptions, id: \.self) { color in
                        Button(action: {
                            self.selectedColor = color
                            self.delegate?.didSelectColor(color)
//                            print("selected color \(selectedColor)")
                            viewController.selectedColor = self.selectedColor
                            contentView.selectedColor = self.selectedColor
                            self.colorFormationArr.append(color)
                            if colorFormationArr.count == 4 && colorFormationArr.count>0{
                                checkColor()
                            }
                            
                    }) {
                            Circle()
                               .fill(color)
                               .frame(width: 36, height: 36)
                        }
                        .buttonStyle(.borderless) // Ensure consistent button style
                    }
                }
               .cornerRadius(10)
               .shadow(radius: 5)
               .offset(x:100)
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
    func checkColor(){
        haptics.prepare()
        for (a, element) in colorFormationArr.enumerated() {
                if element == secretCode[a] {
//                    print("!", terminator: "")
                    count += 1
//                    print("count sekarang \(count)")
                    if count == 4 {
                        isPortalVisible.toggle()
                        withAnimation(.easeInOut){
                            if isPortalVisible{
                                
                                print("KEBUKA CUY \(count)")
                                colorFormationArr = []
                                count = 0
                                haptics.impactOccurred()
                                //                        impactFeedbackGenerator.impactOccurred()
                                // OPEN PORTAL HERE----------------------------------
                            }
                    }
                } else if element != secretCode[a] {
//                    print("X", terminator: "")
                    count = 0
                    break
                }
        }
        }
    }
    
//    @ViewBuilder
//    var colorListView: some View {
//        
//    }

}
