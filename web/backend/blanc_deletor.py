from moviepy.editor import VideoFileClip, concatenate_videoclips
from pydub import AudioSegment, silence
from gcs import download_blob, upload_blob


def extract_audio(video_path):
    video = VideoFileClip(video_path)
    audio_path = video_path.replace(
        ".mp4", "_audio.mp3"
    )  # 生成される音声ファイルのパス
    video.audio.write_audiofile(audio_path)
    return audio_path


def detect_non_silent_parts(audio_path):
    audio = AudioSegment.from_file(audio_path)
    non_silent_parts = silence.detect_nonsilent(
        audio,
        min_silence_len=1000,  # 無言と判断する最小の長さ（ミリ秒）
        silence_thresh=-40,  # 無言の閾値(dB)
    )
    return non_silent_parts  # 形式: [(start1, end1), (start2, end2), ...]


def create_video_without_silence(video_path, non_silent_parts):
    video = VideoFileClip(video_path)
    clips = [
        video.subclip(start / 1000.0, end / 1000.0) for start, end in non_silent_parts
    ]  # pydubはミリ秒単位、moviepyは秒単位
    final_clip = concatenate_videoclips(clips)
    output_path = video_path.replace(".mp4", "_without_silence.mp4")
    final_clip.write_videofile(output_path, codec="libx264", audio_codec="aac")
    return output_path


def remove_silence_from_video(video_path):
    # ステップ 1: 音声の抽出
    audio_path = extract_audio(video_path)

    # ステップ 2: 無言部分の検出
    non_silent_parts = detect_non_silent_parts(audio_path)

    # ステップ 3: 無言でない部分のみの動画を生成
    output_path = create_video_without_silence(video_path, non_silent_parts)

    return output_path


def process_video_on_gcs(bucket_name, source_blob_name, destination_blob_name):
    temp_download_path = "/tmp/temp_video.mp4"

    # GCSから動画をダウンロード
    download_blob(bucket_name, source_blob_name, temp_download_path)

    # 動画から無言部分を削除
    processed_file_path = remove_silence_from_video(temp_download_path)

    # 加工後の動画をGCSにアップロード
    upload_blob(bucket_name, processed_file_path, destination_blob_name)
