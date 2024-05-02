import SwiftUI

protocol AnimateBrushColorDelegate {
    func didSelectColor(_ color: Color)
}

struct AnimateBrushColor: View {
    @Binding var selectedColor: Color
    
    
    @State private var isPortalVisible = false
    @Binding var colorFormationArr: [Color]
    @Binding var count: Int
    
    //    var sceneView: ARSCNView
    var viewController : ViewController
    var contentView: ContentView
    var delegate: AnimateBrushColorDelegate?
    let colorOptions: [Color]
    let secretCode: [Color] = [.red, .yellow, .blue, .red, .yellow, .blue, .red, .yellow, .blue]
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
<<<<<<< Updated upstream
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
                            if colorFormationArr.count == 9 && colorFormationArr.count>0{
                                checkColor()
                            }
                            
                    }) {
                            Circle()
                               .fill(color)
                               .frame(width: 36, height: 36)
                        }
                        .buttonStyle(.borderless) // Ensure consistent button style
=======
        VStack(alignment: .trailing) {
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
>>>>>>> Stashed changes
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
    }
    func checkColor(){
//        print("masuk func")
        haptics.prepare()
        for (a, element) in colorFormationArr.enumerated() {
<<<<<<< Updated upstream
                if element == secretCode[a] {
//                    print("!", terminator: "")
                    count += 1
//                    print("count sekarang \(count)")
                    if count == 9 {
                        isPortalVisible.toggle()
                        colorFormationArr = []
                        count = 0
//                        print("masuk 9")
                        haptics.impactOccurred()
                        if isPortalVisible == true{
//                            print("Portal kebuka")
                            withAnimation(.easeInOut){
                                //                        impactFeedbackGenerator.impactOccurred()
                                // OPEN PORTAL HERE----------------------------------
                            }
                        }else if isPortalVisible == false {
//                            print("Porta ketutup")
                        }
                    }
                }else if element != secretCode[a] {
                    //                    print("X", terminator: "")
                                        count = 0
                                        break
=======
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
>>>>>>> Stashed changes
            }
        }
    }
    
    //    @ViewBuilder
    //    var colorListView: some View {
    //
    //    }
    
}
