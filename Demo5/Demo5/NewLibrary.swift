//
//  Library.swift
//  PlaceInTaipei
//
//  Created by Michael on 05/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import Foundation
struct NewLibrary : Codable {
    var result : Result
}

struct Result : Codable {
    var offset : Int
    var limit : Int
    var count : Int
    var sort : String
    var results : [Item]
}

struct Item : Codable {
    var _id:String
    var o_tlc_agency_name:String
    var o_tlc_agency_category:String
    var o_tlc_agency_categorychild:String
    var o_tlc_agency_purpose:String
    var o_tlc_agency_service:String
    var o_tlc_agency_region:String
    var o_tlc_agency_opentime:String
    var o_tlc_agency_address:String
    var o_tlc_agency_phone:String
    var o_tlc_agency_fax:String
    var o_tlc_agency_email:String
    var o_tlc_agency_admincategory:String
    var o_tlc_agency_img_front:String
    var o_tlc_agency_img_inner:String
    var o_tlc_agency_link:String
}
