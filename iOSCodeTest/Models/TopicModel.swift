//
//  TopicModel.swift
//  KakaoCodeTest
//
//  Created by Joonghoo Im on 2021/07/16.
//

import Foundation

struct TopicModel: Codable, Identifiable {
    let id: String
    let slug: String
    let title: String
    let description: String?
    let published_at: String
    let updated_at: String?
    let starts_at: String
    let ends_at: String?
    let featured: Bool
    let total_photos: UInt32
    var topicSelected: Bool?
}
