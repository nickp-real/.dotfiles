const colors = {
  bg: "#282c34",
  fg: "#abb2bf",

  accentBg: "#282c34",
  accentFg: "#61afef",

  mutedBg: "#353b45",
  mutedFg: "#c8ccd4",

  red: "#e06c75",
  green: "#98c379",
  yellow: "#e5c07b",
  blue: "#61afef",
  purple: "#c678dd",
  cyan: "#56b6c2",
  white: "#abb2bf",
  black: "#282c34",
  brightBlack: "#3e4451",
  brightRed: "#e9969d",
  brightGreen: "#b3d39c",
  brightYellow: "#edd4a6",
  brightBlue: "#8fc6f4",
  brightPurple: "#d7a1e7",
  brightCyan: "#7bc6d0",
  brightWhite: "#c8cdd5",
};

const radius = 8;
const innerRadius = radius / 2;

const font = {
  family: "Google Sans Display",
  sm: 12,
  md: 14,
  base: 16,
  lg: 18,
  xl: 20,
};

const padding = 8;

const icon = { width: 20, height: 20 };

const bar = {
  height: 40,
  radius,
  leftRightGap: padding,
  topBottomGap: padding,
  insideMargin: padding,
};

// const workspace = {
//   height: 24,
//   width: 24,
//   radius: innerRadius,
// };

const slider = {
  width: 32,
  height: 32,
  radius: innerRadius * 3,
  icon,
};

const notifications = {
  timeout: 5000,
};

const button = { width: 20 + innerRadius, height: 20 + innerRadius };

const startupMenu = {
  spacing: padding * 3,
  button: {
    spacing: padding * 2,
    size: 100,
    icon: { size: 50 },
  },
};

const appLauncher = {
  spacing: padding * 2,
  padding: padding * 2,
  input: {
    height: 32,
  },
  listView: {
    spacing: padding,
  },
};
