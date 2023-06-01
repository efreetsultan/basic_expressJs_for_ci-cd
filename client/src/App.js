import React, { useState } from 'react';

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
      const response = await fetch('http://localhost:3000/');
      if (!response.ok) {
        throw new Error('Error fetching data');
      }

      const data = await response.text();
      setResponseData(data);
    } catch (error) {
      setError('An error occurred. Please try again later.');
    } finally {
      setIsLoading(false);
    }
  };

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
      {responseData && <p>Response: {responseData}</p>}
    </div>
  );
}

export default App;
