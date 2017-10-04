/**
# IDEAS

* Casual and Strict mode toggling where Casual puts margins around the screen borders of every command
* Bug: Issueing commands on separate monitor.
*
* API:
*   - https://github.com/kasper/phoenix/blob/2.5/docs/API.md
* Inspiration:
*   - https://github.com/fabiospampinato/phoenix
*   - https://github.com/emiloberg/dotfiles/blob/master/.phoenix.js
**/

/* Helpers */

const simpleRule = rule => () => {
  const window = Window.focused()
  const visible = window.screen().visibleFrame()
  const full = window.screen().flippedFrame()

  const x = full.width - visible.width
  const y = full.height - visible.height

  // The visibleFrame doesn't report the y-position correctly, but we can recalculate
  // the proper value using the height difference of visibleFrame and flippedFrame.
  return rule(window, {x, y, width: visible.width, height: visible.height})
}

/* Operations */

const left = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x,
    y: screen.y,
    width: screen.width / 2,
    height: screen.height
  })
})

const right = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x + screen.width / 2,
    y: screen.y,
    width: screen.width / 2,
    height: screen.height
  })
})

const up = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x,
    y: screen.y,
    width: screen.width,
    height: screen.height / 2
  })
})

const down = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x,
    y: screen.y + screen.height / 2,
    width: screen.width,
    height: screen.height / 2
  })
})

const topleft = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x,
    y: screen.y,
    width: screen.width / 2,
    height: screen.height / 2
  })
})

const topright = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x + screen.width / 2,
    y: screen.y,
    width: screen.width / 2,
    height: screen.height / 2
  })
})

const bottomleft = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x,
    y: screen.y + screen.height / 2,
    width: screen.width / 2,
    height: screen.height / 2
  })
})

const bottomright = simpleRule((window, screen) => {
  window.setFrame({
    x: screen.x + screen.width / 2,
    y: screen.y + screen.height / 2,
    width: screen.width / 2,
    height: screen.height / 2
  })
})

const fullsize = simpleRule((window, screen) => {
  const gutter = screen.width * 0.02
  window.setFrame({
    x: screen.x + gutter,
    y: screen.y + gutter,
    width: screen.width - 2 * gutter,
    height: screen.height - 2 * gutter
  })
})

const fullscreen = () => {
  const window = Window.focused ()

  if ( !window ) return

  window.setFullScreen ( !window.isFullScreen () )
}

//const ML = {
//  switchMonitors: function() {
//    Window.focused().setFrame(
//      Window.focused()
//        .screen()
//        .previous()
//        .flippedVisibleFrame()
//    )
//  },
//}

/* Keybindings */

// Key.on("space", ["shift", "alt"], ML.fullscreen)
Key.on("space", ["shift", "alt"], fullsize)
Key.on("f", ["shift", "alt"], fullscreen)

// Key.on("f", ["shift", "alt"], ML.switchMonitors)

Key.on("h", ["shift", "alt"], left)
Key.on("l", ["shift", "alt"], right)
Key.on("k", ["shift", "alt"], up)
Key.on("j", ["shift", "alt"], down)

Key.on("q", ["shift", "alt"], topleft)
Key.on("w", ["shift", "alt"], topright)
Key.on("a", ["shift", "alt"], bottomleft)
Key.on("s", ["shift", "alt"], bottomright)

//Key.on("t", ["shift", "alt"], ML.show("Terminal"))
//Key.on("w", ["shift", "alt"], ML.show("Google Chrome"))
