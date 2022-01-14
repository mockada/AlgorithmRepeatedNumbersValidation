import UIKit

// Validate numbers within an array if any of them are repeated as many times as their value
// Return the most repeated number

protocol NumbersValidationProtocol {
    func getValidatedNumber() -> Int
}

final class RepeatedNumbersValidation {
    private var repeatedNumbers: [Int] = []
    private var numbersNotRepeated: [Int] = []
    
    private let numbers: [Int]
    
    init(numbers: [Int]) {
        self.numbers = numbers
        validateNumbers()
    }
}

extension RepeatedNumbersValidation: NumbersValidationProtocol {
    func getValidatedNumber() -> Int {
        getMostRepeatedNumber()
    }
}

private extension RepeatedNumbersValidation {
    func getMostRepeatedNumber() -> Int {
        repeatedNumbers.sorted(by: { $0 > $1 }).first ?? -1
    }
    func validateNumbers() {
        numbers.forEach { number in
            guard isAlreadyValidated(number: number) else { return }
            append(number: number)
        }
    }
    func append(number: Int) {
        isValidRepeatedNumber(number) ? repeatedNumbers.append(number) : numbersNotRepeated.append(number)
    }
    func isAlreadyValidated(number: Int) -> Bool {
        !repeatedNumbers.contains(number) && !numbersNotRepeated.contains(number)
    }
    func isValidRepeatedNumber(_ number: Int) -> Bool {
        countRepeat(number: number) == number
    }
    func countRepeat(number: Int) -> Int {
        numbers.filter({ $0 == number }).count
    }
}


let numbers: [Int] = [1, 1, 2, 2, 3, 3, 3]
let numbersValidation = RepeatedNumbersValidation(numbers: numbers)
print(numbersValidation.getValidatedNumber())


/**
 Code explanation:
 
 - RepeatedNumbersValidation is final to avoid inheritance and object oriented programming, the goal is to conform protocols and not objects.
    *Using protocol oriented programming allows to unit test the code mocking the object.
 - RepeatedNumbersValidation is only for the validation described in the beginning, so it's necessary to prevent any other usage.
 - Controling access with private methods / extensions prevents misusage of the values and unexpected results.
 - In validateNumbers method, the original numbers array will be splitted into two others: repeatedNumbers and numbersNotRepeated.
 - These two arrays will be used in isAlreadyValidated method to avoid unneccessary proccessing.
 - Using native methods such as filter, contains and sorted improves the time complexity of the algorithm.
 - This code was made thinking mainly in time complexity, avoiding loops, but increasing space complexity creating more arrays out of it.
 - Using global variables was a choice to allow the usage of those inside other methods, but making sure that the class will be only used for its purposed.
    *It could be nested functions so the class could be more generic, but this would be harder to unit test it.
 - getValidatedNumber is calling another function in order to conform NumbersValidationProtocol and avoiding specification of the protocol.
 - Primitive types as Int don't have class functions such as isEquals, that's why it was necessary to use == instead.
 - getMostRepeatedNumber sorts the valid repeated numbers decreasingly and gets the first one. If the array is empty, it will return -1.
 - countRepeat is the biggest iteration where for each unique number it will have to be validate if it was repeated in the whole array.
 */
