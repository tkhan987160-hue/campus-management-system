const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  rollNumber: {
    type: String,
    required: true,
    unique: true,   // 🔥 UNIQUE roll number
    trim: true
  },

  name: {
    type: String,
    required: true,
    trim: true
  },

  password: {
    type: String,
    required: true
  },

  role: {
    type: String,
    enum: ['student', 'admin'],
    default: 'student'
  },

  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('User', userSchema);