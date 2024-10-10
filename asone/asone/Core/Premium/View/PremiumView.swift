//
//  PremiumView.swift
//  Asone
//
//  Created by Arslan Kamchybekov on 10/10/24.
//

import SwiftUI

struct PremiumView: View {
    @Environment(\.dismiss) var dismiss;
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Close button
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            // Header Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Get personalized insights, exclusive features, and enhance your journey with premium access")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                
                Text("Get full access with\n33% OFF NOW")
                    .font(.title2.bold())
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            // Features Comparison Table
            VStack(spacing: 10) {
                FeatureComparisonRow(feature: "Cycle Tracker", isFreeIncluded: true, isPremiumIncluded: true)
                FeatureComparisonRow(feature: "Mood & Symptom Analysis", isFreeIncluded: false, isPremiumIncluded: true)
                FeatureComparisonRow(feature: "Partner Insights", isFreeIncluded: false, isPremiumIncluded: true)
                FeatureComparisonRow(feature: "Personalized Tips", isFreeIncluded: false, isPremiumIncluded: true)
                FeatureComparisonRow(feature: "Love Language Integration", isFreeIncluded: false, isPremiumIncluded: true)
                FeatureComparisonRow(feature: "Ad-Free Experience", isFreeIncluded: false, isPremiumIncluded: true)
            }
            .background(Color(UIColor.systemGray5))
            .cornerRadius(15)
            .padding(.horizontal)
            
            // Pricing Section
            HStack(spacing: 10) {
                PricingOptionView(price: "$13.33*", period: "/mo", plan: "Quaterly")
                PricingOptionView(price: "$3.99*", period: "/mo", plan: "Yearly")
            }
            .padding(.horizontal)
            
            // Get Premium Button
            Button(action: {
                // Action to get premium
            }) {
                Text("Get 33% off premium")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            
            // Footer Text
            Text("Upgrade today to enjoy all premium features tailored just for you and your partner")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding(.top)
    }
}

// Custom View for Feature Comparison Row
struct FeatureComparisonRow: View {
    var feature: String
    var isFreeIncluded: Bool
    var isPremiumIncluded: Bool
    
    var body: some View {
        HStack {
            Text(feature)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            // Free Section
            Image(systemName: isFreeIncluded ? "checkmark.circle.fill" : "minus.circle")
                .foregroundColor(isFreeIncluded ? .black : .gray)
            
            // Premium Section
            Image(systemName: isPremiumIncluded ? "checkmark.circle.fill" : "minus.circle")
                .foregroundColor(isPremiumIncluded ? .black : .gray)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.white)
    }
}

// Custom View for Pricing Option
struct PricingOptionView: View {
    var price: String
    var period: String
    var plan: String
    var discountText: String? = nil
    
    var body: some View {
        VStack() {
            if let discount = discountText {
                Text(discount)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Text(price)
                .font(.title)
                .bold()
            
            Text(period)
                .font(.caption)
            
            Text(plan)
                .font(.subheadline)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

#Preview {
    PremiumView()
}

