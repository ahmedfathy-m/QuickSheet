//
//  PreferencesView.swift
//  QuickSheet_Example
//
//  Created by Ahmed Fathy on 27/01/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import QuickSheet

struct PreferencesView: View {
    @State var fraction: Double = 0.3
    @State var shadowRadius: CGFloat = 10.0
    @State var shadowOpacity: Float = 0.3
    @State var cornerRadius: CGFloat = 5.0
    @State var color = UIColor.black
    @State var style = PresentationStyle.regular
    @State var blurEffect: UIBlurEffect.Style? = .none
    @State var demo: UIViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DummyVC")
        return vc
    }()
    
    var scrollDemo: UIViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DummyVC")
        return vc
    }()
    
    var noScrollDemo: UIViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NoScrollVC")
        return vc
    }()
    
    var didPressPresent: (QuickSheetOptions, UIViewController) -> () = { _,_ in }
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section {
                    Stepper(value: $fraction, in: 0.3...1.0, step: 0.1) {
                        HStack {
                            Text("Fraction")
                            Spacer()
                            Text(String(format: "%.2f", fraction))
                        }
                    }
                    Picker(selection: $style) {
                        Text("Regular").tag(PresentationStyle.regular)
                        Text("Expandable").tag(PresentationStyle.expandable)
                        Text("Scrollable").tag(PresentationStyle.scrollable)
                    } label: {
                        Text("Presentation Style")
                    }
                    Stepper(value: $cornerRadius, in: 5.0...30.0, step: 5.0) {
                        HStack {
                            Text("Corner Radius")
                            Spacer()
                            Text(String(format: "%.2f", cornerRadius))
                        }
                    }
                    Picker(selection: $blurEffect) {
                        ForEach(UIBlurEffect.Style.allCases, id: \.rawValue) { object in
                            Text(object.description).tag(object as Optional<UIBlurEffect.Style>)
                        }
                        Text("No Blur").tag(Optional<UIBlurEffect.Style>.none)
                    } label: {
                        Text("Blur Effect")
                    }
                } header: {
                    Text("Sheet Style")
                }

                Section {
                    Stepper(value: $shadowOpacity, in: 0.3...1.0, step: 0.1) {
                        HStack {
                            Text("Shadow Opacity")
                            Spacer()
                            Text(String(format: "%.2f", shadowOpacity))
                        }
                    }
                    Stepper(value: $shadowRadius, in: 10.0...30.0, step: 2.5) {
                        HStack {
                            Text("Shadow Radius")
                            Spacer()
                            Text(String(format: "%.2f", shadowRadius))
                        }
                    }
                    Picker(selection: $color) {
                        Text("Black").tag(UIColor.black)
                        Text("Blue").tag(UIColor.blue)
                        Text("Gray").tag(UIColor.gray)
                        Text("Red").tag(UIColor.red)
                        Text("Cyan").tag(UIColor.cyan)
                    } label: {
                        Text("Shadow Color")
                    }
                } header: {
                    Text("Shadow Style")
                }
                
                Section {
                    Picker(selection: $demo) {
                        Text("Scroll Demo").tag(scrollDemo)
                        Text("No Scroll Demo").tag(noScrollDemo)
                    } label: {
                        Text("Select Demo")
                    }

                } header: {
                    Text("Demo")
                }

            }
            Spacer()
            ZStack(alignment: .center) {

                Button("Present Quicksheet") {
                    let shadowStyle = QuickSheetOptions.ShadowStyle(shadowRadius: self.shadowRadius, shadowColor: self.color, shadowOpacity: self.shadowOpacity)
                    let options = QuickSheetOptions(fraction: self.fraction, presentationStyle: self.style, cornerRadius: self.cornerRadius, blurEffect: self.blurEffect, shadowStyle: shadowStyle)
                    self.didPressPresent(options, demo)
                }
                .frame(width: UIScreen.main.bounds.width - 20, height: 55)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.vertical, 8)
            }
        }
    }
}

struct StepperWithValue<T: Strideable>: View {
    let title: String
    @State var value: T
    let range: ClosedRange<T>
    let step: T.Stride
    @State var text = ""
    
    var body: some View {
        Stepper(value: $value, in: range, step: step) {
            HStack {
                Text(title)
                Spacer()
                Text(String(format: "%.2f", value as! CVarArg))
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
