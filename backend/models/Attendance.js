const mongoose = require('mongoose');

const attendanceSchema = new mongoose.Schema(
  {
    rollNumber: {
      type: String,
      required: true,
      trim: true,
    },

    subject: {
      type: String,
      required: true,
    },

    date: {
      type: String, // YYYY-MM-DD
      required: true,
    },

    status: {
      type: String,
      enum: ['present', 'absent', 'leave'],
      required: true,
    },
  },
  { timestamps: true }
);

// 🔒 prevent duplicate attendance (same student, subject, same day)
attendanceSchema.index(
  { rollNumber: 1, subject: 1, date: 1 },
  { unique: true }
);

module.exports = mongoose.model('Attendance', attendanceSchema);