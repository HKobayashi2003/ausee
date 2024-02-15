//
//  Detailview.swift
//  macos
//
//  Created by 小林駿斗 on 2024/02/14.
//

import SwiftUI
import ScreenCaptureKit

struct RecordView: View {
    //監視可能なオブジェクトとして宣言する。これにより、ViewModel内で@Publishedプロパティが更新されるとビューが再描画される。
    @ObservedObject var viewModel = ContentViewModel()
    @State private var showingAlert = false
    var body: some View {
        if let image = viewModel.image {
            Image(nsImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
        } else {
            Text("何も記録されていません")
                .padding(120)
        }
        Button("デスクトップをキャプチャ") {
            viewModel.captureDesktop()
        }
    }
    
    class ContentViewModel: NSObject, ObservableObject, SCStreamOutput {
        @Published var image: NSImage?
        var stream: SCStream!
        
        func captureDesktop() {
            Task {
                do {
                    let windows = try await SCShareableContent.current.windows
                    guard let window = windows.first(where: { $0.title=="Google Chrome" }) else { return }
                    
                    
                    let filter = SCContentFilter(desktopIndependentWindow: window)
                    let configuration = SCStreamConfiguration()
                    configuration.width = Int(window.frame.width)
                    configuration.height = Int(window.frame.height)
                    configuration.showsCursor = true
                    
                    stream = SCStream(filter: filter, configuration: configuration, delegate: nil)
                    try stream.addStreamOutput(self, type: .screen, sampleHandlerQueue: DispatchQueue.main)
                    try await stream.startCapture()
                } catch {
                    print("キャプチャ中にエラーが発生しました: \(error)")
                }
            }
        }
        
        override init() {
            super.init()
        }
        
        @objc(stream:didOutputSampleBuffer:ofType:) func stream(_ stream: SCStream, didOutputSampleBuffer sampleBuffer: CMSampleBuffer, of type: SCStreamOutputType) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            let size = CGSize(width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            let ci = CIImage(cvPixelBuffer: pixelBuffer)
            guard let cg = CIContext().createCGImage(ci, from: .init(origin: .zero, size: size)) else { return }
            self.image = NSImage(cgImage: cg, size: size)
        }
    }
}
