import express from 'express';
import dotenv from 'dotenv';
dotenv.config();

const app = express();
const port = 3000;
const BASE_URL = process.env.BASE_URL


app.use(express.json());

app.get('/api/data', (req, res) => {
  res.json({ message: 'Hello from TypeScript backend!' });
});

app.listen(port, () => {
  console.log(`Server running at ${BASE_URL}:${port}`);
});
