//
//  MovieListView.swift
//  MovieList
//
//  Created by Joao Barbosa on 30/04/2025.
//

import SwiftUI
import Models

struct MovieListView: View {

  @ObservedObject var viewModel: MovieListViewModel

  var body: some View {
    VStack(spacing: 20) {
      ScrollView {
        LazyVStack(spacing: 20) {
          ForEach(viewModel.movies, id: \.id) { movie in
            MovieCell(movie: movie)
              .onTapGesture {
                viewModel.movieWasTapped(movie)
              }
          }
          ProgressView()
              .onAppear {
                  viewModel.triggerNewPageFetch()
              }
        }
      }
    }
    .padding()
  }
}

struct MovieCell: View {
  let movie: Movie

  var posterURL: URL? {
      guard let path = movie.posterPath else { return nil }
      return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
  }

  var body: some View {
      HStack(alignment: .top, spacing: 16) {
        AsyncImage(url: posterURL) { image in
              image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
          } placeholder: {
              Color.gray
          }
          .frame(width: 100, height: 150)
          .clipped()
          VStack(alignment: .leading, spacing: 8) {
              Text(movie.title)
                  .font(.headline)
            Text("⭐️ \(String(format: "%.1f", movie.voteAverage ?? 0.0))")
                  .font(.subheadline)
                  .foregroundColor(.secondary)
              Text(movie.overview ?? "")
                  .font(.body)
                  .lineLimit(4)
                  .foregroundColor(.secondary)
          }
          .padding(.vertical, 8)
      }
      .frame(height: 150)
  }
}
