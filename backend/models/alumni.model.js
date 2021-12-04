const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const Alumni = Schema({
  username: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  fullname: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  ugDept: {
    type: String,
    required: false,
    default: ""
  },
  pgYear: {
    type: String,
    required: false,
    default: ""
  },
  ugYear: {
    type: String,
    required: false,
    default: ""
  },
  city: {
    type: String,
    required: false,
    default: ""
  },
  company: {
    type: String,
    required: false,
    default: ""
  },
  linkedIN: {
    type: String,
    required: false,
    default: ""
  },
  qualificationExam: {
    type: Map,
    required: false,
    default: {
      "name":"",
      "year":"",
      "score":""
    }
  },
  pgCourse:{
    type: Map,
    required: false,
    default:{
      "name":"",
      "duration":""
    }
  },
  internships: {
    type: Array,
    required: false,
    default:[]
  },
  scholarships: {
    type: Array,
    required: false,
    default:[]
  },
  university: {
    type : Map,
    required: false,
    default: {
      "name":"",
      "location":""
    }
  },

});

module.exports = mongoose.model("Alumni", Alumni);