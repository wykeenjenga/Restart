//
//  OnboardingView.swift
//  Restart
//
//  Created by Wykee Njenga on 11/26/21.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffSet: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String  = "WyyK Meditate"
    
    var body: some View {
        
        ZStack{
            
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20){
                Spacer()
                
                VStack(spacing: 0){
                    
                    Text(textTitle)
                        .font(.system(size: 48))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                    To understand the immeasurable,
                    the mind must be extraordinarily
                    quiet, still.
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            
                ZStack{
                    ZStack{
                        CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                            .offset(x: imageOffset.width * -1)
                            .blur(radius: abs(imageOffset.width / 5))
                            .animation(.easeOut(duration: 1),value: imageOffset)
                    }
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1:0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width/20)))
                        .gesture(
                        DragGesture()
                            .onChanged{ gesture in
                                if abs(imageOffset.width) <= 150{
                                    imageOffset = gesture.translation
                                    withAnimation(
                                        .linear(duration: 0.2)){
                                            indicatorOpacity = 0
                                            textTitle = "Give's..."
                                        }
                                }
                            }
                            .onEnded{ _ in
                                imageOffset = .zero
                                withAnimation(.linear(duration: 0.25)){
                                    indicatorOpacity = 1.0
                                    textTitle = "WyK Mediate"
                                }
                            }
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }
                
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isAnimating ? 1: 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                , alignment: .bottom
                )
                
                Spacer()
            
                ZStack{
                    Capsule()
                        .fill(.white).opacity(0.2)
                    Capsule()
                        .fill(.white).opacity(0.2)
                        .padding(8)
                    
                    Text("Get started")
                        .font(.system(.title3, design: .rounded).bold())
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffSet + 80)
                        Spacer()
                    }
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.2))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 28).bold())
                            
                        }.foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffSet)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffSet <= buttonWidth - 80{
                                        buttonOffSet = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(Animation.easeOut(duration: 0.6)){
                                        if buttonOffSet > buttonWidth / 2 {
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffSet = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        }else{
                                            buttonOffSet = 0
                                        }
                                    }
                                }
                        )
                        Spacer()
                    }
                    
                }.frame(width: buttonWidth, height: 80, alignment: .center)
                    .padding(12)
                    .opacity(isAnimating ? 1:0)
                    .offset(y: isAnimating ? 0:40)
                    .animation(.easeOut(duration: 1), value: isAnimating)
            }
        }
        
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
