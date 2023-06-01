import React, { useState, useEffect } from 'react';

function App() {
  const [inputValue, setInputValue] = useState('');
  const [responseData, setResponseData] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    setError('');

    try {
      const response = await fetch('/api/save-data', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ inputValue }),
      });

      if (!response.ok) {
        throw new Error('Error saving data');
      }

      const data = await response.json();
      setResponseData(data.id);
    } catch (error) {
      setError('An error occurred while saving data');
    } finally {
      setIsLoading(false);
    }
  };

  const fetchData = async () => {
    try {
      const response = await fetch('/api/data');
      if (!response.ok) {
        throw new Error('Error fetching data');
      }
      const data = await response.json();
      setResponseData(data);
    } catch (error) {
      setError('An error occurred while fetching data');
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <div>
      <h1>Basic_Express_For_CI-CD</h1>
      <form onSubmit={handleSubmit}>
        <label>
          Input:
          <input
            type="text"
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
          />
        </label>
        <button type="submit" disabled={isLoading}>
          {isLoading ? 'Loading...' : 'Submit'}
        </button>
      </form>

      {error && <p>{error}</p>}
      {responseData && (
        <div>
          <p>Response: {responseData}</p>
          <button onClick={fetchData}>Fetch Data</button>
          <ul>
            {responseData.map((item) => (
              <li key={item.id}>{item.input_value}</li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

export default App;
