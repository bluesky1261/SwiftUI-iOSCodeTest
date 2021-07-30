//
//  PhotoModel.swift
//  KakaoCodeTest
//
//  Created by Joonghoo Im on 2021/07/16.
//

import Foundation

struct PhotoModel: Codable, Identifiable, Equatable {
    let id: String
    let createdAt: String
    let updatedAt: String
    let width: UInt32
    let height: UInt32
    let color: String
    let blurHash: String?
    let likes: UInt32
    let likedByUser: Bool
    let description: String?
    let urls:PhotoUrlModel
    let user: UserModel
    let sponsorship: Sponsorship?

    // 서버상의 snake case 매핑을 camal case 매핑으로 변경
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width
        case height
        case color
        case blurHash = "blur_hash"
        case likes
        case likedByUser = "liked_by_user"
        case description
        case urls
        case user
        case sponsorship
    }

    static func == (lhs: PhotoModel, rhs: PhotoModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct PhotoUrlModel: Codable {
    let full: String?
    let raw: String?
    let regular: String?
    let small: String?
    let thumb: String?
}

struct PhotoSearchResultModel: Codable {
    let total: UInt32
    let totalPages: UInt32
    let results: [PhotoModel]

    // 서버상의 snake case 매핑을 camal case 매핑으로 변경
    private enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
