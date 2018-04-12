//
//  Event.swift
//  MyCalender
//
//  Created by Michael on 12/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import CVCalendar

class Event: NSObject {
    let eventDate:CVDate
    let eventTitle:String
    let eventDetail:String
    
    init(date: Foundation.Date, title: String, detail: String) {
        
        self.eventDate = CVDate(date: date)
        self.eventTitle = title
        self.eventDetail = detail
    }

}
