//
//  SpyView.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct SpyView: View {
    private let imageUrl = URL(string: "https://noro.mx/wp-content/uploads/2025/02/mundial-2026-posible-jersey-mexico5-1.jpg")!
    
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var rotation: Angle = .zero
    @State private var lastRotation: Angle = .zero
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            imageView
            
            if isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .transition(.opacity)
            }
            
            if errorMessage != nil {
                errorBanner
            }
            
            resetButton
        }
        .safeAreaInset(edge: .bottom) {
            controlPanel
        }
    }
    
    private var imageView: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .scaleEffect(2)
                        .onAppear { isLoading = true }
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(currentScale)
                        .offset(offset)
                        .rotationEffect(rotation)
                        .frame(
                            width: UIScreen.main.bounds.width * currentScale,
                            height: UIScreen.main.bounds.height * currentScale
                        )
                        .gesture(
                            MagnificationGesture()
                                .onChanged { scale in
                                    let delta = scale / lastScale
                                    lastScale = scale
                                    currentScale = max(min(currentScale * delta, 5.0), 0.1)
                                }
                                .onEnded { _ in
                                    lastScale = 1.0
                                }
                        )
                        .simultaneousGesture(
                            DragGesture()
                                .onChanged { gesture in
                                    let delta = gesture.translation
                                    offset = CGSize(
                                        width: lastOffset.width + delta.width,
                                        height: lastOffset.height + delta.height
                                    )
                                }
                                .onEnded { _ in
                                    lastOffset = offset
                                }
                        )
                        .simultaneousGesture(
                            RotationGesture()
                                .onChanged { angle in
                                    rotation = lastRotation + angle
                                }
                                .onEnded { angle in
                                    lastRotation += angle
                                }
                        )
                        .simultaneousGesture(
                            TapGesture(count: 2)
                                .onEnded {
                                    resetImageState()
                                }
                        )
                        .onAppear { isLoading = false }
                    
                case .failure(let error):
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        Text("Error al cargar la imagen")
                            .font(.headline)
                        Text(error.localizedDescription)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .onAppear {
                        errorMessage = error.localizedDescription
                        isLoading = false
                    }
                    
                @unknown default:
                    EmptyView()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private var errorBanner: some View {
        VStack {
            Spacer()
            if let error = errorMessage {
                Text("Error: \(error)")
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .transition(.move(edge: .bottom))
                    .onTapGesture {
                        withAnimation {
                            errorMessage = nil
                        }
                    }
            }
        }
        .animation(.easeInOut, value: errorMessage)
    }
    
    private var resetButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: resetImageState) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding()
            }
            Spacer()
        }
    }
    
    private var controlPanel: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Zoom:")
                Slider(value: $currentScale, in: 0.1...5.0, step: 0.1)
                Text("\(currentScale, specifier: "%.1f")x")
                    .frame(width: 40)
            }
            
            HStack {
                Text("Rotación:")
                Slider(value: Binding<Double>(
                    get: { rotation.degrees },
                    set: { rotation = Angle(degrees: $0) }
                ), in: -180...180, step: 1)
                Text("\(Int(rotation.degrees))°")
                    .frame(width: 40)
            }
            
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
    private func resetImageState() {
        withAnimation(.spring()) {
            currentScale = 1.0
            lastScale = 1.0
            offset = .zero
            lastOffset = .zero
            rotation = .zero
            lastRotation = .zero
        }
    }
}
