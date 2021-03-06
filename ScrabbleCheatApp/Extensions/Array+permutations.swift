//
//  Array+permutations.swift
//  ScrabbleCheat
//
//  Created by Jody Abney on 6/2/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

extension Array {
    private func decompose() -> (Iterator.Element, [Iterator.Element])? {
        guard let x = first else { return nil }
        return (x, Array(self[1..<count]))
    }
    
    private func between<T>(x: T, _ ys: [T]) -> [[T]] {
        guard let (head, tail) = ys.decompose() else { return [[x]] }
        return [[x] + ys] + between(x: x, tail).map { [head] + $0 }
    }

    public func permutations<T>(xs: [T]) -> [[T]] {
        guard let (head, tail) = xs.decompose() else { return [[]] }
        return permutations(xs: tail).flatMap { between(x: head, $0) }
    }
}


