# HDatePicker
Precise recreation of the horizontal date picker from the iOS calendar app.

## Usage
```swift
import HDatePicker

struct ContentView: View {
    @State var selectedDay: Date = .now

    var body: some View {
        HDatePicker(selectedDay: $selectedDay)
    }
}
```
