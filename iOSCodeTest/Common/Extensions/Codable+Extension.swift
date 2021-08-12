//
//  Codable+Extension.swift
//  KakaoCodeTest
//
//  Created by Joonghoo Im on 2021/07/16.
//

import Foundation

// MARK: - Extension: Encodable -
extension Encodable {
    var jsonData: Data {
        return try! JSONEncoder().encode(self)
    }

    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: jsonData)) as? [String: Any] ?? [:]
    }

    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }

    var jsonString: String? {
        do {
            let data = try encode()
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

// MARK: - Extension: Decodable -
extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}
