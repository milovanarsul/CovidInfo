//
//  SwiftUITestView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 19.05.2022.
//

import SwiftUI

struct SwiftUITestView: View {
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        ScrollView{
            VStack {
                HStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: screenWidth / 2 - 20, height: 150)
                            .padding(EdgeInsets(top: 200, leading: 20, bottom: 20, trailing: 5))
                        
                        Text("Cazuri totale")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 80, leading: -15, bottom: 0, trailing: 0))
                        
                        Text("689894")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 170, leading: -25, bottom: 0, trailing: 0))
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: screenWidth / 2 - 20, height: 150)
                            .padding(EdgeInsets(top: 200, leading: 0, bottom: 20, trailing: 20))
                        
                        Text("Decese totale")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 80, leading: -45, bottom: 0, trailing: 0))
                        
                        Text("689894")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 170, leading: -55, bottom: 0, trailing: 0))
                    }
                }
                
                HStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: screenWidth / 2 - 20, height: 150)
                            .padding(EdgeInsets(top: -10, leading: 20, bottom: 20, trailing: 5))
                        
                        Text("Cazuri totale\nper milion")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: -70, leading: -15, bottom: 0, trailing: 0))
                        
                        Text("689894")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 20, leading: -25, bottom: 0, trailing: 0))
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: screenWidth / 2 - 20, height: 150)
                            .padding(EdgeInsets(top: -10, leading: 0, bottom: 20, trailing: 20))
                        
                        Text("Decese totale\nper milion")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: -70, leading: -15, bottom: 0, trailing: 0))
                        
                        Text("689894")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 20, leading: -55, bottom: 0, trailing: 0))
                    }
                }
            }

        }
        .frame(width: screenWidth, height: screenHeight)
        .background(.gray)
    }
}

struct SwiftUITestView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITestView()
    }
}
