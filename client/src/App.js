import React, { useState, useEffect } from 'react';

function App() {
  const [inputValue, setInputValue] = useState('');
  const [responseData, setResponseData] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    setError('');

    try {
      const response = await fetch(`${process.env.EXT_IP}:80/api/save-data`, {
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
      setResponseData([...responseData, { id: data.id, input_value: inputValue }]);
      setInputValue('');
    } catch (error) {
      setError('An error occurred while saving data');
    } finally {
      setIsLoading(false);
    }
  };

  const handleDelete = async () => {
    setIsLoading(true);
    setError('');

    try {
      const response = await fetch(`${process.env.EXT_IP}:80/api/delete-data`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ inputValue }),
      });

      if (!response.ok) {
        throw new Error('Error deleting data');
      }

      // const data = await response.json();
      if (response.status === 200) {
        setResponseData(responseData.filter((item) => item.input_value !== inputValue));
        setInputValue('');
      }
    } catch (error) {
      setError('An error occurred while deleting data');
    } finally {
      setIsLoading(false);
    }
  };

  const fetchData = async () => {
    try {
      const response = await fetch(`${process.env.EXT_IP}:80/api/data`);
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
        <button onClick={handleDelete} disabled={isLoading}>
          {isLoading ? 'Deleting...' : 'Delete'}
        </button>
      </form>

      {error && <p>{error}</p>}
      <div>
        <button onClick={fetchData}>List Database Elements</button>
        <ul>
          {responseData.map((item) => (
            <li key={item.id}>{item.input_value}</li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default App;
