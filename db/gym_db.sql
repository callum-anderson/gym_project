DROP TABLE IF EXISTS gym_instructors;
DROP TABLE IF EXISTS gym_bookings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS gym_classes;

CREATE TABLE gym_classes(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  capacity INT4 NOT NULL
);
CREATE TABLE members(
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  age INT4 NOT NULL,
  contact_number VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL
);
CREATE TABLE gym_bookings(
  id SERIAL4 PRIMARY KEY,
  gym_class_id INT4 REFERENCES gym_classes(id) ON DELETE CASCADE,
  member_id INT4 REFERENCES members(id) ON DELETE CASCADE
);
CREATE TABLE gym_instructors(
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  gym_class_id INT4 REFERENCES gym_classes(id) ON DELETE CASCADE
);
