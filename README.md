# Daily

Daily is a simple productivity app loosely based on the [pomodoro technique](https://en.wikipedia.org/wiki/Pomodoro_Technique).  Information is stored using HTML5 local storage. The application was written to both test the behavior of service worker notifications, and also to codify my personal process into something other than a markdown file.

## Roadmap

The current application and package is (and will remain) housed on github pages and backed by local storage.  I'll be considering a chrome app, and electron apps if limitations with service worker notifications become an issue. In the future, if anyone is interested, I'll consider a db backed version to allow for synced data across devices, and first class notifications (APNS, GCM, Safari, etc).

## Notifications

At the time of writing, the push notification system for recalling visitors to the application for interactions with the poms is still not finished.  Additionally, some experimental flags in chrome must be enabled. There is some information about the setup process [here](https://gauntface.com/blog/2014/12/15/push-notifications-service-worker).
