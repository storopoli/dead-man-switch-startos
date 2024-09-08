# Instructions for Dead Man's Switch

Fill in the configurations:

- `username`: Your email's provider username.
- `password`: Your email's provider password.
- `smtp_server`: Your email's provider SMTP server.
- `smtp_port`: Your email's provider SMTP port.
- `message`: The message you want to send when the Dead Man's Timer expires.
- `message_warning`: The message you want to send when the Warning Timer expires.
- `subject`: The subject of the Dead Men's Timer email.
- `subject_warning`: The subject of the Warning Timer email.
- `to`: The email address you want to send the message to.
- `from`: The email address you want to send the message from.
  Probably the same as `username`.
- `timer_warning`: The time in seconds to wait before sending the Warning Timer email.
  The default is 2 weeks: `1209600`.
- `timer_dead_man`: The time in seconds to wait before sending the Dead Man's Times email.
  This will start counting after the Warning Timer expires.
  The default is 1 week: `604800`.

Now you need to check-in before the timer expires.
