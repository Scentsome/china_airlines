//
//  ViewController.swift
//  MyCalender
//
//  Created by Michael on 12/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import CVCalendar
class ViewController: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    let event1 = Event(date: Date(), title: "event1", detail: "detail1")
    let event2 = Event(date: Date(timeIntervalSinceNow: 3600*24*2),
                       title: "event2", detail: "adsfasdfasefasefasefasefaef")
    var events:[Event] = []
    
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    
    @IBOutlet weak var calendarView: CVCalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        events.append(event1)
        events.append(event2)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
        
        let date =  Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMM"
        monthLabel.text = formatter.string(from: date)
    }

    override func viewWillLayoutSubviews() {
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        for event in events {
            
            if dayView.date.commonDescription == event.eventDate.commonDescription {
                return true
            }
        }
        return false

    }
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
        return [UIColor.black]
    }
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        
        for event in events {
            
            if dayView.date.commonDescription == event.eventDate.commonDescription {
                
                dateLabel.text = event.eventDate.commonDescription
                titleLabel.text = event.eventTitle
                detailTextView.text = event.eventDetail
                
                return
                
            } else {
                dateLabel.text = ""
                titleLabel.text = ""
                detailTextView.text = ""
            }
        }
    }

    
    
    func didShowNextMonthView(_ date: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMM"
        monthLabel.text = formatter.string(from: date)
        
    }
    
    func didShowPreviousMonthView(_ date: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMM"
        monthLabel.text = formatter.string(from: date)
    }
    
}

