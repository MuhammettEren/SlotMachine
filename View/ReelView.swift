//
//  ReelView.swift
//  SlotMachine
//
//  Created by Muhammet Eren on 8.02.2025.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 140,idealWidth: 200,maxWidth: 220,minHeight: 130,idealHeight: 190,maxHeight: 200,alignment: .center)
            .modifier(ShadowModifier())
    }
}

#Preview(traits: .fixedLayout(width: 220, height: 220)) {
    ReelView()
        
}
