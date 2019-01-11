import UIKit

protocol NumberToDateProtocol {
    func hoursFromNow() -> Date
    func minutesFromNow() -> Date
    func secondsFromNow() -> Date
    
    func hoursFrom(date: Date) -> Date
    func minutesFrom(date: Date) -> Date
    func secondsFrom(date: Date) -> Date
}

protocol DateManipulationProtocol {
    func future(hours: Int, minutes: Int, seconds: Int) -> Date
    func past(hours: Int, minutes: Int, seconds: Int) -> Date
}

// Time
extension IntegerLiteralType: NumberToDateProtocol {
    func hoursFromNow() -> Date { return hoursFrom(date: Date()) }
    func minutesFromNow() -> Date { return minutesFrom(date: Date()) }
    func secondsFromNow() -> Date { return secondsFrom(date: Date()) }
    
    func hoursFrom(date: Date) -> Date { return date.future(hours: self) }
    func minutesFrom(date: Date) -> Date { return date.future(minutes: self) }
    func secondsFrom(date: Date) -> Date { return date.future(seconds: self) }
}

extension FloatLiteralType: NumberToDateProtocol {
    func hoursFromNow() -> Date { return hoursFrom(date: Date()) }
    func minutesFromNow() -> Date { return minutesFrom(date: Date()) }
    func secondsFromNow() -> Date { return secondsFrom(date: Date()) }
    
    func hoursFrom(date: Date) -> Date {
        let hours = Int(self)
        let remainingHours = self - Double(hours)

        let minutes = Double(remainingHours * 60)
        let remainingMinutes = minutes - Double(Int(minutes))

        let seconds = remainingMinutes * 60
        return date.future(hours: Int(self), minutes: Int(minutes), seconds: Int(seconds))
    }
    
    func minutesFrom(date: Date) -> Date {
        let minutes = Int(self)
        let remainingMinutes = self - Double(minutes)

        let seconds = Double(remainingMinutes * 60)
        
        return date.future(minutes: minutes, seconds: Int(seconds))
    }
    
    func secondsFrom(date: Date) -> Date {
        return date.future(seconds: Int(self))
    }
}

extension Date: DateManipulationProtocol {
    private func timeIntervalSince(hours: Int, minutes: Int, seconds: Int) -> TimeInterval {
        return TimeInterval(seconds) + TimeInterval(60 * minutes) + TimeInterval(hours * 60 * 60)
    }
    
    func future(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        return Date(timeIntervalSinceNow: timeIntervalSince(hours: hours, minutes: minutes, seconds: seconds))
    }
    
    func past(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        return Date(timeIntervalSinceNow: -timeIntervalSince(hours: hours, minutes: minutes, seconds: seconds))
    }
}
