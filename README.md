# XMTP Chat

A small working Flutter app chat example using [xmtp](https://pub.dev/packages/xmtp)
 and [walletconnect_flutter_v2](https://pub.dev/packages/walletconnect_flutter_v2).

This project has no commercial purposes.

Feel free to clone, edit and change, honoring the [LICENSE](LICENSE).

## To Do

Some important improvements/fixes are still needed:

- [ ] Fix XmtpIsolate connection issues
  - XmtpIsolate will lose connection and not recover from it
  - Re-starting XmtpIsolate might throw uncaught exceptions
- [ ] Improve error handling
  - Retrieve errors from XmtpIsolate to give user some context (eg: contact not on Xmtp network)
- [ ] Improve overall design
- [ ] Add feature to name conversations
- [ ] Add LocalNotifications support
