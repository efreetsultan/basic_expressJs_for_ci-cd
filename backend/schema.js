const { Pool } = require('pg');
const AWS = require('aws-sdk');

<<<<<<< HEAD
=======
const pool = new Pool();

>>>>>>> 40d89e2f26e53ec3c65dce27da44d3b8f9f13bdf
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
<<<<<<< HEAD
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
=======
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
>>>>>>> 40d89e2f26e53ec3c65dce27da44d3b8f9f13bdf
  } catch (error) {
    console.error('Error creating schema:', error);
  }
}

module.exports = createSchema;
<<<<<<< HEAD
=======

>>>>>>> 40d89e2f26e53ec3c65dce27da44d3b8f9f13bdf
