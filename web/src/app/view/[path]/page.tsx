import VideoPlayer from "@/app/view/[path]/video_player";

export default function Page({ params }: { params: { path: string } }) {
    console.log(params);
    return (
        <div>
            <h1>動画再生</h1>
            <VideoPlayer fileName={params.path} />
        </div>
    );
}