import XCTest
import StructTransaction

@propertyWrapper
struct JustWrapper<Value> {

  var wrappedValue: Value

}

final class WritingStateTests: XCTestCase {

  @Writing
  struct MyState {

    var age: Int = 18
    var name: String

    @JustWrapper var edge: Int = 0

    var computedName: String {
      get {
        "Mr. " + name
      }
    }

    var computedAge: Int {
      let age = age
      return age
    }

    var computed_setter: String {
      get {
        name
      }
      set {
        name = newValue
      }
    }

    var nested: Nested = .init(name: "hello")

    struct Nested {
      var name = ""
    }

  }

  func testObserve() {

    var myState = MyState(name: "")

    let r = MyState.modify(source: &myState) {
      $0.name = "Hello"
    }

    XCTAssert(r.modifiedIdentifiers.contains("name"))

  }

  func testModifyNested() {

    var myState = MyState(name: "")

    let r = myState.modify {
      $0.nested.name = "hey"
    }

    XCTAssertEqual(r.modifiedIdentifiers, .init(["nested"]))
    XCTAssertEqual(myState.nested.name, "hey")
  }

  func testModifyOverComputedProperty() {

    var myState = MyState(name: "")

    let r = myState.modify {
      $0.computed_setter = "A"
    }

    XCTAssertEqual(r.modifiedIdentifiers, .init(["name"]))
    XCTAssertEqual(myState.name, "A")
  }

}
