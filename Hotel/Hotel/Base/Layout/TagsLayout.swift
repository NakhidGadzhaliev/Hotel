//
//  TagsLayout.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 26.12.2023.
//

import SwiftUI

struct TagsLayout: Layout {
    var alignment: Alignment = .leading
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? 0
        let rows = generateRows(maxWidth, proposal, subviews)
        var height: CGFloat = 0
        
        for (index, row) in rows.enumerated() {
            if index == (rows.count) {
                height += row.maxHeight(proposal)
            } else {
                height += row.maxHeight(proposal) + spacing
            }
        }
        
        return .init(width: maxWidth, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        let maxWidht = bounds.width
        let rows = generateRows(maxWidht, proposal, subviews)
        
        for row in rows {
            origin.x = 0
            for view in row {
                let viewSize = view.sizeThatFits(proposal)
                view.place(at: origin, proposal: proposal)
                origin.x += (viewSize.width - spacing)
            }
            origin.y += (row.maxHeight(proposal) + spacing)
        }
    }
    
    func generateRows(_ maxWidht: CGFloat, _ proposal: ProposedViewSize, _ subviews: Subviews) -> [[LayoutSubviews.Element]] {
        var row: [LayoutSubviews.Element] = []
        var rows: [[LayoutSubviews.Element]] = []
        var origin = CGRect.zero.origin
        
        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)
            
            if (origin.x + viewSize.width + spacing) > maxWidht {
                rows.append(row)
                row.removeAll()
                origin.x = 0
                row.append(view)
                origin.x += (viewSize.width + spacing)
            } else {
                row.append(view)
                origin.x += (viewSize.width + spacing)
            }
        }
        
        if !row.isEmpty {
            rows.append(row)
            row.removeAll()
        }
        
        return rows
    }
}
