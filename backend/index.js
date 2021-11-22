const express = require("express");
const mongoose = require("mongoose");
const port = process.env.PORT || 5000;
const app = express();

mongoose.connect(
  "mongodb+srv://users:usersmtp@cluster0.m2h8j.mongodb.net/MS_Profiles_Tracker?retryWrites=true&w=majority",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  }
);

const connection = mongoose.connection;
connection.once("open", () => {
  console.log("MongoDb connected");
});

//middleware
app.use("/uploads", express.static("uploads"));
app.use(express.json());
const alumniRoute = require("./routes/alumni");
app.use("/alumni", alumniRoute);
const studentRoute = require("./routes/student");
app.use("/student",studentRoute);

data = {
  msg: "Welcome to MS Profiles Tracker",
  info: "This is a root endpoint",
  Working: "",
  request:
    "",
};

app.route("/").get((req, res) => res.json(data));

app.listen(port, "0.0.0.0", () =>
  console.log(`welcome your listening at port ${port}`)
);