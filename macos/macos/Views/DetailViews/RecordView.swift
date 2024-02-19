import SwiftUI
import ScreenCaptureKit

//class ScreenRecorder: ObservableObject {
//    var stream: SCStream?
//    var isRecording = false
//    private var outputFileURL: URL?
//    
//    init(outputPath: String? = nil) {
//        // 保存先のパスを設定（デフォルトはダウンロードフォルダ）
//        let defaultPath = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
//        let fileName = "ScreenRecording_\(Date().timeIntervalSince1970).mov"
//        self.outputFileURL = URL(fileURLWithPath: outputPath ?? defaultPath.appendingPathComponent(fileName).path)
//    }
//    
//    func startRecording() {
//        guard !isRecording else { return }
//        
//        // SCStreamの設定
//        let configuration = SCStreamConfiguration()
//        let filter = SCContentFilter()
//        configuration.showsCursor = true
//        
//        // SCStreamの初期化
//        stream = SCStream(filter:filter, configuration: configuration, delegate: nil)
//        
//        do {
//                
//                stream = try SCStream(filter: filter, configuration: configuration, delegate: nil)
//            } catch {
//                print("SCStreamの初期化時にエラーが発生しました: \(error.localizedDescription)")
//                return
//            }
//    }
//    
//    func stopRecording() {
//        guard isRecording else { return }
//        
//        // 録画の停止
//        stream?.stopCapture(completionHandler: { error in
//            if let error = error {
//                print("録画停止エラー: \(error.localizedDescription)")
//            } else {
//                self.isRecording = false
//                print("録画を停止しました")
//            }
//        })
//    }
//}
//
//struct RecordView: View {
//    @ObservedObject private var recorder = ScreenRecorder()
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                if self.recorder.isRecording {
//                    self.recorder.stopRecording()
//                } else {
//                    self.recorder.startRecording()
//                }
//            }) {
//                Text(recorder.isRecording ? "録画停止" : "録画開始")
//            }
//        }.frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//}
//
//struct RecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordView().environmentObject(ScreenRecorder())
//    }
//}
