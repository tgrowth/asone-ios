import SwiftUI

struct HomeView: View {
    @State private var selectedDayIndex: Int = 0
    
    // Formatter for "Today"
    private var today: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d" // Format as "Month Day"
        return formatter.string(from: Date())
    }
    
    // Get the week days (starting from Sunday, or locale dependent)
    private var weekDays: [Date] {
        let calendar = Calendar.current
        let today = Date()
        var weekDays = [Date]()
        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
            for day in 0..<7 {
                if let weekDay = calendar.date(byAdding: .day, value: day, to: weekInterval.start) {
                    weekDays.append(weekDay)
                }
            }
        }
        return weekDays
    }
    
    // Automatically select today's day index when the view loads
    init() {
        let today = Date()
        if let index = Calendar.current.dateComponents([.weekday], from: today).weekday {
            _selectedDayIndex = State(initialValue: index - 1)  // Subtract 1 because weekday starts from 1 (Sunday)
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Top Date Picker Section
            VStack {
                HStack {
                    Text("Today, \(today)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Image(systemName: "bell")
                }
                .padding()
                
                HStack {
                    ForEach(0..<7) { index in
                        DayView(
                            day: getDayOfWeek(for: weekDays[index]),
                            date: getDate(for: weekDays[index]),
                            isSelected: index == selectedDayIndex
                        )
                        .onTapGesture {
                            selectedDayIndex = index
                        }
                    }
                }
            }
            
            ScrollView(showsIndicators: false) {
                // Period Tracker View
                PeriodTrackerView()
                    .frame(width: 250, height: 250)
                
                // Log Period Button
                Button(action: {
                    // Log period action
                }) {
                    Text("Log period")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding()
                
                // Cycle Advice Section
                VStack {
                    Text("Cycle advices")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    HStack(spacing: 20) {
                        AdviceCard(text: "Sample Advice")
                        AdviceCard(text: "Sample Advice")
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
    
    // Helper function to get the day of the week for a specific date
    func getDayOfWeek(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"  // Format as "Mon", "Tue", etc.
        return formatter.string(from: date)
    }
    
    // Helper function to get the date (day number) for a specific day
    func getDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}

struct PeriodTrackerView: View {
    @State private var periodInDays = 3
    
    var body: some View {
        VStack {
            ZStack {
                // Background Circle
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    .frame(width: 230, height: 230)
                
                // Fertile window segment (light gray)
                Circle()
                    .trim(from: 0.6, to: 1.0) // Adjust start and end points
                    .stroke(Color.gray.opacity(0.5), lineWidth: 20)
                    .rotationEffect(.degrees(270))
                    .frame(width: 230, height: 230)
                
                // Period phase segment (dark gray)
                Circle()
                    .trim(from: 0.0, to: 0.3) // Adjust start and end points
                    .stroke(Color.black.opacity(0.8), lineWidth: 20)
                    .rotationEffect(.degrees(320))
                    .frame(width: 230, height: 230)
                
                // Center text
                VStack {
                    Text("Period in")
                        .foregroundColor(.gray)
                    Text("\(periodInDays) days")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 160, height: 160)
                )
                
                // Pointer Indicator
                PointerIndicator()
                    .fill(Color.gray.opacity(0.2)) // Match color to period segment
                    .frame(width: 21, height: 21)
                    .offset(y: -90) // Position above the center
                    .rotationEffect(.degrees(-60)) // Adjust the rotation as needed
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}


#Preview {
    HomeView()
}
