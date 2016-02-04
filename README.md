# LunarCal - predictive calendar

- <a href="http://lunacal.herokuapp.com" target="_blank">Website</a>
- <a href="http://lunacal.herokuapp.com/stanleyyork" target="_blank">My Profile</a>
- <a href="https://docs.google.com/document/d/1xDjVWUEedxpgN4s7318wuX9sstjZ792Tl_3M9i-EJrg/edit" target="_blank">Planning Document</a>

## Contents

- [Overview](#overview)
- [Technologies](#Technologies)
- [Future Features](#future-features)
- [Major Challenges](#major-challenges)
- [Screenshots](#screenshots)

---

## Overview

Application that allows users to sync their Google calendar for analysis of:
- Basic Stats: such as top collaborators, hours and day of week you have the most meetings, etc.
- Prediction: based on a ratings you give previous meetings / v1 is a weighted average of attributes with the ultimate goal of using logistic regression.

---

## Technologies

- Ruby on Rails
- JavaScript & Jquery
- HTML, CSS & Bootstrap
- OAuth
- Google Calendar API
- Heroku
- Postgres

---

## Future Features

- Primary: logistic regression model for predictions of future meetings ratings (1 - 5)
- Secondary: mutliple calendars, further visualization, etc.

---

## Major Challenges

- The biggest challenge was logistic regression. I had to spend the better part of the weekend re-learning high shcool and college math, just to get to the point where I could understand logistic regression and leveraging existing code (or creating new code) for the regression. I'm not there yet, but it's just a matter of time.
- No other major challenges, however, like with any other project there were things that took longer than expected (sync the calendar) and shorter than expected (OAuth was surprisingly easy).

---

## Screenshots

![Alt text](https://github.com/Stanleyyork/predictiveCalendar/blob/master/app/assets/images/homepage.png?raw=true "Homepage")
![Alt text](https://github.com/Stanleyyork/predictiveCalendar/blob/master/app/assets/images/profilea.png?raw=true "ProfileA")
![Alt text](https://github.com/Stanleyyork/predictiveCalendar/blob/master/app/assets/images/profileb.png?raw=true "ProfileB")