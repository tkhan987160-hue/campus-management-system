const express = require('express');
const Attendance = require('../models/Attendance');
const router = express.Router();
const auth = require('../middleware/authMiddleware');
const mongoose = require('mongoose');

/* ============================
   MARK ATTENDANCE (ADMIN)
============================ */
router.post('/mark', auth, async (req, res) => {
  try {
    const {subject, date, status } = req.body;

    if (!subject || !date || !status) {
      return res.status(400).json({ message: 'All fields are required' });
    }

    const statusMap = {
      P: 'present',
      A: 'absent',
      L: 'leave',
    };

    const normalizedStatus = statusMap[status] || status;

    const existing = await Attendance.findOne({
      rollNumber: req.user.rollNumber,
      subject,
      date,
    });

    if (existing) {
      existing.status = normalizedStatus;
      await existing.save();
      return res.json({ message: 'Attendance updated' });
    }

    const attendance = new Attendance({
      rollNumber: req.user.rollNumber,
      subject,
      date,
      status: normalizedStatus,
    });

    await attendance.save();

    res.json({ message: 'Attendance marked successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

/* ============================
   ATTENDANCE STATS (STUDENT)
============================ */
router.get('/stats', auth, async (req, res) => {
  try {
    const rollNumber = req.user.rollNumber;

    const total = await Attendance.countDocuments({ rollNumber });
    const present = await Attendance.countDocuments({
      rollNumber,
      status: 'present',
    });

    const percentage =
      total === 0 ? 0 : ((present / total) * 100).toFixed(2);

    res.json({
      totalClasses: total,
      presentClasses: present,
      attendancePercentage: Number(percentage),
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

/* ============================
   SUBJECT-WISE ATTENDANCE
============================ */
router.get('/subject-wise', auth, async (req, res) => {
  try {
    const rollNumber = req.user.rollNumber;

    const data = await Attendance.aggregate([
      { $match: { rollNumber } },
      {
        $group: {
          _id: '$subject',
          total: { $sum: 1 },
          present: {
            $sum: {
              $cond: [{ $eq: ['$status', 'present'] }, 1, 0],
            },
          },
        },
      },
      {
        $project: {
          subject: '$_id',
          total: 1,
          present: 1,
          _id: 0,
        },
      },
    ]);

    res.json(data);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

/* ============================
   ALL ATTENDANCE RECORDS
============================ */
router.get('/', auth, async (req, res) => {
  try {
    const records = await Attendance.find({
      rollNumber: req.user.rollNumber,
    }).sort({ date: -1 });

    res.json(records);
  } catch (err) {
    res.status(500).json({ error: 'Something went wrong' });
  }
});

module.exports = router;