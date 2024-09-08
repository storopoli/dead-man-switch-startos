// To utilize the default config system built, this file is required. It defines the *structure* of the configuration file. These structured options display as changeable UI elements within the "Config" section of the service details page in the StartOS UI.

import { compat, types as T } from "../deps.ts";

export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
  "tor-address": {
    name: "Tor Address",
    description: "The Tor address of the network interface",
    type: "pointer",
    subtype: "package",
    "package-id": "dead-man-switch",
    target: "tor-address",
    interface: "main",
  },
  "lan-address": {
    name: "LAN Address",
    description: "The LAN address for the network interface.",
    type: "pointer",
    subtype: "package",
    "package-id": "dead-man-switch",
    target: "lan-address",
    interface: "main",
  },
  password: {
    type: "string",
    name: "Password",
    description:
      "The password for your Dead Men's Switch.  <b>Default: Randomly generated password</b>",
    nullable: false,
    copyable: true,
    masked: true,
    default: {
      charset: "a-z,A-Z,0-9",
      len: 22,
    },
  },
  smtp: {
    type: "object",
    name: "SMTP Configuration",
    description:
      "The configuration for the SMTP server to use for sending emails.",
    spec: {
      server: {
        type: "string",
        name: "SMTP Server",
        description: "The SMTP server host.",
        nullable: false,
        default: "smtp.email.com",
      },
      port: {
        type: "number",
        name: "SMTP Port",
        description: "The SMTP server port.",
        nullable: false,
        range: "[1,*)",
        units: "port",
        default: 587,
      },
      username: {
        type: "string",
        name: "Username",
        description: "The username for the SMTP server.",
        nullable: false,
        masked: true,
        default: "username@email.com",
      },
      password: {
        type: "string",
        name: "Password",
        description: "The password for the SMTP server.",
        nullable: false,
        masked: true,
        default: "password",
      },
    },
  },
  email: {
    type: "object",
    name: "Email Configuration",
    description:
      "The configuration for the email to send when a timer expires.",
    spec: {
      from: {
        type: "string",
        name: "From",
        description: "The email address to send from.",
        nullable: false,
        default: "username@email.com",
      },
      to: {
        type: "string",
        name: "To",
        description: "The email address to send to.",
        nullable: false,
        default: "recipient@email.com",
      },
      subject: {
        type: "string",
        name: "Subject",
        description: "The subject of the email for the Dead Man's timer email.",
        nullable: false,
        default: "[URGENT] Something Happened to Me!",
      },
      subject_warning: {
        type: "string",
        name: "Subject Warning",
        description: "The subject of the email for the Warning timer email.",
        nullable: false,
        default: "[URGENT] You need to check in!",
      },
      message: {
        type: "string",
        name: "Message",
        description: "The message of the email for the Dead Man's timer email.",
        nullable: false,
      },
      message_warning: {
        type: "string",
        name: "Message Warning",
        description: "The message of the email for the Warning timer email.",
        nullable: false,
      },
    },
  },
  timer: {
    type: "object",
    name: "Timer Configuration",
    description: "The configuration for the Dead Man's and Warning timers.",
    spec: {
      dead_man: {
        type: "number",
        name: "Dead Man's Timer (seconds)",
        description:
          "The time in seconds for the Dead Man's timer. (Default is 2 weeks, i.e. 1209600 seconds)",
        nullable: false,
        range: "[30,*)",
        units: "seconds",
        default: 1209600,
      },
      warning: {
        type: "number",
        name: "Warning Timer (seconds)",
        description:
          "The time in seconds for the Warning timer. (Default is 1 week, i.e. 604800 seconds)",
        nullable: false,
        range: "[30,*)",
        units: "seconds",
        default: 604800,
      },
    },
  },
});
