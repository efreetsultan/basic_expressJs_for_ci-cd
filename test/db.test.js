const { Pool } = require('pg');

const poolConfig = {
  user: DB_USERNAME,
  password: DB_PASSWORD,
  host: DB_HOST,
  database: DB_DATABASE,
  port: 5432,
};

async function testDatabaseConnection() {
  const pool = new Pool(poolConfig);

  try {
    const client = await pool.connect();
    const result = await client.query('SELECT NOW()');
    console.log('Connection test successful:', result.rows[0].now);
  } catch (error) {
    console.error('Error testing database connection:', error);
  } finally {
    pool.end(); // Release the pool
  }
}

testDatabaseConnection();
