//
//  ImageSlider.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import SwiftUI

struct ImageSlider: View {
    let imageUrls: [String]
    
    var body: some View {
        TabView {
            ForEach(imageUrls, id: \.self) { imageUrl in
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundStyle(Color.customGray)
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Image(systemSymbol: .photo)
                        @unknown default:
                            fatalError("Unknown error")
                        }
                    }
                }
            }
        }
        .frame(height: 257)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    ImageSlider(imageUrls: ["1", "2"])
}
