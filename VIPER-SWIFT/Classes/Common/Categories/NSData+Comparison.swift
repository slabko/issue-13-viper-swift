// NSDate doesn't include overrides for standard comparison operators in Swift.
// This extension adds <, >, <=, >=, and ==, using NSDate's built-in `compare` method.
// MIT licensed.

import Foundation

func <=(lhs: NSDate, rhs: NSDate) -> Bool {
        let res = lhs.compare(rhs)
            return res == .OrderedAscending || res == .OrderedSame
}
func >=(lhs: NSDate, rhs: NSDate) -> Bool {
        let res = lhs.compare(rhs)
            return res == .OrderedDescending || res == .OrderedSame
}
func >(lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.compare(rhs) == .OrderedDescending
}
func <(lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.compare(rhs) == .OrderedAscending
}
func ==(lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.compare(rhs) == .OrderedSame
}
