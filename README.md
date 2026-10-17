# Infinite Zen (Infinite Positivity Loop)

A small, open-source hobby experiment: a single-page infinite scroll of calm affirmations. Built for curiosity and learning — not for sale. Part of **#BuildForJoy**.

## Why I Built This

I wanted a tiny playground for pure front-end craft: soft motion, theme switching, and an endless feed without a backend. The goal was to practice calm UI patterns and infinite-scroll mechanics while shipping something you can open locally in seconds.

This is a non-commercial exploration. Fork it, break it, rebuild it — enjoy the building.

## What I Explored (Tech Stack)

- **HTML5 / CSS3** — custom properties, layered background animation, responsive layout
- **Vanilla JavaScript** — random affirmation cards, scroll-triggered append, dark/light theme
- **Google Fonts (Quicksand)** — light typography for a lo-fi feel
- **Static hosting** — no server, no database; open `index.html` or drop on Netlify / GitHub Pages

## Lessons Learned

- Separating the “breathing” background onto its own layer keeps scroll and theme toggles smooth.
- Infinite scroll is easy to prototype with vanilla JS; the harder part is remembering well-being (take breaks!).
- Shipping without payments or accounts keeps the experiment honest and easy to share.

## Run Locally

No build step or `npm` required.

1. Clone the repo:
   ```bash
   git clone https://github.com/BeanCounter11/Infinite-positivity-loop.git
   cd Infinite-positivity-loop
   ```
2. Open `index.html` in a browser, **or** serve the folder with any static server, for example:
   ```bash
   npx serve .
   ```
3. Optional: edit affirmations in `messages.js`.

## Try It

- Open the app locally (see above), or visit a static host if you deploy one.
- Browse the code on GitHub: [BeanCounter11/Infinite-positivity-loop](https://github.com/BeanCounter11/Infinite-positivity-loop)

## Disclaimer

This app is a non-commercial hobby experiment provided **AS IS** without warranty of any kind, express or implied. Use at your own risk.

The page uses continuous scroll. Monitor your own usage, take regular breaks, enjoy the interaction, and get building!

## License

MIT — see [LICENSE](./LICENSE).
