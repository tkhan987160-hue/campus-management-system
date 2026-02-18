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
    const { studentId, subject, date, status } = req.body;

    if (!studentId || !subject || !date || !status) {
      return res.status(400).json({ message: 'All fields are required' });
    }

    const statusMap = {
      P: 'present',
      A: 'absent',
      L: 'leave',
    };

    const normalizedStatus = statusMap[status] || status;

    const existing = await Attendance.findOne({
      studentId,
      subject,
      date,
    });

    if (existing) {
      existing.status = normalizedStatus;
      await existing.save();
      return res.json({ message: 'Attendance updated' });
    }

    const attendance = new Attendance({
      studentId,
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
router.get('/stats/:studentId', async (req, res) => {
  try {
    const studentId = new mongoose.types.objectId(req.params.studentId);

    const total = await Attendance.countDocuments({ studentId });
    const present = await Attendance.countDocuments({
      studentId,
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
router.get('/subject-wise/:studentId', async (req, res) => {
  try {
    const studentId = req.params.studentId;

    const data = await Attendance.aggregate([
      { $match: { studentId: studentId } },
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
router.get('/:studentId', async (req, res) => {
  try {
    const records = await Attendance.find({
      studentId: req.params.studentId,
    }).sort({ date: -1 });

    res.json(records);
  } catch (err) {
    res.status(500).json({ error: 'Something went wrong' });
  }
});

module.exports = router;