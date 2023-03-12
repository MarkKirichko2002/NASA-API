//
//  NASASettingsView.swift
//  NASA API
//
//  Created by Марк Киричко on 12.03.2023.
//

import SwiftUI

struct NASASettingsView: View {
    
    let viewModel: NASASettingsViewViewModel
    
    @State var isOn = false
    
    init(viewModel: NASASettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack(spacing: 15) {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.black, lineWidth: 5))
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.title)
                        .fontWeight(.black)
                    Text(viewModel.description)
                        .fontWeight(.medium)
                    Toggle(isOn: $isOn) {
                        switch isOn {
                        case true:
                            Text("включено")
                                .fontWeight(.black)
                                .foregroundColor(.green)
                        case false:
                            Text("выключено")
                                .fontWeight(.black)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
}
