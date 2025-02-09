//
//  LogoView.swift
//  SlotMachine
//
//  Created by Muhammet Eren on 8.02.2025.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("gfx-slot-machine")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 256,idealWidth: 300,maxWidth: 320,minHeight: 112,idealHeight: 130,maxHeight: 140,alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
            .modifier(ShadowModifier())
    }
}

#Preview {
    LogoView()
}
