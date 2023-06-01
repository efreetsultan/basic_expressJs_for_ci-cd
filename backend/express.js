const express = require('express');
const app = express();
const { Pool } = require('pg');
const AWS = require('aws-sdk');
const createSchema = require('./schema');
const cors = require('cors');

AWS.config.update({ region: 'eu-west-2' });

app.use(express.json());
app.use(
  cors({
    origin: 'http://abucketforreact.s3-website.eu-west-2.amazonaws.com'
  })
);

app.get('/', (req, res) => {
  res.send('Backend seems to be working like a charm!');
});

app.get('/api/data', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM data');
    const data = result.rows;
    res.status(200).json(data);
  } catch (error) {
    console.error('Error fetching data:', error);
    res.status(500).json({ error: 'An error occurred while fetching data' });
  }
});

app.post('/api/save-data', async (req, res) => {
  const { inputValue } = req.body;

  try {
    const secretsManager = new AWS.SecretsManager();
    const secretData = await secretsManager.getSecretValue({ SecretId: 'aurora-db-credentials' }).promise();
    const { DB_USERNAME, DB_PASSWORD, DB_HOST, DB_DATABASE } = JSON.parse(secretData.SecretString);

    const poolConfig = {
      user: DB_USERNAME,
      password: DB_PASSWORD,
      host: DB_HOST,
      database: DB_DATABASE,
      port: 5432,
    };

    const pool = new Pool(poolConfig);
    const result = await pool.query('INSERT INTO data (input_value) VALUES ($1) RETURNING id', [inputValue]);

    const insertedId = result.rows[0].id;

    res.status(201).json({ id: insertedId });
  } catch (error) {
    console.error('Error saving data:', error);
    res.status(500).json({ error: 'An error occurred while saving the data' });
  }
});

createSchema();

app.listen(3003, () => {
  console.log('Server is running on port 3003');
});
