//
//  MovieDetailView.swift
//  MovieDetail
//
//  Created by Joao Barbosa on 30/05/2025.
//

import SwiftUI
import Models

struct MovieDetailView: View {
    let viewModel: MovieDetailViewModel
    @State private var isFavorite = false

    var body: some View {
      let movie = viewModel.movie
      let posterURL = URL(string: "https://image.tmdb.org/t/p/original" + (movie.posterPath ?? ""))
        ScrollView {
            ZStack(alignment: .topTrailing) {
              AsyncImage(url: posterURL) { phase in
                  switch phase {
                  case .empty:
                      Color.gray.opacity(0.3)
                  case .success(let image):
                      image
                          .resizable()
                          .scaledToFill()
                  case .failure:
                      Image(systemName: "photo")
                          .resizable()
                          .scaledToFit()
                          .padding()
                          .foregroundColor(.gray)
                  @unknown default:
                      EmptyView()
                  }
              }
              .frame(height: 300)
              .clipped()

                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text(movie.title)
                    .font(.title)
                    .bold()

                Text("Released on: \(movie.releaseDate ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                  Text(String(format: "%.3f", (movie.voteAverage ?? 0.0)))
                        .font(.subheadline)
                }

                Text("Overview")
                    .font(.headline)
                    .padding(.top, 8)

                Text(movie.overview ?? "")
                    .font(.body)

                Text("Additional Information")
                    .font(.headline)
                    .padding(.top)

                Text("""
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                    """)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .ignoresSafeArea(edges: .top)
    }
}
