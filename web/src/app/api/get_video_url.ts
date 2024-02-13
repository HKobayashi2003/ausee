'use server';
import { Storage } from '@google-cloud/storage';
import { NextApiRequest, NextApiResponse } from 'next';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'GET') {
    try {
      const fileName = req.query.fileName; // クエリパラメータからファイル名を取得
      const storage = new Storage({ keyFilename: 'path/to/your/keyfile.json' });
      const bucketName = 'ausee-video';
      const [url] = await storage.bucket(bucketName).file('videos/'+fileName).getSignedUrl({
        action: 'read',
        expires: Date.now() + 1000 * 60 * 60, // 1時間後の期限
      });

      res.status(200).json({ url });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'サーバーエラーが発生しました' });
    }
  } else {
    res.setHeader('Allow', ['GET']);
    res.status(405).end(`Method ${req.method} Not Allowed`);
  }
}
