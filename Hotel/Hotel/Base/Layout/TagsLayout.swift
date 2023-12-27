//
//  TagsLayout.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 26.12.2023.
//

import SwiftUI

// Структура TagsLayout для компоновки подвидов в виде меток с возможностью переноса на новую строку
struct TagsLayout: Layout {
    var alignment: Alignment = .leading
    var spacing: CGFloat = 8
    
    // Метод для расчета размера компоновки
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? 0
        let rows = generateRows(maxWidth, proposal, subviews)
        var height: CGFloat = 0
        
        // Вычисление высоты компоновки на основе строк и интервалов между ними
        for (index, row) in rows.enumerated() {
            if index == (rows.count) {
                height += row.maxHeight(proposal)
            } else {
                height += row.maxHeight(proposal) + spacing
            }
        }
        
        return .init(width: maxWidth, height: height)
    }
    
    // Метод для размещения подвидов в границах компоновки
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        let maxWidth = bounds.width
        let rows = generateRows(maxWidth, proposal, subviews)
        
        // Размещение подвидов в соответствии с расчетами строк и интервалов
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
    
    // Метод для генерации строк подвидов в соответствии с заданным максимальным шириной и интервалом
    func generateRows(
        _ maxWidth: CGFloat,
        _ proposal: ProposedViewSize,
        _ subviews: Subviews
    ) -> [[LayoutSubviews.Element]] {
        var row: [LayoutSubviews.Element] = []
        var rows: [[LayoutSubviews.Element]] = []
        var origin = CGRect.zero.origin
        
        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)
            
            if (origin.x + viewSize.width + spacing) > maxWidth {
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
