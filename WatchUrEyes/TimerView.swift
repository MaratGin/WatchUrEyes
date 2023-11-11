//
//  TimerView.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 11.11.2023.
//

import Foundation
import SwiftUI



struct TimerView: View {
    
    
    var defaultTimeRemaining: CGFloat = 10
    var lineWidth: CGFloat = 30
    var radius: CGFloat = 70
    
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = 30
    var timer = Timer.publish(every: 1, on: .main , in: .common).autoconnect()

    init(defaultTimeRemaining: CGFloat, lineWidth: CGFloat = 30, radius: CGFloat) {
        self.defaultTimeRemaining = defaultTimeRemaining
        self.lineWidth = lineWidth
        self.radius = radius
        _timeRemaining = .init(initialValue: defaultTimeRemaining)
        
    }
    
    
    var body: some View {
        VStack(spacing: 25) {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                Circle()
                    .trim(from: 0, to: 1 - ((defaultTimeRemaining - timeRemaining) / defaultTimeRemaining))
                    .stroke(timeRemaining > 6 ? Color.green : timeRemaining > 3 ? Color.yellow : Color.red, style: StrokeStyle(lineWidth:  lineWidth, lineCap:  .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut)
                Text("\(Int(timeRemaining))").font(.largeTitle)
            }.frame(width: radius * 2, height: radius * 2)
            HStack(spacing: 25) {
                Label(" \(isActive ? "Pause" : "Play")", systemImage: " \(isActive ? "pause.fill" : "play.fill")").foregroundColor(isActive ? .red : .yellow ).font(.title).onTapGesture(perform: {
                    isActive.toggle()
                })
                Label("Resume", systemImage: "backward.fill").foregroundColor(.black).font(.title).onTapGesture(perform: {
                    isActive = false
                    timeRemaining = defaultTimeRemaining
                })
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else {return}
            if timeRemaining > 0 {
                timeRemaining -= 1
                
            } else {
                isActive = false
                timeRemaining = defaultTimeRemaining
            }
            
        })
       
        
    }
    
}



struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
