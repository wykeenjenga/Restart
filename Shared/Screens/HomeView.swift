//
//  HomeView.swift
//  Restart
//
//  Created by Wykee Njenga on 11/26/21.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var isAnimating: Bool =  false
    
    var body: some View {
        
        ZStack{
            
            
            VStack{
                
                Spacer()
                
                //header
                ZStack {
                    CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.2)
                    Image("character-2")
                        .resizable().scaledToFit()
                        .offset(y: isAnimating ? 35: -35)
                        .animation(
                            Animation
                                .easeOut(duration: 4.0)
                                .repeatForever()
                        , value: isAnimating)
                    
                }
                
                Spacer()
                
                //text
                
                Text("""
                Feelings come and go like clouds in a windy sky.
                Conscious breathing is my anchor.
                """).font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                
                Spacer()
                
                //button
                ZStack {
                    Capsule()
                        .fill(Color("ColorBlue"))
                        .frame(width: 180 ,height: 60, alignment: .center)
                    
                    HStack{
                        
                        Button( action: {
                            withAnimation{
                                isOnboardingViewActive = true
                                playSound(sound: "success", type: "m4a")
                            }
                        }){
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 18).bold())
                                .foregroundColor(.white)
                            Text("Restart")
                                .foregroundColor(.white)
                                .font(.title3.bold())
                        }
    
                    }
                    
                }
                .padding(20)
            }.padding(20)
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        isAnimating = true
                    })
                })
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
