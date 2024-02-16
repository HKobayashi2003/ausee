'use client'

import React from 'react';
import { useRecoilValueLoadable } from 'recoil';
import { videoUrlSelector } from './video_url_selector';

export default function VideoPlayer({ fileName }: { fileName: string }) {
    const videoUrlLoadable = useRecoilValueLoadable(videoUrlSelector(fileName));

    switch (videoUrlLoadable.state) {
        case 'hasValue':
            return <video src={videoUrlLoadable.contents} controls width="100%" />;
        case 'loading':
            return <div>Loading...</div>;
        case 'hasError':
            // エラーを表示する
            console.error(videoUrlLoadable.contents);
            return <div>Error: {videoUrlLoadable.contents.message}</div>;
    }
};

