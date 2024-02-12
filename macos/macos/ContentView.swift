import ScreenCaptureKit
import SwiftUI

struct ContentView: View {
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


//class ContentViewModel: NSObject, ObservableObject {
//    @Published var image: NSImage?
//    //キャプチャしたイメージを保持するためのプロパティ。もちろんNULLセーフティ。
//    var stream: SCStream!
//
//    override init() {
//        super.init()
//    }
//
//    @MainActor func setup() async throws {
//        //現在のウィンドウを取得。windowを配列として受け取っている。
//        let windows: [SCWindow] = try await SCShareableContent.current.windows
//
//        //windowの配列の中から、Goole Chromeのウィンドウを取得。
//        //検索が成功し条件を満たすウィンドウが見つかった場合にはそのウィンドウをwindow変数に代入。
//        guard let window = windows.first(where: { $0.title == "Desktop" }) else {
//            return
//        }
//
//        //キャプチャするwindowをフィルタリングしている
//        let filter = SCContentFilter(desktopIndependentWindow: window)
//
//        //configurationは設定って意味。キャプチャする画面の設定を行っている。
//        let configuration = SCStreamConfiguration()
//        configuration.width = 1980
//        configuration.height = 1080
//        configuration.showsCursor = true
//
//        //delegateっていうのは、キャプチャ後の処理を行うためのプロトコル。今回はnilを渡している。つまり、なにも指定していない。
//        stream = SCStream(filter: filter, configuration: configuration, delegate: nil)
//        //streamに自分自身を追加している。これにより、streamがキャプチャしたイメージを自分自身に通知することができる。
//        try stream.addStreamOutput(self, type: .screen, sampleHandlerQueue: DispatchQueue.main)
//
//        //キャプチャを開始している。
//        try await stream.startCapture()
//    }
//}
//
////extensionは既存のクラス、構造体、列挙型、またはプロトコルタイプに新しい機能を追加するために使用される。
////extensionには変更可能なvarは追加できず、代わりに変更不可能なletだけが使われる。
//extension ContentViewModel: SCStreamOutput {
//    //
//    func stream(_ stream: SCStream, didOutputSampleBuffer sampleBuffer: CMSampleBuffer, of type: SCStreamOutputType) {
//        //キャプチャしたイメージを取得している。
//        let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
//        //キャプチャしたイメージのサイズを取得している。
//        let size = CGSize(width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
//        //CIImageはCoreImageの画像データを扱うためのクラス。CIImageのインスタンスを生成している。
//        let ci = CIImage(cvPixelBuffer: pixelBuffer)
//        //CIImageをCGImageに変換している。
//        let cg = CIContext().createCGImage(ci, from: .init(origin: .zero, size: size))!
//        //CGImageをNSImageに変換している。
//        self.image = NSImage(cgImage: cg, size: size)
//    }
//}
