//
//  Test.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 19.12.2023.
//

import SwiftUI

struct ImageSlider: View {
    @State private var selection = 0
    let imageUrls: [String]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: imageUrls[index])) { phase in
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
                            fatalError(Constants.unknownError)
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .background(.customGray)
            .frame(height: 257)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .tabViewStyle(PageTabViewStyle())
            
            IndexIndicatorView(selection: $selection, imageUrls: imageUrls)
        }
    }
}

private struct IndexIndicatorView: View {
    @Binding var selection: Int
    let imageUrls: [String]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.white)
                .frame(height: 17)
                .padding(.bottom, 8)
            HStack(alignment: .center, spacing: 5) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    Circle()
                        .foregroundColor(index == selection ? .black : .black.opacity(0.22))
                        .frame(width: 7, height: 7)
                        .padding(.bottom, 8.5)
                        .onTapGesture {
                            withAnimation {
                                selection = index
                            }
                        }
                }
            }
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .zero)
    }
}
