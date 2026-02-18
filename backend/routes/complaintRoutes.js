const express = require('express');
const Complaint = require('../models/Complaint');
const router = express.Router();
const auth = require('../middleware/authMiddleware');

// Add complaint
router.post('/add', auth, async (req, res) => {
  const { studentId, subject, message } = req.body;
  const complaint = new Complaint({ studentId, subject, message });
  await complaint.save();
  res.status(201).json({ message: 'Complaint registered!' });
});

// Get all complaints by student
router.get('/:studentId', async (req, res) => {
  const complaints = await Complaint.find({ studentId: req.params.studentId });
  res.json(complaints);
});

// Update complaint status
router.put('/resolve/:id', auth, async (req, res) => {
  const complaint = await Complaint.findByIdAndUpdate(
    req.params.id,
    { status: 'resolved' },
    { new: true }
  );
  res.json({ message: 'Complaint resolved!', complaint });
});

// Delete complaint
router.delete('/delete/:id', auth, async (req, res) => {
  await Complaint.findByIdAndDelete(req.params.id);
  res.json({ message: 'Complaint deleted!' });
});

module.exports = router;
