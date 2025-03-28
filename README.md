﻿**_What is PostgreSQL?_**

- PostgreSQL একটি শক্তিশালী, ওপেন সোর্স রিলেশনাল ডেটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS)

**_What is the purpose of a database schema in PostgreSQL?_**

- ডাটাবেসের টেবিল, ভিউ, ফাংশন ইত্যাদি অবজেক্টগুলোকে লজিক্যাল গ্রুপে সাজানো এবং ম্যানেজ করা।

**_Explain the Primary Key and Foreign Key concepts in PostgreSQL._**

- _Primary Key_ - একটি টেবিলের প্রতিটি রেকর্ডকে ইউনিকলি আইডেন্টিফাই করে।
  
  উদাহরণ: `customers` টেবিলের `id` কলাম।

- _Foreign Key_ - একটি টেবিলের কলাম যা অন্য টেবিলের প্রাইমারি কীকে রেফারেন্স করে।

  উদাহরণ: `orders` টেবিলের `customer_id` যা customers টেবিলের `id`-কে নির্দেশ করে।

**_What is the difference between the VARCHAR and CHAR data types?_**

- `CHAR`
  ফিক্সড সাইজ: CHAR(5)-এ "Hi" লিখলে স্টোরেজে ৫ টি ক্যারেক্টার জায়গা নেয়।
- `VARCHAR`
  ভেরিয়েবল সাইজ: VARCHAR(5)-এ "Hi" লিখলে শুধু ২ টি ক্যারেক্টার জায়গা নেয়।

**_Explain the purpose of the WHERE clause in a SELECT statement._**

- `WHERE` ব্যবহার করা হয় শর্ত সাপেক্ষে ডাটা ফিল্টারিং এর জন্য `SELECT` স্টেটমেন্টে।

**_What are the LIMIT and OFFSET clauses used for?_**

- `LIMIT n`: রেজাল্ট সেট থেকে প্রথম `n` রো দেখায়।

  `OFFSET m`: প্রথম `m` রো স্কিপ করে পরের রো গুলো দেখায়।

  `SELECT * FROM books LIMIT 5 OFFSET 10; -- ১১তম থেকে ১৫তম রো  `

**_How can you modify data using UPDATE statements?_**

- `UPDATE` স্টেটমেন্ট ব্যবহার করে একটি টেবিলের নির্দিষ্ট রেকর্ডে ডেটা পরিবর্তন করা করা
  
  `UPDATE books SET price = 45 WHERE id = 1; -- ID 1 এর বইয়ের দাম 45 করা করা`

**_What is the significance of the JOIN operation, and how does it work in PostgreSQL?_**

- `JOIN` অপারেশন দুইটি বা ততোধিক টেবিলের মধ্যে সম্পর্ক স্থাপন করতে ব্যবহার করা হয়।

## **_Explain the GROUP BY clause and its role in aggregation operations._**

- `GROUP BY` কলামের মানের ভিত্তিতে রো গ্রুপিং করে এবং অ্যাগ্রিগেট ফাংশন `(SUM, AVG, COUNT)` প্রয়োগ করে।
  
  ```js
  SELECT author, COUNT(*) AS total_books
  FROM books
  GROUP BY author; -- লেখক-এর ভিত্তিতে বইয়ের সংখ্যা
  ```

**_How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?_**

- `COUNT()`: একটি কলামে মোট রেকর্ডের সংখ্যা গণনা করতে ব্যবহৃত হয়।
  `SELECT COUNT(*) FROM books; -- মোট বইয়ের সংখ্যা `

  `SUM()`: একটি কলামের মোট যোগফল বের করতে ব্যবহৃত হয়।
  `SELECT SUM(price) FROM books; -- সব বইয়ের মোট দাম `

  `AVG()`: একটি কলামের গড় মান বের করতে ব্যবহৃত হয়।
  `SELECT AVG(price) FROM books; -- বইয়ের গড় দাম `
