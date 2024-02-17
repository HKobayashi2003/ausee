'use server'

import { Storage } from '@google-cloud/storage';

export async function getVideoUrl(fileName: string) {
  try {
    const storage = new Storage({ keyFilename: 'src/app/api/ausee-414122-320a5415d1d6.json' });
    const bucketName = 'ausee-video';
    const [url] = await storage.bucket(bucketName).file('videos/'+fileName).getSignedUrl({
      action: 'read',
      expires: Date.now() + 1000 * 60 * 60, // 1時間後の期限
    });
    return url;
  } catch (error) {
    console.error(error);
    throw error;
  }
}


