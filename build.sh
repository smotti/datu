#!/bin/bash

elm make \
  src/Datu.elm \
  src/Models.elm \
  src/Messages.elm \
  src/Update.elm \
  src/Views.elm \
  --output=js/datu.js
