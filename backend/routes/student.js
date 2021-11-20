const express = require("express");
const Student = require("../models/student.model");
const config = require("../config");
const jwt = require("jsonwebtoken");
let middleware = require("../middleware");
const router = express.Router();

router.route("/:username").get(middleware.checkToken, (req, res) => {
  Student.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
});

router.route("/checkusername/:username").get((req, res) => {
  Student.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result !== null) {
      return res.json({
        Status: true,
      });
    } else
      return res.json({
        Status: false,
      });
  });
});

router.route("/login").post((req, res) => {
  Student.findOne({ username: req.body.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result === null) {
      return res.status(403).json({
        token:"",
        msg:"Username incorrect"});
    }
    if (result.password === req.body.password) {
      // here we implement the JWT token functionality
      let token = jwt.sign({ username: req.body.username }, config.key, {});

      res.json({
        token: token,
        msg: "success",
      });
    } else {
      res.status(403).json({
        token:"",
        msg:"password is incorrect"});
    }
  });
});

router.route("/register").post((req, res) => {
  console.log("inside the register");
  const student = new Student({
    username: req.body.username,
    name: req.body.name,
    password: req.body.password,
    email: req.body.email
  });
  student
    .save()
    .then(() => {
      console.log("user registered");
      res.status(200).json({ msg: "Successfully Registered" });
    })
    .catch((err) => {
      res.status(403).json({ msg: err });
    });
});

router.route("/update/:username").patch((req, res) => {
  console.log(req.params.username);
  Student.findOneAndUpdate(
    { username: req.params.username },
    { $set: { password: req.body.password } },
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: "password successfully updated",
        username: req.params.username,
      };
      return res.json(msg);
    }
  );
});

router.route("/delete/:username").delete(middleware.checkToken, (req, res) => {
  Student.findOneAndDelete({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    const msg = {
      msg: "User deleted",
      username: req.params.username,
    };
    return res.json(msg);
  });
});

module.exports = router;