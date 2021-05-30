//
//  JSONData.swift
//  Windscribe Coding Challenge
//
//  Created by Deep on 2021-05-30.
//

import Foundation

// MARK: - Data

struct Servers: Codable {
    let data: [ServerListData]
    let info: Info
}

struct ServerListData: Codable {
    let id: Int
       let name, countryCode: String
       let status, premiumOnly: Int
       let shortName: String
       let p2P: Int
       let tz, tzOffset: String
       let locType: LOCType
       let forceExpand: Int?
       let dnsHostname: String
       let nodes: [Node]

       enum CodingKeys: String, CodingKey {
           case id, name
           case countryCode = "country_code"
           case status
           case premiumOnly = "premium_only"
           case shortName = "short_name"
           case p2P = "p2p"
           case tz
           case tzOffset = "tz_offset"
           case locType = "loc_type"
           case forceExpand = "force_expand"
           case dnsHostname = "dns_hostname"
           case nodes
       }
}

enum LOCType: String, Codable {
    case normal = "normal"
    case streaming = "streaming"
}

// MARK: - Node
struct Node: Codable {
    let ip, ip2, ip3, hostname: String
    let weight: Int
    let group, gps, tz: String
    let type: TypeEnum
    let wgPubkey: String
    let proOnly: Int

    enum CodingKeys: String, CodingKey {
        case ip, ip2, ip3, hostname, weight, group, gps, tz, type
        case wgPubkey = "wg_pubkey"
        case proOnly = "pro_only"
    }
}

enum TypeEnum: String, Codable {
    case entry = "entry"
    case normal = "normal"
}

struct Info: Codable {
    let revision: Int
    let revisionHash: String
    let changed, fc: Int

    enum CodingKeys: String, CodingKey {
        case revision
        case revisionHash = "revision_hash"
        case changed, fc
    }
}

