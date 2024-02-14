import { selectorFamily } from 'recoil';

export const videoUrlSelector = selectorFamily({
  key: 'videoUrl',
  get: (fileName: string) => async () => {
    try {
      const response = await fetch(`/api/getVideoUrl?fileName=${fileName}`);
      const data = await response.json();
      return data.url as string;
    } catch (error) {
      console.error(error);
      throw error;
    }
  },
});
