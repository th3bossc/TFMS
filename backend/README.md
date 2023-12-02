# TFMS BACKEND
Traffic Fine ManageMent System (TFMS) is fine management system created as part of DBMS S6 course

## TABLE OF CONTENTS
- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Resources](#resources)
- [Authors](#authors)


## Overview
    - The backend has been built using django and django-rest-framework
    - The project aims to a simple implementation of a Traffic Fine Management System that provides the features as given below
    - The project offers a separate UI for the user and the admin, with proper authentication and permissions
    - Authentication is done using JWTs

## Features
    - The admin is able to modify all the tables in the database according to his wish 
    - The user is only able to access the database via api calls with proper authentication permissions
    - The user can access any fines that he has paid or has yet to pay, as well as view any transactions done by him
    - The user can also view his profile info and has the permission to modify his own profile with updated information 
    - User registration is done only directly by the admin users can only login with pre-provided credentials 


## Installation

1. Clone this repository
```
git clone https://github.com/th3bossc/tfms.git
```

2. Navigate to the project directory
```
cd tfms/backend
```

3. Install the required dependencies
```
pip install -r requirements.txt
```

4. Start the server 
```
python manage.py runserver
```

5. The server should be running locally on http://localhost:8000


## Usage

### Python Requests
- logging in 
```
requests.post('http://127.0.0.1:8000/api/token/, json={'phone_no' : <phone_no>, 'password' : <password>})
```

- get all fines 
```
requests.get('http://127.0.0.1:8000/fines/', headers = { 'Authorization' : 'JWT <auth_key>})
```

- get specific fine
```
requests.get('http://127.0.0.1:8000/fines/<issue_id>', headers = { 'Authorization' : 'JWT <auth_key>})
```

- get all transactions
```
requests.get('http://127.0.0.1:8000/fines/transactions/', headers = { 'Authorization' : 'JWT <auth_key>})
```

- get specific transaction
```
requests.get('http://127.0.0.1:8000/fines/transactions/<transaction_id>', headers = { 'Authorization' : 'JWT <auth_key>})
```

- pay an unpaid fine 
```
requests.post('http://127.0.0.1:8000/fines/pay/<issue_id>', json= { 'payment_method' : <method> }, headers = { 'Authorization' : 'JWT <auth_key>})
```

- extend an overdue fine
```
requests.post('http://127.0.0.1:8000/fines/extend/<issue_id>', json= { 'extension' : <days>, 'reason' : <reason> }, headers = { 'Authorization' : 'JWT <auth_key>})
```

- view profile details
```
requests.get('http://127.0.0.1:8000/users/profile/', headers = { 'Authorization' : 'JWT <auth_key>})
```

- change profile details
```
requests.post('http://127.0.0.1:8000/users/profile/', headers = { 'Authorization' : 'JWT <auth_key>}, json = {
    'phone_no' : <phone_no>,
    'first_name' : <first_name>,
    'last_name' : <last_name>,
    'email' : <email>,
    'salary' : <salary>
})
```

### CURL
- logging in 
```
curl -X POST -H "Content-Type: application/json" -d '{"phone_no": "<phone_no>", "password": "<password>"}' http://127.0.0.1:8000/api/token/
```


- get all fines 
```
curl -H "Authorization: JWT <auth_key>" http://127.0.0.1:8000/fines/
```


- get specific fine
```
curl -H "Authorization: JWT <auth_key>" http://127.0.0.1:8000/fines/<issue_id>
```

- get all transactions
```
curl -H "Authorization: JWT <auth_key>" http://127.0.0.1:8000/fines/transactions/
```


- get specific transaction
```
curl -H "Authorization: JWT <auth_key>" http://127.0.0.1:8000/fines/transactions/<transaction_id>
```


- pay an unpaid fine 
```
curl -X POST -H "Authorization: JWT <auth_key>" -d '{"payment_method" : "<method>"}' http://127.0.0.1:8000/fines/pay/<issue_id>
```


- extend an overdue fine
```
curl -X POST -H "Authorization: JWT <auth_key>" -d '{"extension": "<days>", "reason": "<reason>"}' http://127.0.0.1:8000/fines/extend/<issue_id>
```


- view profile details
```
curl -H "Authorization: JWT <auth_key>" http://127.0.0.1:8000/users/profile/
```


- change profile details
```
curl -X POST -H "Authorization: JWT <auth_key>" -H "Content-Type: application/json" -d '{
    "phone_no": "<phone_no>",
    "first_name": "<first_name>",
    "last_name": "<last_name>",
    "email": "<email>",
    "salary": "<salary>"
}' http://127.0.0.1:8000/users/profile/
```

### JS Fetch API

- logging in 
```
fetch('http://127.0.0.1:8000/api/token/', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({ phone_no: '<phone_no>', password: '<password>' }),
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

- get all fines 
```
fetch('http://127.0.0.1:8000/fines/', {
  method: 'GET',
  headers: {
    'Authorization': 'JWT <auth_key>',
  },
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

- get specific fine
```
fetch('http://127.0.0.1:8000/fines/<issue_id>', {
  method: 'GET',
  headers: {
    'Authorization': 'JWT <auth_key>',
  },
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

- get all transactions
```
fetch('http://127.0.0.1:8000/fines/transactions/', {
  method: 'GET',
  headers: {
    'Authorization': 'JWT <auth_key>',
  },
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

- get specific transaction
```
fetch('http://127.0.0.1:8000/fines/transactions/<transaction_id>', {
  method: 'GET',
  headers: {
    'Authorization': 'JWT <auth_key>',
  },
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

- pay an unpaid fine 
```
fetch('http://127.0.0.1:8000/fines/pay/<issue_id>', {
  method: 'POST',
  headers: {
    'Authorization': 'JWT <auth_key>',
  },
  body : JSON.stringify({ payment_method : '<method>'})
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

- extend an overdue fine
```
fetch('http://127.0.0.1:8000/fines/extend/<issue_id>', {
  method: 'POST',  // Change the HTTP method to POST
  headers: {
    'Authorization': 'JWT <auth_key>',
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({ extension: '<days>', reason: '<reason>' }),
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

- view profile details
```
fetch('http://127.0.0.1:8000/users/profile/', {
  method: 'GET',
  headers: {
    'Authorization': 'JWT <auth_key>',
  },
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

- change profile details
```
fetch('http://127.0.0.1:8000/users/profile/', {
  method: 'POST',
  headers: {
    'Authorization': 'JWT <auth_key>',
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    phone_no: '<phone_no>',
    first_name: '<first_name>',
    last_name: '<last_name>',
    email: '<email>',
    salary: '<salary>'
  }),
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

## Resources
- [Django docs](https://docs.djangoproject.com/en/4.2/)
- [Django Rest Framework](https://www.django-rest-framework.org/)
- [JWT Authentication](https://jwt.io/introduction)

## Authors
- [Diljith P D](https://github.com/th3bossc)
- [Sreeshma Sangesh](https://github.com/sreeshu123)
- [Anuj Suhas Haval](https://github.com/AnujHaval)
