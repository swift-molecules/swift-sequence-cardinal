public import Cardinal
public import Iterator
public import Sequence
public import Sequence_Property

extension Sequenceable where Self: ~Copyable, Element: Copyable & Escapable {

    @inlinable
    public consuming func collect() throws(Iterator.Failure) -> [Element] {
        let hint = self.hint.count
        var iterator = self.makeIterator()
        var result: [Element] = []
        result.reserveCapacity(Int(clamping: hint.rawValue))
        while let element = try iterator.next() {
            result.append(element)
        }
        return result
    }
}
