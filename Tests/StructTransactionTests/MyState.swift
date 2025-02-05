import StructTransaction

@Tracking
struct Nesting {
  
  var value: String = ""
  
  var next: Nesting?
  
  init(next: Nesting?) {
    self.next = next
  }
  
  init() {
    
    self.next = .init(
      next: .init(
        next: .init(
          next: .init(next: nil)
        )
      )
    )
            
  }
}

@Tracking
struct MyState {
  
  init() {
    self.name = ""
  }

  var height: Int = 0
    
  var age: Int = 18
  var name: String

  var edge: Int = 0

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
  var nestedAttached: NestedAttached = .init(name: "")

  @Tracking
  struct Nested {
    
    init(name: String) {
      self.name = name
    }
    
    var name = ""
  }

  struct NestedAttached {
    var name: String = ""
  }

  mutating func updateName() {
    self.name = "Hiroshi"
  }

}
