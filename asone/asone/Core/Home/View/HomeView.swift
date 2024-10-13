import SwiftUI

struct HomeView: View {
    @State private var selectedDayIndex: Int = 0
    
    private var today: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d" // Format as "Month Day"
        return formatter.string(from: Date())
    }
    
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
                .padding(.horizontal)
                
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
                .padding()
            }
            
            // Circular Progress Tracker
            VStack {
                CircularProgressView()
                    .frame(width: 200, height: 200)
                    .overlay {
                        VStack {
                            Text("Day 26")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Period in 3 days")
                                .font(.body)
                                .foregroundColor(.gray)
                            
                            Text("PMS phase")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
            }
            
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
        .padding(.top)
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

// Circular Progress View for tracking period/fertile window
struct CircularProgressView: View {
    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 15)
            
            // Period Phase Indicator
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color.black, lineWidth: 10)
                .rotationEffect(.degrees(-90))
            
            // Fertile Window Indicator
            Circle()
                .trim(from: 0.75, to: 1.0)
                .stroke(Color.gray, lineWidth: 10)
                .rotationEffect(.degrees(-90))
        }
    }
}

// Small View for each day of the week in the picker
struct DayView: View {
    var day: String
    var date: String
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Text(day)
                .font(.body)
                .foregroundColor(isSelected ? .black : .gray)
            
            Text(date)
                .font(.caption)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(isSelected ? .black : .gray)
                .padding(16)
                .background(isSelected ? Color.black.opacity(0.1) : Color.clear)
                .cornerRadius(8)
        }
    }
}

// Advice Card View
struct AdviceCard: View {
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
}

#Preview {
    HomeView()
}
