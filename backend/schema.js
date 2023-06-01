const { Pool } = require('pg');
const AWS = require('aws-sdk');

const pool = new Pool();

async function getSecretValue(secretId) {
  const secretsManager = new AWS.SecretsManager();
  const secretData = await secretsManager.getSecretValue({ SecretId: secretId }).promise();
  return JSON.parse(secretData.SecretString);
}

const createSchemaQuery = `
  CREATE TABLE IF NOT EXISTS data (
    id SERIAL PRIMARY KEY,
    input_value VARCHAR(255)
  );
`;

async function createSchema() {
  try {
    const { DB_HOST, DB_PORT, DB_NAME, DB_USERNAME, DB_PASSWORD } = await getSecretValue('aurora-db-credentials');

    const poolConfig = {
      host: DB_HOST,
      port: DB_PORT,
      database: DB_NAME,
      user: DB_USERNAME,
      password: DB_PASSWORD,
    };

    const client = await pool.connect(poolConfig);
    await client.query(createSchemaQuery);
    console.log('Schema created successfully!');
    client.release();
  } catch (error) {
    console.error('Error creating schema:', error);
  }
}

module.exports = createSchema;

