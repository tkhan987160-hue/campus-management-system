const express = require("express");
const mongoose = require("mongoose");
require("dotenv").config();
const cors = require("cors");
const User = require("./models/User");
const app = express();
const PORT = process.env.PORT || 5000;

// 🔹 CORS (Flutter Web ke liye MOST IMPORTANT)
app.use(cors({
  origin: "*", // abhi dev ke liye allow all
  methods: ["GET", "POST", "PUT", "DELETE"],
  allowedHeaders: ["Content-Type", "Authorization"],
}));

app.use(express.json());

// ✅ ADMIN: get all students
app.get("/api/students", async (req, res) => {
  try {
    const students = await User.find(
      { role: "student" },
      { rollNumber: 1, name: 1 }
    ).sort({ rollNumber: 1 });

    res.json(students);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 🔹 Routes
const authRoutes = require("./routes/authRoutes");
app.use("/api/auth", authRoutes);

const attendanceRoutes = require("./routes/attendanceRoutes");
app.use("/api/attendance", attendanceRoutes);

const assignmentRoutes = require("./routes/assignmentRoutes");
app.use("/api/assignment", assignmentRoutes);

const complaintRoutes = require("./routes/complaintRoutes");
app.use("/api/complaint", complaintRoutes);

// 🔹 MongoDB
mongoose.connect(process.env.MONGO_URI).then(() => {
  console.log("MongoDB connected");
}).catch((err) => {
  console.log("DB connection error:", err);
});

// 🔹 Server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});