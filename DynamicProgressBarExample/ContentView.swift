//
//  ContentView.swift
//  DynamicProgressBarExample
//
//  Created by Ruyther Costa on 01/10/22.
//

import SwiftUI

enum Constants {
    static let dynamicIslandHeight: CGFloat = 37.0
    static let dynamicIslandWidth: CGFloat = 125.1
    static let dynamicIslandTopSpaceHeight: CGFloat = 11
}

struct DynamicProgressBar: View {
    @Binding var value: Float

    var body: some View {
        GeometryReader { geometry in
            let progressWidthValue = CGFloat(self.value) * geometry.size.width

            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.2)
                    .foregroundColor(Color(.systemTeal))
                    .frame(height: geometry.size.height)

                Rectangle()
                    .frame(width: progressWidthValue, height: geometry.size.height)
                    .foregroundColor(Color(.systemBlue))
                    .animation(.linear, value: value)
            }

            VStack {
                Spacer()
                    .frame(height: geometry.size.height)

                Rectangle()
                    .frame(width: geometry.size.width, height: Constants.dynamicIslandHeight/2)
                    .foregroundColor(.black)
            }
        }
    }
}

struct ContentView: View {
    @State var isProgressViewHidden = true
    @State var progressValue: Float = 0.0

    var body: some View {
        VStack {
            if !isProgressViewHidden {
                DynamicProgressBar(value: $progressValue)
                    .frame(width: Constants.dynamicIslandWidth, height: Constants.dynamicIslandTopSpaceHeight)
                    .ignoresSafeArea()
                    .foregroundColor(.red)
                    .transition(.move(edge: .bottom))
            }

            Spacer()

            VStack(alignment: .center) {
                HStack {
                    Button(action: {
                        withAnimation {
                            isProgressViewHidden = false
                        }
                    }) {
                        Text("Show View")
                    }.padding()

                    Button(action: {
                        withAnimation {
                            isProgressViewHidden = true
                        }
                    }) {
                        Text("Hide View")
                    }.padding()
                }

                Button(action: {
                    self.startProgressBar()
                }) {
                    Text("Start Progress")
                }.padding()

                Button(action: {
                    self.resetProgressBar()
                }) {
                    Text("Reset")
                }.padding()
            }
        }.ignoresSafeArea(.all, edges: .top)
    }

    func startProgressBar() {
        for _ in 0...1 {
            if progressValue > 1 {
                break
            }

            self.progressValue += 0.1
        }
    }

    func resetProgressBar() {
        self.progressValue = 0.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Space above Dynamic Island: 125.1 x 11.1
// Dynamic Island size: 125.1 x 37
