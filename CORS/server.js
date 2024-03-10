const express = require("express");
const cors = require("cors");
const cookieParser = require("cookie-parser");

const app = express();

// List of allowed origins
const allowedOrigins = [
  "https://example.com",
  "https://tricksumo.com",
  "http://localhost:4000",
  "http://127.0.0.1:5500",
  "http://localhost:5500",
];

// CORS middleware
const corsOptions = {
  origin: allowedOrigins, // Pass the list of domains
  methods: ["GET", "POST"], // Allow only GET and POST methods
  allowedHeaders: ["Content-Type", "Authorization", "X-Custom-Header"], // Allow only these headers
  credentials: true, // Allow credentials (cookies) to be sent,
  maxAge: 10,
};

// Enable CORS with the options
app.use(cors(corsOptions));

// Use cookie-parser middleware
app.use(cookieParser());

// Define a simple route
app.get("/", (req, res) => {
  console.log("Cookies:", req.cookies, req.cookies["sss"]);
  res.send({ data: "Hello, World!" });
});

// Listen on port 3000
app.listen(3000, () => {
  console.log("Server running on port 3000");
});

// document.cookie = 'cookieName=cookieValue; path=/; SameSite=Lax;';
// "C:\Program Files\Google\Chrome\Application\chrome.exe" --disable-web-security --disable-gpu --user-data-dir=~/chromeTemp
