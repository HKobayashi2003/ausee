import { selectorFamily } from 'recoil';
import { Storage } from '@google-cloud/storage';

// Google Cloud Storageの初期化
const storage = new Storage({ keyFilename: 'src/api/ausee-414122-320a5415d1d6.json' });
const bucketName = 'ausee-video';

export const videoUrlSelector = selectorFamily<string, string>({
  key: 'videoUrl',
  
  get: (fileName) => async () => {
    try {
      const [url] = await storage.bucket(bucketName).file('videos'+fileName).getSignedUrl({
        action: 'read',
        expires: Date.now() + 1000 * 60 * 60, // 1時間後の期限
      });
      return url;
    } catch (error) {
      console.error(error);
      throw error;
    }
  },
});
