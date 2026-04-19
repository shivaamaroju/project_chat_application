const express = require("express");
const router = express.Router();

// Change "/" to "/health" so it doesn't block your React UI
router.get("/health", (req, res) => {
  res.status(200).send({ response: "Server is up and running." });
});

module.exports = router;
