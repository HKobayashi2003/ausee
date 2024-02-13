import { RecoilRoot } from "recoil";
import VideoPlayer from "@/app/video_player";

export default function Root() {
    return (
        <RecoilRoot>
            <MyApp />
        </RecoilRoot>
    );
}

function MyApp() {
    return (
        <div>
            <h1>動画再生</h1>
            <VideoPlayer fileName="ausee-video/videos/mov_hts-samp003 (online-video-cutter.com).mp4" />
        </div>
    );
}