//
//  Greetings.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/15.
//

import Foundation

func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<8: return "🌅 早起きですね"
        case 12: return "🌞 お昼ですね"
        case 13..<18: return "🌼 こんにちは"
        case 18..<24: return "🌙 こんばんは"
        case 0..<5: return "🌜 夜更かしですね"
        default: return "👋 こんにちは"
        }
}
