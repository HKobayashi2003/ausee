'use client'

import Link from "next/link";
import VideoPlayer from "@/app/view/[path]/video_player";
import CopyToClipboardButton from "@/ui/clipboard_copy_button";

export default function MyApp() {
    const list = [
        { name: '4K海岸', path: '/view/184069(Original).mp4' },
        { name: 'そよ風', path: '/view/samplemov' },
    ]
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
                    </li>
                ))}
            </ul>
        </div>
    );
}