const express = require("express");
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send("Hello Jenkins, my main man!");
});

app.listen(port, () => {
  console.log(`My app listening at http://localhost:${port}`);
});