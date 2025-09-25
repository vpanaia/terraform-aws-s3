import "dotenv/config";
import express from "express";
import cors from "cors";
import { S3Client, ListObjectsV2Command } from "@aws-sdk/client-s3";

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.static("public"));

const {
  PORT = 3000,
  BUCKET_NAME,
  S3_ENDPOINT = "http://localhost:4566",
  AWS_REGION = "us-east-1",
  AWS_ACCESS_KEY_ID = "test",
  AWS_SECRET_ACCESS_KEY = "test",
  FORCE_PATH_STYLE = true,
} = process.env;

if (!BUCKET_NAME) {
    console.error('Missing Bucket name')
    process.exit(1)
}

const s3 = new S3Client({
  region: AWS_REGION,
  endpoint: S3_ENDPOINT,
  forcePathStyle: FORCE_PATH_STYLE === 'true',
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID || 'test',
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY || 'test'
  }
});

app.get('/api/files', async (req, res) => {
  try {
    const prefix = req.query.prefix || ''; 
    const cmd = new ListObjectsV2Command({ Bucket: BUCKET_NAME, Prefix: prefix });
    const out = await s3.send(cmd);

    const files = (out.Contents || []).map(o => ({
      key: o.Key,
      size: o.Size,
      lastModified: o.LastModified
    }));

    res.json({ bucket: BUCKET_NAME, count: files.length, files });
  } catch (err) {
    console.error('Errore ListObjects:', err);
    res.status(500).json({ error: 'ListObjects failed', detail: String(err) });
  }
});

app.listen(PORT, () => {
  console.log(`S3 JS service su http://localhost:${PORT} (bucket: ${BUCKET_NAME})`);
});
