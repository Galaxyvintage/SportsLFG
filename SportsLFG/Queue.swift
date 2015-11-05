//
// File  : Queue.swift
// Author: Isaac Qiao
// Date created  : Nov.02 2015
// Date edited   : Nov.02 2015
// Description :
//

import Foundation

// should be an inner class of Queue, but inner classes and generics crash the compiler, SourceKit (repeatedly) and occasionally XCode.
class QueueItem<T> {
    let value: T!
    var next: QueueItem?
    
    init(newvalue: T?) {
        self.value = newvalue
    }
}

///
/// A standard queue (FIFO - First In First Out). Supports simultaneous adding and removing, but only one item can be added at a time, and only one item can be removed at a time.
///
public class Queue<T> {
    
    typealias Element = T
    
    var front: QueueItem<Element>
    var back : QueueItem<Element>
    
    init () {
        // Insert dummy item. Will disappear when the first item is added.
      back  = QueueItem(newvalue: nil)
        front = back
    }
    
    /// Add a new item to the back of the queue.
    func enqueue (value: Element) {
      back.next = QueueItem(newvalue : value)
        back = back.next!
    }
    
    /// Return and remove the item at the front of the queue.
    func dequeue () -> Element? {
        if let newhead = front.next {
            front = newhead
            return newhead.value
        } else {
            return nil
        }
    }
    
    func isEmpty() -> Bool {
        return front === back
    }
}