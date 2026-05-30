const express = require("express");
const router = express.Router();


router.post("/login", (req, res) => {
  const { username, role } = req.body;
  if (!username || !role) {
    return res.status(400).json({ error: "username and role are required" });
  }
  const userId = Date.now().toString();
 
  return res.json({ userId, username, role });
});

module.exports = router;
