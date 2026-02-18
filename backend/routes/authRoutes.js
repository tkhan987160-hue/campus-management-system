const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

const router = express.Router();

/* =========================
   REGISTER (STUDENT)
========================= */
router.post('/register', async (req, res) => {
  const { rollNumber, name, password } = req.body;

  if (!rollNumber || !name || !password) {
    return res.status(400).json({
      message: 'All fields are required',
    });
  }

  try {
    // 🔒 check duplicate roll number
    const existingUser = await User.findOne({ rollNumber });
    if (existingUser) {
      return res.status(400).json({
        message: 'Roll number already registered',
      });
    }

    // 🔐 hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // 💾 save student
    const newUser = new User({
      rollNumber,
      name,
      password: hashedPassword,
      role: 'student',
    });

    await newUser.save();

    res.status(201).json({
      message: 'Student registered successfully',
    });
  } catch (err) {
    res.status(500).json({
      message: 'Registration failed',
      error: err.message,
    });
  }
});

/* =========================
   LOGIN (STUDENT / ADMIN)
========================= */
router.post('/login', async (req, res) => {
  const { rollNumber, password } = req.body;

  if (!rollNumber || !password) {
    return res.status(400).json({
      message: 'Roll number and password are required',
    });
  }

  try {
    const foundUser = await User.findOne({ rollNumber });
    if (!foundUser) {
      return res.status(401).json({
        message: 'Invalid roll number or password',
      });
    }

    const isMatch = await bcrypt.compare(password, foundUser.password);
    if (!isMatch) {
      return res.status(401).json({
        message: 'Invalid roll number or password',
      });
    }

    // 🔑 JWT
    const token = jwt.sign(
      {
        userId: foundUser._id,
        role: foundUser.role,
        rollNumber: foundUser.rollNumber,
      },
      'mySuperSecretKey@123',
      { expiresIn: '24h' }
    );

    res.json({
      message: 'Login success',
      token,
      role: foundUser.role,
      rollNumber: foundUser.rollNumber,
      name: foundUser.name,
    });
  } catch (err) {
    res.status(500).json({
      message: 'Login failed',
      error: err.message,
    });
  }
});

module.exports = router;