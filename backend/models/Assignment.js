const mongoose = require('mongoose');
const assignmentSchema = new mongoose.Schema({
    studentId: {
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'user',
        rerquired: true
    },
    subject: {
        type: String, required: true
    },title: {
        type: String, required: true
    },
    dueDate: {
        type: Date, required: true
    },
    status: {
        type: String, enum: ['pending','submitted'], default: 'pending'
    }
});

module.exports = mongoose.model('assignment',assignmentSchema);