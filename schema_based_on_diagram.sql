CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  date_of_birth DATE
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(40)
);