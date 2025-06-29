//
//MIT License
//
//Copyright © 2025 Cong Le
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
//
//
//  NeurologicalDisordersView.swift
//  Neurological_Disorders
//
//  Created by Cong Le on 6/29/25.
//


import SwiftUI

// MARK: - Data Model

/// Represents a single neurological disorder with its key characteristics and neuronal impact.
/// This struct is identifiable to be used seamlessly in SwiftUI lists and ForEach loops.
struct Disorder: Identifiable {
    /// A unique identifier for the disorder.
    let id = UUID()
    /// The common name of the disorder.
    let name: String
    /// A brief summary of the primary symptoms or characteristics.
    let keyCharacteristic: String
    /// A description of the underlying effect on neurons or the nervous system.
    let neuronalEffect: String
    /// The name of an SF Symbol to visually represent the disorder.
    let iconName: String
    /// A theme color associated with the disorder for UI styling.
    let themeColor: Color
}

// MARK: - Data Source

/// A simple data source providing a list of common neurological disorders.
/// In a real application, this data might be fetched from a network request or a local database.
struct DisorderData {
    static let disorders: [Disorder] = [
        Disorder(
            name: "Alzheimer's Disease",
            keyCharacteristic: "Progressive cognitive decline and memory loss.",
            neuronalEffect: "Characterized by the loss of neurons and synapses, associated with the formation of amyloid plaques and tau tangles, disrupting overall brain function.",
            iconName: "brain.head.profile",
            themeColor: .blue
        ),
        Disorder(
            name: "Parkinson's Disease",
            keyCharacteristic: "Tremor, muscle rigidity, and difficulty with movement.",
            neuronalEffect: "Caused by the progressive loss of dopamine-producing (dopaminergic) neurons in a midbrain area called the substantia nigra.",
            iconName: "figure.walk.motion",
            themeColor: .purple
        ),
        Disorder(
            name: "Multiple Sclerosis (MS)",
            keyCharacteristic: "Varied symptoms including fatigue, weakness, and vision problems.",
            neuronalEffect: "An autoimmune disorder where the body's immune system attacks and damages the myelin sheath (demyelination) in the Central Nervous System, impairing signal conduction.",
            iconName: "bolt.horizontal.icloud",
            themeColor: .orange
        ),
        Disorder(
            name: "Myasthenia Gravis",
            keyCharacteristic: "Fluctuating muscle weakness and fatigue during simple activities.",
            neuronalEffect: "An autoimmune condition where antibodies block or destroy acetylcholine receptors at the neuromuscular junction, inhibiting muscle activation.",
            iconName: "person.fill.questionmark",
            themeColor: .teal
        ),
        Disorder(
            name: "Charcot-Marie-Tooth",
            keyCharacteristic: "Muscle wasting and loss of touch sensation, primarily in the limbs.",
            neuronalEffect: "A group of inherited disorders caused by mutations affecting the proteins involved in the structure and function of peripheral nerve axons or the myelin sheath.",
            iconName: "hand.draw",
            themeColor: .green
        )
    ]
}


// MARK: - Main SwiftUI View

/// A SwiftUI view that displays a list of neurological disorders and their impact on the nervous system.
/// This view is designed to be informative, accessible, and follow best practices for UI development.
struct NeurologicalDisordersView: View {

    /// The list of disorders to be displayed, sourced from our static data provider.
    private let disorders = DisorderData.disorders
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // --- Introduction Header ---
                    IntroductionView()
                    
                    // --- Disorders List ---
                    ForEach(disorders) { disorder in
                        DisorderDetailCard(disorder: disorder)
                    }
                    
                    // --- Footer and Citation ---
                    FooterView()
                    
                }
                .padding()
            }
            .navigationTitle("Neurological Disorders")
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

// MARK: - Reusable Child Views

/// An introductory text block setting the context for the view.
struct IntroductionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("When Things Go Wrong")
                .font(.title2).bold()
                .foregroundColor(.primary)
            
            Text("Damage to neurons, their myelin sheath, or the process of synaptic transmission can lead to a wide range of neurological disorders. Below are a few examples of how neuronal dysfunction manifests as disease.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}

/// A card-based view to present the details of a single neurological disorder.
struct DisorderDetailCard: View {
    let disorder: Disorder
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // --- Card Header ---
            HStack {
                Image(systemName: disorder.iconName)
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                
                Text(disorder.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            .background(disorder.themeColor)
            
            // --- Card Body ---
            VStack(alignment: .leading, spacing: 16) {
                InfoRow(
                    iconName: "text.bubble.fill",
                    title: "Key Characteristic",
                    description: disorder.keyCharacteristic
                )
                
                Divider()
                
                InfoRow(
                    iconName: "waveform.path.ecg",
                    title: "Neuronal Impact",
                    description: disorder.neuronalEffect
                )
            }
            .padding()
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .accessibilityElement(children: .combine) // Combine children for better VoiceOver experience
        .accessibilityLabel("\(disorder.name). Key characteristic: \(disorder.keyCharacteristic). Neuronal Impact: \(disorder.neuronalEffect)")
    }
}

/// A reusable view for displaying a row of information with an icon, title, and description.
struct InfoRow: View {
    let iconName: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(width: 20, alignment: .center)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.primary)
            }
        }
    }
}

/// The footer view containing a disclaimer and a link to a trusted source for more information.
struct FooterView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("This information is for educational purposes only and is not a substitute for professional medical advice. For detailed information, consult a healthcare provider or a trusted source.")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            // Link to the National Institute of Neurological Disorders and Stroke (NINDS)
            // A trusted, public US data resource.
            if let url = URL(string: "https://www.ninds.nih.gov/health-information/disorders") {
                Link("Source: U.S. National Institute of Neurological Disorders and Stroke (NINDS)", destination: url)
                    .font(.caption2)
                    .padding(.top, 4)
                    .accessibilityHint("Opens the NINDS website in a browser.")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}


// MARK: - SwiftUI Preview

/// Provides a preview of the NeurologicalDisordersView for Xcode's canvas.
struct NeurologicalDisordersView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview in both light and dark mode for thorough UI checking
        Group {
            NeurologicalDisordersView()
                .preferredColorScheme(.light)
            
            NeurologicalDisordersView()
                .preferredColorScheme(.dark)
        }
    }
}
