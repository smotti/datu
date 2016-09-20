#!/bin/bash

elm make \
  src/Datu.elm \
  src/Models.elm \
  src/Messages.elm \
  src/Update.elm \
  src/Views.elm \
  src/Notification.elm \
  src/Alert.elm \
  src/Commands.elm \
  --output=js/datu.js
