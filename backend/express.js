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
    origin: 'http://abucketforreact.s3-website.eu-west-2.amazonaws.com',
  })
);

async function getSecretValue(secretId) {
  const secretsManager = new AWS.SecretsManager();
  const secretData = await secretsManager.getSecretValue({ SecretId: secretId }).promise();
  return JSON.parse(secretData.SecretString);
}

async function initializePool() {
  const secretData = await getSecretValue('aurora-db-credentials');
  const { DB_USERNAME, DB_PASSWORD, DB_HOST, DB_DATABASE, DB_PORT } = secretData;

  const poolConfig = {
    user: DB_USERNAME,
    password: DB_PASSWORD,
    host: DB_HOST,
    database: DB_DATABASE,
    port: DB_PORT,
  };

  return new Pool(poolConfig);
}

app.get('/', (req, res) => {
  res.send('Backend seems to be working like a charm!');
});

app.get('/api/data', async (req, res) => {
  try {
    const pool = await initializePool();
    const result = await pool.query('SELECT * FROM data');
    const data = result.rows;
    pool.end();
    res.status(200).json(data);
  } catch (error) {
    console.error('Error fetching data:', error);
    res.status(500).json({ error: 'An error occurred while fetching data' });
  }
});

app.post('/api/save-data', async (req, res) => {
  const { inputValue } = req.body;

  try {
    const pool = await initializePool();
    const result = await pool.query('INSERT INTO data (input_value) VALUES ($1) RETURNING id', [inputValue]);
    const insertedId = result.rows[0].id;
    pool.end();
    res.status(201).json({ id: insertedId });
  } catch (error) {
    console.error('Error saving data:', error);
    res.status(500).json({ error: 'An error occurred while saving the data' });
  }
});

app.delete('/api/delete-data', async (req, res) => {
  const { inputValue } = req.body;

  try {
    const pool = await initializePool();
    const result = await pool.query('DELETE FROM data WHERE input_value = $1', [inputValue]);
    const rowCount = result.rowCount;
    pool.end();

    if (rowCount > 0) {
      res.status(200).json({ message: 'Record deleted successfully' });
    } else {
      res.status(404).json({ message: 'Record not found' });
    }
  } catch (error) {
    console.error('Error deleting data:', error);
    res.status(500).json({ error: 'An error occurred while deleting the data' });
  }
});

createSchema();

app.listen(3003, () => {
  console.log('Server is running on port 3003');
});
