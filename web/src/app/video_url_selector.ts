"use client"

import { selectorFamily } from 'recoil';
import { getVideoUrl } from './api/get_video_url';

export const videoUrlSelector = selectorFamily({
  key: 'videoUrl',
  get: (fileName: string) => async () => await getVideoUrl(fileName)
});
