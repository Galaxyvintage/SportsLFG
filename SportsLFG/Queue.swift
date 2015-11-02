//
//  Queue.swift
//  SportsLFG
//
//  Created by IsaacQ on 15/11/2.
//  Copyright © 2015年 CMPT-GP03. All rights reserved.
//

import Foundation

// should be an inner class of Queue, but inner classes and generics crash the compiler, SourceKit (repeatedly) and occasionally XCode.
class _QueueItem<T> {
    let value: T!
    var next: _QueueItem?
    
    init(_ newvalue: T?) {
        self.value = newvalue
    }
}

///
/// A standard queue (FIFO - First In First Out). Supports simultaneous adding and removing, but only one item can be added at a time, and only one item can be removed at a time.
///
public class Queue<T> {
    
    typealias Element = T
    
    var _front: _QueueItem<Element>
    var _back: _QueueItem<Element>
    
    init () {
        // Insert dummy item. Will disappear when the first item is added.
        _back = _QueueItem(nil)
        _front = _back
    }
    
    /// Add a new item to the back of the queue.
    func enqueue (value: Element) {
        _back.next = _QueueItem(value)
        _back = _back.next!
    }
    
    /// Return and remove the item at the front of the queue.
    func dequeue () -> Element? {
        if let newhead = _front.next {
            _front = newhead
            return newhead.value
        } else {
            return nil
        }
    }
    
    func isEmpty() -> Bool {
        return _front === _back
    }
}