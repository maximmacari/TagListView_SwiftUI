//
//  Home.swift
//  TagListView
//
//  Created by Maxim Macari on 26/1/21.
//

import SwiftUI

struct Home: View {
    
    @State var text: String = ""
    
    @State var chips: [[ChipData]] = [
        //Sample data for testing
        //        [ChipData(chipText: "Hello"), ChipData(chipText: "World"), ChipData(chipText: "Guys")]
    ]
    
    var body: some View {
        VStack(spacing: 35){
            
            ScrollView{
                LazyVStack(alignment: .leading,spacing: 10){
                    
                    //since we´re using indices, we need to speecify id
                    ForEach(chips.indices, id: \.self) { index in
                        HStack{
                            ForEach(chips[index].indices, id: \.self) { chipIndex in
                                
                                Text(chips[index][chipIndex].chipText)
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(Capsule().stroke(Color.black, lineWidth: 1))
                                    .lineLimit(1)
                                    
                                    .overlay(
                                        //it is updating to each user interraction
                                        GeometryReader { reader -> Color in
                                            
                                            let maxX = reader.frame(in: .global).maxX
                                            
                                            //Both padding = 30 + 30 = 60
                                            //+ 10 eextra spacing = 10
                                            //doing action only if th eitem exceeds
                                            if maxX > UIScreen.main.bounds.width - 70 && !chips[index][chipIndex].isExceeded{
                                                DispatchQueue.main.async {
                                                    //toggling
                                                    chips[index][chipIndex].isExceeded = true
                                                    //Getting last item
                                                    let lastItem = chips[index][chipIndex]
                                                    //removing item from curreent row
                                                    chips.append([lastItem])
                                                    chips[index].remove(at: chipIndex)
                                                }
                                            }
                                            
                                            return Color.clear                                    },
                                        alignment: .trailing
                                    )
                                    .clipShape(Capsule())
                                    .onTapGesture {
                                        //removing data
                                        chips[index].remove(at: chipIndex)
                                        //if the insidee array is empty removing that also
                                        if chips[index].isEmpty {
                                            chips.remove(at: index)
                                        }
                                    }
                                
                            }
                        }
                        
                    }
                }
                .padding()
                
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        Color.gray.opacity(0.5), lineWidth: 1.5
                    )
            )
            
            //texteditor
            TextEditor(text: $text)
                .padding()
                //Border with fixed size...
                .frame(height: 150)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(
                            Color.gray.opacity(0.4), lineWidth: 1.5
                        )
                )
                .onChange(of: text, perform: { value in
                    if value.last == "\n" {
                        text = value.replacingOccurrences(of: "\n", with: "")
                        self.dismissKeyboard()
                    }
                })
            
            //adding button
            Button(action: {
                if chips.isEmpty {
                    chips.append([])
                }
                
                //addiing tag
                chips[chips.count - 1].append(ChipData(chipText: text))
                //Cleart text
                text = ""
                
                
            }, label: {
                Text("Add tag")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(4)
            })
            .disabled(text == "")
            .opacity(text == "" ? 0.45 : 1)
        }
        .padding()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//tag data model

struct ChipData: Identifiable, Hashable {
    var id = UUID().uuidString
    var chipText: String
    //to stop auto updatee
    var isExceeded = false
}
