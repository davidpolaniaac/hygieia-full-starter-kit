use analyticsdb;

db.createUser({
  user: "analyticsuser",
  pwd: "analyticspass",
  "roles": [
    {
      "role": "readWrite",
      "db": "analyticsdb"
    }
  ]
});

use dashboarddb;

db.createUser({
  user: "dashboarduser",
  pwd: "dbpassword",
  "roles": [
    {
      "role": "readWrite",
      "db": "dashboarddb"
    }
  ]
});