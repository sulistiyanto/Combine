import UIKit
import Combine


//collect
["A","B","C","D","E"].publisher.collect(3).sink {
    print($0)
}

//map
let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

[123,45,67].publisher.map {
    formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
}.sink {
    print($0)
}

//flatMap
struct School {
    let name: String
    let noOfStudents: CurrentValueSubject<Int, Never>
    
    init(name: String, noOfStudents: Int) {
        self.name = name
        self.noOfStudents = CurrentValueSubject(noOfStudents)
    }
}

let citySchool = School(name: "Fountain Head School", noOfStudents: 100)

let school = CurrentValueSubject<School,Never>(citySchool)

school
    .flatMap {
        $0.noOfStudents
    }
    .sink {
    print($0)
}

let townSchool = School(name: "Town Head School", noOfStudents: 45)

school.value = townSchool


citySchool.noOfStudents.value += 1
townSchool.noOfStudents.value += 10

//filter
let numbers = (1...20).publisher

numbers.filter { $0 % 2 == 0 }
    .sink {
        print($0)
}

//compactMap
let strings = ["a","1.24","b","3.45","6.7"].publisher
    .compactMap{ Float($0) }
    .sink {
    print($0)
}

//removeDuplicates
let words = "apple apple apple fruit fruit apple apple mango watermelon apple".components(separatedBy: " ").publisher

words
    .removeDuplicates()
    .sink {
    print($0)
}
