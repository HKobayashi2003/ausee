"use client"

import { getVideoUrl } from '@/app/api/get_video_url';
import { selectorFamily } from 'recoil';

export const videoUrlSelector = selectorFamily({
  key: 'videoUrl',
  get: (fileName: string) => async () => await getVideoUrl(fileName)
});
