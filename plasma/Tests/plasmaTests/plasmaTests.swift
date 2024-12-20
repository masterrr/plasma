import Testing
import XCTest
@testable import plasma

@Test func example() async throws {
    let someInput = "test"
           
   // When
   let result = YourPlasmaClass().someFunction(someInput)
   
   // Then
   XCTAssertEqual(result, expectedOutput)
}
