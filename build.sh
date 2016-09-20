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
  src/TimeSettings/Models.elm \
  src/TimeSettings/Messages.elm \
  src/TimeSettings/Ports.elm \
  src/TimeSettings/Subscriptions.elm \
  src/TimeSettings/Update.elm \
  src/TimeSettings/View.elm \
  --output=js/datu.js
