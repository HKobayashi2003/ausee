'use client'

import Link from "next/link";
import VideoPlayer from "@/app/view/[path]/video_player";
import CopyToClipboardButton from "@/ui/clipboard_copy_button";
import { useVideoEditor } from "@/app/gateway/video_editor";
import { FiGift } from "react-icons/fi";

// 次からこういうプルリクは承認したら、マージせずにプルリクを消去してください。
export default function MyApp() {
    const list = [
        { name: '4K海岸', path: '/view/184069(Original).mp4' },
        { name: 'そよ風', path: '/view/samplemov' },
    ]
    const { loading, error, postRequest } = useVideoEditor();
    return (
        <div className="p-6">
            <h1>動画一覧</h1>
            <ul>
                {list.map((item, index) => (
                    <li key={index} className="p-6">
                        <Link href={item.path} className="text-3xl linkStyle">
                            {item.name}
                        </Link>
                        <CopyToClipboardButton content={'http://localhost:3000/' + item.path} message="クリップボードにリンクをコピーしました" />
                        <button onClick={() => postRequest(item.path, { cutSilence: true })} className="color:white"><FiGift /></button>
                    </li>
                ))}
            </ul>
        </div>
    );
}