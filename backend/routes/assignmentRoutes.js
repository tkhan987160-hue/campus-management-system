const express = require('express');
const Assignment = require('../models/Assignment');
const router = express.Router();
const auth = require('../middleware/authMiddleware');

//add assignment//
router.post('/add', auth, async(req, res) => {
    const {
        studentId, subject, title, dueDate
    } = req.body;
    const assignment = new Assignment({
        studentId, subject, title, dueDate
    });
    await assignment.save();
    res.status(201).json({
        message: 'Assignment added!'
    });
});

// get all assignment for student //
router.get('/:studentId',
    async(req, res) => {
        const assignments = await Assignment.find({
            studentId: req.params.studentId
        });
        res.json(assignments);
    }
);

// Update assignment status
router.put('/update/:id', auth, async (req, res) => {
  const { status } = req.body;
  const assignment = await Assignment.findByIdAndUpdate(
    req.params.id,
    { status },
    { new: true }
  );
  res.json({ message: 'Assignment updated!', assignment });
});

// Delete assignment
router.delete('/delete/:id',auth, async (req, res) => {
  await Assignment.findByIdAndDelete(req.params.id);
  res.json({ message: 'Assignment deleted!' });
});

module.exports = router;