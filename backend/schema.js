const { Pool } = require('pg');
const AWS = require('aws-sdk');

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
    const { DB_USERNAME, DB_PASSWORD, DB_HOST, DB_DATABASE, DB_PORT } = await getSecretValue('aurora-db-credentials');

    const poolConfig = {
      user: DB_USERNAME,
      password: DB_PASSWORD,
      host: DB_HOST,
      database: DB_DATABASE,
      port: DB_PORT,
    };

    const pool = new Pool(poolConfig);
    const client = await pool.connect();
    await client.query(createSchemaQuery);
    console.log('Schema created successfully!');
    client.release();
    pool.end();
  } catch (error) {
    console.error('Error creating schema:', error);
  }
}

module.exports = createSchema;
