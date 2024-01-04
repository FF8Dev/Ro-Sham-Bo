//
//  ContentView.swift
//  Roshambo
//
//  Created by F F 8 on 08/02/2022.
//

import SwiftUI
import AVKit

// MARK: - View Model
class RoshamboViewModel: ObservableObject {
    let roshamboSyllabes: [String] = ["Ro", "Sham", "Bo!"]
    
    @Published var gameResult = 0
    
    @Published var userInput = 0
    @Published var cpuInput = 0
    
    @Published var showFight = false
    @Published var roTextAnim = false
    @Published var shamTextAnim = false
    @Published var boTextAnim = false
    @Published var showResult = false
    @Published var showResultBg = false
    @Published var showReset = false
    @Published var letReset = false
    
    @Published var gameOver = false
}

// MARK: - Main View
struct ContentView: View {
    
    @StateObject var roshamboViewModel: RoshamboViewModel = RoshamboViewModel()
    @StateObject var gameLogic = GameLogic(userScore: 0, cpuScore: 0)
    
    var body: some View {
        ZStack {
            
            // background
            
            Rectangle()
                .foregroundColor(roshamboViewModel.showResultBg ? (roshamboViewModel.gameResult == 1 ? .green : ( roshamboViewModel.gameResult == 2 ? .red : Color(UIColor.systemBackground)))
                                    : Color(UIColor.systemBackground))
                .ignoresSafeArea()
                .onTapGesture {
                    if roshamboViewModel.gameOver {
                        gameLogic.resetScore()
                    }
                    if roshamboViewModel.letReset {
                        withAnimation {
                            roshamboViewModel.gameOver = false
                            roshamboViewModel.showFight = false
                            roshamboViewModel.roTextAnim = false
                            roshamboViewModel.shamTextAnim = false
                            roshamboViewModel.boTextAnim = false
                            roshamboViewModel.showResult = false
                            roshamboViewModel.showReset = false
                            roshamboViewModel.letReset = false
                        }
                    }
                    
                }
            
            // content
            
            VStack {
                Text("Roshambo against\n— the machine —")
                    .font(.title)
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                HStack {
                    Text("\(gameLogic.userScore)")
                        .frame(width: 50.0, height: 30.0)
                        .addBorder(Color.gray, width: 1, cornerRadius: 5)
                    Text("—")
                    Text("\(gameLogic.cpuScore)")
                        .frame(width: 50.0, height: 30.0)
                        .addBorder(Color.gray, width: 1, cornerRadius: 5)
                }
                Spacer()
            }
            
            // MARK: - Main UI
            VStack {
                
                // CPU Icon
                Spacer()
                Image("cpu")
                    .resizable()
                    .frame(width: roshamboViewModel.showResult ? 100 : 208.0, height: roshamboViewModel.showResult ? 100: 208.0)
                    .offset(y: roshamboViewModel.showFight ? 100 : 35)
                    .offset(x: roshamboViewModel.showResult ? 125 : 0, y: roshamboViewModel.showResult ? -190 : 0)
                    
                Spacer()
                
                // Action Buttons
                VStack {
                    ActionButton(action: .rock, roshamboViewModel: roshamboViewModel, showFight: $roshamboViewModel.showFight, roTextAnim: $roshamboViewModel.roTextAnim, shamTextAnim: $roshamboViewModel.shamTextAnim, boTextAnim: $roshamboViewModel.boTextAnim, gameLogic: gameLogic, gameResult: $roshamboViewModel.gameResult, showResult: $roshamboViewModel.showResult)
                    HStack {
                        Spacer()
                        ActionButton(action: .paper, roshamboViewModel: roshamboViewModel, showFight: $roshamboViewModel.showFight, roTextAnim: $roshamboViewModel.roTextAnim, shamTextAnim: $roshamboViewModel.shamTextAnim, boTextAnim: $roshamboViewModel.boTextAnim, gameLogic: gameLogic, gameResult: $roshamboViewModel.gameResult, showResult: $roshamboViewModel.showResult)
                        Spacer()
                        ActionButton(action: .scissors, roshamboViewModel: roshamboViewModel, showFight: $roshamboViewModel.showFight, roTextAnim: $roshamboViewModel.roTextAnim, shamTextAnim: $roshamboViewModel.shamTextAnim, boTextAnim: $roshamboViewModel.boTextAnim, gameLogic: gameLogic, gameResult: $roshamboViewModel.gameResult, showResult: $roshamboViewModel.showResult)
                        Spacer()
                    }
                }
                .padding(.bottom, 40.0)
                .opacity(roshamboViewModel.showFight ? 0 : 100)
                .offset(y: roshamboViewModel.showFight ? 380 : 0)
            }
            
            // MARK: - Play Roshambo Text View
            if !roshamboViewModel.showReset {
                if roshamboViewModel.roTextAnim {
                    Text(roshamboViewModel.roshamboSyllabes[0])
                        .font(.system(size: 280))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("RoshamboText"))
                        .transition(AnyTransition.scale.combined(with: .opacity))
                        .animation(Animation.spring().speed(1.88))
                }
                if roshamboViewModel.shamTextAnim {
                    Text(roshamboViewModel.roshamboSyllabes[1])
                        .font(.system(size: 120))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("RoshamboText"))
                        .transition(AnyTransition.scale.combined(with: .opacity))
                        .animation(Animation.spring().speed(1.88))
                }
                if roshamboViewModel.boTextAnim {
                    Text(roshamboViewModel.roshamboSyllabes[2])
                        .font(.system(size: 220))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("RoshamboText"))
                        .transition(AnyTransition.scale.combined(with: .opacity))
                        .animation(Animation.spring().speed(1.88))
                }
            }
            
            // MARK: - Show Result View
            if roshamboViewModel.showResult {
                
                VStack {
                    Spacer()
                    HStack {
                        switch roshamboViewModel.cpuInput {
                        case 1:
                            ActionIcon(action: .rock, showResult: $roshamboViewModel.showResult, roshamboViewModel: roshamboViewModel, gameLogic: gameLogic)
                        case 2:
                            ActionIcon(action: .paper, showResult: $roshamboViewModel.showResult, roshamboViewModel: roshamboViewModel, gameLogic: gameLogic)
                        case 3:
                            ActionIcon(action: .scissors, showResult: $roshamboViewModel.showResult, roshamboViewModel: roshamboViewModel, gameLogic: gameLogic)
                        default:
                            Text("ERROR")
                        }
                    }
                    .padding(.top, 80.0)
                    Spacer()
                    switch roshamboViewModel.gameResult {
                    case 0:
                        Text("DRAW")
                            .transition(AnyTransition.scale.combined(with: .opacity))
                            .animation(Animation.spring().speed(1.88))
                    case 1:
                        if roshamboViewModel.gameOver {
                            VStack {
                                Text("YOU")
                                Text("GAME OVER")
                                    .font(.title)
                                    .fontWeight(.black)
                                Text("WIN!")
                            }
                        } else {
                            Text("YOU WIN")
                                .transition(AnyTransition.scale.combined(with: .opacity))
                                .animation(Animation.spring().speed(1.88))
                        }
                    case 2:
                        if roshamboViewModel.gameOver {
                            VStack {
                                Text("YOU")
                                Text("GAME OVER")
                                    .font(.title)
                                    .fontWeight(.black)
                                Text("LOSE!")
                            }
                        } else {
                            Text("YOU LOSE")
                                .transition(AnyTransition.scale.combined(with: .opacity))
                                .animation(Animation.spring().speed(1.88))
                        }
                    default:
                        Text("ERROR")
                    }
                    Spacer()
                    HStack {
                        switch roshamboViewModel.userInput {
                        case 1:
                            ActionIcon(action: .rock, showResult: $roshamboViewModel.showResult, roshamboViewModel: roshamboViewModel, gameLogic: gameLogic)
                        case 2:
                            ActionIcon(action: .paper, showResult: $roshamboViewModel.showResult, roshamboViewModel: roshamboViewModel, gameLogic: gameLogic)
                        case 3:
                            ActionIcon(action: .scissors, showResult: $roshamboViewModel.showResult, roshamboViewModel: roshamboViewModel, gameLogic: gameLogic)
                        default:
                            Text("ERROR")
                        }
                    }
                    .padding(.bottom, 25.0)
                }
                .padding(.bottom, 40.0)
            }
        }
        // MARK: - Reset View Gesture
        .onTapGesture {
            if roshamboViewModel.letReset {
                withAnimation {
                    roshamboViewModel.showFight = false
                    roshamboViewModel.roTextAnim = false
                    roshamboViewModel.shamTextAnim = false
                    roshamboViewModel.boTextAnim = false
                    roshamboViewModel.showResult = false
                    roshamboViewModel.showReset = false
                    roshamboViewModel.letReset = false
                }
            }
        }
    }
}

// MARK: - Add Border
extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}

// MARK: - Sound Manager
class SoundManager {
    static let instance = SoundManager()
    
    enum SoundOption: String {
        case roshambo
        case rockWin
        case paperWin
        case scissorsWin
        case draw
    }
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

// MARK: - Action Button Struct
struct ActionButton: View {
    
    enum actionMovement {
        case rock
        case paper
        case scissors
    }
    
    @ObservedObject var roshamboViewModel: RoshamboViewModel
    @ObservedObject var gameLogic: GameLogic
    
    let userInput: Int
    let frameColor: Color
    let actionImage: Image
    
    @Binding var showFight: Bool
    @Binding var roTextAnim: Bool
    @Binding var shamTextAnim: Bool
    @Binding var boTextAnim: Bool
    @Binding var showResult: Bool
    
    @Binding var gameResult: Int
    
    var cpuInput: Int
    
    init(action: actionMovement, roshamboViewModel: RoshamboViewModel, showFight: Binding<Bool>,
         roTextAnim: Binding<Bool>, shamTextAnim: Binding<Bool>, boTextAnim: Binding<Bool>,
         gameLogic: GameLogic, gameResult: Binding<Int>, showResult: Binding<Bool>) {
        if action == .rock {
            self.userInput = 1
            self.frameColor = Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1))
            self.actionImage = Image("rock")
        } else if action == .paper {
            self.userInput = 2
            self.frameColor = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            self.actionImage = Image("paper")
        } else if action == .scissors {
            self.userInput = 3
            self.frameColor = Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
            self.actionImage = Image("scissors")
        } else {
            self.userInput = 1
            self.frameColor = Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1))
            self.actionImage = Image("rock")
        }
        self.roshamboViewModel = roshamboViewModel
        self._showFight = showFight
        self._roTextAnim = roTextAnim
        self._shamTextAnim = shamTextAnim
        self._boTextAnim = boTextAnim
        self.gameLogic = gameLogic
        self._gameResult = gameResult
        self._showResult = showResult
        
        self.cpuInput = Int.random(in: 1...3)
    }
    
    var timeAnimation = 0.77
    var maxScore = 3
    
    var body: some View {
        Button(action: {
            SoundManager.instance.playSound(sound: .roshambo)
            // Slide buttons and size CPU
            withAnimation(Animation.spring().speed(0.28)) {
                showFight.toggle()
            }
            
            // Ro Text Toggle
            roTextAnim.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + timeAnimation) {
                withAnimation(Animation.spring().speed(2.88)) {
                    roTextAnim.toggle()
                }
            }
            
            // Sham Text Toggle
            DispatchQueue.main.asyncAfter(deadline: .now() + timeAnimation + 0.2) {
                shamTextAnim.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + timeAnimation*2 + 0.2) {
                withAnimation(Animation.spring().speed(2.88)) {
                    shamTextAnim.toggle()
                }
            }
            
            // Bo! Text Toggle
            DispatchQueue.main.asyncAfter(deadline: .now() + timeAnimation*2 + 0.4) {
                boTextAnim.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + timeAnimation*3 + 0.4) {
                withAnimation(Animation.spring().speed(2.88)) {
                    boTextAnim.toggle()
                }
            }
            
            // MARK: - Show Result Toggle - after press
            DispatchQueue.main.asyncAfter(deadline: .now() + timeAnimation*3 + 0.8) {
                withAnimation(Animation.spring().speed(2.88)) {
                    roshamboViewModel.userInput = userInput
                    roshamboViewModel.cpuInput = cpuInput
                    gameResult = gameLogic.fightLogic(userInput: userInput, cpuInput: cpuInput)
                    roshamboViewModel.showResult.toggle()
                }
            }
            // MARK: - Show Reset Toggle - after press
            DispatchQueue.main.asyncAfter(deadline: .now() + timeAnimation*3 + 1.0) {
                withAnimation {
                    if gameLogic.cpuScore == maxScore || gameLogic.userScore == maxScore {
                        // Game Over
                        roshamboViewModel.gameOver.toggle()
                    }
                    roshamboViewModel.letReset.toggle()
                    roshamboViewModel.showResultBg.toggle()
                }
            }
            
            // MARK: - Background Color - after press
            if gameLogic.cpuScore == maxScore || gameLogic.userScore == maxScore {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.1) {
                    withAnimation {
                        roshamboViewModel.showResultBg.toggle()
                    }
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) {
                    withAnimation {
                        roshamboViewModel.showResultBg.toggle()
                    }
                }
            }
        }, label: {
            Capsule()
                .stroke(frameColor, lineWidth: 2.5)
                .frame(width: 109, height: 135)
                .overlay(actionImage)
                .shadow(radius: 10)
                
        })                                                                    // end of button
    }
}

// MARK: - Action Icon Struct
struct ActionIcon: View {
    
    enum actionMovement {
        case rock
        case paper
        case scissors
    }
    
    @ObservedObject var roshamboViewModel: RoshamboViewModel
    @ObservedObject var gameLogic: GameLogic
    
    let actionInput: Int
    let frameColor: Color
    let actionImage: Image
    
    @Binding var showResult: Bool
    
    init(action: actionMovement, showResult: Binding<Bool>, roshamboViewModel: RoshamboViewModel, gameLogic: GameLogic) {
        if action == .rock {
            self.actionInput = 1
            self.frameColor = Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1))
            self.actionImage = Image("rock")
        } else if action == .paper {
            self.actionInput = 2
            self.frameColor = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            self.actionImage = Image("paper")
        } else if action == .scissors {
            self.actionInput = 3
            self.frameColor = Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
            self.actionImage = Image("scissors")
        } else {
            self.actionInput = 1
            self.frameColor = Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1))
            self.actionImage = Image("rock")
        }
        self._showResult = showResult
        self.roshamboViewModel = roshamboViewModel
        self.gameLogic = gameLogic
    }
    
    var body: some View {
        Capsule()
            .stroke(frameColor, lineWidth: 2.5)
            .frame(width: 109, height: 135)
            .overlay(actionImage)
            .shadow(radius: 10)
            .opacity(showResult ? 100 : 0)
            .onTapGesture {
                if roshamboViewModel.gameOver {
                    gameLogic.resetScore()
                }
                if roshamboViewModel.letReset {
                    withAnimation {
                        roshamboViewModel.gameOver = false
                        roshamboViewModel.showFight = false
                        roshamboViewModel.roTextAnim = false
                        roshamboViewModel.shamTextAnim = false
                        roshamboViewModel.boTextAnim = false
                        roshamboViewModel.showResult = false
                        roshamboViewModel.showReset = false
                        roshamboViewModel.letReset = false
                    }
                }
                
            }
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .previewDevice("iPhone SE (2nd generation)")
                .preferredColorScheme(.dark)
                
        }
    }
}
