//
//  NotificationsView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 11/9/24.
//

import SwiftUI

struct NotificationsView: View {
    // Sample data for notifications
    let notifications = [
        NotificationItem(title: "New Period Log", description: "Your period log has been successfully added."),
        NotificationItem(title: "Reminder", description: "Don't forget to log your next period."),
        NotificationItem(title: "Cycle Advice", description: "Check out new tips for your menstrual cycle."),
        NotificationItem(title: "Pregnancy Reminder", description: "Reminder to check pregnancy probability for the next week.")
    ]

    var body: some View {
        VStack {
            List(notifications, id: \.title) { notification in
                VStack(alignment: .leading) {
                    Text(notification.title)
                        .font(.headline)
                    Text(notification.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }

            Spacer()
        }
        .navigationBarTitle("Notifications")
    }
}


#Preview {
    NotificationsView()
}
