//
//  TxAccountItemView.swift
//  TxGithubProfiles
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import TxUIComponent

struct TxAccountItemView: View {
    var body: some View {
        HStack(spacing: 16) {
            // Avatar with purple background
            ZStack {
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 80, height: 80)

                // Placeholder for the avatar image
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.purple)
            }
            .frame(height: 80)

            // Name and URL
            VStack(alignment: .leading, spacing: 8) {
                Text("David")
                    .font(.headline)
                    .foregroundColor(.black)
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("https://www.linkedin.com/")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .underline()
                //                Spacer()
            }

            //            Spacer()
        }
        .padding()
        .modifier(TxBoxBorderModifier())
        //        .background(
        //            RoundedRectangle(cornerRadius: 10)
        //                .fill(Color.white)
        //                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        //        )
        .padding(.horizontal)
    }
}

struct AccountItemView_Previews: PreviewProvider {
    static var previews: some View {
        TxAccountItemView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}
