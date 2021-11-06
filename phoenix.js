/**
# IDEAS

* Casual and Strict mode toggling where Casual puts margins around the screen borders of every command
* Bug: Issueing commands on separate monitor.
* Bug: The dock size is not always reported correctly to visible frame (workaround: reposition dock and back again)
*
* API:
*   - https://github.com/kasper/phoenix/blob/2.5/docs/API.md
* Inspiration:
*   - https://github.com/fabiospampinato/phoenix
*   - https://github.com/emiloberg/dotfiles/blob/master/.phoenix.js
**/

/* constants */

const gutter = 14;

const tallMonitor = 1;
const middleMonitor = 2;
const offMonitor = 0;

/* Helpers */

const simpleRule = (rule) => () => {
  const window = Window.focused();
  const visible = window.screen().visibleFrame();
  const full = window.screen().flippedVisibleFrame();

  const x = full.width - visible.width;
  const y = full.height - visible.height;

  // The visibleFrame doesn't report the y-position correctly, but we can recalculate
  // the proper value using the height difference of visibleFrame and flippedVisibleFrame.
  return rule(window, {
    x,
    y,
    width: visible.width,
    height: visible.height,
  });
};

const oneThird = (x) => x / 3;
const twoThirds = (x) => (2 * x) / 3;

/* Operations */

const left = (window) => {
  const screen = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screen.x + gutter,
    y: screen.y + gutter,
    width: Math.round(twoThirds(screen.width) - 1.5 * gutter),
    height: screen.height - 2 * gutter,
  });
};

const right = (window) => {
  const screen = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: Math.round(screen.x + twoThirds(screen.width) + 0.5 * gutter),
    y: screen.y + gutter,
    width: Math.round(oneThird(screen.width) - 1.5 * gutter),
    height: screen.height - 2 * gutter,
  });
};

const up = (window) => {
  const screen = window.screen().flippedVisibleFrame();
  window.setFrame({
    ...window.frame(),
    y: screen.y + gutter,
    height: Math.round(screen.height / 2 - 1.5 * gutter),
  });
};

const down = (window) => {
  const screen = window.screen().flippedVisibleFrame();
  window.setFrame({
    ...window.frame(),
    y: Math.round(screen.y + screen.height / 2 + 0.5 * gutter),
    height: Math.round(screen.height / 2 - 1.5 * gutter),
  });
};

const topleft = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x,
    y: screen.y,
    width: 2 * (screen.width / 3),
    height: screen.height / 2,
  });
});

const topright = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x + 2 * (screen.width / 3),
    y: screen.y,
    width: screen.width / 3,
    height: screen.height / 2,
  });
});

const bottomleft = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x,
    y: screen.y + screen.height / 2,
    width: 2 * (screen.width / 3),
    height: screen.height / 2,
  });
});

const bottomright = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x + 2 * (screen.width / 3),
    y: screen.y + screen.height / 2,
    width: screen.width / 3,
    height: screen.height / 2,
  });
});

const fullsize = (window) => {
  const screen = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screen.x + gutter,
    y: screen.y + gutter,
    width: screen.width - 2 * gutter,
    height: screen.height - 2 * gutter,
  });
};

const fullsizeFocusedWindow = () => fullsize(Window.focused());

const fullsizeAllWindows = () => Screen.main().windows().map(fullsize);

const fullscreen = () => {
  const window = Window.focused();

  if (!window) return;

  window.setFullScreen(!window.isFullScreen());
};

const devLayout = [
  {
    "": (window) => {
      // Screen 0 is always the primary window
      moveToScreen(0)(window);
    },
  },
  {
    "Google Chrome": (window) => {
      moveToScreen(tallMonitor)(window);
      left(window);
    },
    Code: (window) => {
      moveToScreen(tallMonitor)(window);
      left(window);
    },
    Alacritty: (window) => {
      moveToScreen(tallMonitor)(window);
      right(window);
    },
    "": (window) => {
      moveToScreen(offMonitor)(window);
    },
  },
  {
    "Google Chrome": (window) => {
      moveToScreen(tallMonitor)(window);
    },
    Code: (window) => {
      moveToScreen(middleMonitor)(window);
      left(window);
    },
    Alacritty: (window) => {
      moveToScreen(middleMonitor)(window);
      right(window);
    },
    "": (window) => {
      moveToScreen(offMonitor)(window);
    },
  },
];

const adminLayout = [
  {
    "": (window) => {
      // Screen 0 is always the primary window
      moveToScreen(0)(window);
    },
  },
  {
    "Google Chrome": (window) => {
      moveToScreen(middleMonitor)(window);
      left(window);
    },
    Code: (window) => {
      moveToScreen(middleMonitor)(window);
      left(window);
    },
    Alacritty: (window) => {
      moveToScreen(middleMonitor)(window);
      right(window);
    },
    "": (window) => {
      moveToScreen(offMonitor)(window);
    },
  },
  {
    "Google Chrome": (window) => {
      moveToScreen(middleMonitor)(window);
    },
    Jira: (window) => {
      moveToScreen(tallMonitor)(window);
      up(window);
    },
    Trello: (window) => {
      moveToScreen(tallMonitor)(window);
      up(window);
    },
    Mail: (window) => {
      moveToScreen(tallMonitor)(window);
      down(window);
    },
    "": (window) => {
      moveToScreen(offMonitor)(window);
    },
  },
];

const applyLayout = (layoutScheme) => {
  const screens = Screen.all();
  const layout = layoutScheme[screens.length - 1];

  Window.all()
    .filter((window) => window.isVisible())
    .forEach((window) => {
      const title = window.app().name();
      const applicableRule = Object.keys(layout).find((rule) =>
        new RegExp(rule).test(title)
      );
      layout[applicableRule](window);
    });
};

let currentLayout = "none";
const toggleLayout = () => {
  const layouts = ["dev", "admin"];
  const currentIndex = layouts.indexOf(currentLayout);
  const nextIndex = (currentIndex + 1) % layouts.length;

  currentLayout = layouts[nextIndex];

  Phoenix.log(JSON.stringify(currentLayout, null, 2));

  switch (currentLayout) {
    case "admin":
      applyLayout(adminLayout);
      break;
    case "dev":
    default:
      applyLayout(devLayout);
      break;
  }
};

const moveToScreen = (index) => (window) => {
  const screen = Screen.all()[index];

  if (screen) {
    const bounds = screen.flippedVisibleFrame();
    window.setFrame({
      x: bounds.x + gutter,
      y: bounds.y + gutter,
      width: bounds.width - 2 * gutter,
      height: bounds.height - 2 * gutter,
    });

    // Hack to make sure the window is on the right monitor before resizing as otherwise the
    // window size will be constrained to the old screen's size.
    setTimeout(moveToScreen.bind(null, index, window), 50);
  }
};

const moveToRelativeSpace = (direction) => () => {
  const window = Window.focused();
  const currentSpace = window.screen().currentSpace();
  const nextSpace =
    direction >= 0 ? currentSpace.next() : currentSpace.previous();
  if (currentSpace && nextSpace) {
    currentSpace.removeWindows([window]);
    nextSpace.addWindows([window]);
  }
};

const focusApp = (name) => () => {
  const app = App.get(name);

  if (app) {
    app.focus();
  }
};

/* Keybindings */

Key.on("space", ["shift", "alt", "ctrl"], /*fullsizeAllWindows*/ toggleLayout);

Key.on("space", ["shift", "alt"], fullsizeFocusedWindow);
Key.on("space", ["shift", "alt", "ctrl", "cmd"], toggleLayout);
Key.on("f", ["shift", "alt"], fullscreen);

Key.on("h", ["shift", "alt"], () => left(Window.focused()));
Key.on("l", ["shift", "alt"], () => right(Window.focused()));
Key.on("k", ["shift", "alt"], () => up(Window.focused()));
Key.on("j", ["shift", "alt"], () => down(Window.focused()));

Key.on("q", ["shift", "alt", "ctrl"], topleft);
Key.on("w", ["shift", "alt", "ctrl"], topright);
Key.on("a", ["shift", "alt", "ctrl"], bottomleft);
Key.on("s", ["shift", "alt", "ctrl"], bottomright);

Key.on("q", ["shift", "alt"], () =>
  moveToScreen(tallMonitor)(Window.focused())
);
Key.on("w", ["shift", "alt"], () =>
  moveToScreen(middleMonitor)(Window.focused())
);
Key.on("e", ["shift", "alt"], () => moveToScreen(offMonitor)(Window.focused()));

Key.on("h", ["shift", "alt", "ctrl"], moveToRelativeSpace(-1));
Key.on("l", ["shift", "alt", "ctrl"], moveToRelativeSpace(1));

Key.on("u", ["shift", "alt"], focusApp("Google Chrome"));
Key.on("i", ["shift", "alt"], focusApp("Code"));
Key.on("o", ["shift", "alt"], focusApp("Alacritty"));
Key.on("p", ["shift", "alt"], focusApp("Slack"));
