#!/bin/bash

elm make \
  src/Datu.elm \
  src/*.elm \
  src/TimeSettings/*.elm \
  src/Pomodoro/*.elm \
  --output=js/datu.js
